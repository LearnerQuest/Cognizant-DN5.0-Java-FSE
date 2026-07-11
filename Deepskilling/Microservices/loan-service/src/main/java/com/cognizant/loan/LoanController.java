package com.cognizant.loan;
import org.springframework.web.bind.annotation.*;
@RestController
public class LoanController {
 @GetMapping("/loans/{number}")
 public Loan get(@PathVariable String number){return new Loan(number,"car",400000,3258,18);}
}
