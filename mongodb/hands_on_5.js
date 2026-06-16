db.students.insertMany([
{
  name: "Arun Kumar",
  age: 21,
  department: "Computer Science",
  cgpa: 8.5
},
{
  name: "Priya Sharma",
  age: 22,
  department: "Computer Science",
  cgpa: 9.1
},
{
  name: "Rahul Verma",
  age: 21,
  department: "Electronics",
  cgpa: 8.0
}
]);

db.students.find();

db.students.find(
  { department: "Computer Science" }
);

db.students.updateOne(
  { name: "Arun Kumar" },
  { $set: { cgpa: 8.8 } }
);

db.students.deleteOne(
  { name: "Rahul Verma" }
);

db.students.aggregate([
{
  $group: {
    _id: "$department",
    totalStudents: { $sum: 1 }
  }
}
]);

db.students.createIndex(
  { department: 1 }
);
