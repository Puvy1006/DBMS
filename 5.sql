-- STEP 1: CREATE DATABASE
CREATE DATABASE BankingDB;
USE BankingDB;

--------------------------------------------------
-- STEP 2: CREATE TABLES
--------------------------------------------------

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    branch_name VARCHAR(50),
    account_type VARCHAR(20),
    balance INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(20),
    amount INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount INT,
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

--------------------------------------------------
-- STEP 3: INSERT DATA
--------------------------------------------------

INSERT INTO Customers VALUES
(1, 'Amit', 'Pune'),
(2, 'Neha', 'Mumbai'),
(3, 'Ravi', 'Delhi'),
(4, 'Sneha', 'Pune'),
(5, 'Karan', 'Mumbai');

INSERT INTO Accounts VALUES
(101, 1, 'Pune', 'Savings', 30000),
(102, 2, 'Mumbai', 'Current', 20000),
(103, 3, 'Delhi', 'Savings', 15000),
(104, 1, 'Mumbai', 'Savings', 25000),
(105, 4, 'Pune', 'Current', 10000);

INSERT INTO Loans VALUES
(201, 1, 'Home', 500000),
(202, 2, 'Car', 200000),
(203, 3, 'Personal', 100000);

INSERT INTO Transactions VALUES
(301, 101, 'Deposit', 5000, '2026-01-10'),
(302, 102, 'Withdraw', 2000, '2026-02-15'),
(303, 103, 'Deposit', 3000, '2026-03-01'),
(304, 101, 'Withdraw', 1000, '2026-03-05'),
(305, 104, 'Deposit', 7000, '2026-03-10'),
(306, 105, 'Deposit', 2000, '2026-03-12');

--------------------------------------------------
-- STEP 4: QUERIES
--------------------------------------------------

-- 1. Total balance for each account type
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

-- 2. Number of accounts in each branch
SELECT branch_name, COUNT(*) AS total_accounts
FROM Accounts
GROUP BY branch_name;

-- 3. Number of customers in each city
SELECT city, COUNT(*) AS total_customers
FROM Customers
GROUP BY city;

-- 4. Loans approved per loan type
SELECT loan_type, COUNT(*) AS total_loans
FROM Loans
GROUP BY loan_type;

-- 5. Total transactions for each type
SELECT transaction_type, COUNT(*) AS total_transactions
FROM Transactions
GROUP BY transaction_type;

-- 6. Customers who do NOT have a loan
SELECT name
FROM Customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM Loans
);

-- 7. Customers having accounts in more than one branch
SELECT customer_id
FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT branch_name) > 1;

-- 8. Accounts with NO deposits in last 3 months
SELECT account_id
FROM Accounts
WHERE account_id NOT IN (
    SELECT account_id
    FROM Transactions
    WHERE transaction_type = 'Deposit'
    AND transaction_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
);

-- 9. Account types with total balance < 25000
SELECT account_type, SUM(balance)
FROM Accounts
GROUP BY account_type
HAVING SUM(balance) < 25000;

-- 10. Account types with total balance > 50000
SELECT account_type, SUM(balance)
FROM Accounts
GROUP BY account_type
HAVING SUM(balance) > 50000;

-- 11. Count transactions on dates with more than 5 transactions
SELECT transaction_date, COUNT(*) AS total
FROM Transactions
GROUP BY transaction_date
HAVING COUNT(*) > 5;

-- 12. Top 3 transaction days by total amount
SELECT transaction_date, SUM(amount) AS total_amount
FROM Transactions
GROUP BY transaction_date
ORDER BY total_amount DESC
LIMIT 3;

-- 13. Customers who have loan but no account
SELECT name
FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Loans)
AND customer_id NOT IN (SELECT customer_id FROM Accounts);