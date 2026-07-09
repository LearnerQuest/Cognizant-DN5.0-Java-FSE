package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    Calculator calculator = new Calculator();

    @Test
    public void testAssertions() {

        // assertEquals
        assertEquals(5, calculator.add(2,3));

        // assertTrue
        assertTrue(10 > 5);

        // assertFalse
        assertFalse(5 > 10);

        // assertNotNull
        assertNotNull(calculator);

        // assertNull
        String value = null;
        assertNull(value);
    }
}