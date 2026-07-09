package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import org.mockito.InOrder;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    void testInteractionOrder() {
        ExternalApi mockApi = mock(ExternalApi.class);
        MyService service = new MyService(mockApi);

        service.process();

        InOrder inOrder = inOrder(mockApi);
        inOrder.verify(mockApi).connect();
        inOrder.verify(mockApi).getData();
        inOrder.verify(mockApi).disconnect();

        System.out.println("Interaction order verified successfully");
    }
}