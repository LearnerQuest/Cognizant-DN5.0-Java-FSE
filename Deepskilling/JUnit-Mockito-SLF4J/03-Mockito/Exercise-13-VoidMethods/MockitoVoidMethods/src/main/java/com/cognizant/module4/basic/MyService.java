package com.cognizant.module4.basic;

public class MyService {

    private ExternalApi externalApi;

    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public void save(String data) {
        externalApi.saveData(data);
    }
}