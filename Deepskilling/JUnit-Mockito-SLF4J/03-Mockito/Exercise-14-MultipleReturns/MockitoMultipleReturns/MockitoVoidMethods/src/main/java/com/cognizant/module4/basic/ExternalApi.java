package com.cognizant.module4.basic;

public interface ExternalApi {
    String getData();
    String getDataById(int id);
    void saveData(String data);
}