SET SERVEROUTPUT ON;

PROMPT ===== BEFORE ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== BEFORE CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== BEFORE EMPLOYEES =====
SELECT * FROM Employees;

--PACKAGE SPEC--
CREATE OR REPLACE PACKAGE BankPackage AS
    PROCEDURE Deposit(acc_id NUMBER, amt NUMBER);
    PROCEDURE Withdraw(acc_id NUMBER, amt NUMBER);
END BankPackage;
/

--PACKAGE BODY--
CREATE OR REPLACE PACKAGE BODY BankPackage AS

PROCEDURE Deposit(acc_id NUMBER, amt NUMBER) IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + amt
    WHERE AccountID = acc_id;

    DBMS_OUTPUT.PUT_LINE('Deposited');
END;

PROCEDURE Withdraw(acc_id NUMBER, amt NUMBER) IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance - amt
    WHERE AccountID = acc_id;

    DBMS_OUTPUT.PUT_LINE('Withdrawn');
END;

END BankPackage;
/

BEGIN
    BankPackage.Deposit(1,500);
    BankPackage.Withdraw(1,200);
END;
/

PROMPT ===== AFTER ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== AFTER CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== AFTER EMPLOYEES =====
SELECT * FROM Employees;