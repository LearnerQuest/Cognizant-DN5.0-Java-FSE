SET SERVEROUTPUT ON;

PROMPT ===== BEFORE ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== BEFORE CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== BEFORE EMPLOYEES =====
SELECT * FROM Employees;

-- 1. SAFE TRANSFER --

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    from_acc NUMBER,
    to_acc NUMBER,
    amt NUMBER
)
IS
    bal NUMBER;
BEGIN
    SELECT Balance INTO bal
    FROM Accounts
    WHERE AccountID = from_acc;

    IF bal < amt THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient Balance');
    END IF;

    UPDATE Accounts
    SET Balance = Balance - amt
    WHERE AccountID = from_acc;

    UPDATE Accounts
    SET Balance = Balance + amt
    WHERE AccountID = to_acc;

    DBMS_OUTPUT.PUT_LINE('Transfer Successful');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    SafeTransferFunds(1,2,500);
END;
/

-- 2. UPDATE SALARY --

CREATE OR REPLACE PROCEDURE UpdateSalary (
    emp_id NUMBER,
    percent NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * percent / 100)
    WHERE EmployeeID = emp_id;

    DBMS_OUTPUT.PUT_LINE('Salary Updated');
END;
/

BEGIN
    UpdateSalary(1,10);
END;
/

--3. ADD CUSTOMER--

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

    DBMS_OUTPUT.PUT_LINE('Customer Added');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Customer already exists');
END;
/

BEGIN
    AddNewCustomer(3,'Rahul',TO_DATE('2000-01-01','YYYY-MM-DD'),1000);
END;
/

PROMPT ===== AFTER ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== AFTER CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== AFTER EMPLOYEES =====
SELECT * FROM Employees;