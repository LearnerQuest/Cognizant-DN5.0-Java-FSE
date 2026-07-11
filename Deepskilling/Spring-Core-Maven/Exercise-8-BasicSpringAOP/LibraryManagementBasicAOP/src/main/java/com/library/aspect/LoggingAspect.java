package com.library.aspect;

public class LoggingAspect {

    public void beforeMethod() {
        System.out.println("AOP Before Advice: method execution started");
    }

    public void afterMethod() {
        System.out.println("AOP After Advice: method execution completed");
    }
}