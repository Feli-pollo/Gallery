# Frontend AGENTS.md — Angular 21 Standalone App

## Overview

The frontend is an Angular 21 standalone component application using signals for state management and Tailwind CSS v4 for styling. It communicates with the ASP.NET backend via HTTP.

**Framework**: Angular 21.2.x (standalone components, no NgModules)
**Language**: TypeScript 5.9 (strict mode)
**Styling**: Tailwind CSS v4
**Icons**: Lucide Angular
**State**: Angular Signals + RxJS Observables
**Testing**: Vitest with jsdom

## Commands

```bash
cd src/Frontend
npm install                    # Install dependencies (required first)
npm start                      # Dev server at http://0.0.0.0:4200
npm test                       # Run tests with Vitest
npm run build                  # Production build to dist/
npm run ng -- generate component <name>  # Generate component
```

- Package manager: **npm** (not yarn/pnpm)
- Test runner: **Vitest** with `vitest/globals` types

## Project Structure

```
src/Frontend/
├── src/
│   ├── main.ts                # bootstrapApplication(App, appConfig)
│   ├── styles.css             # Global styles + Tailwind import
│   ├── index.html
│   └── app/
│       ├── app.ts             # Root component (just <router-outlet />)
│       ├── app.html           # Template
│       ├── app.routes.ts      # Route definitions
│       ├── app.config.ts      # Providers (router, HTTP, icons)
│       ├── poke-card.ts       # PokeCard interface
│       ├── poke-type.ts       # PokeType interface
│       │
│       ├── login/             # Login page
│       │   ├── login.ts       # Component
│       │   ├── login.html     # Template
│       │   └── login.css      # Styles
│       │
│       ├── gallery/           # Pokémon gallery grid
│       │   ├── gallery.ts
│       │   ├── gallery.html
│       │   └── gallery.css
│       │
│       ├── card/              # Pokémon card component
│       │   ├── card.ts
│       │   ├── card.html
│       │   └── card.css
│       │
│       ├── header/            # Navigation header
│       │   ├── header.ts
│       │   ├── header.html
│       │   └── header.css
│       │
│       ├── guards/
│       │   └── auth-guard.ts  # CanActivate route guard
│       │
│       ├── interceptors/
│       │   └── auth-interceptor.ts  # HTTP interceptor for JWT
│       │
│       └── shared/
│           ├── pokemon.service.ts   # GET /api/pokemon
│           ├── login.service.ts     # POST /api/login
│           ├── search.service.ts    # Search event bus
│           ├── search/             # Search input component
│           └── main-layout/        # Layout wrapper
│
├── angular.json               # Angular workspace config
├── tsconfig.json              # TypeScript config
├── tsconfig.spec.json         # Test config (Vitest)
├── proxy.conf.json            # Dev proxy: /api → localhost:5062
└── Dockerfile                 # Multi-stage: Node build → Nginx
```

## Angular Conventions

### Standalone Components Only

Every component is standalone (no NgModules):

```typescript
@Component({
  selector: 'app-gallery',
  imports: [Card, Header, Search],  // Import dependencies directly
  templateUrl: './gallery.html',
  styleUrl: './gallery.css',        // Note: singular, not styleUrls
})
export class Gallery { }
```

### Signals for State

Use Angular signals for reactive state:

```typescript
import { signal, computed } from '@angular/core';

export class Gallery {
  // Declare signal
  pokeList = signal<PokeCard[]>([]);

  // Computed signal (derived state)
  filteredList = computed(() => this.pokeList().filter(p => p.nombre.includes(this.searchTerm())));

  // Update signal
  loadPokemons() {
    this.pokemonService.getPokemons().subscribe(data => {
      this.pokeList.set(data);
    });
  }
}
```

### inject() Preferred

Use `inject()` function instead of constructor injection:

```typescript
// Preferred (modern)
export class Gallery {
  private pokemonService = inject(PokemonService);
  private router = inject(Router);
}

// Avoid (legacy)
export class Gallery {
  constructor(
    private pokemonService: PokemonService,
    private router: Router
  ) {}
}
```

### Modern Control Flow

Use new syntax in templates:

```html
<!-- Modern (use this) -->
@if (isLoggedIn()) {
  <app-header />
}

@for (pokemon of pokeList(); track pokemon.pokedexNumber) {
  <app-card [pokemon]="pokemon] />
} @empty {
  <p>No Pokémon found</p>
}

@switch (status()) {
  @case ('loading') { <spinner /> }
  @case ('error') { <error-message /> }
}

<!-- Avoid (legacy) -->
<div *ngIf="isLoggedIn">...</div>
<div *ngFor="let pokemon of pokeList">...</div>
```

## Routing

### Route Definitions

Routes are defined in `app.routes.ts`:

```typescript
export const routes: Routes = [
  { path: 'login', component: Login },
  {
    path: '',
    component: MainLayout,
    canActivate: [authGuard],
    children: [
      { path: 'gallery', component: Gallery },
      { path: 'card', component: Card },
      { path: 'search', component: Search },
      { path: 'header', component: Header },
    ]
  }
];
```

### Auth Guard

Functional guard that checks localStorage for JWT token:

```typescript
export const authGuard: CanActivateFn = (route, state) => {
  const router = inject(Router);
  const token = localStorage.getItem("token");
  if (token) {
    return true;
  }
  return router.createUrlTree(['/login']);
};
```

### Main Layout

`MainLayout` provides persistent header + nested `<router-outlet>`:

```typescript
@Component({
  selector: 'app-main-layout',
  imports: [Header, RouterOutlet],
  templateUrl: './main-layout.html',
})
export class MainLayout {}
```

```html
<!-- main-layout.html -->
<app-header />
<router-outlet />
```

## Services

### Service Pattern

All services use `providedIn: 'root'` (singleton):

```typescript
@Injectable({
  providedIn: 'root',
})
export class PokemonService {
  private apiUrl = "/api/pokemon";
  constructor(private http: HttpClient) { }

  getPokemons() {
    return this.http.get<PokeCard[]>(this.apiUrl);
  }
}
```

### HTTP Communication

- Base URL: `/api` (proxied to backend in dev via `proxy.conf.json`)
- Auth token attached automatically by `authInterceptor`
- Use typed responses: `http.get<PokeCard[]>` not `http.get<any>`

### Auth Interceptor

Functional interceptor that adds JWT to all requests:

```typescript
export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem("token");
  if (!token) {
    return next(req);
  }
  const authReq = req.clone({
    setHeaders: {
      Authorization: `Bearer ${token}`
    }
  });
  return next(authReq);
};
```

### Search Service

Custom observable-based event bus (not Subject/BehaviorSubject):

```typescript
@Injectable({ providedIn: 'root' })
export class SearchService {
  private onSearch: Subscriber<string>|null = null;

  onSearch$ = new Observable<string>(
    (sub) => this.onSearch = sub
  );

  search(searchName: string) {
    this.onSearch?.next(searchName);
  }
}
```

**Note**: This pattern only supports one subscriber. Consider refactoring to `BehaviorSubject` if multiple components need search events.

## Styling

### Tailwind CSS v4

Tailwind is imported in `styles.css`:

```css
@import 'tailwindcss';
```

**Important**: Tailwind v4 uses `@import` syntax, NOT `@tailwind` directives.

### Component Styles

Each component has its own CSS file (referenced as `styleUrl` singular):

```typescript
@Component({
  selector: 'app-card',
  templateUrl: './card.html',
  styleUrl: './card.css',  // Singular, not styleUrls
})
```

Most component CSS files are empty — styling is done with Tailwind classes in templates.

### Global Styles

`styles.css` contains:
- Tailwind import
- Global utility classes (`.btn`, `.textInput`)
- Base font and body styles

### Dynamic Styles

Card component applies dynamic background gradients based on Pokémon type:

```typescript
ngOnChanges() {
  if (this.pokemon?.type?.length === 2) {
    this.gradientStyle = `linear-gradient(135deg, ${this.pokemon.type[0].color}, ${this.pokemon.type[1].color})`;
  } else {
    this.cardClass = this.pokemon?.type?.[0]?.color || '#A8A878';
  }
}
```

## Models

### PokeCard Interface

```typescript
// poke-card.ts
export interface PokeCard {
    nombre: string;
    pokedexNumber: number;
    imagen: string;
    type: PokeType[];
}
```

### PokeType Interface

```typescript
// poke-type.ts
export interface PokeType {
    type: string;
    color: string;  // Hex color code (#FF0000)
}
```

### Naming Convention

- Interface names: PascalCase (`PokeCard`)
- Properties: camelCase matching backend response (`nombre`, `pokedexNumber`)
- Files: kebab-case (`poke-card.ts`)

## Testing

### Vitest Setup

Tests use Vitest with `vitest/globals` types:

```typescript
// tsconfig.spec.json includes:
"types": ["vitest/globals"]
```

### Component Test Pattern

```typescript
describe('Gallery', () => {
  let component: Gallery;
  let fixture: ComponentFixture<Gallery>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Gallery],
    }).compileComponents();

    fixture = TestBed.createComponent(Gallery);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
```

### Service Test Pattern

```typescript
describe('PokemonService', () => {
  let service: PokemonService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PokemonService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
```

### Spec File Location

Test files are co-located with source:
```
gallery/
├── gallery.ts
├── gallery.html
├── gallery.css
└── gallery.spec.ts      # Test file
```

## Icons

Lucide icons are provided in `app.config.ts`:

```typescript
provideLucideIcons(LucideCircleCheck, LucideHouse)
```

To add new icons:
1. Import icon from `lucide-angular`
2. Add to `provideLucideIcons()` array
3. Use in template: `<lucide-icon name="circle-check" />`

## Proxy Configuration

`proxy.conf.json` forwards `/api/*` to backend during development:

```json
{
  "/api": {
    "target": "http://localhost:5062",
    "secure": false,
    "changeOrigin": true
  }
}
```

**Production**: Nginx handles proxy (see `nginx.conf`).

## Adding a New Component

1. **Generate**: `npm run ng -- generate component features/new-component`
2. **Define interface** if needed in component file or `models/`
3. **Import dependencies** in `@Component.imports`
4. **Add route** in `app.routes.ts` if it's a page
5. **Write tests** in `new-component.spec.ts`

## Adding a New Service

1. **Create service**: `new-service.ts` in `shared/` or `services/`
2. **Use `providedIn: 'root'`** for singletons
3. **Inject HttpClient** for API calls
4. **Return typed Observables**: `http.get<MyType[]>`
5. **Write tests** in `new-service.spec.ts`

## Known Issues

- **SearchService**: Uses captured Subscriber pattern (single subscriber limit)
- **No default route**: `/` has no `redirectTo`, shows 404
- **No post-login navigation**: Login stores token but doesn't redirect
- **Mixed DI patterns**: Some services use `inject()`, others use constructor
- **Gallery subscribes in constructor**: Should use `ngOnInit` instead
- **Token expiry not enforced**: Guard only checks existence, not expiration
- **No error handling**: No loading states or error messages in UI
