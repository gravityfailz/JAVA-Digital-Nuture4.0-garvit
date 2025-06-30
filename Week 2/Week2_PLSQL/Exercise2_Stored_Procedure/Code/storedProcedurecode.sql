--Scenario 1: 
create or replace procedure processmonthlyinterest is
   bal accounts.balance%type;
begin
   for acc in (
      select accountid,
             balance
        from accounts
   ) loop
      bal := acc.balance;
      update accounts
         set
         balance = bal * 1.01
       where accountid = acc.accountid;

      dbms_output.put_line('ACCOUNT ID: '
                           || acc.accountid
                           || ', OLD BALANCE: '
                           || bal
                           || ', NEW BALANCE: '
                           ||(bal * 1.01));
   end loop;
   commit;
end;
/

EXEC PROCESSMONTHLYINTEREST;

--Scenario 2:
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
   bonusPercentage IN NUMBER,
   deptName IN VARCHAR2  
) IS
   bonus employees.salary%TYPE;
   sal   employees.salary%TYPE;
BEGIN
   FOR emp IN (
      SELECT employeeid, salary
      FROM employees
      WHERE department = deptName  
   ) LOOP
      sal := emp.salary;
      bonus := sal * (100 + bonusPercentage) / 100;
 
      UPDATE employees
      SET salary = bonus
      WHERE employeeid = emp.employeeid;
 
      DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp.employeeid ||
                           ', Old salary: ' || sal ||
                           ', New salary: ' || bonus);
   END LOOP;
 
   COMMIT;
END;
/ 


EXEC UPDATEEMPLOYEEBONUS(5, 'HR');

--Senario 3:-

CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account_id   IN NUMBER,
    to_account_id     IN NUMBER,
    amount_to_transfer IN NUMBER
)
AS
    from_balance NUMBER;
    to_balance   NUMBER;
BEGIN
    SELECT balance INTO from_balance
    FROM Accounts
    WHERE AccountID = from_account_id
    FOR UPDATE;

    IF from_balance < amount_to_transfer THEN
        RAISE_APPLICATION_ERROR(-20001, 'Not enough balance to complete the transfer.');
    END IF;

    SELECT balance INTO to_balance
    FROM Accounts
    WHERE AccountID = to_account_id
    FOR UPDATE;

    UPDATE Accounts
    SET balance = balance - amount_to_transfer,
        LastModified = SYSDATE
    WHERE AccountID = from_account_id;

    UPDATE Accounts
    SET balance = balance + amount_to_transfer,
        LastModified = SYSDATE
    WHERE AccountID = to_account_id;

    INSERT INTO Transactions (
        TransactionID, AccountID, TransactionDate, Amount, TransactionType
    ) VALUES (
        Transactions_seq.NEXTVAL, from_account_id, SYSDATE, amount_to_transfer, 'Withdrawal'
    );

    INSERT INTO Transactions (
        TransactionID, AccountID, TransactionDate, Amount, TransactionType
    ) VALUES (
        Transactions_seq.NEXTVAL, to_account_id, SYSDATE, amount_to_transfer, 'Deposit'
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
