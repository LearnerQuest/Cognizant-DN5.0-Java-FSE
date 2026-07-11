SET SERVEROUTPUT ON;

--------------------------------------------------
-- Scenario 1:
-- Apply 1% discount to loan interest rates
-- for customers above 60 years old
--------------------------------------------------

BEGIN
    FOR cust IN (
        SELECT CustomerID, DOB
        FROM Customers
    )
    LOOP
        IF TRUNC(MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12) > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                '1% interest discount applied for Customer ID: ' || cust.CustomerID
            );
        END IF;
    END LOOP;

    COMMIT;
END;
/

--------------------------------------------------
-- Scenario 2:
-- Mark customers as VIP if balance > 10000
--------------------------------------------------

--ALTER TABLE Customers ADD IsVIP VARCHAR2(5);

BEGIN
    FOR cust IN (
        SELECT CustomerID, Balance
        FROM Customers
    )
    LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Customer ID ' || cust.CustomerID || ' promoted to VIP.'
            );
        ELSE
            UPDATE Customers
            SET IsVIP = 'FALSE'
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
END;
/

--------------------------------------------------
-- Scenario 3:
-- Print reminders for loans due in next 30 days
--------------------------------------------------

BEGIN
    FOR loan_rec IN (
        SELECT l.LoanID, l.CustomerID, c.Name, l.EndDate
        FROM Loans l
        JOIN Customers c
        ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Loan ID ' || loan_rec.LoanID ||
            ' for customer ' || loan_rec.Name ||
            ' is due on ' || TO_CHAR(loan_rec.EndDate, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/
SELECT * FROM Customers;
SELECT * FROM Loans;
SET SERVEROUTPUT ON;