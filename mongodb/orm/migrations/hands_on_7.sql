ALTER TABLE students
ADD COLUMN phone_number VARCHAR(15);

ALTER TABLE courses
ADD COLUMN max_seats INT DEFAULT 60;

ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;

CREATE TABLE audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    action_name VARCHAR(100),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO audit_log(action_name)
VALUES ('Migration Applied');

ALTER TABLE students
DROP COLUMN phone_number;
