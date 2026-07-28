import { Component, OnInit, ElementRef, ViewChild, AfterViewInit } from '@angular/core';

@Component({
    selector: 'app-pokeball-bg',
    standalone: true,
    template: `<div #bgContainer class="pokeball-bg-container"></div>`,
    styles: [`
        .pokeball-bg-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
            overflow: hidden;
        }
    `]
})
export class PokeballBgComponent implements AfterViewInit {
    @ViewChild('bgContainer') bgContainer!: ElementRef;

    private pokeballTypes = [
        { id: 'pokeball', color: '#EF4444' },      // Red
        { id: 'greatball', color: '#3B82F6' },      // Blue
        { id: 'ultraball', color: '#1F2937' },      // Black
        { id: 'masterball', color: '#A855F7' },     // Purple
        { id: 'netball', color: '#06B6D4' }         // Cyan
    ];

    ngAfterViewInit() {
        this.generateBackground();
    }

    private generateBackground() {
        const svgNS = 'http://www.w3.org/2000/svg';
        const svg = document.createElementNS(svgNS, 'svg');
        svg.setAttribute('width', '100%');
        svg.setAttribute('height', '100%');
        svg.style.position = 'absolute';
        svg.style.top = '0';
        svg.style.left = '0';

        // Background color
        const bgRect = document.createElementNS(svgNS, 'rect');
        bgRect.setAttribute('width', '100%');
        bgRect.setAttribute('height', '100%');
        bgRect.setAttribute('fill', '#1a1a2e');
        svg.appendChild(bgRect);

        // Define pokeball symbols
        const defs = document.createElementNS(svgNS, 'defs');
        this.pokeballTypes.forEach(type => {
            const g = this.createPokeballSymbol(svgNS, type);
            defs.appendChild(g);
        });
        svg.appendChild(defs);

        // Generate pokeballs in a grid with random offsets (no overlaps)
        const windowWidth = window.innerWidth;
        const windowHeight = window.innerHeight;
        const cellSize = 140; // Larger cells = fewer pokeballs
        const margin = 30;

        const cols = Math.floor(windowWidth / cellSize);
        const rows = Math.floor(windowHeight / cellSize);

        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < cols; col++) {
                // Skip some cells randomly to make it feel more organic
                if (Math.random() < 0.3) continue;

                const type = this.pokeballTypes[Math.floor(Math.random() * this.pokeballTypes.length)];
                const use = document.createElementNS(svgNS, 'use');
                use.setAttribute('href', `#${type.id}`);

                // Base position in grid + random offset
                const baseX = col * cellSize + margin;
                const baseY = row * cellSize + margin;
                const offsetX = (Math.random() - 0.5) * 30;
                const offsetY = (Math.random() - 0.5) * 30;
                const x = baseX + offsetX;
                const y = baseY + offsetY;

                const rotation = Math.floor(Math.random() * 360) - 180;
                const scale = 0.85 + Math.random() * 0.3; // 0.85 to 1.15

                use.setAttribute('x', x.toString());
                use.setAttribute('y', y.toString());
                use.setAttribute('transform', `rotate(${rotation} ${x + 30} ${y + 30}) scale(${scale})`);
                use.setAttribute('opacity', (0.06 + Math.random() * 0.09).toString()); // 0.06 to 0.15

                svg.appendChild(use);
            }
        }

        this.bgContainer.nativeElement.innerHTML = '';
        this.bgContainer.nativeElement.appendChild(svg);
    }

    private createPokeballSymbol(svgNS: string, type: { id: string, color: string }): Element {
        const g = document.createElementNS(svgNS, 'g');
        g.setAttribute('id', type.id);

        // Circle background (white)
        const circle = document.createElementNS(svgNS, 'circle');
        circle.setAttribute('cx', '30');
        circle.setAttribute('cy', '30');
        circle.setAttribute('r', '28');
        circle.setAttribute('fill', 'white');
        circle.setAttribute('stroke', '#333');
        circle.setAttribute('stroke-width', '2');
        g.appendChild(circle);

        // Top half (colored)
        const topHalf = document.createElementNS(svgNS, 'path');
        topHalf.setAttribute('d', 'M2 30 A28 28 0 0 1 58 30');
        topHalf.setAttribute('fill', type.color);
        g.appendChild(topHalf);

        // Special designs for specific types
        if (type.id === 'greatball') {
            const stripe1 = document.createElementNS(svgNS, 'path');
            stripe1.setAttribute('d', 'M8 14 L24 28');
            stripe1.setAttribute('stroke', '#EF4444');
            stripe1.setAttribute('stroke-width', '3');
            g.appendChild(stripe1);

            const stripe2 = document.createElementNS(svgNS, 'path');
            stripe2.setAttribute('d', 'M52 14 L36 28');
            stripe2.setAttribute('stroke', '#EF4444');
            stripe2.setAttribute('stroke-width', '3');
            g.appendChild(stripe2);
        }

        if (type.id === 'ultraball') {
            const hShape = document.createElementNS(svgNS, 'path');
            hShape.setAttribute('d', 'M14 8 Q30 2 46 8 L42 28 L18 28 Z');
            hShape.setAttribute('fill', '#FCD34D');
            g.appendChild(hShape);
        }

        if (type.id === 'masterball') {
            const circle1 = document.createElementNS(svgNS, 'circle');
            circle1.setAttribute('cx', '18');
            circle1.setAttribute('cy', '20');
            circle1.setAttribute('r', '4');
            circle1.setAttribute('fill', '#EC4899');
            g.appendChild(circle1);

            const circle2 = document.createElementNS(svgNS, 'circle');
            circle2.setAttribute('cx', '42');
            circle2.setAttribute('cy', '20');
            circle2.setAttribute('r', '4');
            circle2.setAttribute('fill', '#EC4899');
            g.appendChild(circle2);

            const mLetter = document.createElementNS(svgNS, 'path');
            mLetter.setAttribute('d', 'M24 16 L30 24 L36 16');
            mLetter.setAttribute('stroke', 'white');
            mLetter.setAttribute('stroke-width', '2');
            mLetter.setAttribute('fill', 'none');
            g.appendChild(mLetter);
        }

        if (type.id === 'netball') {
            const line1 = document.createElementNS(svgNS, 'path');
            line1.setAttribute('d', 'M12 12 L48 28');
            line1.setAttribute('stroke', '#333');
            line1.setAttribute('stroke-width', '1');
            line1.setAttribute('opacity', '0.5');
            g.appendChild(line1);

            const line2 = document.createElementNS(svgNS, 'path');
            line2.setAttribute('d', 'M48 12 L12 28');
            line2.setAttribute('stroke', '#333');
            line2.setAttribute('stroke-width', '1');
            line2.setAttribute('opacity', '0.5');
            g.appendChild(line2);

            const line3 = document.createElementNS(svgNS, 'path');
            line3.setAttribute('d', 'M30 4 L30 28');
            line3.setAttribute('stroke', '#333');
            line3.setAttribute('stroke-width', '1');
            line3.setAttribute('opacity', '0.5');
            g.appendChild(line3);
        }

        // Center line
        const centerLine = document.createElementNS(svgNS, 'rect');
        centerLine.setAttribute('x', '2');
        centerLine.setAttribute('y', '28');
        centerLine.setAttribute('width', '56');
        centerLine.setAttribute('height', '4');
        centerLine.setAttribute('fill', '#333');
        g.appendChild(centerLine);

        // Center button
        const buttonOuter = document.createElementNS(svgNS, 'circle');
        buttonOuter.setAttribute('cx', '30');
        buttonOuter.setAttribute('cy', '30');
        buttonOuter.setAttribute('r', '9');
        buttonOuter.setAttribute('fill', 'white');
        buttonOuter.setAttribute('stroke', '#333');
        buttonOuter.setAttribute('stroke-width', '2');
        g.appendChild(buttonOuter);

        return g;
    }
}
