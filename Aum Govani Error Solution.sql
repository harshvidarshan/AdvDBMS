Create Table A
( id int identity primary key,
	name varchar(50) )

select * from A
alter table A alter column Branch_ifsc varchar(40)
Alter table A add constraint Branch_ifsc_unique unique (Branch_ifsc)
insert into A values('harsh',23344),('paris',2333)

insert into A values('helly',23)
delete A where id=2

Create Table B
( id int identity primary key,
	name varchar(50),
	Branch_ifc int )
insert into B values('harshg',12),('parisxyz',13)
insert into B values('harsh',23344),('paris',2333)

Select * from B

sp_rename 'B.Branch_ifc', 'Branch_ifsc', 'COLUMN';

alter table B alter column Branch_ifsc varchar(40)

insert into B values('yash','gh23')

alter table B add constraint branch_ifsc_fk FOREIGN KEY (Branch_ifsc) references A(Branch_ifsc)

--error will occur
--The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "branch_ifsc_fk". The conflict occurred in database "Diploma_TA", table "dbo.A", column 'Branch_ifsc'.

--so you have to delete data which is not same in table A
insert into A values('harshg',12),('parisxyz',13)

select * from A
select * from B

--id=1,2,4 deleted from A
delete A where id=4

--id=3,4,5 deleted from B
delete B where id in(3,5)
delete B where id=4

--run below query again
alter table B add constraint branch_ifsc_fk FOREIGN KEY (Branch_ifsc) references A(Branch_ifsc)

select * from A
select * from B

insert into B values('hi',23344)

select A.name,B.name from B
inner join A 
on
A.Branch_ifsc=B.Branch_ifsc