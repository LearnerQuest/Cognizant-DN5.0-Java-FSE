package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    void testArgumentMatching() {
        ExternalApi mockApi = mock(ExternalApi.class);
        when(mockApi.getDataById(anyInt())).thenReturn("Mock Data By ID");

        MyService service = new MyService(mockApi);
        String result = service.fetchDataById(101);

        assertEquals("Mock Data By ID", result);
        verify(mockApi).getDataById(anyInt());

        System.out.println("Argument matching completed");
    }
}