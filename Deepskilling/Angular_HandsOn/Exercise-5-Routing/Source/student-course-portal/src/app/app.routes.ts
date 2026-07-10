import { Routes } from '@angular/router';

import { Home } from './pages/home/home';
import { CourseList } from './pages/course-list/course-list';
import { StudentProfile } from './pages/student-profile/student-profile';
import { StudentDashboard } from './pages/student-dashboard/student-dashboard';
import { RoutingDemo } from './pages/routing-demo/routing-demo';


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
    path: 'routing',
    component: RoutingDemo
  }

];