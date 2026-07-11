package com.cognizant.greet.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetController {

    @Value("${server.port}")
    private String serverPort;

    @GetMapping("/greet")
    public String greet() {
        return "Hello from Greet Service on port " + serverPort;
    }
}
