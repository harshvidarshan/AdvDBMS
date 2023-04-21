--create database 
CREATE DATABASE Diploma_TA
USE Diploma_Sem4
--Bank_Master
CREATE TABLE Bank_Master
(
	Bank_ID int PRIMARY KEY,
	BANK_Name varchar(30),
	BANK_ShortName varchar(10)
);

INSERT INTO Bank_Master (Bank_ID,BANK_Name,BANK_ShortName) VALUES (1,'State Bank of India','SBI');
INSERT INTO Bank_Master (Bank_ID,BANK_Name,BANK_ShortName) VALUES (2,'Punjab National Bank','PNB');
INSERT INTO Bank_Master (Bank_ID,BANK_Name,BANK_ShortName) VALUES (3,'Nagrik Bank','NB');
INSERT INTO Bank_Master (Bank_ID,BANK_Name,BANK_ShortName) VALUES (4,'Indian Overseas Bank','IOB');
INSERT INTO Bank_Master (Bank_ID,BANK_Name,BANK_ShortName) VALUES (5,'Bank of Baroda','BOB');

CREATE TABLE Branch_Master
(
	Branch_ID int PRIMARY KEY,
	Branch_Name varchar(30),
	Branch_IFSC varchar(10) Unique,
	Bank_ID int REFERENCES Bank_Master(Bank_ID)
);
INSERT INTO Branch_Master
VALUES 
	 (1,'Rajkot','BARBOK123',5),
	 (2,'Jamnagar','BARBOJ123',5),		
	 (3,'Rajkot','NB4567RJT',3),
	 (4,'Ahmedabad','NB456AHMD',3),
	 (5,'Junagadh','PNB988690',2),
	 (6,'Amreli','PNB988691',2),
	 (7,'Rajkot','IOB898691',4),
	 (8,'Rajasthan','IOB898692',4),
	 (9,'Faridabad','SBI926321',1),
	 (10,'Dehli','SBI926322',1)     

SELECT * FROM Branch_Master

CREATE TABLE Employee_Master
(
	Emp_No int PRIMARY KEY,
	Emp_FullName varchar(30),
	Emp_Designation varchar(30),
	Emp_ManagerNo int,
	Branch_IFSC  varchar(10) REFERENCES Branch_Master(Branch_IFSC)
);

INSERT INTO Employee_Master
VALUES
(101,'Mavani Foram','Cashier',140,'BARBOK123'),
(102,'Ghelani Hetvi','Manager',141,'PNB988691'),
(103,'Bhalodia Kevin','Cashier',179,'NB4567RJT'),
(104,'Rajdev Lokesh','XYZ',191,'IOB898691'),
(105,'Sheth Shreya','ABC',201,'SBI926322');     

CREATE TABLE Customer_Master
(
	Cust_ID int PRIMARY KEY,
	Cust_FullName varchar(30),
	Cust_DOB date,
	Cust_Address varchar(50),
	Cust_MobileNo bigint,
	Cust_Email varchar(30),
	Cust_City varchar(20)

);   

INSERT INTO Customer_Master
VALUES
(111,'Falguni Pathak','2022-05-09','91, Sarita Society',982863521,'f@gmail.com','Rajkot'),
(112,'Heni Pathak','2022-06-10','121, Happy Home',982865521,'h@gmail.com','Jamnagar'),
(113,'Siddharth Sharma','2022-05-15','56, Shree Society',922863521,'s@gmail.com','Ahmedabad'),
(114,'Bharti Doshi','1990-05-07','67, Nalanda Heights',956863521,'bd_09@gmail.com','Faridabad'),
(115,'Heli Sheth','1978-05-09','145, Shilpan Onyx',988863521,'hs@gmail.com','Delhi')
 
Create Table Account_Master(
	Acc_NO				Int				Primary Key,
	Cust_ID				Int				References	Customer_Master(Cust_ID),
	Acc_Type			Varchar(10),
	Branch_IFSC			Varchar(10)		References	Branch_Master(Branch_IFSC),
	Constraint Chck_Acc	Check
	(Acc_Type = 'SB' OR Acc_Type = 'CR')
);

INSERT INTO Account_Master
VALUES (201,111,'SB','BARBOK123');
INSERT INTO Account_Master
VALUES (202,112,'CR','BARBOK123');
INSERT INTO Account_Master
VALUES (203,113,'SB','IOB898691');
INSERT INTO Account_Master
VALUES (204,114,'CR','PNB988691');
INSERT INTO Account_Master
VALUES (205,115,'SB','SBI926322');

SELECT * FROM Account_Master
where Branch_IFSC='BARBOK123';

Create Table Transaction_Master
(
	Tran_ID		Int		Primary Key,
	Tran_Acc_No	Int		References		Account_Master(Acc_NO),
	Tran_Date	DateTime,
	Tran_Type	Varchar(50),
	Tran_Amount_Debit_Credit	VarChar(10),
	Constraint Chk_TranType	Check
	(Tran_Type = 'CH' OR Tran_Type = 'CQ' OR Tran_Type = 'OL' OR Tran_Type = 'RG'),
	Constraint Chk_DB Check
	(Tran_Amount_Debit_Credit = 'D' OR Tran_Amount_Debit_Credit = 'C')
);

Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(11,201,'2021-05-04','CH','D');
	
Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(12,202,'2008-02-02','CQ','C');


Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(13,203,'2012-02-04','OL','D');

Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(14,204,'2022-02-18','RG','C');

Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(15,205,'2014-12-02','CH','D');


--PRACTICAL 2
 SELECT *FROM Customer_Master;

BEGIN TRANSACTION trans1

Update Customer_Master
SET Cust_City='AHMEDABAD'
WHERE Cust_ID=118

SAVE TRANSACTION updt1; --savepoint 

INSERT INTO Customer_Master 
VALUES (119,'Sima Pathak','2022-05-10','901, Sarita Society',982553521,'sp@gmail.com','Rajkot')

SAVE TRANSACTION insrt1;

ROLLBACK TRANSACTION updt1; --the data of updation will be removed

SELECT * FROM Customer_Master

DELETE Customer_Master WHERE Cust_ID=118
SAVE TRANSACTION delt1

COMMIT TRANSACTION trans1

ROLLBACK TRANSACTION updt1;
--COMMIT

--PRACTICAL 3
--Employee_Master
CREATE LOGIN DBMS2 WITH PASSWORD='DBMS2'
CREATE USER USER1 FOR LOGIN DBMS2
GRANT INSERT,SELECT ON Employee_Master TO user1  --giving permission to user
--DISCONNECTED FROM DIPLOMA_TA
--CONNECTED TO DBMS2
Select * from Employee_Master
Update Employee_Master set Emp_FullName='Sheth Dhvani' WHERE Emp_No=101 --to new database window DBMS2, the update condition won't work,
-- error generated as below

--again connect to windows authentication
REVOKE INSERT,SELECT ON Employee_Master FROM user1 --to database named as Diploma_TA, taking all permission back from user 

Update Employee_Master set Emp_FullName='Sheth Dhvani' WHERE Emp_No=101 --the data is updated, query to fire in windows authentication
SELECT * FROM Employee_Master


--Account_Master table
 Create LOGIN HI WITH PASSWORD='HI'
 CREATE USER user2 FOR LOGIN HI

 GRANT ALTER, DELETE, SELECT, UPDATE, INSERT ON Account_Master TO user2
 REVOKE  DELETE, UPDATE, INSERT ON Account_Master FROM user2

 Update Account_Master SET Acc_type='CR' WHERE Acc_NO=201
 SELECT * FROM Account_Master

 --LOCK Example
CREATE TABLE TABLE1 (T1_ID INT IDENTITY PRIMARY KEY,T1_NAME VARCHAR(20));
CREATE TABLE TABLE2 (T2_ID INT IDENTITY PRIMARY KEY,T2_NAME VARCHAR(20));
-------
INSERT INTO TABLE1 VALUES ('A');
INSERT INTO TABLE1 VALUES ('B');
SELECT * FROM TABLE1

INSERT INTO TABLE2 VALUES ('C');
INSERT INTO TABLE2 VALUES ('D');
SELECT * FROM TABLE2
---------
--shared lock--
BEGIN TRAN
SELECT T1_ID,T1_NAME FROM TABLE1 with (holdlock)
--WHERE T1_ID=1
WHERE T1_NAME='A'

SELECT resource_type,request_mode,RESOURCE_DESCRIPTION
FROM SYS.dm_tran_locks 

COMMIT TRAN

--exclusive lock---
BEGIN TRAN

UPDATE TABLE1 SET T1_NAME='H' WHERE T1_ID=1 

SELECT resource_type,request_mode,RESOURCE_DESCRIPTION
FROM SYS.dm_tran_locks 

COMMIT TRAN


---deadlock (update lock eg1)--
--screen-1

BEGIN TRAN
--1
UPDATE TABLE1 SET T1_NAME='A' WHERE T1_ID=1
WAITFOR DELAY '00:00:05'

--3
UPDATE TABLE2 SET T2_NAME='C' WHERE T2_ID=1

COMMIT TRAN
SELECT T1_NAME FROM TABLE1 WHERE T1_ID=1
SELECT T2_NAME FROM TABLE2 WHERE T2_ID=1

--UPDATE LOCK EXAMPLE - SOLUTION
--NOTE  USE BOTH SCREEN AS A ADMIN USER
--screen-1

BEGIN TRAN
SELECT @@SPID AS FIRSTTRANSACTIONID 

SELECT T2_ID FROM TABLE2 WITH (UPDLOCK) WHERE T2_ID=1
--1
UPDATE TABLE1 SET T1_NAME='A' WHERE T1_ID=1
WAITFOR DELAY '00:00:05'

--3
UPDATE TABLE2 SET T2_NAME='C' WHERE T2_ID=1

COMMIT TRAN
SELECT T1_NAME FROM TABLE1 WHERE T1_ID=1
SELECT T2_NAME FROM TABLE2 WHERE T2_ID=1




