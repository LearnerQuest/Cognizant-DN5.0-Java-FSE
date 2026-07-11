import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TestingDemo } from './testing-demo';

describe('TestingDemo', () => {
  let component: TestingDemo;
  let fixture: ComponentFixture<TestingDemo>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TestingDemo],
    }).compileComponents();

    fixture = TestBed.createComponent(TestingDemo);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
