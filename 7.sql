--------------------------------------------------
-- STEP 1: CREATE DATABASE
--------------------------------------------------
CREATE DATABASE UniversityDB;
USE UniversityDB;

--------------------------------------------------
-- STEP 2: CREATE TABLES
--------------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100) UNIQUE NOT NULL,
    HOD VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18),
    DepartmentID INT,
    CGPA DECIMAL(3,2) CHECK (CGPA BETWEEN 0 AND 10),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
    ON DELETE SET NULL
);

CREATE TABLE Courses (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
    ON DELETE CASCADE
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID VARCHAR(10),
    Marks INT CHECK (Marks BETWEEN 0 AND 100),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE (StudentID, CourseID)
);

--------------------------------------------------
-- STEP 3: INSERT VALUES
--------------------------------------------------

INSERT INTO Departments (DeptName, HOD) VALUES
('Computer Sci', 'Dr. Rao'),
('Electronics', 'Dr. Mehta'),
('Mechanical', 'Dr. Singh');

INSERT INTO Students (Name, Age, DepartmentID, CGPA) VALUES
('Alice', 20, 1, 9.1),
('Bob', 21, 1, 8.5),
('Charlie', 22, 2, 7.8),
('David', 20, 3, 8.9),
('Eva', 21, 2, 9.5),
('Frank', 23, NULL, 6.5);

INSERT INTO Courses VALUES
('CSE101','DBMS',1),
('CSE102','OS',1),
('ECE201','Signals',2),
('ME301','Thermo',3);

INSERT INTO Enrollments (StudentID, CourseID, Marks) VALUES
(1,'CSE101',90),
(1,'CSE102',85),
(2,'CSE101',70),
(3,'ECE201',60),
(4,'ME301',88),
(5,'ECE201',92);

--------------------------------------------------
-- STEP 4: NESTED QUERIES
--------------------------------------------------

-- 1. Students with CGPA > avg CGPA
SELECT Name FROM Students
WHERE CGPA > (SELECT AVG(CGPA) FROM Students);

-- 2. Students never enrolled
SELECT Name FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- 3. Courses with no students
SELECT CourseName FROM Courses
WHERE CourseID NOT IN (SELECT CourseID FROM Enrollments);

-- 4. Students in 'Computer Sci' courses
SELECT Name FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments
    WHERE CourseID IN (
        SELECT CourseID FROM Courses
        WHERE DepartmentID = (
            SELECT DepartmentID FROM Departments
            WHERE DeptName = 'Computer Sci'
        )
    )
);

-- 5. Students with same age as oldest
SELECT Name FROM Students
WHERE Age = (SELECT MAX(Age) FROM Students);

-- 6. Courses where someone scored >85
SELECT CourseName FROM Courses
WHERE CourseID IN (
    SELECT CourseID FROM Enrollments WHERE Marks > 85
);

-- 7. Highest CGPA in each department
SELECT DepartmentID, MAX(CGPA)
FROM Students
GROUP BY DepartmentID;

-- 8. Students enrolled in >1 course
SELECT Name FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments
    GROUP BY StudentID
    HAVING COUNT(*) > 1
);

-- 9. Department with most students
SELECT DeptName FROM Departments
WHERE DepartmentID = (
    SELECT DepartmentID FROM Students
    GROUP BY DepartmentID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 10. Students not enrolled (same as Q2)
SELECT Name FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- 11. Students scoring below course avg
SELECT Name FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.Marks < (
    SELECT AVG(Marks)
    FROM Enrollments
    WHERE CourseID = e.CourseID
);

-- 12. Department of highest CGPA student
SELECT DeptName FROM Departments
WHERE DepartmentID = (
    SELECT DepartmentID FROM Students
    ORDER BY CGPA DESC
    LIMIT 1
);

-- 13. Department with highest students (same as Q9)
SELECT DeptName FROM Departments
WHERE DepartmentID = (
    SELECT DepartmentID FROM Students
    GROUP BY DepartmentID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 14. Courses where lowest marks >70
SELECT CourseName FROM Courses
WHERE CourseID IN (
    SELECT CourseID FROM Enrollments
    GROUP BY CourseID
    HAVING MIN(Marks) > 70
);

-- 15. Students with same CGPA as Alice
SELECT Name FROM Students
WHERE CGPA = (
    SELECT CGPA FROM Students WHERE Name='Alice'
);

-- 16. Course with max enrollments
SELECT CourseName FROM Courses
WHERE CourseID = (
    SELECT CourseID FROM Enrollments
    GROUP BY CourseID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 17. Students enrolled in >2 courses
SELECT Name FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments
    GROUP BY StudentID
    HAVING COUNT(*) > 2
);

-- 18. Students with highest marks in any course
SELECT Name FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments
    WHERE Marks = (SELECT MAX(Marks) FROM Enrollments)
);

-- 19. Department with lowest avg CGPA
SELECT DeptName FROM Departments
WHERE DepartmentID = (
    SELECT DepartmentID FROM Students
    GROUP BY DepartmentID
    ORDER BY AVG(CGPA) ASC
    LIMIT 1
);

-- 20. Course with max failed students (<40)
SELECT CourseName FROM Courses
WHERE CourseID = (
    SELECT CourseID FROM Enrollments
    WHERE Marks < 40
    GROUP BY CourseID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);