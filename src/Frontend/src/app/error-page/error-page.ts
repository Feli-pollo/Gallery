import { Component, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';

@Component({
    selector: 'app-error-page',
    imports: [RouterLink],
    templateUrl: './error-page.html',
    styleUrl: './error-page.css'
})
export class ErrorPage {
    private router = inject(Router);

    goHome() {
        this.router.navigate(['/gallery']);
    }
}
