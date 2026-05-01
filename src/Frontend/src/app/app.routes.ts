import { Routes } from '@angular/router';
import { Login } from './login/login';
import { Gallery } from './gallery/gallery';

export const routes: Routes = [
    {path: '', redirectTo: 'home', pathMatch: 'full'},
    {path: 'login', component: Login},
    {path: 'gallery', component: Gallery}
];
