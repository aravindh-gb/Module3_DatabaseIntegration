from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()

class Department(Base):
    __tablename__ = "departments"

    department_id = Column(Integer, primary_key=True)
    dept_name = Column(String(100))

class Student(Base):
    __tablename__ = "students"

    student_id = Column(Integer, primary_key=True)
    first_name = Column(String(50))
    last_name = Column(String(50))
    email = Column(String(100))

    department_id = Column(
        Integer,
        ForeignKey("departments.department_id")
    )

    department = relationship("Department")

engine = create_engine(
    "sqlite:///college.db"
)

Base.metadata.create_all(engine)

print("Tables created successfully")
