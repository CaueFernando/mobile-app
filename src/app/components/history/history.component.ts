import { Component } from '@angular/core';

@Component({
  selector: 'app-history',
  standalone: true,
  template: `
    <div class="page-container">
      <h1>Histórico</h1>
      <p>Seu histórico de atividades em desenvolvimento...</p>
    </div>
  `,
  styles: [`
    .page-container {
      padding: 20px;
      padding-bottom: 100px;
    }
  `]
})
export class HistoryComponent {}
