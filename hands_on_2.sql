INSERT INTO departments (dept_name, hod_name, budget)
VALUES
('Computer Science','Dr. Kumar',500000),
('Electronics','Dr. Rao',400000),
('Mechanical','Dr. Singh',350000);

INSERT INTO students
(first_name,last_name,email,date_of_birth,department_id,enrollment_year)
VALUES
('Arun','Kumar','arun@gmail.com','2003-05-10',1,2021),
('Priya','Sharma','priya@gmail.com','2002-08-15',1,2021),
('Rahul','Verma','rahul@gmail.com','2003-01-12',2,2022);

INSERT INTO courses
(course_name,course_code,credits,department_id)
VALUES
('Database Systems','CS301',4,1),
('Data Structures','CS201',4,1),
('Digital Electronics','EC301',3,2);

SELECT * FROM students;

SELECT *
FROM students
WHERE enrollment_year > 2021;

SELECT course_name, credits
FROM courses;

UPDATE students
SET email='arun_new@gmail.com'
WHERE student_id=1;

DELETE FROM courses
WHERE course_id=3;

SELECT COUNT(*) AS total_students
FROM students;

SELECT AVG(credits) AS average_credits
FROM courses;

SELECT *
FROM students
ORDER BY last_name;

SELECT department_id,
COUNT(*) AS total_students
FROM students
GROUP BY department_id;
