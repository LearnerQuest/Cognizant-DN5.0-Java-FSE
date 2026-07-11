package com.cognizant.jwt.controller;

import com.cognizant.jwt.service.JwtService;
import java.security.Principal;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class JwtController {

    private final JwtService jwtService;

    public JwtController(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @GetMapping("/auth/token")
    public Map<String, String> generateToken(
            @RequestParam String username) {

        return Map.of(
                "token",
                jwtService.generateToken(username)
        );
    }

    @GetMapping("/secure")
    public String secureEndpoint(
            Principal principal) {

        return "JWT authentication successful for "
                + principal.getName();
    }
}
