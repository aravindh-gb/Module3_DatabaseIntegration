"""
Hands-On 6

N+1 Problem:
Without eager loading:
1 query loads enrollments
N additional queries load students/courses

With joinedload():
All data is loaded in a single query.

Example:
Before: 13 queries
After: 1 query
"""

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import joinedload

from models import (
Department,
Student,
Course,
Enrollment
)

engine = create_engine(
"sqlite:///college.db",
echo=True
)

Session = sessionmaker(bind=engine)

session = Session()


d1 = Department(
department_id=1,
dept_name="Computer Science"
)

d2 = Department(
department_id=2,
dept_name="Electronics"
)

d3 = Department(
department_id=3,
dept_name="Mechanical"
)

session.add_all([d1,d2,d3])
session.commit()


students = [

Student(
student_id=1,
first_name="Arun",
last_name="Kumar",
email="[arun@gmail.com](mailto:arun@gmail.com)",
department_id=1,
enrollment_year=2022
),

Student(
student_id=2,
first_name="Priya",
last_name="Sharma",
email="[priya@gmail.com](mailto:priya@gmail.com)",
department_id=1,
enrollment_year=2022
),

Student(
student_id=3,
first_name="Rahul",
last_name="Verma",
email="[rahul@gmail.com](mailto:rahul@gmail.com)",
department_id=2,
enrollment_year=2021
)

]

session.add_all(students)
session.commit()


courses = [

Course(
course_id=1,
course_name="Database Systems",
course_code="CS301",
credits=4,
department_id=1
),

Course(
course_id=2,
course_name="Data Structures",
course_code="CS201",
credits=4,
department_id=1
),

Course(
course_id=3,
course_name="Circuit Theory",
course_code="EC301",
credits=3,
department_id=2
)

]

session.add_all(courses)
session.commit()

enrollments = [

Enrollment(
enrollment_id=1,
student_id=1,
course_id=1
),

Enrollment(
enrollment_id=2,
student_id=2,
course_id=2
),

Enrollment(
enrollment_id=3,
student_id=3,
course_id=3
)

]

session.add_all(enrollments)
session.commit()



students = (
session.query(Student)
.join(Department)
.filter(
Department.dept_name ==
"Computer Science"
)
.all()
)

for s in students:
print(s.first_name)



records = session.query(
Enrollment
).all()

for r in records:
print(
r.student.first_name,
r.course.course_name
)



records = (
session.query(Enrollment)
.options(
joinedload(
Enrollment.student
),
joinedload(
Enrollment.course
)
)
.all()
)

for r in records:
print(
r.student.first_name,
r.course.course_name
)



student = (
session.query(Student)
.filter(
Student.email ==
"[arun@gmail.com](mailto:arun@gmail.com)"
)
.first()
)

if student:
student.enrollment_year = 2023

session.commit()


record = (
session.query(Enrollment)
.first()
)

if record:
session.delete(record)

session.commit()

print("CRUD completed successfully")
