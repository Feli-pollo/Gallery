# PokeGallery — Development Roadmap

> This file tracks the development phases. Check off items as they're completed.

---

## Phase 0: Documentation ✅

- [x] Create root AGENTS.md (project overview, architecture, conventions)
- [x] Create Backend AGENTS.md (API patterns, Dapper, services)
- [x] Create Frontend AGENTS.md (Angular 21, signals, Tailwind, Vitest)
- [x] Create Database AGENTS.md (schema, migrations, query patterns)
- [x] Create Auth AGENTS.md (JWT flow, security patterns)

---

## Phase 1: Foundation & Security 🔒

**Goal**: Fix security issues, establish patterns

### Backend
- [ ] Implement BCrypt password hashing
- [ ] Add fields to Users table (Email, DisplayName, Role, etc.)
- [ ] Create `POST /api/v1/auth/register` endpoint
- [ ] Refactor `POST /api/v1/auth/login` with real roles from DB
- [ ] Add UserId and Role claims to JWT
- [ ] Global exception handling middleware (ProblemDetails format)
- [ ] Split endpoints into files by domain (AuthEndpoints.cs, PokemonEndpoints.cs)
- [ ] Health check endpoint (`GET /health`)
- [ ] API versioning (`/api/v1/`)

### Frontend
- [ ] Refactor routing (Gallery as main route `/`)
- [ ] Create RegisterPage component
- [ ] Refactor AuthService with signals
- [ ] Improve authGuard to check token expiration
- [ ] ErrorPage (404, 500)
- [ ] Dark mode toggle

### Infrastructure
- [ ] SQL migration script for new Users fields
- [ ] Environment variables for BCrypt work factor

**Deliverable**: Secure login/registration, deployed with security improvements

---

## Phase 2: Fanart Upload & Storage 🖼️

**Goal**: Core feature — upload and display fanarts

### Backend
- [ ] Configure AWSSDK.S3 for Cloudflare R2
- [ ] Create StorageService (upload, delete, get URLs)
- [ ] Create ImageProcessingService with ImageSharp (resize, WebP, BlurHash)
- [ ] Create tables: Fanarts, Tags, FanartTags
- [ ] `POST /api/v1/fanarts` endpoint (multipart/form-data)
- [ ] `GET /api/v1/pokemon/{id}/fanarts` endpoint (paginated)
- [ ] Validations: real MIME type, max size (10MB), min dimensions

### Frontend
- [ ] UploadPage with drag & drop + preview
- [ ] ImagePreview component
- [ ] PokemonSelector component
- [ ] TagSelector component
- [ ] PokemonDetailPage with fanart grid
- [ ] FanartCard component (thumbnail + basic info)
- [ ] FanartDetailPage with full image
- [ ] Lightbox component
- [ ] Skeleton loading states

### Infrastructure
- [ ] Configure R2 bucket + CORS
- [ ] R2 environment variables in compose.yml
- [ ] SQL script for new tables
- [ ] Update Backend Dockerfile with ImageSharp dependency

**Deliverable**: Users can upload fanarts and view them in per-Pokémon galleries

---

## Phase 3: Social & Profiles 👥

**Goal**: Engagement and community features

### Backend
- [ ] Create tables: Likes, Comments, Follows, UserActivity
- [ ] Like endpoints (toggle)
- [ ] Comment endpoints (CRUD)
- [ ] Follow endpoints (follow/unfollow)
- [ ] User profile endpoint
- [ ] Recent activity endpoint
- [ ] Update LikesCount and CommentsCount in Fanarts (denormalized)

### Frontend
- [ ] LikeButton with heart animation
- [ ] CommentSection with form and list
- [ ] ProfilePage with tabs (fanarts, activity, followers)
- [ ] ProfileHeader (avatar, bio, stats, follow button)
- [ ] EditProfilePage
- [ ] ActivityFeed
- [ ] Toast notifications
- [ ] Infinite scroll in galleries

**Deliverable**: Complete social experience — likes, comments, profiles

---

## Phase 4: Moderation & Discovery 🔍

**Goal**: Scalability and content quality

### Backend
- [ ] Create Reports table
- [ ] Fanart status system (pending → approved/rejected)
- [ ] Moderation endpoints (admin only)
- [ ] Report endpoints
- [ ] Advanced search with filters (tag, artist, Pokémon, date)
- [ ] Trending endpoint (algorithm: recent likes / time)
- [ ] Personalized feed endpoint
- [ ] Rate limiting by IP and user

### Frontend
- [ ] AdminDashboard with stats
- [ ] ModerationQueue (approve/reject with preview)
- [ ] ReportDialog in fanart detail
- [ ] Advanced SearchPage with filters
- [ ] TrendingPage
- [ ] RecentPage
- [ ] FeedPage (requires login)
- [ ] Notification system (badge in header)

**Deliverable**: Moderated platform with discovery — ready to grow

---

## Phase 5: Polish & Technical Excellence ✨

**Goal**: Professional quality for portfolio

### Backend
- [ ] Unit tests (xUnit + mocked Dapper)
- [ ] Integration tests (WebApplicationFactory)
- [ ] Advanced rate limiting (sliding window)
- [ ] API response caching (popular fanarts)
- [ ] Background jobs for rejected image cleanup

### Frontend
- [ ] Unit tests with Vitest (services, pipes, utils)
- [ ] Component tests (Angular Testing Utilities)
- [ ] Virtual scrolling for large lists
- [ ] Optimistic UI (instant like, etc.)
- [ ] PWA support (service worker, manifest)
- [ ] SEO: dynamic meta tags, Open Graph, sitemap
- [ ] Accessibility audit (WCAG 2.1 AA)
- [ ] Angular animations
- [ ] Complete responsive design (mobile-first)
- [ ] Error boundaries

### Infrastructure
- [ ] Tests in CI pipeline
- [ ] Lighthouse CI
- [ ] Basic monitoring (health checks + structured logging)
- [ ] Automated database backups

**Deliverable**: Professional-grade project ready for job interviews

---

## Progress Tracker

| Phase | Status | Completion |
|-------|--------|------------|
| Phase 0: Documentation | ✅ Complete | 100% |
| Phase 1: Foundation & Security | 🔲 Not started | 0% |
| Phase 2: Fanart Upload & Storage | 🔲 Not started | 0% |
| Phase 3: Social & Profiles | 🔲 Not started | 0% |
| Phase 4: Moderation & Discovery | 🔲 Not started | 0% |
| Phase 5: Polish & Technical Excellence | 🔲 Not started | 0% |
