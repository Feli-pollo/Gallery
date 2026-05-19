import { Routes } from '@angular/router';
import { Login } from './login/login';
import { Gallery } from './gallery/gallery';
import { Card } from './card/card';
import { Search } from './search/search';
import { Header } from './header/header';
import { MainLayout } from './shared/main-layout/main-layout';

export const routes: Routes = [
    // {path: '', redirectTo: 'home', pathMatch: 'full'},
    {path: '', component: MainLayout,
        children: [
            {path: 'header', component: Header},
            {path: 'search', component: Search},
            {path: 'card', component: Card},
            {path: 'gallery', component: Gallery}
        ]
    },
    {path: 'login', component: Login}
];
