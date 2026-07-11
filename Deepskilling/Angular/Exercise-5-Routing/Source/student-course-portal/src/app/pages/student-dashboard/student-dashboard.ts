import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-student-dashboard',
  imports: [FormsModule],
  templateUrl: './student-dashboard.html',
  styleUrl: './student-dashboard.css'
})
export class StudentDashboard implements OnInit {

  studentName = "Aashi Garg";
  course = "Angular";
  marks = 85;

  ngOnInit() {
    console.log("Student Dashboard Loaded");
  }

  changeCourse() {
    this.course = "Spring Boot";
  }

}