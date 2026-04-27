import { Routes } from '@angular/router';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { StatisticsComponent } from './components/statistics/statistics.component';
import { ShopComponent } from './components/shop/shop.component';
import { HistoryComponent } from './components/history/history.component';
import { ProfileComponent } from './components/profile/profile.component';

export const routes: Routes = [
  { path: '', component: DashboardComponent },
  { path: 'statistics', component: StatisticsComponent },
  { path: 'shop', component: ShopComponent },
  { path: 'history', component: HistoryComponent },
  { path: 'profile', component: ProfileComponent }
];
