create database Practice;
USE Practice;

 -- Creating the table called student
Create table Practice.student(
	student_id int,
    First_name varchar(12),
    Last_name varchar(12),
    GPA float,
    Enrollment_date datetime,
    Major varchar(25)
);

-- Inserting values into table student
Insert into Practice.student
values(201,'Shivansh','Mahajan',8.79,'2021-09-01 09:30:00','Computer Science');
Insert into student
values(202,'Umesh','Sharma',8.44,'2021-09-01 08:30:00','Mathematics');
Insert into student
values(203,'Rakesh','Kumar',5.60,'2021-09-01 10:00:00','Biology');
Insert into student
values(204,'Radha','Sharma',9.20,'2021-09-01 12:45:00','Chemistry');
Insert into student
values(205,'Kush','Kumar',7.85,'2021-09-01 08:30:00','Physics');
Insert into student
values(206,'Prem','Chopra',9.56,'2021-09-01 09:24:00','History');
Insert into student
values(207,'Pankaj','Vats',9.78,'2021-09-01 02:30:00','English');
Insert into student
values(208,'Navleen','Kaur',7.00,'2021-09-01 06:30:00','Mathematics');
Insert into student
values(209,'Chirag','Paswan',9.20,'2021-09-01 03:25:00','Hindi');
select * from student;

 -- Creating the table called Program
Create table Program(
	student_ref_id int,
    Program_name varchar(25),
    Program_start_date timestamp
);

INSERT INTO Program
VALUES
(201, 'Computer Science', '2021-09-01 00:00:00'),
(202, 'Mathematics', '2021-09-01 00:00:00'),
(208, 'Mathematics', '2021-09-01 00:00:00'),
(205, 'Physics', '2021-09-01 00:00:00'),
(204, 'Chemistry', '2021-09-01 00:00:00'),
(207, 'Psychology', '2021-09-01 00:00:00'),
(206, 'History', '2021-09-01 00:00:00'),
(203, 'Biology', '2021-09-01 00:00:00');

select * from Program;

--  -- Creating the table called scholarship_table
Create table scholarship(
	student_ref_id int,
    scholarship_amount varchar(25),
    scholarship_date timestamp
);
INSERT INTO scholarship
VALUES
(201, '5000', '2021-10-15 00:00:00'),
(202, '4500', '2022-08-18 00:00:00'),
(203, '3000', '2022-01-25 00:00:00'),
(201, '4000', '2021-10-15 00:00:00');

select * from scholarship;

-- 1. Write a SQL query to fetch “FIRST_NAME” from the Student table in upper case and use ALIAS name as STUDENT_NAME.
select Upper(First_name) as STUDENT_NAME 
from student;

-- 2. Write a SQL query to fetch unique values of MAJOR Subjects from Student table.
select distinct(Major) 
from student;

-- 3. Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.
select upper(substring(First_name,1,3) ) as First_name
from student;
-- 4. Write a SQL query to find the position of alphabet (‘a’) int the first name column ‘Shivansh’ from Student table.
select First_name,INSTR(First_name,'a') as 'a_in_First_name'
from student;

-- 5. Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length.
select distinct(Major) , length(Major)
from student;

-- 6. Write a SQL query to print FIRST_NAME from the Student table after replacing ‘a’ with ‘A’.
select replace(First_name,'a','A') as 'New_name'
from student;

-- 7. Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column COMPLETE_NAME.
select concat(First_name,' ',Last_name) as complete_name
from student;

-- 8.Write a SQL query to print all Student details from Student table order by FIRST_NAME Ascending and MAJOR Subject descending .
select *
from student
order by First_name ASC,Major DESC;

-- 9. Write a SQL query to print details of the Students with the FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.
select * 
from student
where First_name in ('Prem','Shivansh');

-- 10. Write a SQL query to print details of the Students excluding FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.
select *
from student
where First_name not in ('Prem','Shivansh');

-- 11. Write a SQL query to print details of the Students whose FIRST_NAME ends with ‘a’.
select *
from student
where First_name Like '%a';

-- 12. Write an SQL query to print details of the Students whose FIRST_NAME ends with ‘a’ and contains six alphabets.
select *
from student
where First_name like '%a' and Length(First_name)=6;

-- 13. Write an SQL query to print details of the Students whose GPA lies between 9.00 and 9.99.
select *
from student
where GPA Between 9.00 and 9.99;

-- 14. Write an SQL query to fetch the count of Students having Major Subject 'Computer Science'
select First_name, count(student_id)
from student
where Major='Computer Science';

-- 15. Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.
select concat(First_name,' ',Last_name) as Full_name
from student
where GPA Between 8.5 and 9.5;
-- 16. Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.
select Major,count(student_id) as Students
from student
group by Major
order by Students;

-- 17. Display the details of students who have received scholarships, including their names, scholarship amounts, and scholarship dates.
select student.First_name,scholarship.scholarship_amount,scholarship.scholarship_date
from student
join scholarship on student_id=student_ref_id;

-- 18. Write an SQL query to show only odd rows from Student table.
select * 
from student
where student_id % 2 !=0;
-- 19. Write an SQL query to show only even rows from Student table.
select * 
from student
where student_id % 2 =0;
-- 20. List all students and their scholarship amounts if they have received any. 
--  If a student has not received a scholarship, display NULL for the scholarship details.
select student.student_id,student.First_name,student.Last_name,scholarship.scholarship_amount,scholarship.scholarship_date
from student
left join scholarship on student.student_id=scholarship.student_ref_id;
-- 21. Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.
select * 
from student
order by GPA desc
Limit 5;
-- 22. Write an SQL query to determine the nth (say n=5) highest GPA from a table.
select *
from student
order by GPA Desc
limit 4,1;

-- 23. Write an SQL query to determine the 5th highest GPA without using LIMIT keyword.
select * from student
order by GPA desc;

select * 
from student s1
where 4 = (select count(distinct(s2.GPA)) from student s2
			where s2.GPA>s1.GPA);
-- the given subquery will count distinct GPA from s2 table for every row in s1 and where count is 4(means there are 4 GPA in 
-- s2 which are greater than the GPA of current row  of s1 ) and we are printing that s1 row here
-- why 4? Because 4 means there are 4 GPA greater than current row so the current row GPA will be 5th highest

-- 24. Write an SQL query to fetch the list of Students with the same GPA.
select s1.* 
from student s1, student s2
where s1.GPA=s2.GPA and s1.student_id!=s2.student_id;

-- 25. Write an SQL query to show the second highest GPA from a Student table using sub-query.
select max(GPA)
from student 
where GPA <(select max(GPA) from student);
-- 26. Write an SQL query to show one row twice in results from a table.
select *
from student
UNION ALL
select * 
from student ;
-- UNION: Removes duplicates, slower performance, ensures unique rows.
-- UNION ALL: Includes duplicates, faster performance, all rows retained.

-- 27. Write an SQL query to list STUDENT_ID who does not get Scholarship.
select * from student;
select * from scholarship;
select student_id 
from student
where student_id not in (
select student_ref_id from scholarship
);
-- ---- 28. Write an SQL query to fetch the first 50% records from a table.
with RankedStudents  as 
	(select *,
    Row_Number() over() as rn,
    count(*) over() as total_rows
    from student)
select * 
from RankedStudents
where rn <= total_rows/2;

SELECT * FROM Student WHERE STUDENT_ID <= 
(SELECT COUNT(STUDENT_ID)/2 FROM Student);
-- 29. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it.
select Major, count(student_id) as Number_of_People
from student
group by Major
having Number_of_people <4;

-- 30. Write an SQL query to show all MAJOR subject along with the number of people in there.
select Major, count(student_id) as Number_of_People
from student
group by Major;
    
-- 31. Write an SQL query to show the last record from a table.
select *
from student 
where student_id=(
		select max(student_id)
        from student
);
-- 32. Write an SQL query to fetch the first row of a table.
select *
from student 
where student_id=(
		select min(student_id)
        from student
);
-- 33. Write an SQL query to fetch the last five records from a table.
select  *
from (
	select * 
    from student 
    order by student_id desc
    limit 5
) as subquery
order by student_id;

-- 34. Write an SQL query to fetch three max GPA from a table using co-related subquery. 
select distinct GPA
from student s1
where 3 >=
	( select count(distinct GPA)
	  from student s2
      where s1.GPA<= s2.GPA 
	)
order by GPA desc;

-- 35. Write an SQL query to fetch three min GPA from a table using co-related subquery.
select * 
from student s1
where 3 >=
	(select count(distinct GPA)
    from student s2
    where  s1.GPA>=s2.GPA
    )
order by GPA;
-- 36. Write an SQL query to fetch nth(n=4) max GPA from a table.
select distinct GPA
from student s1
where 4 >=
	( select count(distinct GPA)
	  from student s2
      where s1.GPA<= s2.GPA 
	)
order by GPA desc;

-- 37. Write an SQL query to fetch MAJOR subjects along with the max GPA in each of these MAJOR subjects.
select Major,max(GPA)
from student 
group by Major;

-- 38. Write an SQL query to fetch the names of Students who has highest GPA. 
select First_name, GPA
from student 
where GPA = (select max(GPA) from student);

-- 39. Write an SQL query to show the current date and time.
select now() as currentDateTime;

-- 40. Write a query to create a new table which consists of data and structure copied from the other table (say Student)
-- or clone the table named Student.
create table clonetable as select * from student;
select * from clonetable;

-- 41. Write an SQL query to update the GPA of all the students in ‘Computer Science’ MAJOR subject to 7.5.
update student
Set GPA = 7.5
where Major="Computer Science";


-- 42. Write an SQL query to find the average GPA for each major.
select Major, round(avg(GPA),2) as Avg_GPA
from student 
group by Major;

-- 43. Write an SQL query to show the top 3 students with the highest GPA.
select *
from student 
order by GPA desc
limit 3;

-- 44. Write an SQL query to find the number of students in each major who have a GPA greater than 7.5.
select Major, count(student_id) as Number_of_Student
from student 
where GPA>=7.5
group by Major;

-- 45. Write an SQL query to find the students who have the same GPA as ‘Shivansh Mahajan’.
select *
from student 
where GPA =(select GPA
from student
where concat(First_name,' ',Last_name)="Shivansh Mahajan");