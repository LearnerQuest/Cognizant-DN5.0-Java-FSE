package com.cognizant.payment;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import org.springframework.web.bind.annotation.*;
@RestController
@RequestMapping("/payments")
public class PaymentController {
 @GetMapping("/{id}")
 @CircuitBreaker(name="paymentService",fallbackMethod="fallback")
 public String pay(@PathVariable String id,@RequestParam(defaultValue="false") boolean fail){
  if(fail) throw new IllegalStateException("Simulated third-party failure");
  return "Payment "+id+" completed successfully";
 }
 public String fallback(String id,boolean fail,Throwable ex){
  return "Payment "+id+" is pending; fallback response returned";
 }
}
