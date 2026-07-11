import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-directives-demo',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './directives-demo.html',
  styleUrl: './directives-demo.css'
})
export class DirectivesDemo {

  showCourses = true;

  courses = [
    {
      name: 'Angular',
      duration: '3 Months'
    },
    {
      name: 'Spring Boot',
      duration: '4 Months'
    },
    {
      name: 'Java',
      duration: '2 Months'
    }
  ];

  toggleCourses() {
    this.showCourses = !this.showCourses;
  }

}