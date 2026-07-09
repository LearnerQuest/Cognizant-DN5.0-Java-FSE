package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class ApiServiceTest {

    @Test
    void testServiceWithMockRestClient() {
        RestClient mockRestClient = mock(RestClient.class);
        when(mockRestClient.getResponse()).thenReturn("Mock Response");

        ApiService apiService = new ApiService(mockRestClient);

        assertEquals("Fetched Mock Response", apiService.fetchData());
        System.out.println("Mock REST API Test Passed");
    }
}