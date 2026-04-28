import { Component, OnInit, OnDestroy, ViewChild, ElementRef, input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PetAnimatorService, SpriteConfig } from '../../services/pet-animator.service';

@Component({
  selector: 'app-pet-animator',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="pet-animator-container">
      <canvas
        #canvas
        [width]="canvasWidth()"
        [height]="canvasHeight()"
        class="pet-canvas"
      ></canvas>
    </div>
  `,
  styles: [`
    .pet-animator-container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 12px;
    }

    .pet-canvas {
      image-rendering: pixelated;
      image-rendering: crisp-edges;
      filter: drop-shadow(0 2px 8px rgba(0, 0, 0, 0.15));
    }
  `]
})
export class PetAnimatorComponent implements OnInit, OnDestroy {
  @ViewChild('canvas') canvasRef!: ElementRef<HTMLCanvasElement>;

  canvasWidth = input(150);
  canvasHeight = input(300);

  private spriteConfig: SpriteConfig = {
    imageUrl: '/dog01/idle/cute-dog01-idle.png',
    frameWidth: 440,
    frameHeight: 440,
    frameCount: 5,
    framesPerSecond: 1  // 1 frame por segundo
  };

  constructor(private animatorService: PetAnimatorService) {
    console.log('🐕 PetAnimatorComponent inicializado');
  }

  ngOnInit(): void {
    // Aguarda o template ser renderizado
    setTimeout(() => {
      const canvas = this.canvasRef.nativeElement;
      console.log('▶️ Iniciando animação do sprite');
      this.animatorService.animate(canvas, this.spriteConfig);
    }, 0);
  }

  ngOnDestroy(): void {
    console.log('⏹️ Parando animação do sprite');
    this.animatorService.stop();
  }
}
