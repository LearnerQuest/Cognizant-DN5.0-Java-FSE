package com.cognizant.module4.basic;

public class FileService {
    private FileReader fileReader;
    private FileWriter fileWriter;

    public FileService(FileReader fileReader, FileWriter fileWriter) {
        this.fileReader = fileReader;
        this.fileWriter = fileWriter;
    }

    public String processFile() {
        String data = fileReader.read();
        fileWriter.write(data);
        return "Processed " + data;
    }
}