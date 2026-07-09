package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class NetworkServiceTest {

    @Test
    void testServiceWithMockNetworkClient() {
        NetworkClient mockNetworkClient = mock(NetworkClient.class);
        when(mockNetworkClient.connect()).thenReturn("Mock Connection");

        NetworkService networkService = new NetworkService(mockNetworkClient);

        assertEquals("Connected to Mock Connection", networkService.connectToServer());
        System.out.println("Mock Network Test Passed");
    }
}