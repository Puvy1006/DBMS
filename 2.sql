CREATE DATABASE StudentManagement;
USE StudentManagement;

CREATE TABLE Students (
    PRN INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Department VARCHAR(50),
    Year INT,
    Email VARCHAR(100)
);

INSERT INTO Students VALUES
(101, 'Aditi', 'Sharma', 20, 'Computer Science', 2, 'aditi@gmail.com'),
(102, 'Rahul', 'Patil', 19, 'Electronics', 1, 'rahul@gmail.com'),
(103, 'Sneha', 'Joshi', 21, 'Computer Science', 3, 'sneha@gmail.com'),
(104, 'Aman', 'Verma', 22, 'Mechanical', 4, 'aman@gmail.com'),
(105, 'Neha', 'Kulkarni', 20, 'Electronics', 3, 'neha@gmail.com');

SELECT * FROM Students;

UPDATE Students
SET Year = 2
WHERE PRN = 102;

DELETE FROM Students
WHERE PRN = 103;

DROP TABLE Students;

ALTER TABLE Students
ADD PhoneNumber VARCHAR(15);

SELECT DISTINCT Department FROM Students;

SELECT COUNT(DISTINCT Department) FROM Students;

SELECT DISTINCT Year FROM Students;

SELECT DISTINCT Age
FROM Students
WHERE Department = 'Computer Science';

SELECT DISTINCT FirstName
FROM Students
WHERE Age < 21;

SELECT *
FROM Students
WHERE Age > 20;

SELECT *
FROM Students
WHERE Year = 3;

SELECT FirstName, LastName, Department
FROM Students
WHERE PRN > 101;

SELECT FirstName, Email
FROM Students
WHERE Department = 'Electronics';

SELECT *
FROM Students
WHERE Department = 'Computer Science' AND Age > 19;

TRUNCATE TABLE Students;

DROP TABLE Students;