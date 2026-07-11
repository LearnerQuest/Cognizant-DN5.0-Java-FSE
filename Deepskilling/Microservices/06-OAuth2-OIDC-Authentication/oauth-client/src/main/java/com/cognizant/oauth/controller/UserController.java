package com.cognizant.oauth.controller;

import java.security.Principal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @GetMapping("/")
    public String home() {
        return "OAuth2 Client is running. Open /user to login.";
    }

    @GetMapping("/user")
    public Principal user(Principal principal) {
        return principal;
    }
}
