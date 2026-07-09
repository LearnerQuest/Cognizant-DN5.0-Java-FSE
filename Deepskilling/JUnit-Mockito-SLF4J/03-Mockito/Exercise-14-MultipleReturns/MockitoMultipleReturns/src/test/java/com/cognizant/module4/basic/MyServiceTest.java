package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    void testMultipleReturns() {
        ExternalApi mockApi = mock(ExternalApi.class);

        when(mockApi.getData())
                .thenReturn("First Data")
                .thenReturn("Second Data");

        MyService service = new MyService(mockApi);

        assertEquals("First Data", service.fetchData());
        assertEquals("Second Data", service.fetchData());

        System.out.println("Multiple return values tested");
    }
}