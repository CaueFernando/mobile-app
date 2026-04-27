import { Component } from '@angular/core';

@Component({
  selector: 'app-shop',
  standalone: true,
  template: `
    <div class="page-container">
      <h1>Pet Shop</h1>
      <p>Loja de itens em desenvolvimento...</p>
    </div>
  `,
  styles: [`
    .page-container {
      padding: 20px;
      padding-bottom: 100px;
    }
  `]
})
export class ShopComponent {}
