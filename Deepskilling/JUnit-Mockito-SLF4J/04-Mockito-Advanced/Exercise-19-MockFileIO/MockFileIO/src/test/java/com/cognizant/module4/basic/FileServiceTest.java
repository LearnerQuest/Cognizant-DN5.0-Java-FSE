package com.cognizant.module4.basic;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class FileServiceTest {

    @Test
    void testServiceWithMockFileIO() {
        FileReader mockFileReader = mock(FileReader.class);
        FileWriter mockFileWriter = mock(FileWriter.class);

        when(mockFileReader.read()).thenReturn("Mock File Content");

        FileService fileService = new FileService(mockFileReader, mockFileWriter);

        assertEquals("Processed Mock File Content", fileService.processFile());
        verify(mockFileWriter).write("Mock File Content");

        System.out.println("Mock File IO Test Passed");
    }
}