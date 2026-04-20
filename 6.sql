--------------------------------------------------
-- STEP 1: CREATE DATABASE
--------------------------------------------------
CREATE DATABASE ECommerceDB;
USE ECommerceDB;

--------------------------------------------------
-- STEP 2: CREATE TABLES
--------------------------------------------------

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(50),
    city VARCHAR(50)
);

-- Extra table (needed for queries like multiple sellers per product)
CREATE TABLE Seller_Products (
    seller_id INT,
    product_id INT,
    PRIMARY KEY (seller_id, product_id),
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

--------------------------------------------------
-- STEP 3: INSERT VALUES
--------------------------------------------------

INSERT INTO Customers VALUES
(1,'Amit','amit@gmail.com','Pune'),
(2,'Neha','neha@gmail.com','Mumbai'),
(3,'Ravi','ravi@gmail.com','Delhi'),
(4,'Sneha','sneha@gmail.com','Pune'),
(5,'Karan','karan@gmail.com','Mumbai');

INSERT INTO Orders VALUES
(101,1,'2026-03-01',5000),
(102,2,'2026-03-10',8000),
(103,1,'2026-04-01',3000),
(104,3,'2026-04-05',10000);

INSERT INTO Products VALUES
(201,'Laptop','Electronics',50000),
(202,'Phone','Electronics',20000),
(203,'Shoes','Fashion',3000),
(204,'Watch','Accessories',5000);

INSERT INTO Order_Items VALUES
(1,101,201,1,5000),
(2,102,202,2,8000),
(3,103,203,1,3000),
(4,104,201,2,10000);

INSERT INTO Sellers VALUES
(301,'SellerA','Pune'),
(302,'SellerB','Mumbai'),
(303,'SellerC','Delhi');

INSERT INTO Seller_Products VALUES
(301,201),
(302,201),
(302,202),
(303,203);

--------------------------------------------------
-- STEP 4: QUERIES
--------------------------------------------------

-- 1. All customers + orders (LEFT JOIN)
SELECT * FROM Customers
LEFT JOIN Orders USING(customer_id);

-- 2. Orders with product names and quantities
SELECT o.order_id, p.product_name, oi.quantity
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- 3. Total orders per customer
SELECT customer_id, COUNT(*) FROM Orders GROUP BY customer_id;

-- 4. Total products per category
SELECT category, COUNT(*) FROM Products GROUP BY category;

-- 5. Orders in last 30 days
SELECT c.name, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 6. Sellers selling Laptop
SELECT DISTINCT s.seller_name
FROM Sellers s
JOIN Seller_Products sp ON s.seller_id = sp.seller_id
JOIN Products p ON sp.product_id = p.product_id
WHERE p.product_name = 'Laptop';

-- 7. Customers with no orders
SELECT name FROM Customers
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);

-- 8. Orders greater than average
SELECT * FROM Orders
WHERE total_amount > (SELECT AVG(total_amount) FROM Orders);

-- 9. Customers with at least 2 orders
SELECT customer_id FROM Orders
GROUP BY customer_id
HAVING COUNT(*) >= 2;

-- 10. Top 3 most ordered products
SELECT product_id, SUM(quantity) AS total_qty
FROM Order_Items
GROUP BY product_id
ORDER BY total_qty DESC
LIMIT 3;

-- 11. Products sold by multiple sellers
SELECT product_id
FROM Seller_Products
GROUP BY product_id
HAVING COUNT(seller_id) > 1;

-- 12. Sellers who never sold
SELECT seller_name FROM Sellers
WHERE seller_id NOT IN (SELECT seller_id FROM Seller_Products);

-- 13. Products never ordered
SELECT product_name FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Order_Items);

-- 14. Customers with highest orders
SELECT name FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders
    GROUP BY customer_id
    HAVING COUNT(*) = (
        SELECT MAX(cnt) FROM (
            SELECT COUNT(*) cnt FROM Orders GROUP BY customer_id
        ) t
    )
);

-- 15. Customers with >5 different products
SELECT customer_id
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) > 5;

-- 16. Products sold by ≥2 sellers but never ordered
SELECT product_id
FROM Seller_Products
GROUP BY product_id
HAVING COUNT(seller_id) >= 2
AND product_id NOT IN (SELECT product_id FROM Order_Items);

-- 17. Customer who spent most
SELECT c.name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY SUM(o.total_amount) DESC
LIMIT 1;

-- 18. Customers who ordered OR live in seller city
SELECT DISTINCT name FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Orders)
OR city IN (SELECT city FROM Sellers);

-- 19. Products in stock OR ordered
SELECT product_name FROM Products
WHERE product_id IN (SELECT product_id FROM Seller_Products)
OR product_id IN (SELECT product_id FROM Order_Items);

-- 20. Products both ordered AND in stock
SELECT product_name FROM Products
WHERE product_id IN (SELECT product_id FROM Seller_Products)
AND product_id IN (SELECT product_id FROM Order_Items);

-- 21. Customers who ordered AND live in seller city
SELECT DISTINCT name FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Orders)
AND city IN (SELECT city FROM Sellers);

-- 22. Customers who ordered in every year
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING COUNT(DISTINCT YEAR(order_date)) = 
       (SELECT COUNT(DISTINCT YEAR(order_date)) FROM Orders);