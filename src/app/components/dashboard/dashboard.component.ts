import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PetAnimatorComponent } from '../pet-animator/pet-animator.component';

interface Pet {
  name: string;
  stage: 'newborn' | 'puppy' | 'young' | 'adult' | 'mature' | 'old';
  daysWithoutNicotine: number;
  moneysaved: number;
  vcoins: number;
}

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, PetAnimatorComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss'
})
export class DashboardComponent {
  pet = signal<Pet>({
    name: 'Puff',
    stage: 'young',
    daysWithoutNicotine: 3,
    moneysaved: 27,
    vcoins: 45
  });

  puffCount = signal(0);
  cigaretteCount = signal(0);

  addPuff() {
    this.puffCount.update(count => count + 1);
  }

  addCigarette() {
    this.cigaretteCount.update(count => count + 1);
  }

  shareProgress() {
    alert(`Compartilhando progresso: ${this.pet().daysWithoutNicotine} dias sem nicotina!`);
  }

  reportCraving() {
    alert('Vontade registrada! Continue firme!');
  }

  emergencyHelp() {
    alert('Procure ajuda de um especialista!');
  }
}
