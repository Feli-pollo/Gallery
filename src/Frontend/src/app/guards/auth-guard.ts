import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { LoginService } from '../shared/login.service';

export const authGuard: CanActivateFn = (route, state) => {
    const router = inject(Router);
    const loginService = inject(LoginService);

    if (loginService.hasValidToken()) {
        return true;
    }

    // Clear invalid token data
    loginService.logout();
    return router.createUrlTree(['/login']);
};
