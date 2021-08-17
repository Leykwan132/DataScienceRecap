USE [DS Training]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_FakeNames_canada_20210816]    Script Date: 8/17/2021 2:27:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[BLD_WRK_FakeNames_canada_20210816]
-- =============================================
-- Author: LEY KWAN CHOO
-- Create date: 20210816
-- Description:	RAW -> WRK
-- =============================================
AS
BEGIN
-- =============================================S
-- DROP TABLE
-- =============================================
IF OBJECT_ID('WRK_FakeNames_canada_20210816') IS NOT NULL
DROP TABLE [WRK_FakeNames_canada_20210816]

-- =============================================
-- CREATE TABLE BLOCK
-- =============================================

CREATE TABLE [WRK_FakeNames_canada_20210816]
(
	  [RowNumber]		INT IDENTITY (1,1)
	  ,[Number]			VARCHAR(100)
      ,[Gender]			VARCHAR(10)
      ,[GivenName]		VARCHAR(1000)
      ,[Surname]		VARCHAR(1000)
      ,[StreetAddress]	VARCHAR(1000)
      ,[City]			VARCHAR(1000)
      ,[ZipCode]		VARCHAR(7)
      ,[CountryFull]	VARCHAR(1000)
      ,[Birthday]		DATE	
      ,[Balance]		FLOAT
      ,[InterestRate]	FLOAT
		
)

-- =============================================
-- TRUNCATE TABLE
-- =============================================

TRUNCATE TABLE [WRK_FakeNames_canada_20210816]

-- =============================================
-- INSERT INTO BLOCK
-- =============================================

INSERT INTO [WRK_FakeNames_canada_20210816]
(
	[Number]			
      ,[Gender]			
      ,[GivenName]		
      ,[Surname]		
      ,[StreetAddress]	
      ,[City]			
      ,[ZipCode]		
      ,[CountryFull]	
      ,[Birthday]		
      ,[Balance]		
      ,[InterestRate]	
)
SELECT 
	 [Number]			
      ,[Gender]			
      ,[GivenName]		
      ,[Surname]		
      ,[StreetAddress]	
      ,[City]			
      ,[ZipCode]		
      ,[CountryFull]	
      ,[Birthday]		
      ,[Balance]		
      ,[InterestRate]	
FROM [RAW_FakeNames_canada_20210816]
--FILTERS:
WHERE ISNUMERIC([BALANCE]) = 1	--10 ROWS
AND LEN([ZipCode]) <= 7			-- 2 ROWS
AND ISDATE([Birthday]) = 1		-- 1 ROW

--(199987 rows affected)
--199987 + 10 + 2 + 1 = 200000 VERIFIED

-- =============================================
-- ADDITIONAL EXCLUSIONS
-- =============================================
DELETE
FROM [WRK_FakeNames_canada_20210816]
WHERE [Balance] < 0
--(1 ROWS AFFECTED)

DELETE
FROM [WRK_FakeNames_canada_20210816]
WHERE [ZipCode] NOT LIKE '___ ___'
--(4 rows affected)

END

/*
SELECT COUNT(*) FROM [RAW_FakeNames_canada_20210816]
SELECT * FROM [dbo].[RAW_OfficeSupplies_P12-TransactionalData_20210522]
*/
