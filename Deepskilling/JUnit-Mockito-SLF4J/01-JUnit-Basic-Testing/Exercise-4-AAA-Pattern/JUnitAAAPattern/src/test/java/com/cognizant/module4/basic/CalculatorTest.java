package com.cognizant.module4.basic;

import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    Calculator calculator;

    @BeforeEach
    void setUp() {
        calculator = new Calculator();
        System.out.println("Setup completed");
    }

    @AfterEach
    void tearDown() {
        System.out.println("Test completed");
    }

    @Test
    void testAdditionUsingAAAPattern() {
        // Arrange
        int a = 2;
        int b = 3;

        // Act
        int result = calculator.add(a, b);

        // Assert
        assertEquals(5, result);
    }
}