import { Injectable } from '@angular/core';

export interface SpriteConfig {
  imageUrl: string;
  frameWidth: number;
  frameHeight: number;
  frameCount: number;
  framesPerSecond: number;
}

@Injectable({
  providedIn: 'root'
})
export class PetAnimatorService {
  private animationFrameId: number | null = null;
  private currentFrame = 0;
  private lastFrameTime = 0;
  private frameInterval = 0;

  constructor() {}

  /**
   * Inicia animação do sprite no canvas
   */
  animate(
    canvas: HTMLCanvasElement,
    spriteConfig: SpriteConfig,
    callback?: (frame: number) => void
  ): void {
    const ctx = canvas.getContext('2d');
    if (!ctx) {
      console.error('Não foi possível obter contexto 2D do canvas');
      return;
    }

    const image = new Image();
    image.crossOrigin = 'anonymous';
    image.src = spriteConfig.imageUrl;

    console.log('🐕 Carregando sprite de:', spriteConfig.imageUrl);

    image.onload = () => {
      console.log('✅ Sprite carregado com sucesso!', image.width, 'x', image.height);
      
      this.frameInterval = 1000 / spriteConfig.framesPerSecond;
      this.currentFrame = 0;
      this.lastFrameTime = Date.now();

      const animate = () => {
        const now = Date.now();
        const elapsed = now - this.lastFrameTime;

        if (elapsed >= this.frameInterval) {
          // Limpa o canvas
          ctx.clearRect(0, 0, canvas.width, canvas.height);

          // Calcula a posição do frame no sprite sheet
          const sourceX = this.currentFrame * spriteConfig.frameWidth;
          const sourceY = 0;

          // Calcula posição centralizada no canvas
          const destX = (canvas.width - spriteConfig.frameWidth) / 2;
          const destY = (canvas.height - spriteConfig.frameHeight) / 2;

          // Desenha o frame do sprite sheet
          ctx.drawImage(
            image,
            sourceX,
            sourceY,
            spriteConfig.frameWidth,
            spriteConfig.frameHeight,
            destX,
            destY,
            spriteConfig.frameWidth,
            spriteConfig.frameHeight
          );

          this.currentFrame = (this.currentFrame + 1) % spriteConfig.frameCount;
          this.lastFrameTime = now;

          if (callback) {
            callback(this.currentFrame);
          }
        }

        this.animationFrameId = requestAnimationFrame(animate);
      };

      this.animationFrameId = requestAnimationFrame(animate);
    };

    image.onerror = () => {
      console.error('❌ Erro ao carregar sprite:', spriteConfig.imageUrl);
      console.error('Verifique se o arquivo existe em: public/', spriteConfig.imageUrl.replace(/^\//, ''));
    };
  }

  /**
   * Para a animação
   */
  stop(): void {
    if (this.animationFrameId !== null) {
      cancelAnimationFrame(this.animationFrameId);
      this.animationFrameId = null;
    }
  }

  /**
   * Reseta o frame atual
   */
  reset(): void {
    this.currentFrame = 0;
    this.lastFrameTime = 0;
  }
}
