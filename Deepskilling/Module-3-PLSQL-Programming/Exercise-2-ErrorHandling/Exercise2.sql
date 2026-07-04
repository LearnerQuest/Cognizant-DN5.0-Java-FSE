SET SERVEROUTPUT ON;

PROMPT ===== BEFORE ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== BEFORE CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== BEFORE EMPLOYEES =====
SELECT * FROM Employees;
----------------------------------------------------
-- SCENARIO 1: SAFE TRANSFER FUNDS
----------------------------------------------------

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    from_acc NUMBER,
    to_acc NUMBER,
    amt NUMBER
)
IS
    bal NUMBER;
BEGIN

    -- get balance
    SELECT Balance INTO bal
    FROM Accounts
    WHERE AccountID = from_acc;

    -- check balance
    IF bal < amt THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient Balance');
    END IF;

    -- debit
    UPDATE Accounts
    SET Balance = Balance - amt
    WHERE AccountID = from_acc;

    -- credit
    UPDATE Accounts
    SET Balance = Balance + amt
    WHERE AccountID = to_acc;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Transfer Successful');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

----------------------------------------------------
-- TEST SCENARIO 1
----------------------------------------------------

BEGIN
    SafeTransferFunds(1, 2, 1000);
END;
/

----------------------------------------------------
-- SCENARIO 2: UPDATE SALARY
----------------------------------------------------

CREATE OR REPLACE PROCEDURE UpdateSalary (
    emp_id NUMBER,
    percent NUMBER
)
IS
BEGIN

    UPDATE Employees
    SET Salary = Salary + (Salary * percent / 100)
    WHERE EmployeeID = emp_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee not found');
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary Updated');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

----------------------------------------------------
-- TEST SCENARIO 2
----------------------------------------------------

BEGIN
    UpdateSalary(1, 10);
END;
/

----------------------------------------------------
-- SCENARIO 3: ADD NEW CUSTOMER
----------------------------------------------------

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    c_id NUMBER,
    c_name VARCHAR2,
    c_dob DATE,
    c_balance NUMBER
)
IS
BEGIN

    INSERT INTO Customers
    VALUES (c_id, c_name, c_dob, c_balance, SYSDATE);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Customer Added');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Customer already exists');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

----------------------------------------------------
-- TEST SCENARIO 3
----------------------------------------------------

BEGIN
    AddNewCustomer(4, 'Mohit', TO_DATE('2000-02-01','YYYY-MM-DD'), 6000);
END;
/

----------------------------------------------------
-- CHECK
----------------------------------------------------
PROMPT ===== AFTER ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== AFTER CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== AFTER EMPLOYEES =====
SELECT * FROM Employees;
