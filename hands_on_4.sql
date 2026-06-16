EXPLAIN
SELECT s.first_name,
s.last_name,
c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;

CREATE INDEX idx_students_enrollment_year
ON students(enrollment_year);


CREATE UNIQUE INDEX idx_enrollment_student_course
ON enrollments(student_id, course_id);


CREATE INDEX idx_courses_course_code
ON courses(course_code);

EXPLAIN
SELECT s.first_name,
s.last_name,
c.course_name
FROM enrollments e
JOIN students s
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;


CREATE INDEX idx_pending_grades
ON enrollments(student_id);


SELECT e.enrollment_id,
s.first_name,
s.last_name,
c.course_name
FROM enrollments e
JOIN students s
ON e.student_id=s.student_id
JOIN courses c
ON e.course_id=c.course_id;

