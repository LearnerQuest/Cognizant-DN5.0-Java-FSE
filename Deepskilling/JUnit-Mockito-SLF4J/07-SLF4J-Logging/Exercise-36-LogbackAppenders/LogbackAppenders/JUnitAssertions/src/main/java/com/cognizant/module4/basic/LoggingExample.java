package com.cognizant.module4.basic;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {

    private static final Logger logger =
            LoggerFactory.getLogger(LoggingExample.class);

    public static void main(String[] args) {

        logger.info("Application Started");

        logger.warn("This is warning message");

        logger.error("This is error message");
    }
}