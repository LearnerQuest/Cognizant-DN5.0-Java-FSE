import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RoutingDemo } from './routing-demo';

describe('RoutingDemo', () => {
  let component: RoutingDemo;
  let fixture: ComponentFixture<RoutingDemo>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RoutingDemo],
    }).compileComponents();

    fixture = TestBed.createComponent(RoutingDemo);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
