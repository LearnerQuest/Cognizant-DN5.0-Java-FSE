package com.cognizant.gateway;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;
@RestController
public class FallbackController {
 @GetMapping("/fallback/payment")
 public Mono<String> fallback(){return Mono.just("Payment service unavailable - gateway fallback");}
}
