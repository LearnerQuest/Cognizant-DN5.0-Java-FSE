package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    void testVoidMethodWithException() {
        ExternalApi mockApi = mock(ExternalApi.class);

        doThrow(new RuntimeException("Delete failed"))
                .when(mockApi)
                .deleteData("101");

        MyService service = new MyService(mockApi);

        RuntimeException exception = assertThrows(
                RuntimeException.class,
                () -> service.delete("101")
        );

        assertEquals("Delete failed", exception.getMessage());
        verify(mockApi).deleteData("101");

        System.out.println("Void method exception tested successfully");
    }
}