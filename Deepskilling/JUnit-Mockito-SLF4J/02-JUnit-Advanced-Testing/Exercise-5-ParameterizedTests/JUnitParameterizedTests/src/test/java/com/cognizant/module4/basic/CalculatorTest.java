package com.cognizant.module4.basic;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    Calculator calculator = new Calculator();

    @ParameterizedTest
    @ValueSource(ints = {2,4,6,8,10})
    void testEvenNumbers(int number){

        assertTrue(number%2==0);

    }
}