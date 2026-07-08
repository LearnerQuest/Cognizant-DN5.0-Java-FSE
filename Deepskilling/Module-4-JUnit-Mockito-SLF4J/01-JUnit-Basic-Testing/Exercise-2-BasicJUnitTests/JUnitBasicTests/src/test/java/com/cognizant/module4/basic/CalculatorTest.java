package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    Calculator calculator = new Calculator();

    @Test
    public void testAddition() {

        assertEquals(5, calculator.add(2,3));

    }

    @Test
    public void testSubtraction() {

        assertEquals(3, calculator.subtract(5,2));

    }

    @Test
    public void testMultiplication() {

        assertEquals(20, calculator.multiply(4,5));

    }

    @Test
    public void testDivision() {

        assertEquals(5, calculator.divide(20,4));

    }

}