import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  constructor() { }


  getCourses(): string[] {

    return [
      "Angular",
      "Java",
      "Spring Boot",
      "React",
      "SQL"
    ];

  }

}