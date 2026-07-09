package com.cognizant.module4.basic;

public class MyService {

    private ExternalApi externalApi;

    public MyService(ExternalApi externalApi) {
        this.externalApi = externalApi;
    }

    public void delete(String id) {
        externalApi.deleteData(id);
    }
}