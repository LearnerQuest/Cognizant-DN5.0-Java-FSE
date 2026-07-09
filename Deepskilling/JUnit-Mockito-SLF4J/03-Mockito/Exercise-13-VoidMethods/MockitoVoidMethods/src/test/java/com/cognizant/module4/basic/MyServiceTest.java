package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    void testVoidMethod() {
        ExternalApi mockApi = mock(ExternalApi.class);

        doNothing().when(mockApi).saveData("Book Saved");

        MyService service = new MyService(mockApi);
        service.save("Book Saved");

        verify(mockApi).saveData("Book Saved");
        System.out.println("Void method verified successfully");
    }
}