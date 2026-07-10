import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CourseService } from '../../services/course';


@Component({
  selector: 'app-service-demo',

  imports: [
    CommonModule
  ],

  templateUrl: './service-demo.html',
  styleUrl: './service-demo.css'
})


export class ServiceDemo implements OnInit {


  courses: string[] = [];


  constructor(private courseService: CourseService) {}


  ngOnInit(): void {

    this.courses = this.courseService.getCourses();

  }

}