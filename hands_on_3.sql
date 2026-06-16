SELECT s.student_id,
       s.first_name,
       d.dept_name
FROM students s
JOIN departments d
ON s.department_id = d.department_id;

SELECT c.course_name,
       d.dept_name
FROM courses c
JOIN departments d
ON c.department_id = d.department_id;

SELECT s.first_name,
       s.last_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';

CREATE VIEW student_department_view AS
SELECT s.student_id,
       s.first_name,
       s.last_name,
       d.dept_name
FROM students s
JOIN departments d
ON s.department_id = d.department_id;

START TRANSACTION;

UPDATE departments
SET budget = budget + 10000
WHERE department_id = 1;

UPDATE departments
SET budget = budget - 10000
WHERE department_id = 2;

COMMIT;

SELECT *
FROM students
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE dept_name = 'Computer Science'
);

SELECT *
FROM courses
WHERE credits = (
    SELECT MAX(credits)
    FROM courses
);
