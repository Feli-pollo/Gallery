import { Component } from '@angular/core';
import { Header } from "../../header/header";
import { RouterOutlet } from '@angular/router';
import { PokeballBgComponent } from '../pokeball-bg/pokeball-bg';

@Component({
    selector: 'app-main-layout',
    imports: [Header, RouterOutlet, PokeballBgComponent],
    templateUrl: './main-layout.html',
    styleUrl: './main-layout.css',
})
export class MainLayout {}
