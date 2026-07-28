import { Component, inject, signal } from '@angular/core';
import { LoginService } from '../shared/login.service';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';

@Component({
    selector: 'app-login',
    imports: [FormsModule, RouterLink],
    templateUrl: './login.html',
    styleUrl: './login.css',
})
export class Login {
    private loginService = inject(LoginService);
    private router = inject(Router);

    username = '';
    password = '';
    isLoading = signal(false);
    error = signal<string | null>(null);

    onSubmit(form: any) {
        if (form.invalid) {
            return;
        }

        this.isLoading.set(true);
        this.error.set(null);

        this.loginService.login({
            user: this.username,
            password: this.password
        }).subscribe({
            next: () => {
                this.router.navigate(['/gallery']);
            },
            error: (err) => {
                this.isLoading.set(false);
                this.error.set(err.error?.error || 'Invalid username or password');
            }
        });
    }
}
