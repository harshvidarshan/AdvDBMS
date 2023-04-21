--Create simple view Bank_View which only contains Bank_ID And Bank_Name
CREATE VIEW Bank_View 
AS SELECT Bank_ID, BANK_Name 
FROM Bank_Master

SELECT * FROM Bank_View

--Create simple view Customer_View which only contains Cust_FullName, Cust_MobileNo and Cust_EmailID
CREATE VIEW Customer_View 
AS SELECT Cust_FullName, Cust_MobileNo, Cust_Email 
FROM Customer_Master

SELECT * FROM Customer_View

ALTER VIEW Cust 
AS SELECT Acc_NO, Branch_Name, Bank_Name, Customer_Master.Cust_ID 
FROM Account_Master
INNER JOIN Customer_Master
ON Customer_Master.Cust_ID = Account_Master.Cust_ID
INNER JOIN Branch_Master
ON Branch_Master.Branch_IFSC=Account_Master.Branch_IFSC
INNER JOIN Bank_Master
ON Bank_Master.Bank_ID= Branch_Master.Bank_ID

SELECT * FROM Cust

Alter VIEW Cust_View 
AS SELECT Cust_FullName, Cust_City 
FROM Customer_Master where Cust_City='Rajkot' WITH CHECK OPTION;

SELECT * FROM Cust_View

INSERT INTO Cust_View VALUES('Lokesh Rajdev','Gandhinagar') -- not allow null error will generate
Update Cust_View SET Cust_FullName='lkr1' where Cust_City='Rajkot'
DELETE Cust_View Where Cust_City='Jasdan' --will not be affected

-- CHECK VIEW_NAME AS SELECT COLUMN_NAMES FROM Table_Name (to see view)

--INDEX 
CREATE NONCLUSTERED 
INDEX ind1
ON Customer_Master(Cust_ID ASC)

SP_HELPINDEX Customer_Master
CREATE UNIQUE CLUSTERED 
INDEX indx2
ON Transaction_Master(Tran_ID )

CREATE NONCLUSTERED 
INDEX ind3
ON Transaction_Master(Tran_ID ASC, Tran_Date DESC)

SELECT * FROM Transaction_Master
 
INSERT INTO Transaction_Master VALUES (17, 205, '2020-09-08','CQ','D')



