import { Routes } from '@angular/router';

import { Home } from './pages/home/home';
import { CourseList } from './pages/course-list/course-list';
import { StudentProfile } from './pages/student-profile/student-profile';
import { StudentDashboard } from './pages/student-dashboard/student-dashboard';
import { ServiceDemo } from './pages/service-demo/service-demo';


export const routes: Routes = [

  {
    path: '',
    component: Home
  },

  {
    path: 'courses',
    component: CourseList
  },

  {
    path: 'profile',
    component: StudentProfile
  },

  {
    path: 'dashboard',
    component: StudentDashboard
  },

  {
    path: 'service',
    component: ServiceDemo
  }

];