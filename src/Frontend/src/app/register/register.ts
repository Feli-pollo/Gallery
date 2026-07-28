import { Component, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { LoginService } from '../shared/login.service';

@Component({
    selector: 'app-register',
    imports: [FormsModule, RouterLink],
    templateUrl: './register.html',
    styleUrl: './register.css'
})
export class Register {
    private loginService = inject(LoginService);
    private router = inject(Router);

    username = '';
    email = '';
    password = '';
    confirmPassword = '';
    displayName = '';

    isLoading = signal(false);
    error = signal<string | null>(null);

    register() {
        this.error.set(null);

        if (!this.username || !this.email || !this.password) {
            this.error.set('Please fill in all required fields');
            return;
        }

        if (this.password !== this.confirmPassword) {
            this.error.set('Passwords do not match');
            return;
        }

        if (this.password.length < 6) {
            this.error.set('Password must be at least 6 characters');
            return;
        }

        this.isLoading.set(true);

        this.loginService.register({
            user: this.username,
            email: this.email,
            password: this.password,
            displayName: this.displayName || this.username
        }).subscribe({
            next: () => {
                this.router.navigate(['/login']);
            },
            error: (err) => {
                this.isLoading.set(false);
                this.error.set(err.error?.error || 'Registration failed. Please try again.');
            }
        });
    }
}
