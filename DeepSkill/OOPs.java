package DeepSkill;
public class OOPs {
   class Student{
    int rollno;
    String name;
    Student(int rollno, String name){
      this.rollno=rollno;
      this.name=name;
    }
   }
   //inheretance of inner class
   class Test extends Student{
    Test(int rollno, String name){
      super(rollno,name);
    }
    //polymorphism of inner class
    
    class Test2 extends Test{
      Test2(int rollno, String name){
        super(rollno,name);
      }
    }
   }
   class TestStudent{
    public static void main(String args[]){
      OOPs outer = new OOPs();
      OOPs.Student s1 = outer.new Student(111,"Karan");
      OOPs.Student s2 = outer.new Student(222,"Aryan");
      System.out.println(s1.rollno+" "+s1.name);
      System.out.println(s2.rollno+" "+s2.name);
    }
   }
}

