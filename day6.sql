-- create table students (
-- 	student_id int primary key,
-- 	student_name varchar(100)
-- );

-- insert into students (student_id, student_name)
-- values
-- 	(1,'akarsh'),
-- 	(2,'simran'),
-- 	(3,'rohan');

-- select * from students

-- create table courses (
-- 	course_id int primary key,
-- 	course_name varchar(100)
-- );

-- insert into courses 
-- values
-- 	(101,'python'),
-- 	(102,'sql'),
-- 	(103,'java');

-- select * from courses;

-- create table student_course (
-- 	student_id int,
-- 	course_id int,
-- 	primary key (student_id,course_id),
-- 	foreign key (student_id) references students(student_id),
-- 	foreign key (course_id) references courses(course_id)
-- );

-- insert into student_course (student_id,course_id)
-- values
-- 	(1,101),
-- 	(1,102),
-- 	(2,101),
-- 	(2,103),
-- 	(3,102);

-- Q> show the list of students with the courses they are enrolled in 

-- select 
-- 	s.student_name,
-- 	c.course_name
-- from 
-- 	student_course sc
-- join students s on sc.student_id = s.student_id
-- join courses c on sc.course_id = c.course_id;


-- Q> Find all courses taken by the student named 'simran'

-- select 
-- 	c.course_name
-- from 
-- 	student_course sc
-- join students s on sc.student_id = s.student_id
-- join courses c on sc.course_id = c.course_id
-- where s.student_name = 'simran';








