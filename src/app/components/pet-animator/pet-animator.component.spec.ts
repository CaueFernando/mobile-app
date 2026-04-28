import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PetAnimatorComponent } from './pet-animator.component';

describe('PetAnimatorComponent', () => {
  let component: PetAnimatorComponent;
  let fixture: ComponentFixture<PetAnimatorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PetAnimatorComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PetAnimatorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
