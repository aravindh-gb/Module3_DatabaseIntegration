CREATE INDEX idx_students_email
ON students(email);

CREATE INDEX idx_courses_code
ON courses(course_code);

CREATE INDEX idx_students_department
ON students(department_id);

EXPLAIN
SELECT *
FROM students
WHERE email = 'arun@gmail.com';

EXPLAIN
SELECT *
FROM courses
WHERE course_code = 'CS301';

CREATE INDEX idx_enrollment_student_course
ON enrollments(student_id, course_id);

EXPLAIN
SELECT department_id,
       COUNT(*)
FROM students
GROUP BY department_id;

EXPLAIN
SELECT s.first_name,
       d.dept_name
FROM students s
JOIN departments d
ON s.department_id = d.department_id;
