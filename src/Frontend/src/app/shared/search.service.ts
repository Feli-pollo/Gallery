import { Injectable } from '@angular/core';
import { Observable, Subscriber } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SearchService {
  private onSearch: Subscriber<string>|null = null;

  onSearch$ = new Observable<string>(
  (sub) => this.onSearch = sub 
  );

  search(searchName: string){
    this.onSearch?.next(searchName);
  }

}
