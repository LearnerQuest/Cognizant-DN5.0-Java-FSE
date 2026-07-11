$ErrorActionPreference = "Stop"

$Root = "C:\Users\aashi\Downloads\Cognizant-Java-FSE\Deepskilling\Microservices"
$Boot = "3.4.5"
$Cloud = "2024.0.1"

function File($Path, $Text) {
    New-Item -ItemType Directory -Path (Split-Path $Path -Parent) -Force | Out-Null
    Set-Content -Path $Path -Value $Text -Encoding UTF8
}

function Pom($Dir, $Artifact, $Deps) {
    $map = @{
        web = '<dependency><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-web</artifactId></dependency>'
        eurekaClient = '<dependency><groupId>org.springframework.cloud</groupId><artifactId>spring-cloud-starter-netflix-eureka-client</artifactId></dependency>'
        eurekaServer = '<dependency><groupId>org.springframework.cloud</groupId><artifactId>spring-cloud-starter-netflix-eureka-server</artifactId></dependency>'
        gateway = '<dependency><groupId>org.springframework.cloud</groupId><artifactId>spring-cloud-starter-gateway</artifactId></dependency>'
        loadbalancer = '<dependency><groupId>org.springframework.cloud</groupId><artifactId>spring-cloud-starter-loadbalancer</artifactId></dependency>'
        resilience = '<dependency><groupId>org.springframework.cloud</groupId><artifactId>spring-cloud-starter-circuitbreaker-resilience4j</artifactId></dependency><dependency><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-actuator</artifactId></dependency>'
    }
    $dependencies = ($Deps | ForEach-Object { $map[$_] }) -join "`n"
    File "$Dir\pom.xml" @"
<project xmlns="http://maven.apache.org/POM/4.0.0"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
 <modelVersion>4.0.0</modelVersion>
 <parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>$Boot</version>
  <relativePath/>
 </parent>
 <groupId>com.cognizant</groupId>
 <artifactId>$Artifact</artifactId>
 <version>0.0.1-SNAPSHOT</version>
 <properties>
  <java.version>21</java.version>
  <spring-cloud.version>$Cloud</spring-cloud.version>
 </properties>
 <dependencies>
  $dependencies
  <dependency><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-test</artifactId><scope>test</scope></dependency>
 </dependencies>
 <dependencyManagement>
  <dependencies>
   <dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-dependencies</artifactId>
    <version>`${spring-cloud.version}</version>
    <type>pom</type><scope>import</scope>
   </dependency>
  </dependencies>
 </dependencyManagement>
 <build><plugins><plugin><groupId>org.springframework.boot</groupId><artifactId>spring-boot-maven-plugin</artifactId></plugin></plugins></build>
</project>
"@
}

New-Item -ItemType Directory -Path $Root -Force | Out-Null

# Eureka
$d="$Root\eureka-discovery-server"
Pom $d "eureka-discovery-server" @("eurekaServer")
File "$d\src\main\java\com\cognizant\eureka\EurekaDiscoveryServerApplication.java" @'
package com.cognizant.eureka;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;
@EnableEurekaServer
@SpringBootApplication
public class EurekaDiscoveryServerApplication {
 public static void main(String[] args){SpringApplication.run(EurekaDiscoveryServerApplication.class,args);}
}
'@
File "$d\src\main\resources\application.properties" @'
spring.application.name=eureka-discovery-server
server.port=8761
eureka.client.register-with-eureka=false
eureka.client.fetch-registry=false
logging.level.com.netflix.eureka=OFF
logging.level.com.netflix.discovery=OFF
'@

# Account
$d="$Root\account-service"
Pom $d "account-service" @("web","eurekaClient")
File "$d\src\main\java\com\cognizant\account\AccountServiceApplication.java" @'
package com.cognizant.account;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class AccountServiceApplication {
 public static void main(String[] args){SpringApplication.run(AccountServiceApplication.class,args);}
}
'@
File "$d\src\main\java\com\cognizant\account\Account.java" @'
package com.cognizant.account;
public record Account(String number,String type,double balance){}
'@
File "$d\src\main\java\com\cognizant\account\AccountController.java" @'
package com.cognizant.account;
import org.springframework.web.bind.annotation.*;
@RestController
public class AccountController {
 @GetMapping("/accounts/{number}")
 public Account get(@PathVariable String number){return new Account(number,"savings",234343);}
}
'@
File "$d\src\main\resources\application.properties" @'
spring.application.name=account-service
server.port=8080
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
eureka.instance.prefer-ip-address=true
'@

# Loan
$d="$Root\loan-service"
Pom $d "loan-service" @("web","eurekaClient")
File "$d\src\main\java\com\cognizant\loan\LoanServiceApplication.java" @'
package com.cognizant.loan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class LoanServiceApplication {
 public static void main(String[] args){SpringApplication.run(LoanServiceApplication.class,args);}
}
'@
File "$d\src\main\java\com\cognizant\loan\Loan.java" @'
package com.cognizant.loan;
public record Loan(String number,String type,double loan,double emi,int tenure){}
'@
File "$d\src\main\java\com\cognizant\loan\LoanController.java" @'
package com.cognizant.loan;
import org.springframework.web.bind.annotation.*;
@RestController
public class LoanController {
 @GetMapping("/loans/{number}")
 public Loan get(@PathVariable String number){return new Loan(number,"car",400000,3258,18);}
}
'@
File "$d\src\main\resources\application.properties" @'
spring.application.name=loan-service
server.port=8081
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
eureka.instance.prefer-ip-address=true
'@

# Greet service; run twice for load balancing
$d="$Root\greet-service"
Pom $d "greet-service" @("web","eurekaClient")
File "$d\src\main\java\com\cognizant\greet\GreetServiceApplication.java" @'
package com.cognizant.greet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class GreetServiceApplication {
 public static void main(String[] args){SpringApplication.run(GreetServiceApplication.class,args);}
}
'@
File "$d\src\main\java\com\cognizant\greet\GreetController.java" @'
package com.cognizant.greet;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
@RestController
public class GreetController {
 @Value("${server.port}") String port;
 @GetMapping("/greet")
 public String greet(){return "Hello World!! from port "+port;}
}
'@
File "$d\src\main\resources\application.properties" @'
spring.application.name=greet-service
server.port=${PORT:8082}
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
eureka.instance.prefer-ip-address=true
'@

# Payment + circuit breaker
$d="$Root\payment-service"
Pom $d "payment-service" @("web","eurekaClient","resilience")
File "$d\src\main\java\com\cognizant\payment\PaymentServiceApplication.java" @'
package com.cognizant.payment;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class PaymentServiceApplication {
 public static void main(String[] args){SpringApplication.run(PaymentServiceApplication.class,args);}
}
'@
File "$d\src\main\java\com\cognizant\payment\PaymentController.java" @'
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
'@
File "$d\src\main\resources\application.properties" @'
spring.application.name=payment-service
server.port=8083
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
eureka.instance.prefer-ip-address=true
management.endpoints.web.exposure.include=health,info,circuitbreakers
resilience4j.circuitbreaker.instances.paymentService.sliding-window-size=5
resilience4j.circuitbreaker.instances.paymentService.failure-rate-threshold=50
resilience4j.circuitbreaker.instances.paymentService.wait-duration-in-open-state=10s
'@

# Gateway
$d="$Root\api-gateway"
Pom $d "api-gateway" @("gateway","eurekaClient","loadbalancer","resilience")
File "$d\src\main\java\com\cognizant\gateway\ApiGatewayApplication.java" @'
package com.cognizant.gateway;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class ApiGatewayApplication {
 public static void main(String[] args){SpringApplication.run(ApiGatewayApplication.class,args);}
}
'@
File "$d\src\main\java\com\cognizant\gateway\LoggingFilter.java" @'
package com.cognizant.gateway;
import org.slf4j.*;
import org.springframework.cloud.gateway.filter.*;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
@Component
public class LoggingFilter implements GlobalFilter,Ordered {
 private static final Logger log=LoggerFactory.getLogger(LoggingFilter.class);
 public Mono<Void> filter(ServerWebExchange exchange,GatewayFilterChain chain){
  log.info("Incoming request: {} {}",exchange.getRequest().getMethod(),exchange.getRequest().getURI());
  return chain.filter(exchange);
 }
 public int getOrder(){return -1;}
}
'@
File "$d\src\main\java\com\cognizant\gateway\FallbackController.java" @'
package com.cognizant.gateway;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;
@RestController
public class FallbackController {
 @GetMapping("/fallback/payment")
 public Mono<String> fallback(){return Mono.just("Payment service unavailable - gateway fallback");}
}
'@
File "$d\src\main\resources\application.yml" @'
spring:
  application:
    name: api-gateway
  cloud:
    gateway:
      discovery:
        locator:
          enabled: true
          lower-case-service-id: true
      routes:
        - id: account
          uri: lb://account-service
          predicates: [ Path=/api/accounts/** ]
          filters:
            - RewritePath=/api/accounts/(?<s>.*), /accounts/${s}
        - id: loan
          uri: lb://loan-service
          predicates: [ Path=/api/loans/** ]
          filters:
            - RewritePath=/api/loans/(?<s>.*), /loans/${s}
        - id: greet
          uri: lb://greet-service
          predicates: [ Path=/api/greet ]
          filters:
            - RewritePath=/api/greet, /greet
        - id: payment
          uri: lb://payment-service
          predicates: [ Path=/api/payments/** ]
          filters:
            - RewritePath=/api/payments/(?<s>.*), /payments/${s}
            - name: CircuitBreaker
              args:
                name: paymentGatewayCircuitBreaker
                fallbackUri: forward:/fallback/payment
server:
  port: 9090
eureka:
  client:
    service-url:
      defaultZone: http://localhost:8761/eureka/
  instance:
    prefer-ip-address: true
management:
  endpoints:
    web:
      exposure:
        include: health,info,gateway,circuitbreakers
'@

# Build all
$projects=@("eureka-discovery-server","account-service","loan-service","greet-service","payment-service","api-gateway")
foreach($p in $projects){
 Write-Host "Building $p..."
 Push-Location "$Root\$p"
 mvn clean package -DskipTests
 if($LASTEXITCODE -ne 0){Pop-Location;throw "Build failed: $p"}
 Pop-Location
}

# Runner
File "$Root\run-all.ps1" @'
$Root=Split-Path -Parent $MyInvocation.MyCommand.Path
$Log="$Root\logs"
New-Item -ItemType Directory -Path $Log -Force|Out-Null
function Run($Name,$Port=""){
 $jar=Get-ChildItem "$Root\$Name\target\*.jar"|Where-Object{$_.Name-notlike"*.original"}|Select-Object -First 1
 $prefix=if($Port){"`$env:PORT='$Port'; "}else{""}
 Start-Process powershell -ArgumentList "-NoExit","-Command","$prefix java -jar `"$($jar.FullName)`" *> `"$Log\$Name-$Port.log`""
 Write-Host "Started $Name $Port"
}
Run "eureka-discovery-server"
Start-Sleep 12
Run "account-service"
Run "loan-service"
Run "greet-service" "8082"
Run "greet-service" "8088"
Run "payment-service"
Start-Sleep 15
Run "api-gateway"
Write-Host ""
Write-Host "Eureka:  http://localhost:8761"
Write-Host "Greet:   http://localhost:9090/api/greet"
Write-Host "Account: http://localhost:9090/api/accounts/00987987973432"
Write-Host "Loan:    http://localhost:9090/api/loans/H00987987972342"
Write-Host "Payment: http://localhost:9090/api/payments/P100"
Write-Host "Fallback:http://localhost:9090/api/payments/P100?fail=true"
'@

File "$Root\stop-all.ps1" @'
Get-CimInstance Win32_Process |
 Where-Object{$_.Name-eq"java.exe"-and$_.CommandLine-like"*\Deepskilling\Microservices\*"} |
 ForEach-Object{Stop-Process -Id $_.ProcessId -Force;Write-Host "Stopped $($_.ProcessId)"}
'@

File "$Root\README.md" @'
# Microservices Hands-On

Created automatically:
- Account Service â€” `/accounts/{number}` on 8080
- Loan Service â€” `/loans/{number}` on 8081
- Eureka Discovery Server on 8761
- Two Greet Service instances on 8082 and 8088
- API Gateway on 9090 with discovery, routing, path rewriting, load balancing and global logging
- Payment Service on 8083 with Resilience4j fallback

Run:
```powershell
.\run-all.ps1
```

Stop:
```powershell
.\stop-all.ps1
```
'@

Write-Host ""
Write-Host "COMPLETE. Run:"
Write-Host "cd `"$Root`""
Write-Host ".\run-all.ps1"

