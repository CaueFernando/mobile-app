import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';

interface NavItem {
  label: string;
  icon: string;
  route: string;
}

@Component({
  selector: 'app-bottom-nav',
  standalone: true,
  imports: [CommonModule, RouterLink, RouterLinkActive],
  templateUrl: './bottom-nav.component.html',
  styleUrl: './bottom-nav.component.scss'
})
export class BottomNavComponent {
  navItems: NavItem[] = [
    { label: 'Dashboard', icon: '🏠', route: '/' },
    { label: 'Estatísticas', icon: '📊', route: '/statistics' },
    { label: 'Pet Shop', icon: '🛍️', route: '/shop' },
    { label: 'Histórico', icon: '📋', route: '/history' },
    { label: 'Perfil', icon: '👤', route: '/profile' }
  ];
}
