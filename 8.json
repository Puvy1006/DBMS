//////////////////////////////////////////////////
// STEP 1: CREATE DATABASE
//////////////////////////////////////////////////
use PCCOE

//////////////////////////////////////////////////
// STEP 2: CREATE COLLECTIONS
//////////////////////////////////////////////////

// Teachers Collection
db.Teachers.insertMany([
{
  Tname: "Praveen",
  dno: 1,
  dname: "COMP",
  experience: 5,
  salary: 12000,
  date_of_joining: new Date("2020-06-10")
},
{
  Tname: "Ramesh",
  dno: 2,
  dname: "IT",
  experience: 3,
  salary: 9000,
  date_of_joining: new Date("2022-01-15")
},
{
  Tname: "Suresh",
  dno: 3,
  dname: "E&TC",
  experience: 7,
  salary: 15000,
  date_of_joining: new Date("2018-08-20")
},
{
  Tname: "Anita",
  dno: 1,
  dname: "COMP",
  experience: 4,
  salary: 11000,
  date_of_joining: new Date("2021-05-05")
}
]);

// Students Collection
db.Students.insertMany([
{ Sname: "Amit", roll_no: 1, class: "SE" },
{ Sname: "Neha", roll_no: 2, class: "TE" },
{ Sname: "Ravi", roll_no: 3, class: "BE" }
]);

//////////////////////////////////////////////////
// STEP 3: QUERIES
//////////////////////////////////////////////////

// 3. Display all teachers
db.Teachers.find();

// 4. Teachers from computer department
db.Teachers.find({ dname: "COMP" });

// 5. Teachers from COMP, IT, E&TC
db.Teachers.find({ dname: { $in: ["COMP", "IT", "E&TC"] } });

// 6. Teachers from COMP, IT, E&TC with salary >=10000
db.Teachers.find({
  dname: { $in: ["COMP", "IT", "E&TC"] },
  salary: { $gte: 10000 }
});

// 7. Students with roll_no = 2 OR name = xyz
db.Students.find({
  $or: [
    { roll_no: 2 },
    { Sname: "xyz" }
  ]
});

// 8. Update experience of Praveen to 10 (if not exist insert)
db.Teachers.updateOne(
  { Tname: "Praveen" },
  {
    $set: {
      experience: 10,
      dno: 1,
      dname: "COMP",
      salary: 12000,
      date_of_joining: new Date()
    }
  },
  { upsert: true }
);

// 9. Update IT department to COMP
db.Teachers.updateMany(
  { dname: "IT" },
  { $set: { dname: "COMP" } }
);

// 10. Display teacher name and experience
db.Teachers.find({}, { Tname: 1, experience: 1, _id: 0 });

// 11. Using save() insert into department collection
db.Department.save({
  dno: 1,
  dname: "COMP"
});

// 12. Using save() change dept of Praveen to IT
var teacher = db.Teachers.findOne({ Tname: "Praveen" });
teacher.dname = "IT";
db.Teachers.save(teacher);

// 13. Delete teachers from IT department
db.Teachers.deleteMany({ dname: "IT" });

// 14. Display first 3 teachers in ascending order with pretty()
db.Teachers.find().sort({ Tname: 1 }).limit(3).pretty();