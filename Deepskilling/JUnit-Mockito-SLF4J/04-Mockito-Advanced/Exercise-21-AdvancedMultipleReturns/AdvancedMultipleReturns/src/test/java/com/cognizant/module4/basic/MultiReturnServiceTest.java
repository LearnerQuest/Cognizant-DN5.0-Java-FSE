package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class MultiReturnServiceTest {

    @Test
    void testServiceWithMultipleReturnValues() {
        Repository mockRepository = mock(Repository.class);

        when(mockRepository.getData())
                .thenReturn("First Mock Data")
                .thenReturn("Second Mock Data");

        Service service = new Service(mockRepository);

        assertEquals("Processed First Mock Data", service.processData());
        assertEquals("Processed Second Mock Data", service.processData());

        System.out.println("Advanced Multiple Returns Test Passed");
    }
}