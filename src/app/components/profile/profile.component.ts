import { Component } from '@angular/core';

@Component({
  selector: 'app-profile',
  standalone: true,
  template: `
    <div class="page-container">
      <h1>Perfil</h1>
      <p>Sua página de perfil em desenvolvimento...</p>
    </div>
  `,
  styles: [`
    .page-container {
      padding: 20px;
      padding-bottom: 100px;
    }
  `]
})
export class ProfileComponent {}
