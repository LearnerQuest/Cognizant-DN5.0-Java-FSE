import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StateDemo } from './state-demo';

describe('StateDemo', () => {
  let component: StateDemo;
  let fixture: ComponentFixture<StateDemo>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [StateDemo],
    }).compileComponents();

    fixture = TestBed.createComponent(StateDemo);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
