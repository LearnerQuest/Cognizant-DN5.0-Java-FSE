# Exercise 1 - Singleton Design Pattern

## Objective

Develop a Logger utility that ensures only one object is created and shared across the application.

## Why Singleton?

Creating multiple logger objects increases memory usage and may lead to inconsistent logging. Singleton ensures that a single shared instance is used throughout the application.

## Files

- Logger.java
- SingletonTest.java

## Output

Logger intialized sucessfully.
[LOG] 19:23:59.396049700 - Firstmessage
[LOG] 19:23:59.419077500 - Second message
Logger1 and Logger2 refer to the same object.