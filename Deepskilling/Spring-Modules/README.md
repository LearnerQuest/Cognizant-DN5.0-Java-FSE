# Cognizant DN5.0 - Spring Modules

This package contains ready-to-run Maven projects generated from the supplied hands-on documents.

## Modules

- Spring REST using Spring Boot
- Spring Data JPA with Hibernate

Each exercise is independent. Open the inner project folder containing `pom.xml`, then run:

```powershell
mvn clean test
mvn spring-boot:run
```

All database-based projects use the H2 in-memory database so no MySQL setup is required.
