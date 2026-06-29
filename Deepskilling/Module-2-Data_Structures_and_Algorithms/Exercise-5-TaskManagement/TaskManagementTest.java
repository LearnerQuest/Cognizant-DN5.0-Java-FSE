public class TaskManagementTest {
    public static void main(String[] args) {
        TaskLinkedList taskList = new TaskLinkedList();

        taskList.addTask(new Task(1, "Complete DSA Exercise", "Pending"));
        taskList.addTask(new Task(2, "Push code to GitHub", "In Progress"));
        taskList.addTask(new Task(3, "Revise Spring Core", "Pending"));

        System.out.println();
        taskList.displayTasks();

        System.out.println("\nSearching task with ID 2:");
        Task task = taskList.searchTask(2);

        if (task != null) {
            task.displayTask();
        } else {
            System.out.println("Task not found.");
        }

        System.out.println("\nDeleting task with ID 1:");
        taskList.deleteTask(1);

        System.out.println();
        taskList.displayTasks();
    }
}