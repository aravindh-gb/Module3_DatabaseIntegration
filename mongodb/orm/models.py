from sqlalchemy import (
create_engine,
Column,
Integer,
String,
ForeignKey,
Date,
Numeric
)

from sqlalchemy.orm import (
declarative_base,
relationship
)

Base = declarative_base()


class Department(Base):
**tablename** = "departments"

```
department_id = Column(Integer, primary_key=True)
dept_name = Column(String(100))
hod_name = Column(String(100))
budget = Column(Numeric(12,2))

students = relationship(
    "Student",
    back_populates="department"
)

professors = relationship(
    "Professor",
    back_populates="department"
)
```


class Student(Base):
**tablename** = "students"

```
student_id = Column(Integer, primary_key=True)

first_name = Column(String(50))
last_name = Column(String(50))
email = Column(String(100))

date_of_birth = Column(Date)

department_id = Column(
    Integer,
    ForeignKey("departments.department_id")
)

enrollment_year = Column(Integer)

department = relationship(
    "Department",
    back_populates="students"
)

enrollments = relationship(
    "Enrollment",
    back_populates="student"
)
```


class Course(Base):
**tablename** = "courses"

```
course_id = Column(Integer, primary_key=True)

course_name = Column(String(150))
course_code = Column(String(20))
credits = Column(Integer)

department_id = Column(
    Integer,
    ForeignKey("departments.department_id")
)

enrollments = relationship(
    "Enrollment",
    back_populates="course"
)
```

class Enrollment(Base):
**tablename** = "enrollments"

```
enrollment_id = Column(
    Integer,
    primary_key=True
)

student_id = Column(
    Integer,
    ForeignKey("students.student_id")
)

course_id = Column(
    Integer,
    ForeignKey("courses.course_id")
)

enrollment_date = Column(Date)

grade = Column(String(2))

student = relationship(
    "Student",
    back_populates="enrollments"
)

course = relationship(
    "Course",
    back_populates="enrollments"
)
```


class Professor(Base):
**tablename** = "professors"

```
professor_id = Column(
    Integer,
    primary_key=True
)

prof_name = Column(String(100))

email = Column(String(100))

salary = Column(Numeric(10,2))

department_id = Column(
    Integer,
    ForeignKey("departments.department_id")
)

department = relationship(
    "Department",
    back_populates="professors"
)
```


engine = create_engine(
"sqlite:///college.db",
echo=True
)

Base.metadata.create_all(engine)

print("All ORM tables created successfully")
