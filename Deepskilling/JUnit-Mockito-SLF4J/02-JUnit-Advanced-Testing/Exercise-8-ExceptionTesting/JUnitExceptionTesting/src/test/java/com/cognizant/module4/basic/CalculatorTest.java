package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    @Test
    void divideByZeroTest() {
        Calculator calculator = new Calculator();

        ArithmeticException exception = assertThrows(
                ArithmeticException.class,
                () -> calculator.divide(10, 0)
        );

        assertEquals("Cannot divide by zero", exception.getMessage());
        System.out.println("Exception handled successfully");
    }
}