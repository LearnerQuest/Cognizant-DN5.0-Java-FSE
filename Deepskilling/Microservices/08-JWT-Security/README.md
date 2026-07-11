# Exercise 8 - JWT Security

## Objective
Generate JWT tokens and secure REST endpoints using bearer-token authentication.

## Port
8087

## Generate Token
GET /auth/token?username=Aashi

## Protected Endpoint
GET /secure

Header:
Authorization: Bearer TOKEN
