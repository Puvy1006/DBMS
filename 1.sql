CREATE DATABASE inventory_db;
USE inventory_db;

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
CREATE TABLE Supplier (
    Supplier_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Contact VARCHAR(15)
);CREATE TABLE Warehouse (
    Warehouse_ID INT PRIMARY KEY,
    Location VARCHAR(100)
);CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE,
    Customer_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
CREATE TABLE Order_Product (
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
CREATE TABLE Product_Supplier (
    Product_ID INT,
    Supplier_ID INT,
    PRIMARY KEY (Product_ID, Supplier_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);
CREATE TABLE Warehouse_Product (
    Warehouse_ID INT,
    Product_ID INT,
    Quantity INT,
    PRIMARY KEY (Warehouse_ID, Product_ID),
    FOREIGN KEY (Warehouse_ID) REFERENCES Warehouse(Warehouse_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

INSERT INTO Customer VALUES 
(1, 'Purvi', '9876543210', 'Pune'),
(2, 'Puvy', '8765432109', 'Mumbai');

INSERT INTO Product VALUES 
(101, 'Milk', 50.00, 100),
(102, 'Bread', 30.00, 200);

INSERT INTO Supplier VALUES 
(1, 'Dairy Supplier', '9999999999'),
(2, 'Bakery Supplier', '8888888888');

INSERT INTO Warehouse VALUES 
(1, 'Pune Warehouse'),
(2, 'Mumbai Warehouse');

INSERT INTO Orders VALUES 
(1001, '2026-04-20', 1),
(1002, '2026-04-21', 2);

INSERT INTO Order_Product VALUES 
(1001, 101, 2),
(1001, 102, 1),
(1002, 102, 3);

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Order_Product;

SELECT * FROM Product
ORDER BY Price ASC;

SELECT Orders.Order_ID, Customer.Name
FROM Orders
JOIN Customer ON Orders.Customer_ID = Customer.Customer_ID;

SELECT Orders.Order_ID, Product.Name, Order_Product.Quantity
FROM Order_Product
JOIN Orders ON Order_Product.Order_ID = Orders.Order_ID
JOIN Product ON Order_Product.Product_ID = Product.Product_ID;

SELECT COUNT(*) FROM Customer;

SELECT SUM(Stock) FROM Product;

SELECT AVG(Price) FROM Product;

SELECT Order_ID, SUM(Quantity)
FROM Order_Product
GROUP BY Order_ID;

UPDATE Product
SET Price = 60
WHERE Product_ID = 101;

DELETE FROM Customer
WHERE Customer_ID = 2;

SELECT Customer.Name, Orders.Order_ID, Product.Name, Order_Product.Quantity
FROM Customer
JOIN Orders ON Customer.Customer_ID = Orders.Customer_ID
JOIN Order_Product ON Orders.Order_ID = Order_Product.Order_ID
JOIN Product ON Order_Product.Product_ID = Product.Product_ID;
