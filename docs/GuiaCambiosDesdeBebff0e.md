# Guia de cambios desde `bebff0e887f4c62a3d31af1de7bea00b8a4df4f9`

Esta guia resume los cambios hechos despues del commit:

```text
bebff0e887f4c62a3d31af1de7bea00b8a4df4f9
```

El objetivo es explicar los cambios de forma clara para un dev junior: que problema habia, que se cambio, por que se cambio, y como verificarlo.

## Commits incluidos

Despues de `bebff0e...` vienen estos commits:

```text
40830fd fix: align API routes with Caddy path stripping
188a01a fix: remove duplicate endpoint
4c078c1 ci: split VPS deploy workflow into rerunnable jobs
c8b8839 try to fix health check
```

## Resumen corto

Se hicieron cuatro cambios importantes:

1. El backend dejo de exponer rutas internas con `/api/v1/...` y ahora expone `/v1/...`.
2. El Nginx del frontend dejo de hacer reverse proxy a la API.
3. El proxy local de Angular ahora imita a Caddy y quita `/api` antes de mandar al backend.
4. El workflow de GitHub Actions se separo en jobs mas pequenos para poder reintentar solo lo que fallo.
5. El endpoint `/health` del backend se simplifico para evitar fallos durante el deploy.

## Por que se hicieron estos cambios

Los cambios no fueron solo refactor. Se hicieron para alinear la app con la forma en que ya trabaja la plataforma del VPS.

La plataforma ya tiene Caddy como reverse proxy principal. Caddy recibe todo el trafico publico de `vibegallery.kity.dev` y decide si una request va al frontend o al backend.

Eso significa que la app no debe pelearse con Caddy por las rutas. Cada parte debe tener una responsabilidad clara:

```text
Caddy: maneja el prefijo publico /api
Backend: expone rutas internas versionadas /v1
Frontend Nginx: sirve solo archivos estaticos
Angular local proxy: imita el comportamiento de Caddy en desarrollo
GitHub Actions: separa build, publish y deploy para debug mas facil
```

Antes habia mezcla de responsabilidades:

```text
Caddy quitaba /api
Backend esperaba /api/v1
Nginx frontend tambien intentaba proxyear /api
GitHub Actions hacia todo en un solo job
```

Esa mezcla produjo problemas como:

```text
404 en login
Swagger generando URLs confusas
health checks dificiles de diagnosticar
deploys que habia que reintentar completos aunque fallara solo un paso
```

Los cambios buscan que el sistema sea mas predecible:

```text
Una sola capa decide el routing publico: Caddy.
Una sola convencion interna para la API: /v1.
Un solo servidor estatico para Angular: Nginx.
Un workflow separado por responsabilidades: validate, publish, deploy.
```

## Contexto: como funciona el routing en produccion

La plataforma usa Caddy con una regla parecida a esta:

```caddy
vibegallery.kity.dev {
    encode zstd gzip

    handle_path /api/* {
        reverse_proxy vibe-gallery-backend:8080
    }

    handle {
        reverse_proxy vibe-gallery-frontend:8080
    }
}
```

La parte importante es:

```caddy
handle_path /api/*
```

`handle_path` no solo matchea `/api/*`. Tambien le quita el prefijo `/api` antes de mandar la request al backend.

Ejemplo:

```text
Browser llama:  /api/v1/auth/login
Caddy envia:    /v1/auth/login
Backend recibe: /v1/auth/login
```

Por eso el backend debe exponer rutas internas `/v1/...`, no `/api/v1/...`.

## Cambio 1: rutas del backend alineadas con Caddy

### Por que se hizo

Se hizo porque Caddy usa `handle_path /api/*`, y `handle_path` elimina `/api` antes de reenviar la request.

Si el backend tambien incluye `/api` en sus rutas, hay una duplicacion conceptual: Caddy trata `/api` como infraestructura, pero el backend lo trata como parte de la ruta real.

La mejor practica para este setup es:

```text
URL publica: /api/v1/...
Ruta interna backend: /v1/...
```

Asi el backend no queda acoplado al prefijo publico del dominio. Si manana el proxy publico cambia de `/api` a `/backend`, el backend podria seguir usando `/v1/...`.

### Antes

El backend tenia grupos asi:

```csharp
app.MapGroup("/api/v1/auth")
app.MapGroup("/api/v1/pokemon")
```

Eso chocaba con Caddy, porque Caddy ya quitaba `/api`.

En produccion pasaba esto:

```text
Browser: /api/v1/auth/login
Caddy:   /v1/auth/login
Backend esperaba: /api/v1/auth/login
Resultado: 404
```

### Ahora

En `src/Backend/Endpoints/AuthEndpoints.cs`:

```csharp
var authGroup = app.MapGroup("/v1/auth")
    .WithTags("Authentication");
```

En `src/Backend/Endpoints/PokemonEndpoints.cs`:

```csharp
var pokemonGroup = app.MapGroup("/v1/pokemon")
    .WithTags("Pokemon");
```

Ahora el flujo queda correcto:

```text
Browser: /api/v1/auth/login
Caddy:   /v1/auth/login
Backend: /v1/auth/login
Resultado: OK
```

## Cambio 2: Swagger sigue usando `/api`

### Por que se hizo

Swagger representa la API desde el punto de vista del consumidor externo.

El consumidor externo no sabe que Caddy quita `/api` antes de llamar al backend. El consumidor solo ve:

```text
https://vibegallery.kity.dev/api/v1/...
```

Por eso Swagger debe mantener:

```csharp
options.AddServer(new OpenApiServer { Url = "/api" });
```

pero los paths documentados deben ser:

```text
/v1/...
```

Asi Swagger calcula correctamente:

```text
/api + /v1/... = /api/v1/...
```

En `src/Backend/Program.cs` se mantiene:

```csharp
options.AddServer(new OpenApiServer { Url = "/api" });
options.AddServer(new OpenApiServer { Url = "/" });
```

Esto solo afecta Swagger/OpenAPI. No cambia las rutas reales de ASP.NET.

Swagger combina:

```text
server URL + endpoint path
```

Como ahora los endpoints documentados son `/v1/...`, Swagger genera publicamente:

```text
/api + /v1/auth/login = /api/v1/auth/login
```

Eso es correcto para produccion.

## Cambio 3: Nginx del frontend quedo simple

### Por que se hizo

Se hizo porque en produccion ya existe Caddy como reverse proxy central.

Si tambien ponemos reverse proxy en el Nginx del frontend, hay dos capas intentando decidir que hacer con `/api`:

```text
Caddy decide /api
Nginx tambien decide /api
```

Eso puede funcionar en algunos casos, pero complica el sistema. Cuando algo falla, ya no sabes rapidamente si la URL la cambio Caddy, Nginx, Angular o el backend.

La mejor practica aqui es que Nginx del frontend sea aburrido y predecible: solo servir Angular.

En el commit base `bebff0e...`, se habia agregado proxy de API dentro del Nginx del frontend.

Eso fue removido.

### Por que se removio

En produccion ya existe Caddy como reverse proxy principal. Si Nginx tambien intenta decidir que hacer con `/api`, quedan dos proxies con responsabilidad parecida:

```text
Caddy -> frontend Nginx -> backend
```

Eso complica el despliegue y hace mas dificil saber quien esta cambiando la URL.

La mejor separacion para este setup es:

```text
Caddy: decide si la request va a frontend o backend
Nginx frontend: solo sirve archivos estaticos de Angular
Backend: solo expone API interna
```

### Ahora

`src/Frontend/nginx.conf` quedo asi:

```nginx
server {
    listen 8080;
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

Eso significa que Nginx solo sirve la SPA de Angular.

## Cambio 4: proxy local de Angular imita a Caddy

### Por que se hizo

Se hizo para que desarrollo local y produccion tengan el mismo comportamiento de rutas.

En produccion:

```text
/api/v1/auth/login -> Caddy quita /api -> /v1/auth/login
```

En local no hay Caddy. Entonces Angular necesita un proxy que haga lo mismo:

```text
/api/v1/auth/login -> Angular dev proxy quita /api -> /v1/auth/login
```

Esto evita tener codigo diferente para local y produccion.

En local, Angular sigue llamando URLs publicas:

```text
/api/v1/auth/login
/api/v1/pokemon
```

Pero el backend local ahora espera:

```text
/v1/auth/login
/v1/pokemon
```

Para que local funcione igual que produccion, se actualizo `src/Frontend/proxy.conf.json`.

### Antes

```json
{
    "/api": {
        "target": "http://localhost:5062",
        "secure": false,
        "changeOrigin": true
    }
}
```

Eso mandaba `/api/v1/...` al backend local sin cambiarlo.

### Ahora

```json
{
    "/api": {
        "target": "http://localhost:5062",
        "secure": false,
        "changeOrigin": true,
        "pathRewrite": {
            "^/api": ""
        }
    }
}
```

`pathRewrite` hace esto:

```text
Angular llama: /api/v1/auth/login
Proxy local envia al backend: /v1/auth/login
```

Esto imita el comportamiento de Caddy con `handle_path /api/*`.

## Cambio 5: health checks del backend

### Por que se hizo

Se hizo para que el deploy broker tenga una URL muy simple para saber si el contenedor arranco.

Un health check de deploy no necesita validar base de datos, auth, Swagger ni integraciones externas. Solo necesita responder:

```text
Estoy vivo y Kestrel esta escuchando.
```

Por eso se cambio a un `MapGet` simple. Menos magia, menos puntos de fallo.

El deploy broker validaba el contenedor con una URL como:

```text
http://vibe-gallery-backend-next:8080/health
```

El backend arrancaba, pero el health check fallaba.

En los logs aparecian warnings como:

```text
Storing keys in a directory '/root/.aspnet/DataProtection-Keys'
```

Ese warning de DataProtection no era la causa principal. Solo avisa que las llaves no persisten si el contenedor se destruye.

### Que se cambio

Se quito el sistema de health checks de ASP.NET:

```csharp
builder.Services.AddHealthChecks();
app.MapHealthChecks("/health")
```

Y se reemplazo por un endpoint normal:

```csharp
app.MapGet("/health", () => Results.Ok(new { status = "ok" }))
    .AllowAnonymous()
    .WithTags("Health");
```

Esto hace que `/health` sea lo mas simple posible:

```text
GET /health -> 200 OK
```

### Endpoints de salud actuales

En `Program.cs` quedan:

```text
/          -> respuesta simple para saber que la app esta viva
/health    -> health check interno para broker/contenedor
/v1/health -> health versionado de API
```

Si Caddy usa `handle_path /api/*`, entonces publicamente:

```text
/api/v1/health
```

llega al backend como:

```text
/v1/health
```

## Cambio 6: workflow de deploy separado en jobs

### Por que se hizo

Se hizo porque GitHub Actions reintenta jobs completos, no steps individuales.

Antes todo estaba en un solo job. Si fallaba el deploy backend, habia que repetir:

```text
build frontend
build backend
publish frontend
publish backend
deploy frontend
deploy backend
```

Eso desperdicia tiempo y hace mas lento debuggear.

Separarlo en jobs permite repetir solo la parte que fallo.

Antes `.github/workflows/deploy-vps.yml` tenia un solo job:

```yaml
test-build-deploy
```

Ese job hacia todo:

1. Build frontend.
2. Build backend.
3. Publicar imagen backend.
4. Publicar imagen frontend.
5. Deploy frontend.
6. Deploy backend.

El problema es que GitHub Actions reintenta por job, no por step.

Si fallaba solo el deploy backend, "Re-run failed jobs" repetia todo.

### Ahora

El workflow se separo en:

```text
validate-frontend
validate-backend
publish-frontend
publish-backend
deploy-frontend
deploy-backend
```

La cadena queda asi:

```text
validate-frontend -> publish-frontend -> deploy-frontend
validate-backend  -> publish-backend  -> deploy-backend
```

Esto se controla con `needs`.

Ejemplo:

```yaml
publish-backend:
  needs: validate-backend
```

Y:

```yaml
deploy-backend:
  needs: publish-backend
```

### Beneficio

Si falla `deploy-backend`, ahora puedes usar:

```text
Re-run failed jobs
```

y GitHub deberia repetir solo ese job, no todo el build.

## Por que `environment: RackNerd` solo esta en deploy

Antes el job unico tenia:

```yaml
environment: RackNerd
```

Ahora se puso solo en:

```yaml
deploy-frontend
deploy-backend
```

Eso es mejor porque `RackNerd` representa el ambiente real de despliegue y sus secrets.

Los jobs de build y publish no necesitan ese environment.

Separacion final:

```text
validate-* -> compila y valida
publish-*  -> construye y sube imagenes a GHCR
deploy-*   -> habla con deploy.kity.dev y despliega al VPS
```

## Como probar localmente

Terminal 1:

```bash
cd src/Backend
dotnet run
```

Terminal 2:

```bash
cd src/Frontend
npm start
```

Angular puede llamar:

```text
/api/v1/auth/login
```

El proxy local lo reescribe a:

```text
/v1/auth/login
```

## Como probar en el VPS

Para probar el backend actual sin depender del DNS de Podman:

```bash
sudo podman run --rm \
  --network container:vibe-gallery-backend \
  docker.io/curlimages/curl:latest \
  -i http://127.0.0.1:8080/health
```

Resultado esperado:

```text
HTTP/1.1 200 OK
```

Body esperado:

```json
{"status":"ok"}
```

Tambien puedes probar:

```bash
sudo podman run --rm \
  --network container:vibe-gallery-backend \
  docker.io/curlimages/curl:latest \
  -i http://127.0.0.1:8080/
```

## Nota sobre DNS de Podman

Durante el debugging, esto fallo:

```bash
sudo podman run --rm --network podman docker.io/curlimages/curl:latest \
  -i http://vibe-gallery-backend:8080/health
```

Error:

```text
curl: (6) Could not resolve host: vibe-gallery-backend
```

Eso indica que la red default `podman` no estaba resolviendo nombres de contenedores como DNS.

Por eso para probar el endpoint se uso:

```bash
--network container:vibe-gallery-backend
```

Asi el contenedor temporal comparte la red del backend y llama a:

```text
http://127.0.0.1:8080/health
```

## Archivos modificados desde `bebff0e...`

```text
.github/workflows/deploy-vps.yml
src/Backend/Endpoints/AuthEndpoints.cs
src/Backend/Endpoints/PokemonEndpoints.cs
src/Backend/Program.cs
src/Frontend/nginx.conf
src/Frontend/proxy.conf.json
```

## Resumen final para recordar

La arquitectura queda asi:

```text
Produccion:
Browser -> /api/v1/... -> Caddy handle_path -> Backend /v1/...
Browser -> cualquier ruta frontend -> Caddy -> Nginx Angular

Local:
Angular -> /api/v1/... -> Angular proxy pathRewrite -> Backend /v1/...
```

Responsabilidades:

```text
Caddy: TLS, dominio y prefijo publico /api
Nginx frontend: servir Angular estatico
Backend: rutas internas /v1
Angular proxy local: imitar a Caddy
GitHub Actions: validar, publicar y desplegar en jobs separados
```
