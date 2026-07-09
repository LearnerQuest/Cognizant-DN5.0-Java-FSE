package com.cognizant.module4.basic;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({
        CalculatorTest.class,
        StringTest.class
})
public class AllTests {
}