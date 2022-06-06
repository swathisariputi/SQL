create table EMPLOYEEINFO(
    empid int,
    empfname varchar(15),
    emplname varchar(15),
    department char(3),
    project varchar(50),
    address varchar(100),
    dob date,
    gender char(1)
 )
 
insert into EMPLOYEEINFO values (1,'john','deer','CSE','Web','Hyd',TO_DATE('2002/03/21','yyyy/mm/dd'),'M')
insert into EMPLOYEEINFO values (2,'Amy','Jakson','ECE','Embedded system','Ngp',TO_DATE('1999/02/12','yyyy/mm/dd'),'F')
insert into EMPLOYEEINFO values (3,'Raj','','CME','Meta','Bng',TO_DATE('1986/12/09','yyyy/mm/dd'),'M')

create table EmployeePosition(
    empid int,
    empposition varchar(15),
    dateofjoining date,
    salary int
)

insert into EmployeePosition values (1,'developer',TO_DATE('2021/03/21','yyyy/mm/dd'),75000)
insert into EmployeePosition values (2,'Engineer',TO_DATE('2022/11/15','yyyy/mm/dd'),50000)
insert into EmployeePosition values (3,'Engineer',TO_DATE('2022/10/15','yyyy/mm/dd'),20000)
--1
select empfname||' '||emplname as employeename from EMPLOYEEINFO 
where empfname like 'A%';
--or
select empfname||' '||emplname as employeename from EMPLOYEEINFO 
where SUBSTR(empfname, 1,1)='A' ;

--2
create view v as
select e.empid,e.empfname,e.emplname,e.department,e.project,e.address,e.dob,e.gender,ep.empposition,ep.dateofjoining,ep.salary 
from EMPLOYEEINFO e, EmployeePosition ep
where e.empid=ep.empid
order by e.empid desc;
select * from v 
where rownum<=2
order by empid;
select * from (
select e.empid,e.empfname,e.emplname,e.department,e.project,e.address,e.dob,e.gender,ep.empposition,ep.dateofjoining,ep.salary 
from EMPLOYEEINFO e, EmployeePosition ep
where e.empid=ep.empid
order by e.empid desc)
where rownum<=2
order by empid;
--unsorted
create view xx as
select e.empid,e.empfname,e.emplname,e.department,e.project,e.address,e.dob,e.gender,ep.empposition,ep.dateofjoining,ep.salary,rownum as r 
from EMPLOYEEINFO e, EmployeePosition ep
where e.empid=ep.empid;
--or
create view x2 as
select e.empid,e.empfname,e.emplname,e.department,e.project,e.address,e.dob,e.gender,ep.empposition,ep.dateofjoining,ep.salary,rownum as r 
from EMPLOYEEINFO e
join EmployeePosition ep on e.empid=ep.empid;
select * from x2 where r>(select count(*) from xx)-2;
--or
select * from xx where r>(select max(r) from xx)-2;
--select e.empid,e.empfname,e.emplname,e.department,e.project,e.address,e.dob,e.gender,ep.empposition,ep.dateofjoining,ep.salary,rownum as r 
--from EMPLOYEEINFO e
--join EmployeePosition ep on e.empid=ep.empid 
--where r>(select count(*) from EMPLOYEEINFO)-2;

--3
select SUBSTR(address, 1, INSTR('(',address)) FROM EMPLOYEEINFO;
 
 
--4 
select SUBSTR(emplname,1,4) fourchar from EMPLOYEEINFO;
 
--5
select empfname||' '||emplname as fullname from EMPLOYEEINFO ;

create table SAILORS(
    s_id int,
    sname varchar(15),
    rating int,
    age int
)
insert into SAILORS values (1,'john',6,42)
insert into SAILORS values (2,'Amir',8,25)
insert into SAILORS values (3,'Khan',5,43)
insert into SAILORS values (4,'BB',5,34)
insert into SAILORS values (5,'BaB',1,29)
insert into SAILORS values (6,'BhaB',9,36)
insert into SAILORS values (7,'BhaBs',10,17)

create table Reserves(
   s_id int,
   b_id int,
   dy varchar(10)
)
insert into Reserves values (1,1,'Monday')  
insert into Reserves values (1,2,'Monday')
insert into Reserves values (2,2,'Sunday')
insert into Reserves values (3,1,'Thursday')
insert into Reserves values (4,1,'Sunday')
insert into Reserves values (5,2,'Friday')
insert into Reserves values (6,3,'Wednesday')
insert into Reserves values (7,1,'Saturday')
create table Boats(
   b_id int,
   bname varchar(25),
   color varchar(10)
)
insert into Boats values (1,'boat1','blue')
insert into Boats values (2,'boat2','red')
insert into Boats values (3,'boat3','green')

--1
select sname from SAILORS s 
join Reserves r on s.s_id=r.s_id 
join Boats b on b.b_id=r.b_id
where b.color='red';

--2
select age,sname from SAILORS 
where sname like 'B_%B';

--3
select sname,color from SAILORS s 
join Reserves r on s.s_id=r.s_id 
join Boats b on b.b_id=r.b_id
where b.color='red' or b.color='green';

--4
create view v1 as
select s_id,sname,rating,age,rownum as r from SAILORS;
select * from v1 where mod(r,2)=1;

--5
select sname,rating+1 from SAILORS 
where s_id in (select s_id from Reserves group by dy,s_id having count(*)=2);

--select sname,rating+1,count(Reserves.s_id) as c1 from SAILORS 
--join Reserves on Reserves.s_id=SAILORS.s_id
--where c1=2
--group by dy;


create table Worker(
    workerid int,
    firstname varchar(15),
    lastname varchar(15),
    salary int,
    joiningdate date,
    department char(3)
)
insert into Worker values (1,'john','deer',3000,TO_DATE('2002/03/21','yyyy/mm/dd'),'CSE')
insert into Worker values (2,'Amy','Jakson',8000,TO_DATE('1999/02/12','yyyy/mm/dd'),'MEC')
insert into Worker values (3,'Raj','',5500,TO_DATE('1986/12/09','yyyy/mm/dd'),'CME')
insert into Worker values (4,'Max','Well',5000,TO_DATE('2021/12/09','yyyy/mm/dd'),'CIV')
insert into Worker values (12,'Max9','Well',5500,TO_DATE('2021/12/09','yyyy/mm/dd'),'CIV')
create table Bonus(
    workerid int,
    bonusdate date,
    bonusamount int
)
insert into Bonus values (1,TO_DATE('2022/04/09','yyyy/mm/dd'),2500)
insert into Bonus values (2,TO_DATE('2022/04/19','yyyy/mm/dd'),1500)
insert into Bonus values (3,TO_DATE('2022/04/02','yyyy/mm/dd'),5000)
insert into Bonus values (4,TO_DATE('2022/04/15','yyyy/mm/dd'),2000)

create table Title(
   workerid int,
   workertitle varchar(50),
   affected_from varchar(50)
)

insert into Title values (1,'worker1','breathing')
insert into Title values (2,'worker2','Asthma')
insert into Title values (3,'worker3','Nervous')
insert into Title values (4,'worker4','Cold')
--1 (last row from title table)
create view w1 as
select workerid,workertitle,affected_from,rownum as r
from Title;
select * from w1 where r=(select max(r) from w1);

--2
select firstname||' '||lastname as workername,salary
from Worker
where salary=(select avg(salary) from Worker) or salary=(select min(salary) from worker);\
--or
create view w2 as
select avg(salary) as avg_sal,min(salary) as min_sal
from Worker;
select firstname||' '||lastname as workername,salary,avg_sal,min_sal 
from Worker,w2 
where salary=avg_sal or salary=min_sal;

select firstname,department,salary  from Worker w
where salary = (select min(salary) from Worker where department=w.department);

--3
select * from Worker fetch first 50 percent rows only;

--4
--can't be solved as no data of manager

insert into Worker values (5,'MaxB','Well',5000,TO_DATE('2021/12/09','yyyy/mm/dd'),'CIV')
insert into Worker values (6,' MaxdsB','Well',5000,TO_DATE('2021/12/09','yyyy/mm/dd'),'CIV')
insert into Worker values (7,'MaxgrrB','Well',5000,TO_DATE('2021/12/09','yyyy/mm/dd'),'CIV')

--5
select firstname from Worker
where firstname like '_____%B';

create table EmployeeDetails(
    empid int,
    fullname varchar(50),
    managerid int,
    dateofjoining date,
    city varchar(25)
)
insert into EmployeeDetails values (1,'MAxwell',3,TO_DATE('2020/12/09','yyyy/mm/dd'),'Hyd')
insert into EmployeeDetails values (2,'JohnDeer',1,TO_DATE('2022/01/20','yyyy/mm/dd'),'Hyd')
insert into EmployeeDetails values (3,'Arun',2,TO_DATE('2021/12/11','yyyy/mm/dd'),'Bng')
create table EmployeeSalary(
   empid int,
   project varchar(100),
   salary int,
   variablepay int
)
insert into EmployeeSalary values (1,'p1',9000,2000)
insert into EmployeeSalary values (2,'p2',10000,5000)
insert into EmployeeSalary values (3,'p1',15000,3000)

--1
select count(*) as count_of_employee_with_project_p1 from EmployeeDetails e
where e.empid in (select empid from EmployeeSalary where project='p1');

--2
select salary as third_highest_Salary from(select salary,dense_rank() over (order by salary desc)r 
from EmployeeSalary) where r=3;
--or
select min(salary) as third_highest_Salary from (select distinct salary from EmployeeSalary order by salary desc) where rownum<=3;

--3
select empid,fullname,managerid from EmployeeDetails
where empid in (select managerid from EmployeeDetails) order by empid;
--or
select e1.fullname from employeedetails e1 
where e1.empid=(select e2.managerid from employeedetails e2 where e1.empid = e2.managerid);
--4
select SUBSTR(fullname, 1, INSTR(' ',fullname)) as firstname FROM EmployeeDetails;

--5
select * from EmployeeDetails 
join EmployeeSalary on employeesalary.empid=EmployeeDetails.empid
where salary >=5000 and salary<=10000;

create table Actor(
   actid int,
   actfname varchar(20),
   actlname varchar(20),
   gender char(1)
)

create table Movie(
    mov_id int,
    mov_title varchar(25),
    mov_year int,
    mov_time int,
    mov_lang varchar(25),
    mov_dt_rel date,
    mov_rel_country char(5)
)
create table rating(
    mov_id int,
    rev_id int,
    rev_stars int,
    num_0_ratings int
)
create table reviewer(
   rev_id int,
   rev_name varchar(25)
)
--1
select * from Movie 
where mov_id not in (select mov_id from rating); --wrong
--2
select distinct mov_year from Movie 
where mov_id in (select mov_id from rating where rev_stars>=4);
--or
select distinct mov_year from Movie 
where mov_year in (select mov_year from Movie group by mov_year having count(*) >= 1)
and mov_id in (select mov_id from rating where rev_stars>=4);

--3
select rev_name,mov_name from Movie
join ratings on ratings.mov_id=Movie.mov_id
join reviewer on reviewer.rev_id=ratings.rev_id;
--single list
select rev_name from reviewers
union
select mov_name from Movie

--4
select mov_name from Movie
join ratings on ratings.mov_id=Movie.mov_id
where ratings.rev_stars=(select max(rev_stars) from ratings)
or ratings.rev_stars=(select min(rev_stars) from ratings);
--5
--cant be solved.Not enough details given 

----1
--select count(driver_id) from Person p,Owns o,Car c,Participated p1,Accident a
--where p.driver_id=o.driver_id
--and o.license=c.license
--and p1.driver_id=p.driver_id
--and p1.report_no=a.report_no
--and year(a.adate)=2007;
--and date between date '2007/00/00' and date '2007/12/31';
--
----2
--select count (distinct *)
--from accident
--where exists
--(select *
--from participated, person
--where participated.driver_id = person.driver_id
--and person.name = 'John Smith'
--and accident.report_number = participated.report_number);
--
----3
--insert into accident
--values (4007, '2001-09-01', 'Berkeley')
--insert into participated
--select o.driver_id, c.license, 4007, 3000
--from person p, owns o, car c
--where p.name = 'Jones' and p.driver_id = o.driver_id and
--o.license = c.license and c.model = 'Toyota';
----4
--delete car
--where model = ’Mazda’ and license in
--(select license
--from person p, owns o
--where p.name = ’John Smith’ and p.driver-id = o.driver-id)
----5
--update participated
--set damage-amount = 3000
--where report-number = “AR2197” and driver-id in
--(select driver-id
--from owns
--where license = “AABB2000”)

create table employees1(
    empid int,
    empname varchar(25),
    job_name varchar(25),
    managerid int,
    hiredate date,
    salary int,
    commission int,
    depid int
)
insert into employees1 values (1,'john','Electrical',2,TO_DATE('2000/03/29','yyyy/mm/dd'),50000,2500,1001)
insert into employees1 values (2,'john','Electrical',3,TO_DATE('1990/11/19','yyyy/mm/dd'),50000,2500,1002)
insert into employees1 values (3,'john','Science',1,TO_DATE('2001/05/23','yyyy/mm/dd'),100000,2500,6001)
insert into employees1 values (4,'max','Analyst',1,TO_DATE('2001/05/23','yyyy/mm/dd'),3000,0,1002)
insert into employees1 values (5,'rocky','Analyst',1,TO_DATE('1999/05/23','yyyy/mm/dd'),3000,0,1002)
create table salary_grade1(
    grade int,
    min_salary int,
    max_salary int
);
insert into salary_grade1 values (1,400000,500000);
insert into salary_grade1 values (2,250000,399999);
insert into salary_grade1 values (3,100000,249999);
insert into salary_grade1 values (4,50000,99999);
create table department2(
    depid int,
    depname varchar(20),
    deplocation varchar(50)
);
insert into department2 values (1001,'ENGINEERING','Nagpur');
insert into department2 values (6001,'Doctor','Hyderabad');
insert into department2 values (1002,'ENGINEERING','Banglore');

--1
select empid,empname from employees1 
where depid=1001 or depid=6001
and salary>(select max_salary from salary_grade1 where grade=4) 
or salary<(select min_salary from salary_grade1 where grade=4);

--2
select empid,empname,job_name from employees1
where job_name in ('Analyst','Manager') and salary>=2000 and salary<=4000 and commission=0;

--3
--select empid,empname from employees1 e1
--where e1.managerid in 
--(select e2.empid from employees1 e2 where e2.hiredate<e1.hiredate);

select empid,empname from employees1 e1
where e1.managerid=(select e2.empid from employees1 e2 where e2.empid=e1.managerid and e2.hiredate<e1.hiredate);
--or
select * from employees1;
select e1.empid,e1.empname from employees1 e1
join employees1 e2 on e2.empid=e1.managerid
where e2.hiredate<e1.hiredate;



--4
select empid,empname,salary from employees1 
order by salary;

--5
select empid,empname,salary,round(salary/30,2) as dailysalary,salary*12 as annualsalary
from employees1
order by annualsalary;

create table employee3(
    empid int,
    empname varchar(25),
    department varchar(50),
    contactno int,
    emailid varchar(50),
    empheadid int
)
create table department3(
    depid int,
    depname varchar(15),
    dephead varchar(25)
)
create table empproject(
    empid int,
    projectid varchar(25)
)
create table empsalary(
    empid int,
    salary int,
    ispermanent char(1)
)
create table project1(
    projectid int,
    drtn int
)

--1
select projectid,drtn from project1
where projectid not in (select projectid from empproject);

--2
select empname from employee3
join department3 on department3.depname=employee3.department
where dephead='Sales' or dephead='HR';

--3
select empname from employee3
join department3 on department3.depname=employee3.department
where dephead='Sales';

--4
select count(*)as c from employee3
group by department
order by c desc;

--5
select * from (select projectid,drtn,rownum as r from project1 ) where mod(r,2)=1;

create table Suppliers(
   s_id int,
   sname varchar(50),
   address varchar(50)
);
insert into Suppliers values (1,'John','Banglore');
insert into Suppliers values (2,'Max','Nagpur');
insert into Suppliers values (3,'Susi','Pune');
insert into Suppliers values (4,'Jandi','Parker Street');
create table Parts(
   p_id int,
   pname varchar(6),
   color varchar(15)
);
insert into Parts values (1,'part1','blue');
insert into Parts values (2,'part2','blue');
insert into Parts values (3,'part3','red');
insert into Parts values (4,'part4','green');
insert into Parts values (5,'part5','green');
insert into Parts values (6,'part6','red');
create table Catalog1(
   s_id int,
   p_id int,
   cst real
);
insert into Catalog1 values (1,2,3000);
insert into Catalog1 values (1,3,4500);
insert into Catalog1 values (1,1,3000);
insert into Catalog1 values (1,4,3450);
insert into Catalog1 values (1,5,3450);
insert into Catalog1 values (1,6,3450);
insert into Catalog1 values (2,1,3000);
insert into Catalog1 values (3,3,3450);
insert into Catalog1 values (4,5,3450);
insert into Catalog1 values (3,4,3450);
insert into Catalog1 values (2,2,3000);
insert into Catalog1 values (3,6,3450);

--1
select sname from Suppliers
where s_id in (select s_id from Catalog1 where p_id in (select p_id from Parts where color='blue'));

--or
select sname from Suppliers
where s_id in (select s_id from Catalog1,Parts where Catalog1.p_id=Parts.p_id and color='blue');

--2
--select distinct s_id from Catalog1 where p_id in (select p_id from Parts where color='red'or color='green');

select s_id from Catalog1 where p_id in (select p_id from Parts where color='red')
intersect
select s_id from Catalog1 where p_id in (select p_id from Parts where color='green');
--or
select s_id from Catalog1,Parts where Catalog1.p_id=Parts.p_id and color='red and green';

--3
select s_id from Suppliers
where 
s_id in (select s_id from Catalog1 where p_id in (select p_id from Parts where color='red')) 
or address='Parker Street';

--4
--repeated

--5
select p_id from catalog1
intersect
select p_id from parts;


SELECT  employee_id,  first_name, last_name,  salary AS SalaryDrawn,  
ROUND((salary -(SELECT AVG(salary) FROM employees)),2) AS AvgCompare,  
CASE  WHEN salary >= 
(SELECT AVG(salary) 
FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END AS SalaryStatus 
FROM employees;

select distinct
CASE  WHEN EXISTS (SELECT * FROM employees WHERE salary >5000 ) THEN 'True'  
ELSE 'False'  
END AS existence
FROM employees ;
