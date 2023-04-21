--FACTORIAL OF NUMBER BY CREATING STORED PROCEDURE

ALTER PROCEDURE FACT (@CNT INT )
AS BEGIN 
DECLARE @FACT INT =1

WHILE( @CNT !=0)
BEGIN
	SET @FACT=@FACT * @CNT;
	SET @CNT=@CNT-1;
END
PRINT(@FACT)
END

EXECUTE FACT 5

Create procedure SelectAll
AS 
BEGIN
 SELECT * FROM Customer_Master
END

EXEC SelectAll

--MAX OF TWO
alter procedure MAXX(@m3 int, @m4 int)
as
begin
if(@m3 > @m4)
	print concat(@m3,'is max')
else
	print concat(@m4,'is max')
end

exec MAXX 12, 10
--MAXIMUM OF TWO NUMBERS BY CREATING SP
ALTER PROCEDURE MAXI(@NO1 INT , @NO2 INT)
AS BEGIN
IF (@NO1 > @NO2)
	PRINT CONCAT(@NO1, ' IS MAXIMUM');
ELSE IF(@NO1 < @NO2)
	PRINT CONCAT(@NO2, ' IS MAXIMUM');
END

EXECUTE MAXI 2, 7

--SQUARE OF NUMBER BY CREATING SP
CREATE PROCEDURE SQR(@NO3 INT)
AS BEGIN
DECLARE @RESULT INT, @RESULT2 INT, @RESULT3 INT
    SET @RESULT=@NO3 * @NO3
	SET @RESULT2=POWER(@NO3,2)
	SET @RESULT3=SQUARE(@NO3)
	PRINT CONCAT(@RESULT, Char(10) ,@RESULT2, Char(10) , @RESULT3)
END

EXECUTE SQR 2

ALTER PROCEDURE SQR1(@NO3 INT)
AS BEGIN
	PRINT CONCAT(@NO3 * @NO3, Char(10) ,POWER(@NO3,2), Char(10) , SQUARE(@NO3))
END

EXECUTE SQR1 2

CREATE FUNCTION CUBEbb(@A INT)
RETURNS INT
AS
BEGIN
	RETURN POWER(@A,3)
END;

SELECT CUBEbb(2) AS 'CUBE OF NUMBER'
SELECT * FROM Customer_Master
select * from Bank_Master
select * from Employee_Master
select * from Branch_Master
select * from Account_Master
select * from Transaction_Master

CREATE FUNCTION Customer(@C_ID INT)
RETURNS TABLE
AS
	RETURN SELECT * FROM CUSTOMER_MASTER WHERE @C_ID<=Cust_ID

select Cust_ID,Cust_FullName, Cust_DOB from Customer(115)
	
CREATE FUNCTION BANK(@B_ID INT)
RETURNS TABLE
AS
	RETURN 
		SELECT Bank_Name, Branch_Name FROM Branch_Master INNER JOIN BANK_MASTER ON BANK_MASTER.BANK_ID=BRANCH_MASTER.BANK_ID
		WHERE @B_ID=Branch_Master.Bank_ID

SELECT Bank_Name, Branch_Name FROM BANK(5)


CREATE FUNCTION [dbo].[isPrime]
(
    @number INT
)
RETURNS VARCHAR(10)
BEGIN

    DECLARE @retVal VARCHAR(10) = 'TRUE';
    DECLARE @x INT = 1;
    DECLARE @y INT = 0;

    WHILE (@x <= @number )
    BEGIN

            IF (( @number % @x) = 0 )
            BEGIN
                SET @y = @y + 1;
            END

            IF (@y > 2 )
            BEGIN
                SET @retVal = 'FALSE'
                BREAK
            END

            SET @x = @x + 1
	end 
    RETURN @retVal
end

SELECT [dbo].[isPrime](6)