import { Routes } from '@angular/router';
import { Login } from './login/login';
import { Gallery } from './gallery/gallery';
import { MainLayout } from './shared/main-layout/main-layout';
import { authGuard } from './guards/auth-guard';

export const routes: Routes = [
    {
        path: '',
        canActivate: [authGuard],
        component: MainLayout,
        children: [
            { path: '', redirectTo: 'gallery', pathMatch: 'full' },
            { path: 'gallery', component: Gallery },
        ]
    },
    { path: 'login', component: Login },
    {
        path: 'register',
        loadComponent: () => import('./register/register').then(m => m.Register)
    },
    {
        path: 'error',
        loadComponent: () => import('./error-page/error-page').then(m => m.ErrorPage)
    },
    {
        path: '**',
        redirectTo: 'error',
        pathMatch: 'full'
    }
];
