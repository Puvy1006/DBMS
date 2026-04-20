CREATE DATABASE StudentManagement;
USE StudentManagement;

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY NOT NULL,
    CourseName VARCHAR(100) NOT NULL UNIQUE,
    Credits INT DEFAULT 3
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    DOB DATE NOT NULL,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Courses VALUES
(1, 'Computer Science', 3),
(2, 'Electronics', 3),
(3, 'Mechanical', 3);

INSERT INTO Students VALUES
(101, 'Aditi', 'Sharma', 'aditi@gmail.com', '2003-05-10', 1),
(102, 'Rahul', 'Patil', 'rahul@gmail.com', '2004-07-15', 2),
(103, 'Sneha', 'Joshi', 'sneha@gmail.com', '2002-03-20', 1),
(104, 'Aman', 'Verma', 'aman@gmail.com', '2001-11-25', 3),
(105, 'Neha', 'Kulkarni', 'neha@gmail.com', '2003-08-30', 2);

-- Test 1: NULL in NOT NULL column
INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID)
VALUES (106, NULL, 'Test', 'test1@gmail.com', '2003-01-01', 1);

-- Test 2: Duplicate UNIQUE Email
INSERT INTO Students VALUES
(107, 'Test', 'User', 'aditi@gmail.com', '2003-02-02', 1);

-- Test 3: Invalid FOREIGN KEY
INSERT INTO Students VALUES
(108, 'Invalid', 'FK', 'invalid@gmail.com', '2003-03-03', 10);

SELECT FirstName, LastName
FROM Students
WHERE YEAR(DOB) > 2000;

UPDATE Courses
SET Credits = 4
WHERE CourseName = 'Computer Science';

DELETE FROM Students
WHERE Email = 'test@example.com';

SELECT *
FROM Students
WHERE CourseID IS NULL;

-- Test UNIQUE again
INSERT INTO Students VALUES
(109, 'Duplicate', 'Email', 'rahul@gmail.com', '2003-04-04', 2);

-- Test FOREIGN KEY again
INSERT INTO Students VALUES
(110, 'Wrong', 'Course', 'wrong@gmail.com', '2003-05-05', 20);