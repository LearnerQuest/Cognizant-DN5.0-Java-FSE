package DeepSkill;
import java.util.Scanner;
public class Calculator {
  //Simple Calculator design for addition, substraction, multiplication, division and modulus operations
  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    int a = sc.nextInt();
    String operator = sc.next();
    int b = sc.nextInt();
    for(char c : operator.toCharArray()) {
      if (c == '+') {
        System.out.println(add(a, b));
      } else if (c == '-') {
        System.out.println(subtract(a, b));
      } else if (c == '*') {
        System.out.println(multiply(a, b));
      } else if (c == '/') {
        System.out.println(divide(a, b));
      } else {
        System.out.println("Invalid operator");
      }
    }
    if(b==0 && operator.equals("/")) {
      System.out.println("Division by zero is not allowed");
    }
    /*switch (operator) {
      case "+":
        System.out.println(add(a, b));
        break;
      case "-":
        System.out.println(subtract(a, b));
        break;
      case "*":
        System.out.println(multiply(a, b));
        break;
      case "/":
        System.out.println(divide(a, b));
        break;
    }*/
  }
  public static int add(int a, int b) {
    return a + b;
  }
  public static int subtract(int a, int b) {
    return a - b;
  }
  public static int multiply(int a, int b) {
    return a * b;
  }
  public static int divide(int a, int b) {
    return a/b;
  }
}
