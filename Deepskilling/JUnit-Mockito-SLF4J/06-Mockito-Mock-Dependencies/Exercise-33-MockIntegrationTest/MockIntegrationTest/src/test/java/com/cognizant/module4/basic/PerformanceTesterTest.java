package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import java.time.Duration;
import static org.junit.jupiter.api.Assertions.*;

public class PerformanceTesterTest {

    @Test
    void performanceTest() {
        PerformanceTester tester = new PerformanceTester();

        assertTimeout(Duration.ofSeconds(2), () -> {
            tester.performTask();
        });

        System.out.println("Performance test completed within time limit");
    }
}