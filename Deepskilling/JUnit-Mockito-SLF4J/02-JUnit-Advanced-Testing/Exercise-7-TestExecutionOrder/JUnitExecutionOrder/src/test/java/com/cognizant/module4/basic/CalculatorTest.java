package com.cognizant.module4.basic;

import org.junit.jupiter.api.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CalculatorTest {

    @Test
    @Order(1)
    void firstTest() {
        System.out.println("First test executed");
    }

    @Test
    @Order(2)
    void secondTest() {
        System.out.println("Second test executed");
    }

    @Test
    @Order(3)
    void thirdTest() {
        System.out.println("Third test executed");
    }
}