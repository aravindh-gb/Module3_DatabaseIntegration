from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from models import Student, Department

engine = create_engine("sqlite:///college.db")

Session = sessionmaker(bind=engine)
session = Session()

dept = Department(
    department_id=1,
    dept_name="Computer Science"
)

session.add(dept)
session.commit()

student = Student(
    student_id=1,
    first_name="Arun",
    last_name="Kumar",
    email="arun@gmail.com",
    department_id=1
)

session.add(student)
session.commit()

students = session.query(Student).all()

for s in students:
    print(s.first_name, s.last_name)

student = session.query(Student).first()
student.email = "updated@gmail.com"

session.commit()

student = session.query(Student).first()

if student:
    session.delete(student)
    session.commit()

print("CRUD operations completed")
