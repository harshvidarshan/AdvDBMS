--static 
--simple example
DECLARE empCSR CURSOR STATIC
	FOR SELECT * FROM Employee_Master
OPEN empCSR
FETCH NEXT FROM empCSR

DEALLOCATE empCSR
SELECT * FROM Employee_Master

--static eg as per ppt
DECLARE @ID INT, @EMP_NAME VARCHAR(20), @EMP_DES VARCHAR(50)
DECLARE empCSR CURSOR STATIC
	FOR SELECT Emp_No, Emp_Fullname, Emp_Designation FROM Employee_Master
OPEN empCSR 
IF @@CURSOR_ROWS > 0
BEGIN 
	FETCH NEXT FROM empCSR INTO @ID, @EMP_NAME, @EMP_DES
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT('ID: ',@ID,', NAME OF EMPLOYEE: ',@EMP_NAME,', DESIGNATION: ',@EMP_DES)
		FETCH NEXT FROM empCSR INTO @ID, @EMP_NAME, @EMP_DES
	END
END
CLOSE empCSR

DEALLOCATE empCSR

--dynamic cursor simple eg
DECLARE dynamic_employee_cursor CURSOR 
DYNAMIC FOR 
	SELECT [Emp_No]
	      ,[Emp_FullName]
	FROM Employee_Master
    ORDER BY Emp_FullName
open
dynamic_employee_cursor
FETCH FIRST FROM dynamic_employee_cursor
FETCH NEXT FROM dynamic_employee_cursor
DEALLOCATE dynamic_employee_cursor

--dynamic cursor eg as per ppt
DECLARE @E_ID INT, @E_NAME VARCHAR(50), @E_DES VARCHAR(50);
DECLARE emp_DCSR CURSOR DYNAMIC
FOR SELECT Emp_No, Emp_FullName, Emp_Designation FROM Employee_Master
OPEN emp_DCSR
	FETCH NEXT FROM emp_DCSR INTO @E_ID, @E_NAME,@E_DES
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF @E_ID=104
			UPDATE Employee_Master SET Emp_Designation='HRr' WHERE CURRENT OF emp_DCSR
			DELETE Employee_Master WHERE Emp_No=101
			--INSERT INTO Employee_Master Values(107,'hi','CS',121,'IOB898691')
		FETCH NEXT FROM emp_DCSR INTO @E_ID, @E_NAME,@E_DES
	END
	SELECT * FROM Employee_Master
CLOSE emp_DCSR
DEALLOCATE emp_DCSR

--EXCEPTION HANDLING
--1)SYSTEM DEFINED EXCEPTION
--DIVIDE BY ZERO
DECLARE @NO1 INT, @NO2 INT
BEGIN TRY
SET @NO1=10
SET @NO2=@NO1/0;
END TRY
BEGIN CATCH
	SELECT 
	ERROR_NUMBER() AS ERRORNUMBER,
	ERROR_STATE() AS ERRORSTATE,
	ERROR_SEVERITY() AS ERRORSEVERITY,
	ERROR_PROCEDURE() AS ERRORPROCEDURE,
	ERROR_LINE() AS ERRORLINE,
	ERROR_MESSAGE() AS ERRORMESSAGE;
END CATCH
--2)
BEGIN TRY
	INSERT INTO Employee_Master
	VALUES--VALUE WONT GET INSERTED ANY OF
	(102,'RAM','BRANCH MANAGER',898,'PNB988691')
	INSERT INTO Employee_Master
	VALUES -- IF ONLY THESE STATEMENT VALUE GETS INSERTED AS NO EXCEPTION GENERATED
	(110,'RAM','BRANCH MANAGER',898,'PNB988691')
END TRY
BEGIN CATCH
	SELECT 
	ERROR_NUMBER() AS ERRORNUMBER,
	ERROR_STATE() AS ERRORSTATE,
	ERROR_SEVERITY() AS ERRORSEVERITY,
	ERROR_PROCEDURE() AS ERRORPROCEDURE,
	ERROR_LINE() AS ERRORLINE,
	ERROR_MESSAGE() AS ERRORMESSAGE;
END CATCH

SELECT * FROM Employee_Master
--USER DEFINED EXCEPTION
CREATE PROCEDURE USER_DEFINE_EXCEPTION 
(@e_no int, @emp_name varchar(50), @emp_des varchar(50), @emp_manageno int, @emp_branchifsc varchar(50))
AS
BEGIN TRY
	if @emp_manageno >1000
	BEGIN
		RAISERROR('EMP_MANAGER_NO>100',900,1)
	END
	ELSE
		INSERT INTO EMPLOYEE_MASTER
		VALUES
		(@e_no, @emp_name, @emp_des, @emp_manageno, @emp_branchifsc)
END TRY
BEGIN CATCH
	SELECT 
	ERROR_NUMBER() AS ERRORNUMBER,
	ERROR_STATE() AS ERRORSTATE,
	ERROR_SEVERITY() AS ERRORSEVERITY,
	ERROR_PROCEDURE() AS ERRORPROCEDURE,
	ERROR_LINE() AS ERRORLINE,
	ERROR_MESSAGE() AS ERRORMESSAGE;
END CATCH

EXEC  USER_DEFINE_EXCEPTION 211,'Simma Gosaliya','Senior Bank Manager',7,'PNB988691'
EXEC  USER_DEFINE_EXCEPTION 211,'Simma Gosaliya','Senior Bank Manager',789,'PNB988691'