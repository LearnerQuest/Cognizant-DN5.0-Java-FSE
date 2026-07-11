package com.cognizant.greet;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
@RestController
public class GreetController {
 @Value("${server.port}") String port;
 @GetMapping("/greet")
 public String greet(){return "Hello World!! from port "+port;}
}
