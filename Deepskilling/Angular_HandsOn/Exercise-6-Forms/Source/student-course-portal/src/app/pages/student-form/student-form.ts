import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
 selector:'app-student-form',
 imports:[FormsModule],
 templateUrl:'./student-form.html',
 styleUrl:'./student-form.css'
})
export class StudentForm {

name="";
email="";

submit(){
 alert("Form Submitted");
}

}