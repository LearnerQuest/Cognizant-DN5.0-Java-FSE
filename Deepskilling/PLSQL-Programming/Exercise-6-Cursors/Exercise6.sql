SET SERVEROUTPUT ON;

PROMPT ===== BEFORE ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== BEFORE CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== BEFORE EMPLOYEES =====
SELECT * FROM Employees;
DECLARE
    CURSOR c1 IS SELECT * FROM Employees;
    e Employees%ROWTYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO e;
        EXIT WHEN c1%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(e.Name || ' - ' || e.Salary);
    END LOOP;
    CLOSE c1;
END;
/

PROMPT ===== AFTER ACCOUNTS =====
SELECT * FROM Accounts;

PROMPT ===== AFTER CUSTOMERS =====
SELECT * FROM Customers;

PROMPT ===== AFTER EMPLOYEES =====
SELECT * FROM Employees;