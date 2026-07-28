import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { PokeCard } from '../poke-card';
import { CommonModule } from '@angular/common';

@Component({
    selector: 'app-card',
    imports: [CommonModule],
    templateUrl: './card.html',
    styleUrl: './card.css',
})
export class Card implements OnInit, OnChanges {
    @Input() currentCard!: PokeCard;
    @Input() index: number = 0;

    gradientStyle: any = {};
    animationDelay: string = '0ms';
    typeNames: string = '';

    ngOnInit(): void {
        this.updateStyles();
    }

    ngOnChanges(changes: SimpleChanges): void {
        this.updateStyles();
    }

    updateStyles() {
        if (!this.currentCard?.type?.length) return;

        this.typeNames = this.currentCard.type.map(t => t.type).join(' / ');

        if (this.currentCard.type.length > 1) {
            const color1 = this.currentCard.type[0]?.color;
            const color2 = this.currentCard.type[1]?.color;
            this.gradientStyle = {
                'background': `linear-gradient(135deg, ${color1} 0%, ${color2} 100%)`
            };
        } else {
            const color = this.currentCard.type[0]?.color ?? '#A8A878';
            this.gradientStyle = {
                'background': `linear-gradient(135deg, ${color} 0%, ${this.darkenColor(color, 25)} 100%)`
            };
        }

        this.animationDelay = `${this.index * 60}ms`;
    }

    exploreFanart() {
        console.log('Explorar fanart de', this.currentCard.nombre);
    }

    uploadFanart() {
        console.log('Subir fanart de', this.currentCard.nombre);
    }

    toggleFavorite(event: Event) {
        event.stopPropagation();
        console.log('Toggle favorito', this.currentCard.nombre);
    }

    private darkenColor(hex: string, percent: number): string {
        const num = parseInt(hex.replace('#', ''), 16);
        const amt = Math.round(2.55 * percent);
        const R = Math.max((num >> 16) - amt, 0);
        const G = Math.max((num >> 8 & 0x00FF) - amt, 0);
        const B = Math.max((num & 0x0000FF) - amt, 0);
        return `#${(1 << 24 | R << 16 | G << 8 | B).toString(16).slice(1)}`;
    }
}
