create table tourist(t_id varchar(10) primary key, tfirst_name varchar(20), tlast_name varchar(20), age int, phone varchar(13), country varchar(20));
create table houseboat(h_id varchar(10) primary key, h_name varchar(20), capacity int, acfacility varchar(6), noofbedrooms int, wifi varchar(6), price int);																																		
create table medicalrecords(i_id varchar(10) primary key, idescription varchar(80));
create table driver(d_id varchar(10) primary key, dfirst_name varchar(20), dlast_name varchar(20), dsalary int, dage int, i_id varchar(10), foreign key(i_id) references medicalrecords on update cascade on delete cascade);
create table boatowner(o_id varchar(10) primary key, ofirst_name varchar(20),olast_name varchar(20), ophone varchar(13));
create table management(rent_date date, t_id varchar(10), h_id varchar(10), d_id varchar(10), o_id varchar(10), foreign key(t_id) references tourist on update cascade on delete cascade, foreign key(d_id) references driver on update cascade on delete cascade, foreign key(h_id) references houseboat on update cascade on delete cascade, foreign key(o_id) references boatowner on update cascade on delete cascade, primary key(rent_date, t_id));																		  
 
insert into tourist values('T1', 'Sowmya', 'Khanna', 29, '+919446252773', 'India'); 
insert into tourist values('T2', 'Rajesh', 'Khanna', 34, '+919497822113', 'India'); 
insert into tourist values('T3', 'John', 'Doe', 35, '+15555421238', 'USA'); 
insert into tourist values('T4', 'Mary', 'Jones', 34, '+15555421282', 'USA'); 
insert into tourist values('T5', 'Abdus', 'Salam', 29, '+971050120282', 'UAE'); 
insert into tourist values('T6', 'Sanaa', 'Salam', 25, '+971050821682', 'UAE'); 
																													
select * from tourist;																			   

insert into houseboat values('H123', 'Aqua Castle', 6, 'AC', 2, 'Y', 33810);		
insert into houseboat values('H108', 'Nova Holidays', 4, 'NONAC', 1, 'Y', 13510);																													
insert into houseboat values('H154', 'Pournami', 10, 'AC', 4, 'Y', 41378);																																																										
insert into houseboat values('H162', 'River View', 3, 'NONAC', 2, 'N', 20229);																																																																																							
insert into houseboat values('H821', 'Pearl Spot', 6, 'AC', 3, 'N', 43500);																																																																																							

select * from houseboat;																													

																													
insert into driver values('D454', 'Suresh', 'M. N', 12000, 40, 'I454');		
insert into driver values('D156', 'Venu', 'S. K', 8000, 35, 'I156');																													
insert into driver values('D664', 'Raghu', 'C', 20000, 38, 'I664');																																																										
insert into driver values('D321', 'Ravi', 'Kumar', 13000, 42, 'I321');																																																																																							
insert into driver values('D842', 'Manoj', 'Unnikrishnan', 22000, 43, 'I842');																																																																																							
insert into driver values('D846', 'Mahesh', 'Krishnan', 19000, 25, NULL);																																																																																							

select * from driver;
																													
insert into medicalrecords values('I454','Diabeties');	
insert into medicalrecords values('I156','None');
insert into medicalrecords values('I664','Eyesight Issues');
insert into medicalrecords values('I321','BP');
insert into medicalrecords values('I842','Heart Patient');

select * from medicalrecords;																													
																													
insert into boatowner values('O123','Aravindan', 'Menon', '+919746576958');	
insert into boatowner values('O421','Vijayan', 'Nair', '+919567843277');	
insert into boatowner values('O668','Samuel', 'John', '+919895436378');	
insert into boatowner values('O187','Chacko', 'K. T', '+919298154468');	
insert into boatowner values('O842','Kurien', 'K. P', '+919646782854');		
																					
select * from management;					

insert into management values('06-11-18', 'T1', 'H108', 'D156', 'O187');																													
insert into management values('06-11-18', 'T2', 'H108', 'D156', 'O187');
insert into management values('09-10-18', 'T3', 'H123', 'D454', 'O842');
insert into management values('09-10-18', 'T4', 'H123', 'D454', 'O842');
insert into management values('01-05-18', 'T5', 'H154', 'D664', 'O123');
insert into management values('01-05-18', 'T6', 'H154', 'D664', 'O123');

select max(price) from houseboat;												
select min(price) from houseboat;								
select avg(price) from houseboat;																													
select count(t_id), country from tourist where age>30 group by country having count(t_id)>1;
select * from houseboat order by price;
select Tourist.TFirst_name, Houseboat.H_name from ((Management INNER JOIN Tourist ON Management.T_id = Tourist.T_id) INNER JOIN Houseboat ON Management.H_id = Houseboat.H_id);																													
select Tourist.tfirst_name, Management.h_id from Tourist FULL OUTER JOIN Management ON Tourist.t_id = Management.t_id; 
select * from houseboat where price>40000;																													
select h_name, price-1000 as discount_price from houseboat;
select * from driver where dfirst_name like 'R%';															
select * from tourist where tlast_name like '%h%';
select t_id, to_char(rent_date, 'DD-MONTH-YYYY') from management;
select extract(month from rent_date) from Management;													
select * from Management where Rent_date BETWEEN '06-10-18' AND '09-11-18';																													
select * from Management where Rent_date NOT BETWEEN '06-10-18' AND '09-11-18';																													
select dfirst_name from driver where dsalary in (select dsalary from driver where dsalary>9000); 
select dfirst_name from driver where dsalary not in (select dsalary from driver where dsalary>9000); 
select tfirst_name "First Name", tlast_name "Last Name" from tourist union select dfirst_name, dlast_name from driver;
select tfirst_name "First Name", tlast_name "Last Name" from tourist intersect select dfirst_name, dlast_name from driver;
select h_name, capacity from houseboat where h_id in(select h_id from houseboat where acfacility like 'AC');
select h_name, capacity from houseboat where capacity >=ANY(select capacity from houseboat where h_name like 'Pearl Spot');
select h_name, capacity from houseboat where capacity < ALL(select capacity from houseboat where h_name like 'Pearl Spot');
select d.dfirst_name from driver d where EXISTS(SELECT i_id from medicalrecords m where d.i_id=m.i_id);
select d.dfirst_name from driver d where NOT EXISTS(SELECT i_id from medicalrecords m where d.i_id=m.i_id);
																													