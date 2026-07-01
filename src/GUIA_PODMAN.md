# 🐧 Guía de Referencia VPS: Podman & SQL Server

Este documento sirve como manual rápido de comandos y arquitectura para la administración del entorno de contenedores y la base de datos en el VPS.

---

## 🛠️ 1. Gestión de Contenedores (Podman)

Podman administra los servicios del backend, frontend, proxy (Caddy) y base de datos utilizando la misma sintaxis que Docker.

### Monitoreo y Estado

* **Listar contenedores activos:**
  ```
  podman container list
  # o resumido:
  podman ps
  ```
* **Listar todos los contenedores (incluyendo detenidos):**
  ```
  podman ps -a
  ```
* **Inspeccionar configuraciones (Redes, IP, Volúmenes):**
  ```
  podman inspect sqlserver
  ```
* **Ver logs en tiempo real (Depuración):**
  ```
  podman logs -f sqlserver
  ```
### Control de Ciclo de Vida
* **Detener contenedor:** 
  ```
  podman stop <nombre_o_id>
  ```
* **Iniciar contenedor:** 
  ```
  podman start <nombre_o_id>
  ```
* **Reiniciar contenedor:** 
  ```
  podman restart <nombre_o_id>
  ```

---

## 💾 2. Persistencia y Ubicación de Datos

La base de datos utiliza un volumen mapeado en el VPS para evitar la pérdida de información si el contenedor se destruye o actualiza.

* **Ruta de los archivos .mdf y .ldf en el VPS:**
  ```
  cd /var/lib/containers/storage/volumes/vps_sqlserver_data/_data/data
  ```
* **Archivos principales de producción:**
  - PokemonesDB.mdf (Datos principales)
  - PokemonesDB_log.ldf (Logs de transacciones)

> ⚠️ Nota: Los archivos pertenecen al UID 10001 debido al aislamiento por mapeo de usuarios (rootless) de Podman. Evita modificar permisos manualmente.

---

## 🛢️ 3. Acceso Directo a SQL Server (sqlcmd)

Para interactuar con la base de datos desde la línea de comandos del VPS sin usar clientes externos:

1. **Entrar a la terminal del contenedor:**
   ```
   podman exec -it sqlserver bash
   ```
2. **Iniciar sesión en el cliente SQL:**
   ```
   /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'AQUIVALAPASSWORD' -C
   (La bandera -C confía implícitamente en el certificado SSL local).
    ```

3. **Comandos básicos en la consola de SQL (Escribir GO para ejecutar):**
    ```
   * **Cambiar de contexto a la base de datos del proyecto:**```
     USE PokemonesDB;
     GO

   * **Consultar tablas de la base de datos:**
     SELECT * FROM Users;
     GO
     
     SELECT * FROM Pokemon;
     GO

   * **Salir del cliente y del contenedor:**
     - Escribe 'exit' para cerrar sqlcmd.
     - Escribe 'exit' nuevamente para volver al VPS.
    ```
---

## 📋 4. Datos de Conexión del Entorno

Usa estos parámetros para configurar las variables de entorno (.env) en tus proyectos o herramientas como DBeaver:

- Motor de DB: SQL Server 2022 Express (Imagen oficial de Microsoft)
- Host Interno: sqlserver
- Red Compartida: vps_shared (Red donde coexisten los contenedores)
- Puerto DB: 1433 (Puerto interno del contenedor)
- Usuario Master: sa (System Administrator)
- Base de Datos: PokemonesDB (DB asignada para la aplicación)