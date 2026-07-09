package com.cognizant.module4.basic;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {

    private static final Logger logger =
            LoggerFactory.getLogger(LoggingExample.class);

    public static void main(String[] args) {

        String user = "Aashi";
        int id = 101;

        logger.info("User {} logged in with id {}", user, id);

        logger.warn("User {} has pending tasks", user);

        logger.error("Error occurred for user {}", user);
    }
}