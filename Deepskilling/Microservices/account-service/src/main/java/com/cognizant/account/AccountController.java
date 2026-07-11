package com.cognizant.account;
import org.springframework.web.bind.annotation.*;
@RestController
public class AccountController {
 @GetMapping("/accounts/{number}")
 public Account get(@PathVariable String number){return new Account(number,"savings",234343);}
}
