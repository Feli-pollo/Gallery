import { Component, EventEmitter, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { LucideDynamicIcon } from '@lucide/angular';

@Component({
  selector: 'app-search',
  imports: [FormsModule, LucideDynamicIcon],
  templateUrl: './search.html',
  styleUrl: './search.css',
})

export class Search {
  @Output() findSearch = new EventEmitter<string>();
  searchBox: string = '';

  search() {
    this.findSearch.emit(this.searchBox);
  }
}
