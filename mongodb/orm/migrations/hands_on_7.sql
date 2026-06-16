CREATE TABLE IF NOT EXISTS migration_history (
migration_id INT PRIMARY KEY AUTO_INCREMENT,
version_name VARCHAR(100),
applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO migration_history(version_name)
VALUES ('baseline_v1');


ALTER TABLE students
ADD COLUMN phone_number VARCHAR(15);

INSERT INTO migration_history(version_name)
VALUES ('add_phone_number_v2');


ALTER TABLE courses
ADD COLUMN max_seats INT DEFAULT 60;

INSERT INTO migration_history(version_name)
VALUES ('add_max_seats_v3');


ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;

INSERT INTO migration_history(version_name)
VALUES ('rename_hod_column_v4');


CREATE TABLE audit_log (
log_id INT PRIMARY KEY AUTO_INCREMENT,
action_name VARCHAR(100),
action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO audit_log(action_name)
VALUES ('Migration Applied');


ALTER TABLE students
DROP COLUMN phone_number;

INSERT INTO migration_history(version_name)
VALUES ('rollback_phone_number_v2');


SELECT *
FROM migration_history;

SELECT *
FROM audit_log;
