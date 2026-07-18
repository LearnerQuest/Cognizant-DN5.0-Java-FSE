$ErrorActionPreference = "Stop"

$repo = "C:\Users\aashi\Downloads\Cognizant-Java-FSE"
$root = Join-Path $repo "Deepskilling\Spring REST using Spring Boot"

function Write-Utf8 {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $parent = Split-Path $Path -Parent

    if ($parent) {
        New-Item $parent -ItemType Directory -Force | Out-Null
    }

    [System.IO.File]::WriteAllText(
        $Path,
        $Content,
        [System.Text.UTF8Encoding]::new($false)
    )
}

New-Item $root -ItemType Directory -Force | Out-Null

# =========================================================
# EXERCISE 2 - GET REST SERVICES + MOCKMVC
# =========================================================

$ex2 = Join-Path $root "2. spring-rest-handson"
$p2  = Join-Path $ex2 "spring-learn"

$folders2 = @(
    "$p2\src\main\java\com\cognizant\springlearn\controller",
    "$p2\src\main\java\com\cognizant\springlearn\exception",
    "$p2\src\main\java\com\cognizant\springlearn\model",
    "$p2\src\main\java\com\cognizant\springlearn\service",
    "$p2\src\main\resources",
    "$p2\src\test\java\com\cognizant\springlearn",
    "$ex2\output"
)

foreach ($folder in $folders2) {
    New-Item $folder -ItemType Directory -Force | Out-Null
}

Write-Utf8 "$p2\pom.xml" @'
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         https://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.5</version>
        <relativePath/>
    </parent>

    <groupId>com.cognizant</groupId>
    <artifactId>spring-rest-get</artifactId>
    <version>1.0-SNAPSHOT</version>
    <name>spring-rest-get</name>

    <properties>
        <java.version>21</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
'@

Write-Utf8 "$p2\src\main\java\com\cognizant\springlearn\SpringLearnApplication.java" @'
package com.cognizant.springlearn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringLearnApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringLearnApplication.class, args);
    }
}
'@

Write-Utf8 "$p2\src\main\java\com\cognizant\springlearn\model\Country.java" @'
package com.cognizant.springlearn.model;

public class Country {

    private String code;
    private String name;

    public Country() {
    }

    public Country(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
'@

Write-Utf8 "$p2\src\main\java\com\cognizant\springlearn\exception\CountryNotFoundException.java" @'
package com.cognizant.springlearn.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(
        value = HttpStatus.BAD_REQUEST,
        reason = "Country Not found"
)
public class CountryNotFoundException extends RuntimeException {

    public CountryNotFoundException(String code) {
        super("Country not found for code: " + code);
    }
}
'@

Write-Utf8 "$p2\src\main\java\com\cognizant\springlearn\service\CountryService.java" @'
package com.cognizant.springlearn.service;

import com.cognizant.springlearn.exception.CountryNotFoundException;
import com.cognizant.springlearn.model.Country;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class CountryService {

    private final List<Country> countries = List.of(
            new Country("US", "United States"),
            new Country("DE", "Germany"),
            new Country("IN", "India"),
            new Country("JP", "Japan")
    );

    public List<Country> getAllCountries() {
        return countries;
    }

    public Country getCountry(String code) {
        return countries.stream()
                .filter(country ->
                        country.getCode().equalsIgnoreCase(code))
                .findFirst()
                .orElseThrow(() ->
                        new CountryNotFoundException(code));
    }
}
'@

Write-Utf8 "$p2\src\main\java\com\cognizant\springlearn\controller\HelloController.java" @'
package com.cognizant.springlearn.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    private static final Logger LOGGER =
            LoggerFactory.getLogger(HelloController.class);

    @GetMapping("/hello")
    public String sayHello() {

        LOGGER.info("sayHello START");

        String response = "Hello World!!";

        LOGGER.info("sayHello END");

        return response;
    }
}
'@

Write-Utf8 "$p2\src\main\java\com\cognizant\springlearn\controller\CountryController.java" @'
package com.cognizant.springlearn.controller;

import com.cognizant.springlearn.model.Country;
import com.cognizant.springlearn.service.CountryService;
import java.util.List;
import org.springframework.web.bind.annotation.*;

@RestController
public class CountryController {

    private final CountryService countryService;

    public CountryController(CountryService countryService) {
        this.countryService = countryService;
    }

    @GetMapping("/country")
    public Country getCountryIndia() {
        return countryService.getCountry("IN");
    }

    @GetMapping("/countries")
    public List<Country> getAllCountries() {
        return countryService.getAllCountries();
    }

    @GetMapping("/countries/{code}")
    public Country getCountry(
            @PathVariable String code) {

        return countryService.getCountry(code);
    }
}
'@

Write-Utf8 "$p2\src\main\resources\application.properties" @'
spring.application.name=spring-rest-get
server.port=8083

logging.level.com.cognizant.springlearn=DEBUG
server.error.include-message=always
'@

Write-Utf8 "$p2\src\test\java\com\cognizant\springlearn\SpringLearnApplicationTests.java" @'
package com.cognizant.springlearn;

import com.cognizant.springlearn.controller.CountryController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class SpringLearnApplicationTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private CountryController countryController;

    @Test
    void contextLoads() {
        assertNotNull(countryController);
    }

    @Test
    void helloEndpointReturnsHelloWorld() throws Exception {

        mockMvc.perform(get("/hello"))
                .andExpect(status().isOk())
                .andExpect(content().string("Hello World!!"));
    }

    @Test
    void countryEndpointReturnsIndia() throws Exception {

        mockMvc.perform(get("/countries/IN"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value("IN"))
                .andExpect(jsonPath("$.name").value("India"));
    }

    @Test
    void invalidCountryReturnsBadRequest() throws Exception {

        mockMvc.perform(get("/countries/AZ"))
                .andExpect(status().isBadRequest())
                .andExpect(status().reason("Country Not found"));
    }
}
'@

Write-Utf8 "$ex2\README.md" @'
# 2. Spring REST Hands-on

## Implemented

- GET `/hello`
- GET `/country`
- GET `/countries`
- GET `/countries/{code}`
- JSON response conversion
- Path variable handling
- Country-not-found exception
- MockMvc tests

## Run

```powershell
cd spring-learn
mvn clean test
mvn spring-boot:run