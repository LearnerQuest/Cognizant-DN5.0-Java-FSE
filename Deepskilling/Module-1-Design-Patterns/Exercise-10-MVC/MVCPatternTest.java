public class MVCPatternTest {
    public static void main(String[] args) {
        Student student = new Student("Aashi", 101, "A");

        StudentView view = new StudentView();

        StudentController controller =
                new StudentController(student, view);

        controller.updateView();

        System.out.println();

        controller.setStudentName("Aashi Garg");
        controller.setStudentGrade("A+");

        controller.updateView();
    }
}