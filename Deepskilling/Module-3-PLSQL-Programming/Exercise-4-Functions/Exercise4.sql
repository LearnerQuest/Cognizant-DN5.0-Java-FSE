SET SERVEROUTPUT ON;

PROMPT ===== BEFORE ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== BEFORE CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== BEFORE EMPLOYEES =====
SELECT * FROM Employees;

-- Salary bonus calculator --

CREATE OR REPLACE FUNCTION CalcBonus (
    sal NUMBER
) RETURN NUMBER
IS
BEGIN
    RETURN sal * 0.10;
END;
/

SELECT CalcBonus(Salary) FROM Employees;

PROMPT ===== AFTER ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== AFTER CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== AFTER EMPLOYEES =====
SELECT * FROM Employees;
