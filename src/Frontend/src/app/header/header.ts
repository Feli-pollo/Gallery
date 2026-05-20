import { Component } from '@angular/core';
import { Search } from '../shared/search/search';
import { SearchService } from '../shared/search.service';

@Component({
  selector: 'app-header',
  imports: [Search],
  templateUrl: './header.html',
  styleUrl: './header.css',
})

export class Header {
  constructor(private searchService: SearchService) {
  }

  findSearch(searchName: string) {
    this.searchService.search(searchName);
  }
}
