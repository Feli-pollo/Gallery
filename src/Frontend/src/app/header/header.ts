import { Component, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { Search } from '../shared/search/search';
import { SearchService } from '../shared/search.service';
import { LoginService } from '../shared/login.service';

@Component({
    selector: 'app-header',
    imports: [Search, RouterLink],
    templateUrl: './header.html',
    styleUrl: './header.css',
})
export class Header {
    private searchService = inject(SearchService);
    private loginService = inject(LoginService);
    private router = inject(Router);

    findSearch(searchName: string) {
        this.searchService.search(searchName);
    }

    logout() {
        this.loginService.logout();
        this.router.navigate(['/login']);
    }
}
