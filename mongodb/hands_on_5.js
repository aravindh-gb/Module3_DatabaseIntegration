use college_nosql;

db.feedback.insertMany([
{
student_id:1,
course_code:"CS101",
semester:"2022-ODD",
rating:5,
comments:"Excellent teaching",
tags:["challenging","well-structured"],
attachments:[{filename:"notes.pdf",size_kb:240}]
},
{
student_id:2,
course_code:"CS101",
semester:"2022-ODD",
rating:4,
comments:"Very useful",
tags:["challenging"]
},
{
student_id:3,
course_code:"CS101",
semester:"2022-ODD",
rating:5,
comments:"Great course",
tags:["good-examples"]
},
{
student_id:4,
course_code:"CS102",
semester:"2022-ODD",
rating:3,
comments:"Average",
tags:["database"]
},
{
student_id:5,
course_code:"CS102",
semester:"2022-ODD",
rating:2,
comments:"Needs improvement",
tags:["difficult"]
},
{
student_id:6,
course_code:"CS103",
semester:"2022-ODD",
rating:4,
comments:"Good",
tags:["oop"]
},
{
student_id:7,
course_code:"EC101",
semester:"2022-ODD",
rating:5,
comments:"Excellent",
tags:["electronics"]
},
{
student_id:8,
course_code:"ME101",
semester:"2022-ODD",
rating:2,
comments:"Hard subject",
tags:["mechanical"]
},
{
student_id:9,
course_code:"CS101",
semester:"2021-EVEN",
rating:4,
comments:"Old semester",
tags:["challenging"]
},
{
student_id:10,
course_code:"CS102",
semester:"2021-EVEN",
rating:1,
comments:"Poor",
tags:["database"]
}
]);

db.feedback.countDocuments();


db.feedback.find({rating:5});

db.feedback.find({
course_code:"CS101",
tags:"challenging"
});

db.feedback.find(
{},
{
student_id:1,
course_code:1,
rating:1,
_id:0
}
);

db.feedback.updateMany(
{rating:{$lt:3}},
{$set:{needs_review:true}}
);

db.feedback.updateMany(
{needs_review:true},
{$push:{tags:"reviewed"}}
);

db.feedback.deleteMany(
{semester:"2021-EVEN"}
);


db.feedback.aggregate([
{$match:{semester:"2022-ODD"}},
{
$group:{
_id:"$course_code",
avg_rating:{$avg:"$rating"},
total_feedback:{$sum:1}
}
},
{
$project:{
course_code:"$_id",
average_rating:{$round:["$avg_rating",1]},
total_feedback:1,
_id:0
}
},
{$sort:{average_rating:-1}}
]);


db.feedback.aggregate([
{$unwind:"$tags"},
{
$group:{
_id:"$tags",
count:{$sum:1}
}
},
{$sort:{count:-1}}
]);


db.feedback.createIndex(
{course_code:1}
);

db.feedback.find(
{course_code:"CS101"}
).explain("executionStats");
