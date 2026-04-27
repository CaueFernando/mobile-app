import { Component } from '@angular/core';

@Component({
  selector: 'app-statistics',
  standalone: true,
  template: `
    <div class="page-container">
      <h1>Estatísticas</h1>
      <p>Página de estatísticas em desenvolvimento...</p>
    </div>
  `,
  styles: [`
    .page-container {
      padding: 20px;
      padding-bottom: 100px;
    }
  `]
})
export class StatisticsComponent {}
