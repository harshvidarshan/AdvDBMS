--BANK_MASTER

Create Table Bank_Master(
	BankId			int not null,
	BankName		Varchar(100),
	BankShortName	varchar(50)
);

alter table Bank_Master
Add Primary Key (BankID);

Insert Into Bank_Master 
Values	(1,'Bank Of Baroda','BOB'),
		(2,'State Bank Of India','SBI'),
		(3,'Central Bank Of India','CBI'),
		(4,'Rajkot Nagarik Sahakarik Bank','RNSB'),
		(5,'Punjab National Bank','PNB');

--Branch_Master

Create Table Branch_Master(
	BranchID			int Primary Key,
	BranchName			Varchar(50),
	Branch_IFSC_Code	Varchar(50) Unique,
	BankID				int
);

Alter Table Branch_Master
Add Foreign Key (BankID)
References Bank_Master(BankID)

Insert Into Branch_Master
Values	(1,'Rajkot','RJ9283',1),
		(2,'Morbi','MB3232',1),
		(3,'Rajkot','RJ2322',2),
		(4,'Morbi','MB7866',2),
		(5,'Ahemdabad','AH3323',3),
		(6,'Baroda','BR2321',3),

--Employee_Master

Create Table Employee_Master(
		EmpNo	int Primary Key,
		EmpFullName nvarchar(100),
		Emp_Designation	nvarchar(50),
		Branch_IFSC_Code varchar(50) Foreign Key
		References Branch_Master(Branch_IFSC_Code)
);


Insert Into Employee_Master 
Values	(101,'Varu Aryan','Manager','RJ9283'),
		(102,'Mehta Hit','Cashier','MB3232'),
		(103,'Goswami Prince','Cashier','RJ2322'),
		(104,'ABC XYZ','PQR','MB7866'),
		(105,'XYZ ABC','PQR','AH3323');

Select * from Employee_Master


--CustomerName

Create Table Customer_Master(
	Cust_ID			Int		Primary Key,
	Cust_FullName	Varchar(50),
	Cust_DOB		DateTime,
	Cust_Address	Varchar(50),
	Cust_MobileNo	BigInt,
	Cust_EmailID	varchar(50),
	Cust_CIty		Varchar(50)
);

Insert into Customer_Master(Cust_ID,Cust_FullName,Cust_DOB,Cust_Address,Cust_MobileNo,Cust_EmailID,Cust_CIty)
	Values(1,'abc','2002-02-02','Morbi,Gujarat',9876543210,'abc@123.com','Morbi');

Insert into Customer_Master(Cust_ID,Cust_FullName,Cust_DOB,Cust_Address,Cust_MobileNo,Cust_EmailID,Cust_CIty)
	Values(2,'xyz','2002-02-02','Rajkot,Gujarat',9876543210,'xyz@123.com','Rajkot');

Insert into Customer_Master(Cust_ID,Cust_FullName,Cust_DOB,Cust_Address,Cust_MobileNo,Cust_EmailID,Cust_CIty)
	Values(3,'def','2002-02-02','Ahemdabad,Gujarat',9876543210,'def@123.com','Ahemdabad');

Insert into Customer_Master(Cust_ID,Cust_FullName,Cust_DOB,Cust_Address,Cust_MobileNo,Cust_EmailID,Cust_CIty)
	Values(4,'ghi','2002-02-02','Baroda,Gujarat',9876543210,'ghi@123.com','Baroda');

Insert into Customer_Master(Cust_ID,Cust_FullName,Cust_DOB,Cust_Address,Cust_MobileNo,Cust_EmailID,Cust_CIty)
	Values(5,'pqr','2002-02-02','Kutchh,Gujarat',9876543210,'Kutchh@123.com','Kutchh');


--Account Master

Create Table Account_Master(
	Acc_NO				Int				Primary Key,
	Cust_ID				Int				References	Customer_Master(Cust_ID),
	Acc_Type			Varchar(50),
	Branch_IFSC_Code	Varchar(50)		References	Branch_Master(Branch_IFSC_Code),
	Constraint Chk_Acc	Check
	(Acc_Type = 'SB' OR Acc_Type = 'CR')
);

Insert Into Account_Master
	Values(101,1,'SB','RJ9283');
Insert Into Account_Master
	Values(102,2,'CR','MB7866');
Insert Into Account_Master
	Values(103,3,'SB','AH3323');
Insert Into Account_Master
	Values(104,4,'CR','MB7866');
Insert Into Account_Master
	Values(105,5,'SB','RJ9283');


--Transaction Master

Create Table Transaction_Master(
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
	Values	(1,101,'2022-02-02','CH','D');
	
Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(2,102,'2022-02-02','CQ','C');


Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(3,103,'2022-02-02','OL','D');

Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(4,104,'2022-02-02','RG','C');

Insert Into Transaction_Master(Tran_ID, Tran_Acc_No, Tran_Date,	Tran_Type, Tran_Amount_Debit_Credit)
	Values	(5,105,'2022-02-02','CH','D');

Select * From Bank_Master;

Select 
	BranchID
	,BranchName
	,Branch_IFSC_Code
	,BankName 
From Branch_Master

inner join Bank_Master
ON	Bank_Master.BankId = Branch_Master.BankID;

Select 
	EmpNo,
	EmpFullName,
	Emp_Designation,
	Employee_Master.Branch_IFSC_Code
From Employee_Master

inner join Branch_Master
ON	Branch_Master.Branch_IFSC_Code = Employee_Master.Branch_IFSC_Code;

Select * From Customer_Master;

Select 
	Acc_NO
	,Customer_Master.Cust_ID
	,Cust_FullName
	,Acc_Type
	,Branch_IFSC_Code
From Account_Master

inner join Customer_Master
ON	Customer_Master.Cust_ID = Account_Master.Cust_ID;

Select 
	Tran_ID
	,Tran_Acc_No
	,Customer_Master.Cust_FullName
	,Tran_Date
	,Tran_Type
	,Tran_Amount_Debit_Credit
From	Transaction_Master

inner join Account_Master
ON	Account_Master.Acc_NO = Transaction_Master.Tran_Acc_No
inner join Customer_Master
ON	Account_Master.Cust_ID = Customer_Master.Cust_ID;