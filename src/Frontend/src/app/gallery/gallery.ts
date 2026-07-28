import { Component, OnInit, signal } from '@angular/core';
import { PokeCard } from '../poke-card';
import { Card } from '../card/card';
import { Search } from "../shared/search/search";
import { Header } from "../header/header";
import { SearchService } from '../shared/search.service';
import { PokemonService } from '../shared/pokemon.service';
import { CommonModule } from '@angular/common';

@Component({
    selector: 'app-gallery',
    imports: [CommonModule, Card, Search, Header],
    templateUrl: './gallery.html',
    styleUrl: './gallery.css',
})
export class Gallery implements OnInit {
    pokeList = signal<PokeCard[]>([]);
    pokeListFull: PokeCard[] = [];
    searchVersion = signal(0);

    constructor(private searchService: SearchService, private pokemonService: PokemonService) {
        this.searchService.onSearch$.subscribe((searchName: string) => {
            this.findSearch(searchName);
        });
    }

    ngOnInit(): void {
        this.GetPokemons();
    }

    private GetPokemons() {
        this.pokemonService.getPokemons().subscribe({
            next: (data) => {
                this.pokeList.set(data);
                this.pokeListFull = [...data];
            },
            error: (err) => {
                console.error(err);
            }
        });
    }

    findSearch(searchName: string) {
        this.searchVersion.update(v => v + 1);

        if (!searchName || searchName.trim() === '') {
            this.pokeList.set([...this.pokeListFull]);
        } else {
            const filtered = this.pokeListFull.filter(poke =>
                poke.nombre.toLowerCase().includes(searchName.toLowerCase())
            );
            this.pokeList.set(filtered);
        }
    }

    trackByPokemon(index: number, item: PokeCard): string {
        return `${item.pokedexNumber}-${this.searchVersion()}`;
    }
}
