CREATE DATABASE ECommerce;
USE ECommerce;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price INT,
    Stock INT,
    Category VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Amount INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES
(1, 'Aditi', 25, 'New York', 'aditi@gmail.com'),
(2, 'Rahul', 32, 'Los Angeles', 'rahul@gmail.com'),
(3, 'Sneha', 35, 'New York', 'sneha@gmail.com'),
(4, 'Aman', 28, 'Chicago', 'aman@gmail.com'),
(5, 'Neha', 31, 'Los Angeles', 'neha@gmail.com');

INSERT INTO Products VALUES
(1, 'iPhone', 800, 10, 'Electronics'),
(2, 'Laptop', 1000, 3, 'Electronics'),
(3, 'Tablet', 300, 0, 'Electronics'),
(4, 'Shirt', 40, 20, 'Clothing'),
(5, 'Shoes', 60, 5, 'Footwear');

INSERT INTO Orders VALUES
(1, 1, 1, 800, '2024-01-10', 'Completed'),
(2, 2, 2, 1000, '2024-02-15', 'Pending'),
(3, 3, 3, 300, '2024-03-20', 'Completed'),
(4, 3, 1, 800, '2024-04-01', 'Cancelled'),
(5, 5, 4, 40, '2024-04-10', 'Completed');

SELECT SUM(Amount)
FROM Orders
WHERE CustomerID = 3;

SELECT SUM(Amount)
FROM Orders;

SELECT ProductName, Price * Stock AS StockValue
FROM Products;

SELECT *
FROM Customers
WHERE Age > 30 AND City = 'New York';

SELECT *
FROM Customers
WHERE City = 'Los Angeles' OR CustomerID IN
(SELECT CustomerID FROM Orders WHERE Amount > 500);

SELECT *
FROM Products
WHERE Stock > 0 AND Price < 50;

SELECT *
FROM Products
WHERE Stock < 5;

SELECT *
FROM Orders
WHERE Status != 'Completed';

SELECT *
FROM Products
WHERE Stock = 0 OR Category = 'Electronics';

SELECT Email
FROM Customers
WHERE Email LIKE '%@gmail.com';

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%Phone%';

SELECT *
FROM Customers
WHERE Name LIKE '_____';

SELECT *
FROM Products
WHERE ProductName LIKE '%Laptop%' OR ProductName LIKE '%Tablet%';

SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 2024;

SELECT *
FROM Customers
WHERE City IN ('New York', 'Los Angeles', 'Chicago');

SELECT *
FROM Products
WHERE Category NOT IN ('Electronics', 'Clothing');

SELECT *
FROM Orders
WHERE CustomerID IN (1, 3, 5);

SELECT *
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

SELECT *
FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT *
FROM Orders
WHERE Amount % 100 = 0;