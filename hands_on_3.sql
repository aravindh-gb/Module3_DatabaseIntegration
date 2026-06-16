SELECT student_id,
COUNT(*) AS total_courses
FROM enrollments
GROUP BY student_id
HAVING COUNT(*) >
(
SELECT AVG(course_count)
FROM
(
SELECT COUNT(*) AS course_count
FROM enrollments
GROUP BY student_id
) avg_table
);


SELECT c.course_name
FROM courses c
WHERE NOT EXISTS
(
SELECT *
FROM enrollments e
WHERE e.course_id = c.course_id
AND e.grade <> 'A'
);


SELECT p.*
FROM professors p
WHERE salary =
(
SELECT MAX(p2.salary)
FROM professors p2
WHERE p2.department_id = p.department_id
);


SELECT *
FROM
(
SELECT department_id,
AVG(salary) AS avg_salary
FROM professors
GROUP BY department_id
) dept_avg
WHERE avg_salary > 85000;


CREATE VIEW vw_student_enrollment_summary AS
SELECT
s.student_id,
CONCAT(s.first_name,' ',s.last_name) AS student_name,
d.dept_name,
COUNT(e.course_id) AS total_courses,
ROUND(
AVG(
CASE
WHEN e.grade='A' THEN 4
WHEN e.grade='B' THEN 3
WHEN e.grade='C' THEN 2
WHEN e.grade='D' THEN 1
ELSE 0
END
),2
) AS gpa
FROM students s
LEFT JOIN enrollments e
ON s.student_id=e.student_id
LEFT JOIN departments d
ON s.department_id=d.department_id
GROUP BY s.student_id,d.dept_name;


CREATE VIEW vw_course_stats AS
SELECT
c.course_name,
c.course_code,
COUNT(e.student_id) AS total_enrollments,
ROUND(
AVG(
CASE
WHEN e.grade='A' THEN 4
WHEN e.grade='B' THEN 3
WHEN e.grade='C' THEN 2
WHEN e.grade='D' THEN 1
ELSE 0
END
),2
) AS avg_gpa
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id;


SELECT *
FROM vw_student_enrollment_summary
WHERE gpa > 3;


DROP VIEW IF EXISTS vw_student_enrollment_summary;

CREATE VIEW vw_student_enrollment_summary AS
SELECT *
FROM students
WHERE enrollment_year >= 2022
WITH CHECK OPTION;


DELIMITER $$

CREATE PROCEDURE sp_enroll_student(
IN p_student_id INT,
IN p_course_id INT,
IN p_enrollment_date DATE
)
BEGIN

IF EXISTS
(
SELECT *
FROM enrollments
WHERE student_id=p_student_id
AND course_id=p_course_id
)
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Duplicate Enrollment';
ELSE

INSERT INTO enrollments
(student_id,course_id,enrollment_date)
VALUES
(p_student_id,p_course_id,p_enrollment_date);

END IF;

END$$

DELIMITER ;


CREATE TABLE department_transfer_log
(
log_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
old_department INT,
new_department INT,
transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


START TRANSACTION;

UPDATE students
SET department_id=2
WHERE student_id=1;

INSERT INTO department_transfer_log
(student_id,old_department,new_department)
VALUES
(1,1,2);

COMMIT;

START TRANSACTION;

INSERT INTO enrollments
(student_id,course_id,enrollment_date)
VALUES
(1,3,CURDATE());

SAVEPOINT first_insert;

ROLLBACK TO first_insert;

COMMIT;
