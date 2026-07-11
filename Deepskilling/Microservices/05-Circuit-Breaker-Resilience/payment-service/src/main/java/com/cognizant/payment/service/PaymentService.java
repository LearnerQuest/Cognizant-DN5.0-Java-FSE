package com.cognizant.payment.service;

import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    @CircuitBreaker(
            name = "paymentService",
            fallbackMethod = "paymentFallback"
    )
    public String processPayment(String orderId) {

        System.out.println("Calling external payment provider...");

        throw new RuntimeException(
                "External payment provider is unavailable"
        );
    }

    public String paymentFallback(
            String orderId,
            Throwable throwable) {

        System.out.println(
                "Fallback executed because: "
                + throwable.getMessage()
        );

        return "Payment temporarily unavailable for order "
                + orderId;
    }
}
