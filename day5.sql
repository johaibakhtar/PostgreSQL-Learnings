-- Relationships and Joins  -- 


-- CREATE TABLE students (
--     student_id SERIAL PRIMARY KEY,
--     student_name VARCHAR(50),
--     age INT
-- );

-- INSERT INTO students (student_name, age) VALUES
-- ('Alice', 15),
-- ('Bob', 16),
-- ('Charlie', 15);

-- select * from students;

-- CREATE TABLE grades (
--     grade_id SERIAL PRIMARY KEY,
--     student_id INT REFERENCES students(student_id),
--     subject VARCHAR(50),
--     marks INT
-- );
-- ALTER TABLE grades
-- ADD CONSTRAINT fk_student_id
-- FOREIGN KEY (student_id)
-- REFERENCES students(student_id);

-- INSERT INTO grades (student_id, subject, marks) VALUES
-- (1, 'Math', 90),
-- (1, 'Science', 85),
-- (2, 'Math', 78),
-- (3, 'Science', 92);


-- SELECT 
-- 	s.student_id,
-- 	s.student_name,
-- 	g.grade_id,
-- 	g.subject,
-- 	g.marks
-- 	FROM students s
-- 	JOIN grades g
-- 	on s.student_id = g.student_id;


-- 1 to many rel.


-- create table employees(
-- empl_id serial primary key,
-- empl_name varchar(100) not null 
-- );


-- create table hobbies (
-- game_id serial primary key,
-- empl_id int,
-- games varchar(50),
-- score int ,
-- foreign key (empl_id) references employees(empl_id)
-- );


-- insert into employees(empl_name)
-- values ('johaib'),('sahid'),('afzal');


-- insert into hobbies(empl_id,games,score)
-- values 
-- ('1','cricket',155),
-- ('1','football',13),
-- ('1','hocky',19),

-- ('2','cricket',50),
-- ('2','football',5),
-- ('2','hocky',15),

-- ('3','cricket',101),
-- ('3','football',3),
-- ('3','hocky',12);

-- select * from hobbies;

-- Q> show each employee name along with their game and score

-- select e.empl_name , h.games , h.score 
-- from employees e join hobbies h 
-- on e.empl_id = h.empl_id;



-- Q> show score of only johaib in all games


-- select e.empl_name , h.games , h.score 
-- from employees e join hobbies h 
-- on e.empl_id = h.empl_id
-- where empl_name = 'johaib';

-- Q> show only those games where scores are above 100
-- Q> sort all employees socre in descending order 
-- Q> show each employee avg score



-- insert into employees (empl_name)
-- values ('faheem');

-- select e.empl_name , h.games , h.score 
-- from employees e left join hobbies h 
-- on e.empl_id = h.empl_id;


-- insert into hobbies(empl_id,games,score)
-- values (4,'hocky',10);


-- select e.empl_name , h.games , h.score 
-- from employees e right join hobbies h 
-- on e.empl_id = h.empl_id;


-- select e.empl_name , h.games , h.score 
-- from employees e full join hobbies h 
-- on e.empl_id = h.empl_id;








