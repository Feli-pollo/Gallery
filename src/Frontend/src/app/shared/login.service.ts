import { inject, Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap } from 'rxjs';

interface TokenResponse {
    token: string;
    expirationDate: string;
}

@Injectable({
    providedIn: 'root',
})
export class LoginService {
    private http = inject(HttpClient);
    private apiUrl = '/api/v1/auth';

    private currentUser = signal<any>(null);
    readonly user = this.currentUser.asReadonly();
    readonly isLoggedIn = signal(this.hasValidToken());

    login(credentials: { user: string; password: string }) {
        return this.http.post<TokenResponse>(`${this.apiUrl}/login`, credentials).pipe(
            tap(response => {
                localStorage.setItem('token', response.token);
                localStorage.setItem('expirationDate', response.expirationDate);
                this.isLoggedIn.set(true);
            })
        );
    }

    register(data: { user: string; email: string; password: string; displayName?: string }) {
        return this.http.post(`${this.apiUrl}/register`, data);
    }

    logout() {
        localStorage.removeItem('token');
        localStorage.removeItem('expirationDate');
        this.isLoggedIn.set(false);
        this.currentUser.set(null);
    }

    getToken(): string | null {
        return localStorage.getItem('token');
    }

    hasValidToken(): boolean {
        const token = localStorage.getItem('token');
        const expiration = localStorage.getItem('expirationDate');

        if (!token || !expiration) {
            return false;
        }

        const expirationDate = new Date(expiration);
        return expirationDate > new Date();
    }

    getCurrentUser() {
        return this.http.get(`${this.apiUrl}/me`).pipe(
            tap(user => this.currentUser.set(user))
        );
    }
}
