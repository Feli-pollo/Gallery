import { PokeType } from "./poke-type";

export interface PokeCard {
    nombre: string;
    pokedexNumber: number;
    imagen: string;
    type: PokeType[];
}
