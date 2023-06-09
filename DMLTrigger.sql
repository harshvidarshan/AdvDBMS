--for/after trigger for A AND B1
--step 1 CREATE NEW TABLE AND INSERT ONE DATA (WITH CHECK CONSTRAINT)
CREATE TABLE CUST_DETAIL 
(C_ID INT IDENTITY (1,1) PRIMARY KEY, 
C_NAME VARCHAR(10),
C_ACC_BAL BIGINT NOT NULL,
CONSTRAINT CHECK_BAL CHECK (C_ACC_BAL>1500)
);
SELECT * FROM CUST_DETAIL

INSERT INTO CUST_DETAIL
VALUES
( 'HI','19000')

--STEP 2 TO MAINTAIN TRIGGER_LOG AND STORE TRIGGER EVENT DATA
CREATE TABLE DML_LOGTABLE 
(
LOGID INT IDENTITY(1,1) PRIMARY KEY, 
CUST_ID INT NOT NULL,
EVENT_TEXT TEXT, 
EVENT_DATE DATETIME NOT NULL,
 );

select * from DML_LOGTABLE
--STEP 3 CREATE TRIGGER
CREATE TRIGGER TRIGGER_DML_DEMO1
ON CUST_DETAIL
FOR
INSERT
as
BEGIN 
DECLARE @CUSTM_ID INT
SELECT @CUSTM_ID=C_ID FROM INSERTED
INSERT INTO DML_LOGTABLE
VALUES
(@CUSTM_ID, 'insert log', GETDATE())
END

--STEP 4 INSERT NEW DATA IN CUST_DETAIL TABLE
INSERT INTO CUST_DETAIL
VALUES
( 'HI11','20000')

--STEP 5 NOW CHECK BOTH TABLE
SELECT * FROM CUST_DETAIL
SELECT * FROM DML_LOGTABLE

--INSTEAD OF TRIGGER
ALTER TRIGGER TRIGGER_DML_DEMO2
ON CUST_DETAIL
INSTEAD OF
DELETE
AS
BEGIN 
DECLARE @CUSTT_ID INT
SELECT @CUSTT_ID = C_ID FROM DELETED
IF (@CUSTT_ID IS NULL)
	PRINT ('CUSTOMER DATA NOT EXIST FOR THESE ID');
ELSE
BEGIN
	INSERT INTO DML_LOGTABLE
	VALUES
	(@CUSTT_ID, 'DELETE log', GETDATE())
	DELETE FROM CUST_DETAIL
	WHERE C_ID=@CUSTT_ID
END
END

--DELETE DATA
DELETE FROM CUST_DETAIL WHERE C_ID=4

DELETE FROM CUST_DETAIL WHERE C_ID=1

SELECT * FROM CUST_DETAIL
SELECT * FROM DML_LOGTABLE



