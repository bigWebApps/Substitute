UPDATE DB_Version SET [DB_Version] = 11
GO

/****** Object:  UserDefinedFunction [dbo].[GetActiveSubType]    Script Date: 09/15/2009 16:13:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GetActiveSubType]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetActiveSubType]
(
	@EMPLOYEE_NUM int
)
RETURNS INT
AS
BEGIN
	DECLARE @Subtype int
	DECLARE @EMPLOYEE_NUMBER char(6)
	SET @EMPLOYEE_NUMBER = replicate (''0'', 6 - Len(@EMPLOYEE_NUM)) + Convert(char(6), @EMPLOYEE_NUM)
	SET @Subtype = (SELECT 		
		CASE WHEN 
			SEG_501_LOCATION IN (9971,9977,9973)
			AND SEG_501_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_501_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_501_BOARD_CODE > 39	THEN SEG_501_LOCATION 
		ELSE CASE WHEN 
			SEG_502_LOCATION IN (9971,9977,9973)
			AND SEG_502_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_502_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_502_BOARD_CODE > 39	THEN SEG_502_LOCATION 		
		ELSE CASE WHEN 
			SEG_503_LOCATION IN (9971,9977,9973)
			AND SEG_503_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_503_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_503_BOARD_CODE > 39	THEN SEG_503_LOCATION 		
		ELSE CASE WHEN 
			SEG_504_LOCATION IN (9971,9977,9973)
			AND SEG_504_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_504_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_504_BOARD_CODE > 39	THEN SEG_504_LOCATION 		
		ELSE CASE WHEN 
			SEG_505_LOCATION IN (9971,9977,9973)
			AND SEG_505_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_505_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_505_BOARD_CODE > 39	THEN SEG_505_LOCATION 		
		ELSE CASE WHEN 
			SEG_506_LOCATION IN (9971,9977,9973)
			AND SEG_506_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_506_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_506_BOARD_CODE > 39	THEN SEG_506_LOCATION 		
		ELSE CASE WHEN 
			SEG_507_LOCATION IN (9971,9977,9973)
			AND SEG_507_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_507_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_507_BOARD_CODE > 39	THEN SEG_507_LOCATION 		
		ELSE CASE WHEN 
			SEG_508_LOCATION IN (9971,9977,9973)
			AND SEG_508_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_508_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_508_BOARD_CODE > 39	THEN SEG_508_LOCATION 		
		ELSE CASE WHEN 
			SEG_509_LOCATION IN (9971,9977,9973)
			AND SEG_509_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_509_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_509_BOARD_CODE > 39	THEN SEG_509_LOCATION 		
		ELSE CASE WHEN 
			SEG_510_LOCATION IN (9971,9977,9973)
			AND SEG_510_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_510_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_510_BOARD_CODE > 39	THEN SEG_510_LOCATION 		
		ELSE 0
		END END END END END END END END END END
    FROM V_EMPLOYEE_SEGMENT 
    WHERE EMPLOYEE_NUMBER = @EMPLOYEE_NUMBER)     
    
	IF (@Subtype = 0)
	BEGIN
		SET @Subtype = (SELECT 	
		CASE WHEN 
			SEG_511_LOCATION IN (9971,9977,9973)
			AND SEG_511_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_511_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_511_BOARD_CODE > 39	THEN SEG_511_LOCATION 		
		ELSE CASE WHEN 
			SEG_512_LOCATION IN (9971,9977,9973)
			AND SEG_512_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_512_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_512_BOARD_CODE > 39	THEN SEG_512_LOCATION 		
		ELSE CASE WHEN 
			SEG_513_LOCATION IN (9971,9977,9973)
			AND SEG_513_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_513_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_513_BOARD_CODE > 39	THEN SEG_513_LOCATION 		
		ELSE CASE WHEN 
			SEG_514_LOCATION IN (9971,9977,9973)
			AND SEG_514_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_514_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_514_BOARD_CODE > 39	THEN SEG_514_LOCATION 		
		ELSE CASE WHEN 
			SEG_515_LOCATION IN (9971,9977,9973)
			AND SEG_515_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_515_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_515_BOARD_CODE > 39	THEN SEG_515_LOCATION 		
		ELSE CASE WHEN 
			SEG_516_LOCATION IN (9971,9977,9973)
			AND SEG_516_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_516_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_516_BOARD_CODE > 39	THEN SEG_516_LOCATION 		
		ELSE CASE WHEN 
			SEG_517_LOCATION IN (9971,9977,9973)
			AND SEG_517_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_517_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_517_BOARD_CODE > 39	THEN SEG_517_LOCATION 		
		ELSE CASE WHEN 
			SEG_518_LOCATION IN (9971,9977,9973)
			AND SEG_518_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_518_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_518_BOARD_CODE > 39	THEN SEG_518_LOCATION 		
		ELSE CASE WHEN 
			SEG_519_LOCATION IN (9971,9977,9973)
			AND SEG_519_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_519_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_519_BOARD_CODE > 39	THEN SEG_519_LOCATION 		
		ELSE CASE WHEN 
			SEG_520_LOCATION IN (9971,9977,9973)
			AND SEG_520_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
			AND SEG_520_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_520_BOARD_CODE > 39	THEN SEG_520_LOCATION 
		ELSE 0
		END END END END END END END END END END
	    FROM V_EMPLOYEE_SEGMENT 
		WHERE EMPLOYEE_NUMBER = @EMPLOYEE_NUMBER)
	END	
			
	IF (@Subtype = 0)
	BEGIN
		SET @Subtype = ISNULL((SELECT LOCATION FROM DW_PERQ.dbo.V_EMPLOYEE WHERE EMPLOYEE_NUMBER = @EMPLOYEE_NUMBER AND LOCATION IN (9971,9977,9973) AND JOB_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND JOB_BOARD_CODE > 39 AND PAYCODE NOT IN (''A'', ''C'', ''D'', ''H'', ''J'', ''Q'', ''R'', ''W'', ''X'', ''Y'')), 0)
	END
			
	IF (@Subtype = 0)
	BEGIN
		SET @Subtype = (SELECT LocationId FROM [User] WHERE UserId = @EMPLOYEE_NUMBER)
	END
	
	SET @Subtype = ISNULL(@Subtype, 9029)
	
	RETURN @Subtype
END
' 
END
GO
/****** Object:  View [dbo].[EmployeeSegments]    Script Date: 09/15/2009 16:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[EmployeeSegments]') AND OBJECTPROPERTY(id, N'IsView') = 1)
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[EmployeeSegments]
AS
SELECT     EMPLOYEE_NUMBER, SEG_501_LOCATION AS ''Location'', SEG_501_PAYCODE AS ''Paycode'', SEG_501_BOARD_CODE AS ''BoardCode''
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_502_LOCATION, SEG_502_PAYCODE, SEG_502_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_503_LOCATION, SEG_503_PAYCODE, SEG_503_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_504_LOCATION, SEG_504_PAYCODE, SEG_504_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_505_LOCATION, SEG_505_PAYCODE, SEG_505_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_506_LOCATION, SEG_506_PAYCODE, SEG_506_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_507_LOCATION, SEG_507_PAYCODE, SEG_507_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_508_LOCATION, SEG_508_PAYCODE, SEG_508_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_509_LOCATION, SEG_509_PAYCODE, SEG_509_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_510_LOCATION, SEG_510_PAYCODE, SEG_510_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_511_LOCATION, SEG_511_PAYCODE, SEG_511_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_512_LOCATION, SEG_512_PAYCODE, SEG_512_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_513_LOCATION, SEG_513_PAYCODE, SEG_513_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_514_LOCATION, SEG_514_PAYCODE, SEG_514_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_515_LOCATION, SEG_515_PAYCODE, SEG_515_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_516_LOCATION, SEG_516_PAYCODE, SEG_516_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_517_LOCATION, SEG_517_PAYCODE, SEG_517_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_518_LOCATION, SEG_518_PAYCODE, SEG_518_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_519_LOCATION, SEG_519_PAYCODE, SEG_519_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
UNION ALL
SELECT     EMPLOYEE_NUMBER, SEG_520_LOCATION, SEG_520_PAYCODE, SEG_520_BOARD_CODE
FROM         V_EMPLOYEE_SEGMENT
'
GO
/****** Object:  UserDefinedFunction [dbo].[IsSubstitute]    Script Date: 09/15/2009 16:13:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[IsSubstitute]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[IsSubstitute]
(
	@EMPLOYEE_NUM int
)
RETURNS INT
AS
BEGIN
	DECLARE @Subtype int
	DECLARE @EMPLOYEE_NUMBER char(6)
	SET @EMPLOYEE_NUMBER = replicate (''0'', 6 - Len(@EMPLOYEE_NUM)) + Convert(char(6), @EMPLOYEE_NUM)
	SET @Subtype = (SELECT ISNULL(SEG_501_LOCATION,ISNULL(SEG_502_LOCATION,ISNULL(SEG_503_LOCATION,ISNULL(SEG_504_LOCATION,ISNULL(SEG_505_LOCATION,ISNULL(SEG_506_LOCATION,ISNULL(SEG_507_LOCATION,ISNULL(SEG_508_LOCATION,ISNULL(SEG_509_LOCATION,ISNULL(SEG_510_LOCATION,ISNULL(SEG_501_LOCATION,ISNULL(SEG_511_LOCATION,ISNULL(SEG_512_LOCATION,ISNULL(SEG_513_LOCATION,ISNULL(SEG_514_LOCATION,ISNULL(SEG_515_LOCATION,ISNULL(SEG_516_LOCATION,ISNULL(SEG_517_LOCATION,ISNULL(SEG_518_LOCATION,ISNULL(SEG_519_LOCATION,ISNULL(SEG_520_LOCATION,0))))))))))))))))))))) FROM V_EMPLOYEE_SEGMENT
	WHERE EMPLOYEE_NUMBER = @EMPLOYEE_NUMBER
	AND (
			(
				SEG_501_LOCATION IN (9971,9977,9973)
				AND SEG_501_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_501_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_501_BOARD_CODE > 39
			)
			OR
			(
				SEG_502_LOCATION IN (9971,9977,9973)
				AND SEG_502_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_502_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_502_BOARD_CODE > 39
			)
			OR
			(
				SEG_503_LOCATION IN (9971,9977,9973)
				AND SEG_503_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_503_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_503_BOARD_CODE > 39
			)
			OR
			(
				SEG_504_LOCATION IN (9971,9977,9973)
				AND SEG_504_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_504_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_504_BOARD_CODE > 39
			)
			OR
			(
				SEG_505_LOCATION IN (9971,9977,9973)
				AND SEG_505_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_505_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_505_BOARD_CODE > 39
			)
			OR
			(
				SEG_506_LOCATION IN (9971,9977,9973)
				AND SEG_506_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_506_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_506_BOARD_CODE > 39
			)
			OR
			(
				SEG_507_LOCATION IN (9971,9977,9973)
				AND SEG_507_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_507_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_507_BOARD_CODE > 39
			)
			OR
			(
				SEG_508_LOCATION IN (9971,9977,9973)
				AND SEG_508_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_508_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_508_BOARD_CODE > 39
			)
			OR
			(
				SEG_509_LOCATION IN (9971,9977,9973)
				AND SEG_509_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_509_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_509_BOARD_CODE > 39
			)
			OR
			(
				SEG_510_LOCATION IN (9971,9977,9973)
				AND SEG_510_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_510_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_510_BOARD_CODE > 39
			)
			OR
			(
				SEG_511_LOCATION IN (9971,9977,9973)
				AND SEG_511_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_511_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_511_BOARD_CODE > 39
			)
			OR
			(
				SEG_512_LOCATION IN (9971,9977,9973)
				AND SEG_512_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_512_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_512_BOARD_CODE > 39
			)
			OR
			(
				SEG_513_LOCATION IN (9971,9977,9973)
				AND SEG_513_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_513_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_513_BOARD_CODE > 39
			)
			OR
			(
				SEG_514_LOCATION IN (9971,9977,9973)
				AND SEG_514_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_514_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_514_BOARD_CODE > 39
			)
			OR
			(
				SEG_515_LOCATION IN (9971,9977,9973)
				AND SEG_515_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_515_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_515_BOARD_CODE > 39
			)
			OR
			(
				SEG_516_LOCATION IN (9971,9977,9973)
				AND SEG_516_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_516_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_516_BOARD_CODE > 39
			)
			OR
			(
				SEG_517_LOCATION IN (9971,9977,9973)
				AND SEG_517_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_517_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_517_BOARD_CODE > 39
			)
			OR
			(
				SEG_518_LOCATION IN (9971,9977,9973)
				AND SEG_518_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_518_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_518_BOARD_CODE > 39
			)
			OR
			(
				SEG_519_LOCATION IN (9971,9977,9973)
				AND SEG_519_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_519_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_519_BOARD_CODE > 39
			)
			OR
			(
				SEG_520_LOCATION IN (9971,9977,9973)
				AND SEG_520_PAYCODE NOT IN (''A'',''C'',''D'',''H'',''J'',''Q'',''R'',''W'',''X'',''Y'')
				AND SEG_520_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND SEG_520_BOARD_CODE > 39
			)
		)						
	)
	
	IF (@Subtype = 0)
	BEGIN
		SET @Subtype = (SELECT LOCATION FROM DW_PERQ.dbo.V_EMPLOYEE WHERE EMPLOYEE_NUMBER = @EMPLOYEE_NUMBER AND LOCATION IN (9971,9977,9973) AND JOB_BOARD_CODE NOT IN (''1A'', ''1C'', ''1P'', ''1H'', ''1Q'', ''1Y'', ''1E'', ''1G'') AND JOB_BOARD_CODE > 39 AND PAYCODE NOT IN (''A'', ''C'', ''D'', ''H'', ''J'', ''Q'', ''R'', ''W'', ''X'', ''Y''))
	END
			
	SET @Subtype = ISNULL(@Subtype, 0)
	
	RETURN @Subtype	  	  
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadEmployeeSegments]    Script Date: 09/15/2009 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[LoadEmployeeSegments]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LoadEmployeeSegments]
	@UserId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM EmployeeSegments 
	WHERE 
	EMPLOYEE_NUMBER = replicate (''0'', 6 - Len(@UserId)) + Convert(char(6), @UserId)
	AND Location is not null
END
' 
END
GO


/****** Object:  StoredProcedure [dbo].[Mc_SelectAllUsersGroups]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllUsersGroups] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllUsersGroups]
	@OrganizationId int
AS
	SET NOCOUNT ON;

SELECT UserId, GroupId 
FROM dbo.Mc_UsersGroups
--INNER JOIN dbo.Mc_Group g
--	ON	ug.GroupId = g.GroupId
--		AND g.Deleted = 0
--		AND g.OrganizationId = @OrganizationId
--INNER JOIN dbo.Mc_User u
--	ON	ug.UserId = u.UserId
--		AND u.Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllLoginByOrganizationId]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllLoginByOrganizationId] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllLoginByOrganizationId]
	@OrganizationId int
AS
	SET NOCOUNT ON;

SELECT 
	l.LoginId
	,l.LoginName
	,l.Password
	,l.Deleted
	,ol.IsOrganizationAdministrator
FROM dbo.Mc_OrganizationsLogins ol
INNER JOIN dbo.Mc_Login l
	ON	ol.LoginId = l.LoginId
		AND ol.OrganizationId = @OrganizationId
		AND l.Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[UserIsSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UserIsSubstitute]
(
	@LoginName nvarchar(255)
)
AS
SET NOCOUNT ON;

SELECT 1 AS UserIsSubstitute
FROM dbo.Mc_UsersGroups
WHERE GroupId = 2 AND UserId = @LoginName
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectLogin]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectLogin] ******/
ALTER PROCEDURE [dbo].[Mc_SelectLogin]
	@LoginId int
AS
	SET NOCOUNT ON;

SELECT 
	LoginId
	,LoginName
	,Password
	,Deleted
FROM dbo.Mc_Login
WHERE LoginId = @LoginId;
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectOrganizationsLogins]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectOrganizationsLogins] ******/
ALTER PROCEDURE [dbo].[Mc_SelectOrganizationsLogins]
(
	@OrganizationId int,
	@LoginId int
)
AS
	SET NOCOUNT ON;

SELECT [OrganizationId], [LoginId], [IsOrganizationAdministrator]
FROM [dbo].[Mc_OrganizationsLogins]
WHERE	[OrganizationId] = @OrganizationId
		AND [LoginId] = @LoginId;
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdateActionType]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateActionType]
(
	@ActionTypeId int,
	@Name nvarchar(50)
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [ActionType]
	SET
		[Name] = @Name
	WHERE
		[ActionTypeId] = @ActionTypeId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  View [dbo].[Mc_User]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[Mc_User] ******/
ALTER VIEW [dbo].[Mc_User]
AS
SELECT
	[UserId]
	,[Email]
	,[FirstName]
	,[LastName]
	,[MiddleName]
	,[LastLoginDate]
	,[Deleted]
FROM [dbo].[User]
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllRolesActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllRolesActions] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllRolesActions]
AS
	SET NOCOUNT ON;

SELECT ra.[RoleId], ra.ActionId 
FROM dbo.Mc_RolesActions ra
INNER JOIN dbo.Mc_Role r
	ON	ra.RoleId = r.RoleId
		AND r.Deleted = 0
INNER JOIN dbo.Mc_Action a
	ON	ra.ActionId = a.ActionId
		AND a.Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRole]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRole] ******/
ALTER PROCEDURE [dbo].[Mc_InsertRole]
(
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@ShortName nvarchar(50),
	@Rank int,
	@StartActionId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_Role] ([Name], [Description], [ShortName], [Rank], [StartActionId], [Deleted]) VALUES (@Name, @Description, @ShortName, @Rank, @StartActionId, @Deleted);
	
SELECT RoleId, [Name], Description, ShortName, Rank, StartActionId, Deleted FROM Mc_Role WHERE (RoleId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllRole]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllRole] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllRole]
AS
	SET NOCOUNT ON;
SELECT RoleId, [Name], Description, ShortName, Rank, StartActionId, Deleted FROM dbo.Mc_Role WHERE (Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllRolesSettings]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllRolesSettings] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllRolesSettings]
AS
	SET NOCOUNT ON;

SELECT rs.[RoleId], rs.SettingId, rs.[Value]
FROM dbo.Mc_RolesSettings rs
INNER JOIN dbo.Mc_Role r
	ON	rs.RoleId = r.RoleId
		AND r.Deleted = 0
INNER JOIN dbo.Mc_Setting s
	ON	rs.SettingId = s.SettingId
		AND s.Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateRole]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateRole] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateRole]
(
	@RoleId int,
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@ShortName nvarchar(50),
	@Rank int,
	@StartActionId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_Role] SET [Name] = @Name, [Description] = @Description, [ShortName] = @ShortName, [Rank] = @Rank, [StartActionId] = @StartActionId, [Deleted] = @Deleted WHERE ([RoleId] = @RoleId);
	
SELECT RoleId, [Name], Description, ShortName, Rank, StartActionId, Deleted FROM Mc_Role WHERE (RoleId = @RoleId)
GO
/****** Object:  View [dbo].[Certifiable]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Certifiable]
AS
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 1 AS CertifiableId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, 
                      CERTIFIABLE_LEVEL_OF_COVER_1 AS LevelOfCoverage, CERTIFIABLE_SUBJ_OF_COVER_1 AS SubjectOfCoverage
FROM         dbo.V_EMPLOYEE_CERTIFICATE
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 2 AS CertifiableId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, 
                      CERTIFIABLE_LEVEL_OF_COVER_2 AS LevelOfCoverage, CERTIFIABLE_SUBJ_OF_COVER_2 AS SubjectOfCoverage
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_5
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 3 AS CertifiableId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, 
                      CERTIFIABLE_LEVEL_OF_COVER_3 AS LevelOfCoverage, CERTIFIABLE_SUBJ_OF_COVER_3 AS SubjectOfCoverage
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_4
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 4 AS CertifiableId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, 
                      CERTIFIABLE_LEVEL_OF_COVER_4 AS LevelOfCoverage, CERTIFIABLE_SUBJ_OF_COVER_4 AS SubjectOfCoverage
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 5 AS CertifiableId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, 
                      CERTIFIABLE_LEVEL_OF_COVER_5 AS LevelOfCoverage, CERTIFIABLE_SUBJ_OF_COVER_5 AS SubjectOfCoverage
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 6 AS CertifiableId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, 
                      CERTIFIABLE_LEVEL_OF_COVER_6 AS LevelOfCoverage, CERTIFIABLE_SUBJ_OF_COVER_6 AS SubjectOfCoverage
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
GO
/****** Object:  View [dbo].[Segment851Certificate]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Segment851Certificate]
AS
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 100 + 1 * 10 + 1 AS Segment851CertificateId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, 
                      CERTIF_EXPIRE_YEAR_1 AS ExpireYear, CERTIF_LEVEL_1 AS [Level], CERTIF_TYPE_1 AS Type, 1 AS LevelTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 100 + 1 * 10 + 2 AS Segment851CertificateId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, 
                      CERTIF_EXPIRE_YEAR_2 AS ExpireYear, CERTIF_LEVEL_2 AS [Level], CERTIF_TYPE_2 AS Type, 1 AS LevelTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 100 + 1 * 10 + 3 AS Segment851CertificateId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, 
                      CERTIF_EXPIRE_YEAR_3 AS ExpireYear, CERTIF_LEVEL_3 AS [Level], CERTIF_TYPE_3 AS Type, 1 AS LevelTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 100 + 2 * 10 + 1 AS Segment851CertificateId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, 
                      DIST_CERTIF_EXPIRE_YEAR_1 AS ExpireYear, DIST_CERTIF_LEVEL_1 AS [Level], DIST_CERTIF_TYPE_1 AS Type, 2 AS LevelTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 100 + 2 * 10 + 2 AS Segment851CertificateId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, 
                      DIST_CERTIF_EXPIRE_YEAR_2 AS ExpireYear, DIST_CERTIF_LEVEL_2 AS [Level], DIST_CERTIF_TYPE_2 AS Type, 2 AS LevelTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 100 + 2 * 10 + 3 AS Segment851CertificateId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, 
                      DIST3_CERTIF_EXPIRE_YEAR AS ExpireYear, DIST3_CERTIF_LEVEL AS [Level], DIST3_CERTIF_TYPE AS Type, 2 AS LevelTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
GO
/****** Object:  View [dbo].[Coverage]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Coverage]
AS
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_1_1 AS [Level], SUBJECT_OF_COVERAGE_1_1 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_1_2 AS [Level], SUBJECT_OF_COVERAGE_1_2 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_5
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_1_3 AS [Level], SUBJECT_OF_COVERAGE_1_3 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_4
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_1_4 AS [Level], SUBJECT_OF_COVERAGE_1_4 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_1_5 AS [Level], SUBJECT_OF_COVERAGE_1_5 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_1_6 AS [Level], SUBJECT_OF_COVERAGE_1_6 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_2_1 AS [Level], SUBJECT_OF_COVERAGE_2_1 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_6
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_2_2 AS [Level], SUBJECT_OF_COVERAGE_2_2 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_5
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_2_3 AS [Level], SUBJECT_OF_COVERAGE_2_3 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_4
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_2_4 AS [Level], SUBJECT_OF_COVERAGE_2_4 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_2_5 AS [Level], SUBJECT_OF_COVERAGE_2_5 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_2_6 AS [Level], SUBJECT_OF_COVERAGE_2_6 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_3_1 AS [Level], SUBJECT_OF_COVERAGE_3_1 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_7
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_3_2 AS [Level], SUBJECT_OF_COVERAGE_32_2 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_5
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_3_3 AS [Level], SUBJECT_OF_COVERAGE_3_3 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_4
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_3_4 AS [Level], SUBJECT_OF_COVERAGE_3_4 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_3_5 AS [Level], SUBJECT_OF_COVERAGE_3_5 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     EMPLOYEE_NUMBER, LEVEL_OF_COVERAGE_3_6 AS [Level], SUBJECT_OF_COVERAGE_3_6 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
UNION ALL
SELECT     EMPLOYEE_NUMBER, DIST_LEVEL_OF_COVERAGE_1_1 AS [Level], DIST_SUBJECT_OF_COVERAGE_1_1 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
UNION ALL
SELECT     EMPLOYEE_NUMBER, DIST_LEVEL_OF_COVERAGE_1_2 AS [Level], DIST_SUBJECT_OF_COVERAGE_1_2 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     EMPLOYEE_NUMBER, DIST_LEVEL_OF_COVERAGE_1_3 AS [Level], DIST_SUBJECT_OF_COVERAGE_1_3 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     EMPLOYEE_NUMBER, DIST_LEVEL_OF_COVERAGE_1_4 AS [Level], DIST_SUBJECT_OF_COVERAGE_1_4 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_4
UNION ALL
SELECT     EMPLOYEE_NUMBER, DIST_LEVEL_OF_COVERAGE_1_5 AS [Level], DIST_SUBJECT_OF_COVERAGE_1_5 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_5
UNION ALL
SELECT     EMPLOYEE_NUMBER, DIST_LEVEL_OF_COVERAGE_1_6 AS [Level], DIST_SUBJECT_OF_COVERAGE_1_6 AS Subject
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_6
GO
/****** Object:  View [dbo].[Segment851]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Segment851]
AS
SELECT     EMPLOYEE_NUMBER * 10 + 1 AS Segment851Id, EMPLOYEE_NUMBER AS UserId, DISTRICT_CERTIFICATE_NUMBER AS DistrictCertificateNumber, 
                      BTP_ALTERNATE_IDENT AS BTPAlternateIdent, BTP_COMPLETION_STATUS AS BTPCompletionStatus, 
                      BTP_PROGRAM_STATUS AS BTPProgramStatus, BTP_PREVIOUS_EXPERIENCE AS BTPPreviousExperience, BTP_CRITERIA AS BTPCriteria, 
                      BTP_ENTRY_DATE AS BTPEntryDate, BTP_EXIT_DATE AS BTPExitDate, BTP_PEER_TEACHER AS BTPPeerTeacher, BTP_DOE_DATE AS BTPDoeDate, 
                      BTP_PEER_TCH_DATE AS BTPPeerTchDate, CERTIFICATE_NUMBER AS CertificateNumber, CERTIFICATE_LAST_MAINT_DT AS CertificateLastMaintDt, 
                      POP_PROGRAM_STATUS AS PopProgramStatus, POP_ESTIMATED_COMP_DATE AS PopEstimatedCompDate
FROM         dbo.V_EMPLOYEE_CERTIFICATE
GO
/****** Object:  View [dbo].[School]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[School]
AS
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 1 AS SchoolId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, PUBLIC_SCHOOL_STATE_1 AS State, 
                      PUBLIC_SCHOOL_YEARS_1 AS Years, 1 AS SchoolTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 2 AS SchoolId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, PUBLIC_SCHOOL_STATE_2 AS State, 
                      PUBLIC_SCHOOL_YEARS_2 AS Years, 1 AS SchoolTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_5
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 3 AS SchoolId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, PUBLIC_SCHOOL_STATE_3 AS State, 
                      PUBLIC_SCHOOL_YEARS_3 AS Years, 1 AS SchoolTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_4
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 4 AS SchoolId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, NON_PUBLIC_SCHOOL_STATE_1 AS State, 
                      NON_PUBLIC_SCHOOL_YEARS_1 AS Years, 2 AS SchoolTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_3
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 5 AS SchoolId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, NON_PUBLIC_SCHOOL_STATE_2 AS State, 
                      NON_PUBLIC_SCHOOL_YEARS_2 AS Years, 2 AS SchoolTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_2
UNION ALL
SELECT     (EMPLOYEE_NUMBER * 10 + 1) * 10 + 6 AS SchoolId, EMPLOYEE_NUMBER * 10 + 1 AS Segment851, NON_PUBLIC_SCHOOL_STATE_3 AS State, 
                      NON_PUBLIC_SCHOOL_YEARS_3 AS Years, 2 AS SchoolTypeId
FROM         dbo.V_EMPLOYEE_CERTIFICATE AS Segment_851_1
GO
/****** Object:  StoredProcedure [dbo].[GetCoverage]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetCoverage]
	@userId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT [Level], Subject, V_CERTIFICATE.Subject_of_coverage_description as 'SubjectName', V_CERTIFICATE_LEVEL.CERTIFICATE_LEVEL_DESC as 'LevelName', CASE WHEN V_EMPLOYEE_CERTIFICATE.CERTIF_EXPIRE_YEAR_1 > 0 THEN V_EMPLOYEE_CERTIFICATE.CERTIF_EXPIRE_YEAR_1 ELSE V_EMPLOYEE_CERTIFICATE.DIST_CERTIF_EXPIRE_YEAR_1 END as 'ExpireYear'
	FROM Coverage
	LEFT JOIN V_CERTIFICATE ON V_CERTIFICATE.Subject_of_coverage = Coverage.Subject
	LEFT JOIN V_CERTIFICATE_LEVEL ON V_CERTIFICATE_LEVEL.CERTIFICATE_LEVEL_CODE = Coverage.[Level]
	LEFT JOIN V_EMPLOYEE_CERTIFICATE ON V_EMPLOYEE_CERTIFICATE.EMPLOYEE_NUMBER = Coverage.EMPLOYEE_NUMBER
	WHERE Coverage.EMPLOYEE_NUMBER = @userId AND Subject <> '000'
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRolesSettings]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRolesSettings] ******/
ALTER PROCEDURE [dbo].[Mc_InsertRolesSettings]
(
	@RoleId int,
	@SettingId int,
	@Value nvarchar(512)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_RolesSettings] ([RoleId], [SettingId], [Value]) VALUES (@RoleId, @SettingId, @Value);
	
SELECT [RoleId], SettingId, [Value] FROM Mc_RolesSettings WHERE (([RoleId] = @RoleId) AND ([SettingId] = @SettingId))
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteRolesSettings]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteRolesSettings] ******/
ALTER PROCEDURE [dbo].[Mc_DeleteRolesSettings]
(
	@RoleId int,
	@SettingId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Mc_RolesSettings] WHERE (([RoleId] = @RoleId) AND ([SettingId] = @SettingId))
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateRolesSettings]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateRolesSettings] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateRolesSettings]
(
	@RoleId int,
	@SettingId int,
	@Value nvarchar(512)
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_RolesSettings] SET [Value] = @Value WHERE (([RoleId] = @RoleId) AND ([SettingId] = @SettingId));
	
SELECT [RoleId], SettingId, [Value] FROM Mc_RolesSettings WHERE (([RoleId] = @RoleId) AND ([SettingId] = @SettingId))
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRolesActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRolesActions] ******/
ALTER PROCEDURE [dbo].[Mc_InsertRolesActions]
(
	@RoleId int,
	@ActionId int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_RolesActions] ([RoleId], [ActionId]) VALUES (@RoleId, @ActionId);
	
SELECT [RoleId], ActionId FROM Mc_RolesActions WHERE (ActionId = @ActionId) AND ([RoleId] = @RoleId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteRolesActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteRolesActions] ******/
ALTER PROCEDURE [dbo].[Mc_DeleteRolesActions]
(
	@RoleId int,
	@ActionId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Mc_RolesActions] WHERE (([RoleId] = @RoleId) AND ([ActionId] = @ActionId))
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSession]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteSession]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSettingListValues] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllSettingListValues]
AS
	SET NOCOUNT ON;
SELECT SettingListValuesId, SettingId, [Name], [Value], Deleted FROM dbo.Mc_SettingListValues WHERE (Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertSettingListValues] ******/
ALTER PROCEDURE [dbo].[Mc_InsertSettingListValues]
(
	@SettingId int,
	@Name nvarchar(255),
	@Value nvarchar(512),
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_SettingListValues] ([SettingId], [Name], [Value], [Deleted]) VALUES (@SettingId, @Name, @Value, @Deleted);
	
SELECT SettingListValuesId, SettingId, [Name], [Value], Deleted FROM Mc_SettingListValues WHERE (SettingListValuesId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSettingListValues]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSettingListValues] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateSettingListValues]
(
	@SettingListValuesId int,
	@SettingId int,
	@Name nvarchar(255),
	@Value nvarchar(512),
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_SettingListValues] SET [SettingId] = @SettingId, [Name] = @Name, [Value] = @Value, [Deleted] = @Deleted WHERE ([SettingListValuesId] = @SettingListValuesId);
	
SELECT SettingListValuesId, SettingId, [Name], [Value], Deleted FROM Mc_SettingListValues WHERE (SettingListValuesId = @SettingListValuesId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSettingType]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSettingType] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllSettingType]
AS
	SET NOCOUNT ON;
SELECT SettingTypeId, [Name], ClassFullName FROM dbo.Mc_SettingType
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSqlServer]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSqlServer] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllSqlServer]
AS
	SET NOCOUNT ON;
SELECT SqlServerId, [Name], [InstanceName], [Port], Description, WebSiteId, Deleted FROM dbo.Mc_SqlServer WHERE (Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSqlServer]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSqlServer] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateSqlServer]
(
	@SqlServerId int,
	@Name nvarchar(255),
	@InstanceName nvarchar(255),
	@Port int,
	@Description nvarchar(1024),
	@WebSiteId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_SqlServer] SET [Name] = @Name, [InstanceName] = @InstanceName, [Port] = @Port, [Description] = @Description, [WebSiteId] = @WebSiteId, [Deleted] = @Deleted WHERE ([SqlServerId] = @SqlServerId);
	
SELECT SqlServerId, [Name], [InstanceName], [Port], Description, WebSiteId, Deleted FROM Mc_SqlServer WHERE (SqlServerId = @SqlServerId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertSqlServer]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertSqlServer] ******/
ALTER PROCEDURE [dbo].[Mc_InsertSqlServer]
(
	@Name nvarchar(255),
	@InstanceName nvarchar(255),
	@Port int,
	@Description nvarchar(1024),
	@WebSiteId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_SqlServer] ([Name], [InstanceName], [Port], [Description], [WebSiteId], [Deleted]) VALUES (@Name, @InstanceName, @Port, @Description, @WebSiteId, @Deleted);
	
SELECT SqlServerId, [Name], [InstanceName], [Port], Description, WebSiteId, Deleted FROM Mc_SqlServer WHERE (SqlServerId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateWebSite]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateWebSite] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateWebSite]
(
	@WebSiteId int,
	@Name nvarchar(255),
	@Url nvarchar(2048),
	@Description nvarchar(1024),
	@AdminContactInfo nvarchar(2048),
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_WebSite] SET [Name] = @Name, [Url] = @Url, [Description] = @Description, [AdminContactInfo] = @AdminContactInfo, [Deleted] = @Deleted WHERE ([WebSiteId] = @WebSiteId);
	
SELECT WebSiteId, [Name], Url, Description, AdminContactInfo, Deleted FROM Mc_WebSite WHERE (WebSiteId = @WebSiteId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllWebSite]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllWebSite] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllWebSite]
AS
	SET NOCOUNT ON;
SELECT WebSiteId, [Name], Url, Description, AdminContactInfo, Deleted FROM dbo.Mc_WebSite WHERE (Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertWebSite]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertWebSite] ******/
ALTER PROCEDURE [dbo].[Mc_InsertWebSite]
(
	@Name nvarchar(255),
	@Url nvarchar(2048),
	@Description nvarchar(1024),
	@AdminContactInfo nvarchar(2048),
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_WebSite] ([Name], [Url], [Description], [AdminContactInfo], [Deleted]) VALUES (@Name, @Url, @Description, @AdminContactInfo, @Deleted);
	
SELECT WebSiteId, [Name], Url, Description, AdminContactInfo, Deleted FROM Mc_WebSite WHERE (WebSiteId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[GetTimes]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetTimes]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Name, Value from TimePicker
END
GO
/****** Object:  StoredProcedure [dbo].[GetWeekdays]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetWeekdays]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM Weekday
END
GO
/****** Object:  StoredProcedure [dbo].[AddSubstituteToList]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[AddSubstituteToList] 
@substituteId int,
@locationId int
AS
BEGIN
	DELETE FROM Preferred WHERE SubstituteId = @substituteId AND LocationId = @locationId
	INSERT INTO Preferred (SubstituteId, LocationId) VALUES (@substituteId, @locationId)
	
	DELETE FROM ClerkPreferredSubs WHERE SubstituteId = @substituteId AND LocationId = @locationId
	INSERT INTO ClerkPreferredSubs (SubstituteId, LocationId) VALUES (@substituteId, @locationId)	
END
GO
/****** Object:  StoredProcedure [dbo].[daab_InsertClerkPreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_InsertClerkPreferred]
(
	@LocationId int,
	@SubstituteId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT INTO [ClerkPreferredSubs]
	(LocationId, SubstituteId)
	VALUES
	(@LocationId, @SubstituteId)

	SET @Err = @@Error
	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteClerkPreferredBySubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteClerkPreferredBySubstitute]
(
	@LocationId int,
	@SubstituteId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [ClerkPreferredSubs]
	WHERE
		[LocationId] = @LocationId
		AND [SubstituteId] = @SubstituteId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[IsExistPreferredClerk]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[IsExistPreferredClerk]
	@locationId int,
	@substituteId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM ClerkPreferredSubs 
	WHERE LocationId = @locationId AND SubstituteId = @substituteId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetJob]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetJob]
(
	@JobId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[JobId],
		[LocationId],
		[SubtypeId],
		[Teacher],
		[GradeId],
		[StatusId],
		[DatetimeStart],
		[DatetimeEnd],
		[Room],
		[Note],
		[SubstituteId],
		[Subject]
	FROM [Job]
	WHERE
		([JobId] = @JobId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteJob]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteJob]
(
	@JobId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE FROM [JobSubstitutes] WHERE [JobId] = @JobId
	DELETE FROM [Job] WHERE	[JobId] = @JobId

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_AddJob]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddJob]
(
	@JobId int = NULL OUTPUT,
	@LocationId int = NULL,
	@SubtypeId int = NULL,
	@Teacher nvarchar(255) = NULL,
	@GradeId int = NULL,
	@StatusId int = NULL,
	@DatetimeStart datetime = NULL,
	@DatetimeEnd datetime = NULL,
	@Room varchar(50) = NULL,
	@Note varchar(255) = NULL,
	@SubstituteId int = NULL,
	@Subject varchar(50) = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [Job]
	(
		[LocationId],
		[SubtypeId],
		[Teacher],
		[GradeId],
		[StatusId],
		[DatetimeStart],
		[DatetimeEnd],
		[Room],
		[Note],
		[SubstituteId],
		[Subject]
	)
	VALUES
	(
		@LocationId,
		@SubtypeId,
		@Teacher,
		@GradeId,
		@StatusId,
		@DatetimeStart,
		@DatetimeEnd,
		@Room,
		@Note,
		@SubstituteId,
		@Subject
	)

	SET @Err = @@Error
	SELECT @JobId = SCOPE_IDENTITY()

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdateJob]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateJob]
(
	@JobId int,
	@LocationId int = NULL,
	@SubtypeId int = NULL,
	@Teacher nvarchar(255) = NULL,
	@GradeId int = NULL,
	@StatusId int = NULL,
	@DatetimeStart datetime = NULL,
	@DatetimeEnd datetime = NULL,
	@Room varchar(50) = NULL,
	@Note varchar(255) = NULL,
	@SubstituteId int = NULL,
	@Subject varchar(50) = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [Job]
	SET
		[LocationId] = @LocationId,
		[SubtypeId] = @SubtypeId,
		[Teacher] = @Teacher,
		[GradeId] = @GradeId,
		[StatusId] = @StatusId,
		[DatetimeStart] = @DatetimeStart,
		[DatetimeEnd] = @DatetimeEnd,
		[Room] = @Room,
		[Note] = @Note,
		[SubstituteId] = @SubstituteId,
		[Subject] = @Subject
	WHERE
		[JobId] = @JobId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteJobSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteJobSubstitute]
(
	@SubstituteId int,
	@JobId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	DELETE FROM [JobSubstitutes]
	WHERE 
		[SubstituteId] = @SubstituteId
		AND [JobId] = @JobId

	UPDATE Job SET SubstituteId = 0, StatusId = 1 WHERE JobId = @JobId

	SET @Err = @@Error
	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[LoadLastJobBySubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LoadLastJobBySubstitute]
(
	@SubstituteId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT                
		[Job].Teacher as 'Name',
		CONVERT(varchar, DatetimeStart, 1) as 'DatetimeStart',
		datediff(hour,DatetimeStart,DatetimeEnd) as 'TimeWorks'
	FROM [Job]
	WHERE
		([SubstituteId] = @SubstituteId)
	ORDER BY [Datetimeend] DESC

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[SetSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SetSubstitute]
@JobId int,
@SubstituteId int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Job SET SubstituteId = @SubstituteId, StatusId = 2 WHERE JobId = @JobId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_IsOverlap]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_IsOverlap] 
@SubstituteId int,
@JobId int
AS
BEGIN
	SET NOCOUNT OFF;
	SELECT jb.JobId as [JobId] FROM [Job] jb
	LEFT JOIN [Job] ON [Job].JobId = @JobId
	WHERE jb.SubstituteId = @SubstituteId 
		AND (			   							   			   
			   (jb.[DatetimeStart] >= [Job].[DatetimeStart] AND [jb].[DatetimeStart] <= [Job].[DatetimeEnd])
			   OR (jb.[DatetimeEnd] >= [Job].[DatetimeStart] AND [jb].[DatetimeEnd] <= [Job].[DatetimeEnd])
			   OR (jb.[DatetimeStart] <= [Job].[DatetimeStart] AND [jb].[DatetimeEnd] >= [Job].[DatetimeEnd])
			   OR (jb.[DatetimeEnd] < [Job].[DatetimeStart] AND [jb].[DatetimeEnd] > [Job].[DatetimeEnd])					
			)

END
GO
/****** Object:  StoredProcedure [dbo].[daab_IsOverlapDay]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_IsOverlapDay] 
@SubstituteId int,
@Day datetime
AS
BEGIN
	SET NOCOUNT OFF;
	SELECT JobId FROM [Job]
	WHERE [Job].SubstituteId = @SubstituteId 
		AND (
			   @Day >= [Job].[DatetimeStart] AND @Day <= [Job].[DatetimeEnd]
			)
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateDepartment]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateDepartment] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateDepartment]
(
	@DepartmentId int,
	@OrganizationId int,
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@EnableSignUpUser bit,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_Department] SET [OrganizationId] = @OrganizationId, [Name] = @Name, [Description] = @Description, [EnableSignUpUser] = @EnableSignUpUser, [Deleted] = @Deleted WHERE ([DepartmentId] = @DepartmentId);
	
SELECT DepartmentId, OrganizationId, [Name], Description, EnableSignUpUser, Deleted FROM Mc_Department WHERE (DepartmentId = @DepartmentId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertDepartment]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertDepartment] ******/
ALTER PROCEDURE [dbo].[Mc_InsertDepartment]
(
	@OrganizationId int,
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@EnableSignUpUser bit,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_Department] ([OrganizationId], [Name], [Description], [EnableSignUpUser], [Deleted]) VALUES (@OrganizationId, @Name, @Description, @EnableSignUpUser, @Deleted);
	
SELECT DepartmentId, OrganizationId, [Name], Description, EnableSignUpUser, Deleted FROM Mc_Department WHERE (DepartmentId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllDepartment]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllDepartment] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllDepartment]
	@OrganizationId int
AS
	SET NOCOUNT ON;
SELECT DepartmentId, OrganizationId, [Name], Description, EnableSignUpUser, Deleted FROM dbo.Mc_Department WHERE (Deleted = 0) AND (OrganizationId = @OrganizationId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllGroupsDepartmentsRoles]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllGroupsDepartmentsRoles] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllGroupsDepartmentsRoles]
	@OrganizationId int
AS
	SET NOCOUNT ON;
	
SELECT gdr.GroupId, gdr.DepartmentId, gdr.RoleId
FROM dbo.Mc_GroupsDepartmentsRoles gdr
INNER JOIN dbo.Mc_Group g
	ON	gdr.GroupId = g.GroupId
		AND g.Deleted = 0
		AND g.OrganizationId = @OrganizationId
INNER JOIN dbo.Mc_Department d
	ON	gdr.DepartmentId = d.DepartmentId
		AND d.Deleted = 0
		AND d.OrganizationId = @OrganizationId;
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllGroupsDepartmentsActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllGroupsDepartmentsActions] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllGroupsDepartmentsActions]
	@OrganizationId int
AS
	SET NOCOUNT ON;

SELECT gda.GroupId, gda.DepartmentId, gda.ActionId, gda.Enabled 
FROM dbo.Mc_GroupsDepartmentsActions gda
INNER JOIN dbo.Mc_Group g
	ON	gda.GroupId = g.GroupId
		AND g.Deleted = 0
		AND g.OrganizationId = @OrganizationId
INNER JOIN dbo.Mc_Department d
	ON	gda.DepartmentId = d.DepartmentId
		AND d.Deleted = 0
		AND d.OrganizationId = @OrganizationId;
GO
/****** Object:  StoredProcedure [dbo].[daab_GetTemplate]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetTemplate]
(
	@TemplateId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[TemplateId],
		[Name],
		[Header],
		[Description],
		[Text]
	FROM [dbo].[Template]
	WHERE
		([TemplateId] = @TemplateId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_AddTemplate]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddTemplate]
(
	@TemplateId int = NULL OUTPUT,
	@Name varchar(255),
	@Header varchar(500),
	@Description varchar(500) = NULL,
	@Text text = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [dbo].[Template]
	(
		[Name],
		[Header],
		[Description],
		[Text]
	)
	VALUES
	(
		@Name,
		@Header,
		@Description,
		@Text
	)

	SET @Err = @@Error
	SELECT @TemplateId = SCOPE_IDENTITY()

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllTemplate]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllTemplate]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[TemplateId],
		[Name],
		[Header],
		[Description],
		[Text]
	FROM [dbo].[Template]

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[LoadTemplateByName]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LoadTemplateByName]
(
	@TemplateName nvarchar(255)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[TemplateId],
		[Name],
		[Header],
		[Description],
		[Text]
	FROM [dbo].[Template]
	WHERE
		([Name] = @TemplateName)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdateTemplate]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateTemplate]
(
	@TemplateId int,
	@Name varchar(255),
	@Header varchar(500),
	@Description varchar(500) = NULL,
	@Text text = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [dbo].[Template]
	SET
		[Name] = @Name,
		[Header] = @Header,
		[Description] = @Description,
		[Text] = @Text
	WHERE
		[TemplateId] = @TemplateId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteTemplate]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteTemplate]
(
	@TemplateId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [dbo].[Template]
	WHERE
		[TemplateId] = @TemplateId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateGroupsDepartmentsActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Mc_UpdateGroupsDepartmentsActions]
(
	@GroupId int,
	@DepartmentId int,
	@ActionId int,
	@Enabled bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_GroupsDepartmentsActions] SET [Enabled] = @Enabled WHERE (ActionId = @ActionId) AND (DepartmentId = @DepartmentId) AND (GroupId = @GroupId);
	
SELECT GroupId, DepartmentId, ActionId, Enabled FROM Mc_GroupsDepartmentsActions WHERE (ActionId = @ActionId) AND (DepartmentId = @DepartmentId) AND (GroupId = @GroupId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertGroupsDepartmentsActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertGroupsDepartmentsActions] ******/
ALTER PROCEDURE [dbo].[Mc_InsertGroupsDepartmentsActions]
(
	@GroupId int,
	@DepartmentId int,
	@ActionId int,
	@Enabled bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_GroupsDepartmentsActions] ([GroupId], [DepartmentId], [ActionId], [Enabled]) VALUES (@GroupId, @DepartmentId, @ActionId, @Enabled);
	
SELECT GroupId, DepartmentId, ActionId, Enabled FROM Mc_GroupsDepartmentsActions WHERE (ActionId = @ActionId) AND (DepartmentId = @DepartmentId) AND (GroupId = @GroupId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteGroupsDepartmentsActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteGroupsDepartmentsActions] ******/
ALTER PROCEDURE [dbo].[Mc_DeleteGroupsDepartmentsActions]
(
	@GroupId int,
	@DepartmentId int,
	@ActionId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Mc_GroupsDepartmentsActions] WHERE (([GroupId] = @GroupId) AND ([DepartmentId] = @DepartmentId) AND ([ActionId] = @ActionId))
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteGroupsDepartmentsRoles]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteGroupsDepartmentsRoles] ******/
ALTER PROCEDURE [dbo].[Mc_DeleteGroupsDepartmentsRoles]
(
	@GroupId int,
	@DepartmentId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Mc_GroupsDepartmentsRoles] WHERE (([GroupId] = @GroupId) AND ([DepartmentId] = @DepartmentId))
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateGroupsDepartmentsRoles]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateGroupsDepartmentsRoles] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateGroupsDepartmentsRoles]
(
	@GroupId int,
	@DepartmentId int,
	@RoleId int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_GroupsDepartmentsRoles] SET [GroupId] = @GroupId, [DepartmentId] = @DepartmentId, [RoleId] = @RoleId WHERE (([GroupId] = @GroupId) AND ([DepartmentId] = @DepartmentId));
	
SELECT GroupId, DepartmentId, RoleId FROM Mc_GroupsDepartmentsRoles WHERE (DepartmentId = @DepartmentId) AND (GroupId = @GroupId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertGroupsDepartmentsRoles]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertGroupsDepartmentsRoles] ******/
ALTER PROCEDURE [dbo].[Mc_InsertGroupsDepartmentsRoles]
(
	@GroupId int,
	@DepartmentId int,
	@RoleId int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_GroupsDepartmentsRoles] ([GroupId], [DepartmentId], [RoleId]) VALUES (@GroupId, @DepartmentId, @RoleId);
	
SELECT GroupId, DepartmentId, RoleId FROM Mc_GroupsDepartmentsRoles WHERE (DepartmentId = @DepartmentId) AND (GroupId = @GroupId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertSettingValue]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertSettingValue] ******/
ALTER PROCEDURE [dbo].[Mc_InsertSettingValue]
(
	@SettingId int,
	@Value nvarchar(512),
	@OrganizationId int,
	@DepartmentId int,
	@GroupId int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_SettingValue] ([SettingId], [Value], [OrganizationId], [DepartmentId], [GroupId]) VALUES (@SettingId, @Value, @OrganizationId, @DepartmentId, @GroupId);
	
SELECT SettingValueId, SettingId, [Value], OrganizationId, DepartmentId, GroupId FROM Mc_SettingValue WHERE (SettingValueId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSettingValue]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllSettingValue] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllSettingValue]
	@OrganizationId int
AS
	SET NOCOUNT ON;

SELECT SettingValueId, SettingId, [Value], OrganizationId, DepartmentId, GroupId
FROM dbo.Mc_SettingValue 
WHERE	OrganizationId IS NULL
		OR (	OrganizationId IS NOT NULL 
				AND OrganizationId = @OrganizationId
		);
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSettingValue]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSettingValue] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateSettingValue]
(
	@SettingValueId int,
	@SettingId int,
	@Value nvarchar(512),
	@OrganizationId int,
	@DepartmentId int,
	@GroupId int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_SettingValue] SET [SettingId] = @SettingId, [Value] = @Value, [OrganizationId] = @OrganizationId, [DepartmentId] = @DepartmentId, [GroupId] = @GroupId WHERE ([SettingValueId] = @SettingValueId);
	
SELECT SettingValueId, SettingId, [Value], OrganizationId, DepartmentId, GroupId FROM Mc_SettingValue WHERE (SettingValueId = @SettingValueId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteSettingValue]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteSettingValue] ******/
ALTER PROCEDURE [dbo].[Mc_DeleteSettingValue]
(
	@SettingValueId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Mc_SettingValue] WHERE ([SettingValueId] = @SettingValueId)
GO
/****** Object:  View [dbo].[UserLocation]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[UserLocation]
AS
SELECT     LOCATION AS UserLocationId, LOCATION AS LocationId, EMPLOYEE_NUMBER AS UserId
FROM         dbo.V_AUTHORIZED_USER
GO
/****** Object:  StoredProcedure [dbo].[daab_GetEmployee]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetEmployee]
(
	@LocationId varchar(4)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT * 
	FROM dbo.V_AUTHORIZED_USER
	WHERE
		V_AUTHORIZED_USER.[Location] = @LocationId

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  View [dbo].[User]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[User]
AS
SELECT     CAST(EMPLOYEE_NUMBER AS int) AS UserId, CAST(EMPLOYEE_NUMBER AS nvarchar(255)) AS LoginName, CAST(REPLACE(CONVERT(varchar, BIRTH_DATE, 1), '/', 
                      '') AS nvarchar(50)) AS Password, CAST(EMPLOYEE_EMAIL_ADDRESS AS nvarchar(255)) AS Email, CAST(FIRST_NAME AS nvarchar(255)) AS FirstName, 
                      CAST(LAST_NAME AS nvarchar(255)) AS LastName, CAST(MIDDLE_NAME AS nvarchar(255)) AS MiddleName, CAST(NULL AS datetime) AS LastLoginDate, CAST(0 AS bit)
                       AS IsOrganizationAdministrator, CAST(0 AS bit) AS Deleted, PAYCODE, JOB_BOARD_CODE AS BoardCode, LOCATION AS LocationId, 
                      RESIDENCE_PHONE_NUMBER AS CellPhone, SALARY_SCHEDULE
FROM         DW_PERQ.dbo.V_EMPLOYEE
WHERE     (STATUS = '1')
UNION
SELECT     CAST(EMPLOYEE_NUMBER AS int) AS UserId, EMPLOYEE_NUMBER AS LoginName, '000000' AS Password, EMPLOYEE_EMAIL_ADDRESS AS Email, 
                      FULL_NAME AS FirstName, '' AS LastName, '' AS MiddleName, CAST(NULL AS datetime) AS LastLoginDate, CAST(0 AS bit) AS IsOrganizationAdministrator, 
                      CAST(0 AS bit) AS Deleted, '0' AS Expr1, '0' AS BoardCode, LOCATION AS LocationId, NULL AS CellPhone, '' AS SALARY_SCHEDULE
FROM         dbo.V_AUTHORIZED_USER
WHERE     (EMPLOYEE_NUMBER = 910658)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectVersion]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectVersion] ******/
ALTER PROCEDURE [dbo].[Mc_SelectVersion]
AS
	SET NOCOUNT ON;
SELECT Version FROM dbo.Mc_Version
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateAction]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateAction] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateAction]
(
	@ActionId int,
	@ParentActionId int,
	@ActionTypeId int,
	@Name nvarchar(1024),
	@Description nvarchar(1024),
	@IconUrl nvarchar(2048),
	@ButtonIconUrl nvarchar(2048),
	@NavigateUrl nvarchar(2048),
	@OrderNumber int,
	@ClassFullName nvarchar(1024),
	@DepartmentRequired bit,
	@Visible bit,
	@ShowInDetailMenu bit,
	@ShowChildrenInDetailMenu bit,
	@GroupInDetailMenu bit,
	@HighlightInDetailMenu bit,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_Action] SET ParentActionId = @ParentActionId, ActionTypeId = @ActionTypeId, [Name] = @Name, Description = @Description, IconUrl = @IconUrl, ButtonIconUrl = @ButtonIconUrl, NavigateUrl = @NavigateUrl, OrderNumber = @OrderNumber, ClassFullName = @ClassFullName, DepartmentRequired = @DepartmentRequired, Visible = @Visible, ShowInDetailMenu = @ShowInDetailMenu, ShowChildrenInDetailMenu = @ShowChildrenInDetailMenu, GroupInDetailMenu = @GroupInDetailMenu, HighlightInDetailMenu = @HighlightInDetailMenu, Deleted = @Deleted WHERE ([ActionId] = @ActionId);
	
SELECT ActionId, ParentActionId, ActionTypeId, [Name], Description, IconUrl, ButtonIconUrl, NavigateUrl, OrderNumber, ClassFullName, DepartmentRequired, Visible, ShowInDetailMenu, ShowChildrenInDetailMenu, GroupInDetailMenu, HighlightInDetailMenu, Deleted FROM dbo.Mc_Action WHERE (ActionId = @ActionId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllAction]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllAction] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllAction]
AS
	SET NOCOUNT ON;
SELECT ActionId, ParentActionId, ActionTypeId, [Name], Description, IconUrl, ButtonIconUrl, NavigateUrl, OrderNumber, ClassFullName, DepartmentRequired, Visible, ShowInDetailMenu, ShowChildrenInDetailMenu, GroupInDetailMenu, HighlightInDetailMenu, Deleted FROM dbo.Mc_Action WHERE (Deleted = 0) ORDER BY ParentActionId, OrderNumber, [Name]
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertAction]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertAction] ******/
ALTER PROCEDURE [dbo].[Mc_InsertAction]
(
	@ParentActionId int,
	@ActionTypeId int,
	@Name nvarchar(1024),
	@Description nvarchar(1024),
	@IconUrl nvarchar(2048),
	@ButtonIconUrl nvarchar(2048),
	@NavigateUrl nvarchar(2048),
	@OrderNumber int,
	@ClassFullName nvarchar(1024),
	@DepartmentRequired bit,
	@Visible bit,
	@ShowInDetailMenu bit,
	@ShowChildrenInDetailMenu bit,
	@GroupInDetailMenu bit,
	@HighlightInDetailMenu bit,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_Action] (ParentActionId, ActionTypeId, [Name], Description, IconUrl, ButtonIconUrl, NavigateUrl, OrderNumber, ClassFullName, DepartmentRequired, Visible, ShowInDetailMenu, ShowChildrenInDetailMenu, GroupInDetailMenu, HighlightInDetailMenu , Deleted) VALUES (@ParentActionId, @ActionTypeId, @Name, @Description, @IconUrl, @ButtonIconUrl, @NavigateUrl, @OrderNumber, @ClassFullName, @DepartmentRequired, @Visible, @ShowInDetailMenu, @ShowChildrenInDetailMenu, @GroupInDetailMenu, @HighlightInDetailMenu, @Deleted);
	
SELECT ActionId, ParentActionId, ActionTypeId, [Name], Description, IconUrl, ButtonIconUrl, NavigateUrl, OrderNumber, ClassFullName, DepartmentRequired, Visible, ShowInDetailMenu, ShowChildrenInDetailMenu, GroupInDetailMenu, HighlightInDetailMenu, Deleted FROM dbo.Mc_Action WHERE (ActionId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllActionsParentActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllActionsParentActions] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllActionsParentActions]
AS
	SET NOCOUNT ON;

SELECT p.[ActionId], p.[ParentActionId] 
FROM [dbo].[Mc_ActionsParentActions] p
INNER JOIN [dbo].[Mc_Action] a
	ON	p.[ActionId] = a.[ActionId]
		AND a.Deleted = 0
INNER JOIN [dbo].[Mc_Action] a1
	ON	p.[ActionId] = a1.[ActionId]
		AND a1.Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateGroup]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateGroup] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateGroup]
(
	@GroupId int,
	@OrganizationId int,
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_Group] SET [OrganizationId] = @OrganizationId, [Name] = @Name, [Description] = @Description, [Deleted] = @Deleted WHERE ([GroupId] = @GroupId);
	
SELECT GroupId, OrganizationId, [Name], Description, Deleted FROM Mc_Group WHERE (GroupId = @GroupId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertGroup]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertGroup] ******/
ALTER PROCEDURE [dbo].[Mc_InsertGroup]
(
	@OrganizationId int,
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_Group] ([OrganizationId], [Name], [Description], [Deleted]) VALUES (@OrganizationId, @Name, @Description, @Deleted);
	
SELECT GroupId, OrganizationId, [Name], Description, Deleted FROM Mc_Group WHERE (GroupId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllGroup]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllGroup] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllGroup]
	@OrganizationId int
AS
	SET NOCOUNT ON;
SELECT GroupId, OrganizationId, [Name], Description, Deleted FROM dbo.Mc_Group WHERE (Deleted = 0) AND (OrganizationId = @OrganizationId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllOrganizationByLoginId]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllOrganizationByLoginId] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllOrganizationByLoginId]
	@LoginId int
AS
	SET NOCOUNT ON;

SELECT 
	o.OrganizationId
	,o.[Name]
	,o.Description
	,o.WebSiteUrl
	,o.IconUrl
	,o.DatabaseId
	,o.Deleted
FROM dbo.Mc_OrganizationsLogins ol
INNER JOIN dbo.Mc_Organization o
	ON	ol.OrganizationId = o.OrganizationId
		AND ol.LoginId = @LoginId
		AND o.Deleted = 0;
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectLoginByDetails]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectLoginByDetails] ******/
ALTER PROCEDURE [dbo].[Mc_SelectLoginByDetails]
	@LoginName nvarchar(255),
	@Password nvarchar(50)
AS
	SET NOCOUNT ON;

SELECT 
	l.LoginId
	,l.LoginName
	,l.Password
	,l.Deleted
	,(CASE WHEN EXISTS(
		SELECT TOP 1 o.OrganizationId
		FROM dbo.Mc_Organization o
		INNER JOIN dbo.Mc_OrganizationsLogins ol
			ON	o.OrganizationId = ol.OrganizationId 
				AND ol.LoginId = l.LoginId
				AND o.Deleted = 0
		) THEN 1 ELSE 0 END
	) AS OrganizationExists
FROM dbo.Mc_Login l
WHERE l.LoginName = @LoginName 
	AND (	@Password IS NULL
			OR (	@Password IS NOT NULL
					AND l.Password = @Password
			)
	);
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllOrganization]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllOrganization] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllOrganization]
AS
	SET NOCOUNT ON;
SELECT OrganizationId, [Name], Description, WebSiteUrl, IconUrl, DatabaseId, Deleted FROM dbo.Mc_Organization WHERE (Deleted = 0)
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateOrganization]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateOrganization] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateOrganization]
(
	@OrganizationId int,
	@Name nvarchar(255),
	@Description nvarchar(255),
	@WebSiteUrl nvarchar(2048),
	@IconUrl nvarchar(2048),
	@DatabaseId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_Organization] SET [Name] = @Name, [Description] = @Description, [WebSiteUrl] = @WebSiteUrl, [IconUrl] = @IconUrl, [DatabaseId] = @DatabaseId, [Deleted] = @Deleted WHERE ([OrganizationId] = @OrganizationId);
	
SELECT OrganizationId, [Name], Description, WebSiteUrl, IconUrl, DatabaseId, Deleted FROM Mc_Organization WHERE (OrganizationId = @OrganizationId)
GO
/****** Object:  StoredProcedure [dbo].[GetAllMailLogByLocationId]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetAllMailLogByLocationId]
@LocationId int
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[MailLogId],
		[LocationId],
		[SendDate],
		[MailTo],
		[MailFrom],
		[Subject],
		[Message],
		[MailType]
	FROM [dbo].[MailLog]
	WHERE 
		[LocationId] = @LocationId
	ORDER BY [SendDate] DESC

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteMailLog]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DeleteMailLog]
(
	@LocationId int,
	@Count int
)
AS
BEGIN
	SET ROWCOUNT @Count

	DELETE FROM [MailLog] WHERE LocationId = @LocationId
	
	SET ROWCOUNT 0
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteMailLog]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteMailLog]
(
	@MailLogId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [dbo].[MailLog]
	WHERE
		[MailLogId] = @MailLogId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_AddMailLog]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddMailLog]
(
	@MailLogId int = NULL OUTPUT,
	@LocationId int,
	@SendDate datetime,
	@MailTo varchar(5000) = NULL,
	@MailFrom varchar(5000) = NULL,
	@Subject varchar(500) = NULL,
	@Message text = NULL,
	@MailType varchar(255) = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [dbo].[MailLog]
	(
		[LocationId],
		[SendDate],
		[MailTo],
		[MailFrom],
		[Subject],
		[Message],
		[MailType]
	)
	VALUES
	(
		@LocationId,
		@SendDate,
		@MailTo,
		@MailFrom,
		@Subject,
		@Message,
		@MailType
	)

	SET @Err = @@Error
	SELECT @MailLogId = SCOPE_IDENTITY()

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdateMailLog]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateMailLog]
(
	@MailLogId int,
	@LocationId int,
	@SendDate datetime,
	@MailTo varchar(5000) = NULL,
	@MailFrom varchar(5000) = NULL,
	@Subject varchar(500) = NULL,
	@Message text = NULL,
	@MailType varchar(255) = NULL
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [dbo].[MailLog]
	SET
		[LocationId] = @LocationId,
		[SendDate] = @SendDate,
		[MailTo] = @MailTo,
		[MailFrom] = @MailFrom,
		[Subject] = @Subject,
		[Message] = @Message,
		[MailType] = @MailType
	WHERE
		[MailLogId] = @MailLogId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllMailLog]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllMailLog]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[MailLogId],
		[LocationId],
		[SendDate],
		[MailTo],
		[MailFrom],
		[Subject],
		[Message],
		[MailType]
	FROM [dbo].[MailLog]

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetMailLog]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetMailLog]
(
	@MailLogId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[MailLogId],
		[LocationId],
		[SendDate],
		[MailTo],
		[MailFrom],
		[Subject],
		[Message],
		[MailType]
	FROM [dbo].[MailLog]
	WHERE
		([MailLogId] = @MailLogId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdateSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateSubstitute]
(
	@SubstituteId int,
	@Active bit = NULL,
	@AvailabilityTimeStart varchar(5) = NULL,
	@AvailabilityTimeEnd varchar(5) = NULL,
	@AvailabilityWeekDays varchar(50) = NULL,
	@GradeId int = NULL,
	@UserId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [Substitute]
	SET
		[Active] = @Active,
		[AvailabilityTimeStart] = @AvailabilityTimeStart,
		[AvailabilityTimeEnd] = @AvailabilityTimeEnd,
		[AvailabilityWeekDays] = @AvailabilityWeekDays,
		[GradeId] = @GradeId,
		[UserId] = @UserId
	WHERE
		[SubstituteId] = @SubstituteId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[LoadSubstituteExceptionsByUserId]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadSubstituteExceptionsByUserId] 
@UserId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [SubstituteExceptions].* FROM SubstituteExceptions 
	INNER JOIN Substitute ON [SubstituteExceptions].SubstituteId=[Substitute].SubstituteId
	WHERE [Substitute].UserId = @UserId
		  AND DateStart >= getDate()
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetSubstitute]
(
	@SubstituteId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[SubstituteId],
		[Active],
		[AvailabilityTimeStart],
		[AvailabilityTimeEnd],
		[AvailabilityWeekDays],
		[GradeId],
		[UserId]
	FROM [Substitute]
	WHERE
		([SubstituteId] = @SubstituteId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[GetAvailabilityForUser]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetAvailabilityForUser]
	@UserId int
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Substitute
	WHERE UserId = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteSubstitute]
(
	@SubstituteId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [Substitute]
	WHERE
		[SubstituteId] = @SubstituteId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllSubstitute]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[SubstituteId],
		[Active],
		[AvailabilityTimeStart],
		[AvailabilityTimeEnd],
		[AvailabilityWeekDays],
		[GradeId],
		[UserId]
	FROM [Substitute]

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_AddSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddSubstitute]
(
	@SubstituteId int = NULL OUTPUT,
	@Active bit = NULL,
	@AvailabilityTimeStart varchar(5) = NULL,
	@AvailabilityTimeEnd varchar(5) = NULL,
	@AvailabilityWeekDays varchar(50) = NULL,
	@GradeId int = NULL,
	@UserId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [Substitute]
	(
		[Active],
		[AvailabilityTimeStart],
		[AvailabilityTimeEnd],
		[AvailabilityWeekDays],
		[GradeId],
		[UserId]
	)
	VALUES
	(
		@Active,
		@AvailabilityTimeStart,
		@AvailabilityTimeEnd,
		@AvailabilityWeekDays,
		@GradeId,
		@UserId
	)

	SET @Err = @@Error
	SELECT @SubstituteId = SCOPE_IDENTITY()

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateLocationBySubstituteId]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[UpdateLocationBySubstituteId] 
	@SubstituteId int,
	@LocationId int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Substitute
	SET LocationId = @LocationId
	WHERE SubstituteId = @SubstituteId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetPreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetPreferred]
(
	@PreferredId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[PreferredId],
		[LocationId],
		[SubstituteId]
	FROM [Preferred]
	WHERE
		([PreferredId] = @PreferredId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllPreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllPreferred]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[PreferredId],
		[LocationId],
		[SubstituteId]
	FROM [Preferred]

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdatePreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdatePreferred]
(
	@PreferredId int,
	@LocationId int,
	@SubstituteId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [Preferred]
	SET
		[LocationId] = @LocationId,
		[SubstituteId] = @SubstituteId
	WHERE
		[PreferredId] = @PreferredId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeletePreferredBySubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeletePreferredBySubstitute]
(
	@LocationId int,
	@SubstituteId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [Preferred]
	WHERE
		[LocationId] = @LocationId
		AND [SubstituteId] = @SubstituteId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_AddPreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddPreferred]
(
	@PreferredId int = NULL OUTPUT,
	@LocationId int,
	@SubstituteId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [Preferred]
	(
		[LocationId],
		[SubstituteId]
	)
	VALUES
	(
		@LocationId,
		@SubstituteId
	)

	SET @Err = @@Error
	SELECT @PreferredId = SCOPE_IDENTITY()

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[IsExistPreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[IsExistPreferred]
	@locationId int,
	@substituteId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Preferred 
	WHERE LocationId = @locationId AND SubstituteId = @substituteId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeletePreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeletePreferred]
(
	@PreferredId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [Preferred]
	WHERE
		[PreferredId] = @PreferredId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetTeacher]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetTeacher]
(
	@TeacherId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[TeacherId],
		[Active],
		[UserProfileId]
	FROM [Teacher]
	WHERE
		([TeacherId] = @TeacherId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllTeacher]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllTeacher]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[TeacherId],
		[Active],
		[UserProfileId]
	FROM [Teacher]

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_UpdateTeacher]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateTeacher]
(
	@TeacherId int,
	@Active bit,
	@UserProfileId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [Teacher]
	SET
		[Active] = @Active,
		[UserProfileId] = @UserProfileId
	WHERE
		[TeacherId] = @TeacherId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_AddTeacher]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddTeacher]
(
	@TeacherId int,
	@Active bit,
	@UserProfileId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [Teacher]
	(
		[TeacherId],
		[Active],
		[UserProfileId]
	)
	VALUES
	(
		@TeacherId,
		@Active,
		@UserProfileId
	)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteTeacher]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteTeacher]
(
	@TeacherId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [Teacher]
	WHERE
		[TeacherId] = @TeacherId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[GetSubTypes]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetSubTypes]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT SubtypeId, Name, [Desc] from Subtype ORDER BY SubtypeId DESC
END
GO
/****** Object:  StoredProcedure [dbo].[GetSubTypesForReport]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetSubTypesForReport]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 'All' as 'Name', 0 as 'Desc'
	UNION ALL
	SELECT Name, [Desc] from Subtype 
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteActionsParentActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_DeleteActionsParentActions] ******/
ALTER PROCEDURE [dbo].[Mc_DeleteActionsParentActions]
(
	@ActionId int,
	@ParentActionId int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Mc_ActionsParentActions] WHERE (ActionId = @ActionId) AND (ParentActionId = @ParentActionId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertActionsParentActions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertRolesActions] ******/
ALTER PROCEDURE [dbo].[Mc_InsertActionsParentActions]
(
	@ActionId int,
	@ParentActionId int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_ActionsParentActions] ([ActionId], [ParentActionId]) VALUES (@ActionId, @ParentActionId);
	
SELECT [ActionId], [ParentActionId] FROM [dbo].[Mc_ActionsParentActions] WHERE (ActionId = @ActionId) AND (ParentActionId = @ParentActionId);
GO
/****** Object:  View [dbo].[UserProfile]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[UserProfile]
AS
SELECT     EMPLOYEE_NUMBER * 10 + 1 AS UserProfileId, EMPLOYEE_NUMBER AS UserId, RESIDENCE_PHONE_NUMBER AS Phone, 
                      EMPLOYEE_EMAIL_ADDRESS AS Email, ADDRESS_1 AS Address, ADDRESS_2 AS Address2, APPENDAGE, BIRTH_DATE AS BirthDate, 
                      JOB_POSITION AS JobPosition, JOB_ASSIGNMENT_DESCRIPTION AS JobAssignmentDescription
FROM         dbo.V_EMPLOYEE
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertDatabase]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_InsertDatabase] ******/
ALTER PROCEDURE [dbo].[Mc_InsertDatabase]
(
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@SqlServerId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Mc_Database] ([Name], [Description], [UserName], [Password], [SqlServerId], [Deleted]) VALUES (@Name, @Description, @UserName, @Password, @SqlServerId, @Deleted);
	
SELECT DatabaseId, [Name], Description, UserName, Password, SqlServerId, Deleted FROM Mc_Database WHERE (DatabaseId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateDatabase]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateDatabase] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateDatabase]
(
	@DatabaseId int,
	@Name nvarchar(255),
	@Description nvarchar(1024),
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@SqlServerId int,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Mc_Database] SET [Name] = @Name, [Description] = @Description, [UserName] = @UserName, [Password] = @Password, [SqlServerId] = @SqlServerId, [Deleted] = @Deleted WHERE ([DatabaseId] = @DatabaseId);
	
SELECT DatabaseId, [Name], Description, UserName, Password, SqlServerId, Deleted FROM Mc_Database WHERE (DatabaseId = @DatabaseId)
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllDatabase]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllDatabase] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllDatabase]
AS
	SET NOCOUNT ON;
SELECT DatabaseId, [Name], Description, UserName, Password, SqlServerId, Deleted FROM dbo.Mc_Database WHERE (Deleted = 0)
GO
/****** Object:  View [dbo].[JobDesc]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[JobDesc]
AS
SELECT     JOB_POSITION AS JobDescId, JOB_ASSIGNMENT_DESCRIPTION AS AssignmentDescription
FROM         dbo.V_JOB
GO
/****** Object:  StoredProcedure [dbo].[daab_DeleteGrade]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_DeleteGrade]
(
	@GradeId int
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	DELETE
	FROM [Grade]
	WHERE
		[GradeId] = @GradeId
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllGrade]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllGrade]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[GradeId],
		[Name]
	FROM [Grade]
	ORDER BY [GradeId]
	
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetGrade]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetGrade]
(
	@GradeId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[GradeId],
		[Name]
	FROM [Grade]
	WHERE
		([GradeId] = @GradeId)

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  View [dbo].[Location]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Location]
AS
SELECT     LOC_NUM AS LocationId, LOC_NAME AS Name, LOC_NAME_SHORT AS NameShort, LOC_ADDR_STREET AS Street, LOC_ADDR_CITY AS City, 
                      LOC_ADDR_ZIP_CODE AS ZipCode, REPLACE(LOC_PHONE_NUM_OFFICE, ')', ') ') AS PhoneNumOffice, ISNULL(LOC_REGN_CODE, 0) AS RegionId
FROM         dbo.V_LOCATION
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllUser]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllUser] ******/
ALTER PROCEDURE [dbo].[Mc_SelectAllUser]
	@OrganizationId int
AS
	SET NOCOUNT ON;

SELECT DISTINCT u.UserId, u.Email, u.FirstName, u.LastName, u.MiddleName, u.LastLoginDate, u.Deleted, uo.IsOrganizationAdministrator
FROM dbo.Mc_User u
INNER JOIN dbo.Mc_OrganizationsUsers uo
	ON	u.UserId = uo.UserId
		AND u.Deleted = 0
		AND uo.OrganizationId = @OrganizationId;
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateUser]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateUser] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateUser]
(
	@UserId int,
	@Email nvarchar(255),
	@FirstName nvarchar(255),
	@LastName nvarchar(255),
	@MiddleName nvarchar(255),
	@LastLoginDate datetime,
	@Deleted bit
)
AS
	SET NOCOUNT OFF;

SELECT UserId, Email, FirstName, LastName, MiddleName, LastLoginDate, Deleted FROM Mc_User WHERE (UserId = @UserId)
GO
/****** Object:  View [dbo].[Region]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Region]
AS
SELECT     CAST(REGN_CODE AS INT) AS RegionId, RTRIM(REGN_NAME) AS Name
FROM         dbo.V_REGION AS Region_1
GO
/****** Object:  StoredProcedure [dbo].[daab_AddJobSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_AddJobSubstitute]
(
	@SubstituteId int,
	@JobId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	INSERT
	INTO [JobSubstitutes]
	(
		[SubstituteId],
		[JobId]
	)
	VALUES
	(
		@SubstituteId,
		@JobId
	)

	SET @Err = @@Error
	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_LoadJobSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_LoadJobSubstitute]
(
	@SubstituteId int,
	@JobId int
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT * FROM JobSubstitutes 
	WHERE
	SubstituteId = @SubstituteId
	AND JobId = @JobId

END
GO
/****** Object:  View [dbo].[Ceritificate]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Ceritificate]
AS
SELECT     SUBJECT_OF_COVERAGE AS CertificateId, SUBJECT_OF_COVERAGE_DESCRIPTION AS SubjectOfCoverageDescription
FROM         dbo.V_CERTIFICATE
GO
/****** Object:  View [dbo].[LevelOfCoverage]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[LevelOfCoverage]
AS
SELECT     SUBJECT_OF_COVERAGE * 10 + 1 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, LEVEL_OF_COVERAGE_1 AS Name
FROM         dbo.V_CERTIFICATE
UNION ALL
SELECT     SUBJECT_OF_COVERAGE * 10 + 2 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, LEVEL_OF_COVERAGE_2 AS Name
FROM         dbo.V_CERTIFICATE AS V_CERTIFICATE_6
UNION ALL
SELECT     SUBJECT_OF_COVERAGE * 10 + 3 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, LEVEL_OF_COVERAGE_3 AS Name
FROM         dbo.V_CERTIFICATE AS V_CERTIFICATE_5
UNION ALL
SELECT     SUBJECT_OF_COVERAGE * 10 + 4 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, LEVEL_OF_COVERAGE_4 AS Name
FROM         dbo.V_CERTIFICATE AS V_CERTIFICATE_4
UNION ALL
SELECT     SUBJECT_OF_COVERAGE * 10 + 5 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, LEVEL_OF_COVERAGE_5 AS Name
FROM         dbo.V_CERTIFICATE AS V_CERTIFICATE_3
UNION ALL
SELECT     SUBJECT_OF_COVERAGE * 10 + 6 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, LEVEL_OF_COVERAGE_6 AS Name
FROM         dbo.V_CERTIFICATE AS V_CERTIFICATE_2
UNION ALL
SELECT     TOP 100 PERCENT SUBJECT_OF_COVERAGE * 10 + 7 AS LevelOfCoverageId, SUBJECT_OF_COVERAGE AS CertificateId, 
                      LEVEL_OF_COVERAGE_7 AS Name
FROM         dbo.V_CERTIFICATE AS V_CERTIFICATE_1
ORDER BY CertificateId
GO
/****** Object:  StoredProcedure [dbo].[GetUsageReport]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[InsertUsage]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllSubstituteExceptions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[daab_GetSubstituteExceptions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
/****** Object:  StoredProcedure [dbo].[daab_UpdateSubstituteExceptions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_UpdateSubstituteExceptions]
(
	@SubstituteExceptionsId int,
	@SubstituteId int,
	@DateStart datetime,
	@DateEnd datetime
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	UPDATE [SubstituteExceptions]
	SET
		[SubstituteId] = @SubstituteId,
		[DateStart] = @DateStart,
		[DateEnd] = @DateEnd
	WHERE
		[SubstituteExceptionsId] = @SubstituteExceptionsId


	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSessionLogin]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateSessionLogin] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateSessionLogin]
	@SessionCookie varchar(50),
	@LoginId int
AS
BEGIN
    SET NOCOUNT ON;

	IF @LoginId IS NOT NULL
	BEGIN
		DECLARE @FirstSessionCookie varchar(50);
		
		SELECT @FirstSessionCookie = SessionCookie
		FROM [dbo].[Mc_Session] 
		WHERE LoginId = @LoginId AND SessionCookie <> @SessionCookie;
	    
		IF @FirstSessionCookie IS NOT NULL
			EXEC [dbo].[Mc_DeleteSession] @FirstSessionCookie, NULL;
	END
	
	EXEC [Mc_UpdateSession] @SessionCookie, NULL;

	UPDATE [dbo].[Mc_Session] 
	SET LoginId = @LoginId
	WHERE SessionCookie = @SessionCookie;
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserForMain]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetUserForMain] 
	@userId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [User].*, [UserProfile].Email as EmailProfile, Address, Address2, JobPosition, 
		   JobAssignmentDescription, [UserProfile].Phone, Subtype.Name as 'Subtype', [Location].[Name] as 'LocationName', [Region].[Name] as 'RegionName'
	FROM [User] 
	LEFT JOIN [UserProfile] ON [User].UserId = [UserProfile].UserId
	LEFT JOIN [Location] ON [Location].LocationId = dbo.GetActiveSubType([User].UserId)
	LEFT JOIN [Region] ON [Location].RegionId = [Region].RegionId
	LEFT JOIN [Subtype] ON [User].UserId = @UserId 
		  AND Subtype.[Desc]= dbo.GetActiveSubType([User].UserId)

	WHERE [User].UserId = @userId
END
GO
/****** Object:  StoredProcedure [dbo].[LoadLocationUser]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadLocationUser]
@LocationId int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [User].Email, 
			ltrim(rtrim([User].LastName) + ' '+[User].FirstName) as 'UName',
			Location.Name as 'LName',
			(
				SELECT count(*) 
				FROM [User] 
				WHERE 
					isnumeric(BoardCode)=1 AND BoardCode > 39 AND NOT (PayCode = 'A' OR PayCode = 'C' OR PayCode = 'D' OR PayCode = 'H' OR PayCode = 'J' OR PayCode = 'Q' OR PayCode = 'R' OR PayCode = 'W' OR PayCode = 'X' OR PayCode = 'Y')
					AND dbo.GetActiveSubType([User].UserId) = UserLocation.LocationId
			) as 'CountUsers',
			(
				SELECT count(*) FROM Substitute
				LEFT JOIN Preferred ON Preferred.SubstituteId = Substitute.SubstituteId
				WHERE Preferred.LocationId = UserLocation.LocationId
					AND Preferred.SubstituteId = Substitute.SubstituteId
			) as 'CountPreferredUsers'

	FROM Location
	LEFT JOIN UserLocation ON UserLocation.LocationId = Location.LocationId
	LEFT JOIN [User] ON [User].UserId = UserLocation.UserId
	WHERE Location.LocationId = @LocationId OR @LocationId = 0
	ORDER BY Location.LocationId ASC	
/*
	SELECT
	(SELECT 
	 count(*) FROM [User] LEFT JOIN Mc_UsersGroups ON [User].UserId = Mc_UsersGroups.UserId WHERE dbo.GetActiveSubType([User].UserId) = Location.LocationId AND Mc_UsersGroups.GroupId=2) as 'CountUsers',	
	(SELECT count(*) FROM [User] 
		LEFT JOIN Mc_UsersGroups ON [User].UserId = Mc_UsersGroups.UserId 
		LEFT JOIN Substitute ON [User].UserId = Substitute.UserId
		LEFT JOIN Preferred ON Preferred.SubstituteId = Substitute.SubstituteId
		WHERE Mc_UsersGroups.GroupId=2 AND Preferred.LocationId = Location.LocationId
		AND Preferred.SubstituteId = Substitute.SubstituteId) as 'CountPreferredUsers',

 	[UserProfile].Email, Location.Name as 'LName', rtrim([User].LastName) + ', '+[User].FirstName as 'UName'
	FROM UserLocation

	LEFT JOIN Location ON UserLocation.LocationId = Location.LocationId AND 
							(UserLocation.LocationId = @LocationId OR @LocationId = 0)
	LEFT JOIN [User] ON [User].UserId = UserLocation.UserId
	LEFT JOIN [UserProfile] ON [User].UserId = [UserProfile].UserId
	ORDER BY Location.Name ASC
*/

END
GO
/****** Object:  StoredProcedure [dbo].[LoadAvailableSubstitutes]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadAvailableSubstitutes]
@JobId int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT Substitute.SubstituteId, rtrim([User].LastName) + ', '+[User].FirstName as 'Name',
		   '' as 'IsPreferred',
		   '' as 'IsClerkPreferred',
		   null as 'DateLastWorked',null as 'TimeWorked', [UserProfile].Phone as 'Phone', Subtype.Name as 'SubtypeName', Job.LocationId as 'JobLocationId', ClerkPreferredSubs.LocationId
	FROM Substitute
	LEFT JOIN [User] ON [User].UserId = Substitute.UserId
	LEFT JOIN Mc_UsersGroups ON Mc_UsersGroups.UserId = [User].UserId
	LEFT JOIN [UserProfile] ON [UserProfile].UserId = Substitute.UserId
	LEFT JOIN Job ON Job.JobId = @JobId
	LEFT JOIN Preferred ON Preferred.LocationId = Job.LocationId AND Preferred.SubstituteId = Substitute.SubstituteId
	LEFT JOIN ClerkPreferredSubs ON ClerkPreferredSubs.LocationId = Job.LocationId AND ClerkPreferredSubs.SubstituteId = Substitute.SubstituteId
	LEFT JOIN Subtype ON Subtype.SubtypeId = Job.SubtypeId
	WHERE Mc_UsersGroups.GroupId = 2
	  AND Subtype.[Desc] = dbo.GetActiveSubType([User].UserId)
	ORDER BY IsClerkPreferred DESC, IsPreferred DESC
END
GO
/****** Object:  StoredProcedure [dbo].[SearchUserByName]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SearchUserByName]
	@Fullname nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT rtrim(CAST(LastName as varchar))+', '+rtrim(CAST(FirstName as varchar)) as 'Name', UserId as 'UserId'
	FROM [dbo].[User]
	WHERE
		REPLACE(CAST(LastName as varchar)+', '+CAST(FirstName as varchar),' ','') LIKE REPLACE(@Fullname,' ','')+'%'
		AND dbo.GetActiveSubType([User].UserId) NOT IN (SELECT [Desc] From Subtype)
END
GO
/****** Object:  StoredProcedure [dbo].[LoadAllSubstitutes]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LoadAllSubstitutes]
@LocationId int = 0,
@Show int = 0
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT rtrim(LastName)+', '+FirstName as 'Name', UserProfile.Phone as 'Phone',
	case when Preferred.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsPreferred',
	Substitute.SubstituteId as 'SubstituteId', [User].UserId as 'UserId'
	FROM [User]
	LEFT JOIN Mc_UsersGroups ON Mc_UsersGroups.UserId = [User].UserId
	LEFT JOIN UserProfile ON UserProfile.UserId = [User].UserId
	LEFT JOIN Substitute ON Substitute.UserId = [User].UserId
	LEFT JOIN Preferred ON Preferred.LocationId = @LocationId AND Preferred.SubstituteId = Substitute.SubstituteId
	WHERE Mc_UsersGroups.GroupId = 2 AND (@Show = 1 OR Preferred.SubstituteId is not null)
		  AND (@LocationId = 0 OR dbo.GetActiveSubType([User].UserId) = @LocationId)
	ORDER BY IsPreferred DESC, rtrim(LastName) ASC
	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[SearchSubstitute]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SearchSubstitute] 
@id int
AS
BEGIN
	SELECT Firstname, Lastname, Subtype.Name as 'Subtype', [User].UserId as 'UserId'
	FROM [User]
	LEFT JOIN Subtype ON Subtype.[Desc] = dbo.GetActiveSubType([User].UserId)
	LEFT JOIN Mc_UsersGroups ON [User].UserId = Mc_UsersGroups.UserId
	WHERE [User].UserId = @id AND Mc_UsersGroups.GroupId = 2
	
END
GO
/****** Object:  StoredProcedure [dbo].[LoadAllPreferredSubstitutes]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LoadAllPreferredSubstitutes]
@LocationId int = 0
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT rtrim(LastName)+', '+FirstName as 'Name', UserProfile.Phone as 'Phone',
	case when Preferred.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsPreferred',
	case when ClerkPreferredSubs.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsClerkPreferred',
	Substitute.SubstituteId as 'SubstituteId', [User].UserId as 'UserId', Subtype.Name as 'Subtype'
	FROM [User]
	LEFT JOIN Subtype ON Subtype.[Desc] = dbo.GetActiveSubType([User].UserId)
	LEFT JOIN UserProfile ON UserProfile.UserId = [User].UserId
	LEFT JOIN Substitute ON Substitute.UserId = [User].UserId
	LEFT JOIN Preferred ON Preferred.LocationId = @LocationId AND Preferred.SubstituteId = Substitute.SubstituteId
	LEFT JOIN ClerkPreferredSubs ON ClerkPreferredSubs.LocationId = @LocationId AND ClerkPreferredSubs.SubstituteId = Substitute.SubstituteId
	WHERE Preferred.SubstituteId is not null		 
	ORDER BY rtrim(LastName) ASC
	SET @Err = @@Error

	RETURN @Err

END
GO
/****** Object:  View [dbo].[Mc_Login]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Mc_Login]
AS
SELECT
	[UserId] AS [LoginId]
	,[LoginName]
	,[Password]
	,[Deleted]
FROM [dbo].[User]
GO
/****** Object:  View [dbo].[Mc_OrganizationsLogins]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Mc_OrganizationsLogins]
AS
SELECT     1 AS OrganizationId, UserId AS LoginId, IsOrganizationAdministrator
FROM         dbo.[User]
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectAllUsersGroupsFiltered]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Mc_SelectAllUsersGroupsFiltered]
	@OrganizationId int,
	@GroupId int
AS
	SET NOCOUNT ON;

IF (@GroupId = 2)
BEGIN
	SELECT     UserId, 2 AS GroupId
	FROM         dbo.[User]
END
ELSE
BEGIN
	SELECT     UserId, 3 AS GroupId
	FROM         dbo.[User]
END
--SELECT UserId, GroupId 
--FROM dbo.Mc_UsersGroups
--WHERE GroupId = @GroupId
GO
/****** Object:  View [dbo].[Mc_OrganizationsUsers]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Mc_OrganizationsUsers]
AS
SELECT
	1 AS [OrganizationId]
	,[UserId]
	,[IsOrganizationAdministrator]
FROM [dbo].[User]
GO
/****** Object:  View [dbo].[Mc_UsersGroups]    Script Date: 09/15/2009 15:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[Mc_UsersGroups]
AS
SELECT     UserId, 2 AS GroupId
FROM         dbo.[User]
WHERE     dbo.IsSubstitute(UserId) > 0
UNION ALL
SELECT     UserId, 3 AS GroupId
FROM         dbo.[User]
WHERE     dbo.IsSubstitute(UserId) = 0 OR
                      (dbo.IsSubstitute(UserId) > 0 AND SALARY_SCHEDULE IN ('G0', 'AT', 'AU'))
GO
/****** Object:  StoredProcedure [dbo].[LoadSubstituteListForReport]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LoadSubstituteListForReport]
@Subtype int = 0,
@Name nvarchar(255) = '',
@PartTime nvarchar(255) = ''
AS
BEGIN
	SET NOCOUNT ON;
	SELECT  
		UserId, FirstName, LastName, CellPhone, Email, 		
		CASE WHEN SubType.[Desc] is not null THEN 
		'<font color="green">'+SubType.[Name]+'</span>' ELSE '' END as 'SubStatus'
		FROM [User]
		LEFT JOIN SubType ON SubType.[Desc] = dbo.IsSubstitute(UserId)
	WHERE
		(SubType.[Desc] = @Subtype OR @Subtype = 0)
		AND LastName + FirstName like '%'+REPLACE(@Name,' ','%')+'%'
		AND (
				@PartTime = 'All' 
				OR (@PartTime = '' AND SubType.[Desc] IS NOT NULL)
				OR (CASE WHEN SALARY_SCHEDULE IN ('G0', 'AT', 'AU') AND SubType.[Desc] is not null THEN 'Yes' ELSE 'No' END = @PartTime)
			)
		
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectViewState]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_SelectViewState] ******/
ALTER PROCEDURE [dbo].[Mc_SelectViewState]
    @ViewStateId int,
    @SessionCookie varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    EXEC [Mc_UpdateSession] @SessionCookie, NULL;

    SELECT ViewState
    FROM [dbo].[Mc_ViewState] 
    WHERE ViewStateId = @ViewStateId;
END
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateViewState]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Mc_UpdateViewState] ******/
ALTER PROCEDURE [dbo].[Mc_UpdateViewState]
	@ViewStateId int OUTPUT,
    @SessionCookie varchar(50),
    @ViewState image
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SessionId INT;
  
    EXEC [Mc_UpdateSession] @SessionCookie, @SessionId OUTPUT;
    
    IF EXISTS(
		SELECT 0
		FROM [dbo].[Mc_ViewState]
		WHERE	ViewStateId = @ViewStateId
				AND SessionId = @SessionId
    )
	BEGIN
		UPDATE [dbo].[Mc_ViewState]
		SET ViewState = @ViewState
		WHERE ViewStateId = @ViewStateId;
    END
    ELSE
    BEGIN
		INSERT INTO [dbo].[Mc_ViewState] (SessionId, ViewState) 
		VALUES (@SessionId, @ViewState);
    
		SET @ViewStateId = SCOPE_IDENTITY();
    END
END
GO
/****** Object:  StoredProcedure [dbo].[LoadDefaultLocationUser]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadDefaultLocationUser]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ltrim(rtrim([User].LastName)+' '+[User].FirstName) as 'UName', Location.Name as 'LName'
	FROM UserLocation	
		LEFT JOIN [User] ON [User].UserId = UserLocation.UserId
		LEFT JOIN Location ON Location.LocationId = UserLocation.LocationId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_SearchJobOpened]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_SearchJobOpened] 
@jfrom datetime,
@jto datetime,
@locName int,
@SubstituteId int,
@UserId int = 0
AS
BEGIN
	SET NOCOUNT OFF;
	SELECT
		[Job].[JobId],
		CONVERT(varchar, [Job].[DatetimeStart], 101) as 'DatetimeStart',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as 'DatetimeEnd',
		Jbl.Name as 'Location',
		Jbr.Name as 'Region',
		[Job].Teacher as 'Teacher',
		(
			SELECT COUNT(*) FROM [Job] jb
			WHERE jb.SubstituteId = @SubstituteId 
				AND (
					   (jb.[DatetimeStart] >= [Job].[DatetimeStart] AND [jb].[DatetimeStart] <= [Job].[DatetimeEnd])
					   OR (jb.[DatetimeEnd] >= [Job].[DatetimeStart] AND [jb].[DatetimeEnd] <= [Job].[DatetimeEnd])
					   OR (jb.[DatetimeStart] <= [Job].[DatetimeStart] AND [jb].[DatetimeEnd] >= [Job].[DatetimeEnd])
					   OR (jb.[DatetimeEnd] < [Job].[DatetimeStart] AND [jb].[DatetimeEnd] > [Job].[DatetimeEnd])					
					)
		) as 'Overlap'

	FROM [Job]
	LEFT JOIN [dbo].[Preferred] as Jbp ON [Job].[LocationId] = Jbp.[LocationId] AND Jbp.SubstituteId = @SubstituteId
	LEFT JOIN [dbo].[Location] as Jbl ON Job.[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	LEFT JOIN [dbo].[User] as Jbs ON Jbs.UserId = @UserId
	LEFT JOIN [Subtype] ON Jbs.LocationId = Subtype.[Desc]
	WHERE [Job].StatusId = 1
		  AND [Job].SubtypeId = [Subtype].SubtypeId
		  AND ([Job].[DatetimeStart] >= @jfrom OR @jfrom = CAST('1980-01-01' as datetime))
		  AND ([Job].[DatetimeStart] <= @jto OR @jto = CAST('1980-01-01' as datetime))
		  AND (Jbp.LocationId = @locName OR @SubstituteId = 0 OR (@locName=0 AND Jbp.LocationId > 0))
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllJobOpened]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllJobOpened]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[Job].[JobId],
		CONVERT(varchar, [Job].[DatetimeStart], 101) as 'DatetimeStart',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as 'DatetimeEnd',
		Jbl.Name as 'Location',
		Jbr.Name as 'Region',
		[Job].Teacher as 'Teacher'
	FROM [Job]
	LEFT JOIN [dbo].[Location] as Jbl ON [Job].[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	WHERE [Job].StatusId = 1

	SET @Err = @@Error

	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetAllJob]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_GetAllJob]
@LocationId int = 0,
@StatusId int = 0,
@DateSelected datetime = '1990-01-01',
@DateSelectedTo datetime = '1990-01-01'
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[JobId],
		Job.[LocationId],
		Job.[SubstituteId],
		Job.[GradeId],
		Job.[StatusId],
		[DatetimeStart],
		[DatetimeEnd],
		CONVERT(varchar, Job.DatetimeStart, 1)+' - '+CONVERT(varchar, Job.DatetimeEnd, 1) as 'Period',
		[Room],
		[Subject],
		[Note],
		rtrim(usersub.LastName)+','+usersub.FirstName as 'Substitute',
		Job.Teacher as 'Teacher',
		Location.Name as 'Location',
		Region.Name as 'Region',
		Subtype.Name as 'Subtype',
		'<img hspace="2" src="Images/'+Status.Name+'.gif" alt="'+Status.Name+'" />' as 'Status'
	FROM [Job]
	LEFT JOIN Substitute ON Job.[SubstituteId] = Substitute.[SubstituteId]
	LEFT JOIN [User] as usersub ON Substitute.UserId = usersub.UserId
	LEFT JOIN Location ON Location.LocationId = Job.[LocationId]
	LEFT JOIN Region ON Location.RegionId = Region.RegionId
	LEFT JOIN Status ON Status.StatusId = Job.StatusId
	LEFT JOIN Subtype ON Subtype.SubtypeId = Job.SubtypeId
	WHERE (Location.LocationId = @LocationId OR @LocationId = 0) AND
		  (Job.StatusId = @StatusId OR @StatusId = 0) AND 
		  (
			Job.DatetimeStart >= @DateSelected 
			AND (Job.DatetimeStart <= @DateSelectedTo OR @DateSelectedTo = '1990-01-01')
			OR Job.StatusId > 1
		  )
	ORDER BY [Job].JobId

	SET @Err = @@Error
	RETURN @Err
END
GO
/****** Object:  StoredProcedure [dbo].[daab_GetJobOpenedById]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[daab_GetJobOpenedById]
@JobId int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[Job].[JobId],
		CONVERT(varchar, [Job].[DatetimeStart], 101) as 'DatetimeStart',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as 'DatetimeEnd',
		Jbl.Name as 'Location',
		Jbr.Name as 'Region',
		Jbs.Name as 'Subtype',
		Jbs.SubtypeId as 'SubtypeId',
		Jbst.Name as 'Status',
		[Job].Room as 'Room',
		[Job].Note as 'Note',
		[Job].Subject as 'Subject',
		JbGrade.Name as 'GradeName',
		[Job].Teacher as 'Teacher'
	FROM [Job]
	LEFT JOIN [dbo].[Location] as Jbl ON [Job].[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	LEFT JOIN [dbo].[Subtype] as Jbs ON [Job].[SubtypeId] = Jbs.[SubtypeId]
	LEFT JOIN [dbo].[Status] as Jbst ON [Job].[StatusId] = Jbst.[StatusId]
	LEFT JOIN [dbo].[Grade] as JbGrade ON [Job].[GradeId] = JbGrade.[GradeId] AND [Job].[GradeId]<>0
	WHERE [Job].JobId = @jobId
END
GO
/****** Object:  StoredProcedure [dbo].[daab_SearchJobOpenedByRegion]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_SearchJobOpenedByRegion] 
@jfrom datetime,
@jto datetime,
@locName int,
@SubstituteId int,
@UserId int = 0
AS
BEGIN
	SET NOCOUNT OFF;
	SELECT
		[Job].[JobId],
		CONVERT(varchar, [Job].[DatetimeStart], 101) as 'DatetimeStart',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as 'DatetimeEnd',
		Jbl.Name as 'Location',
		Jbr.Name as 'Region',
		[Job].Teacher as 'Teacher'
	FROM [Job]
	LEFT JOIN [dbo].[Preferred] as Jbp ON [Job].[LocationId] = Jbp.[LocationId] AND Jbp.SubstituteId = @SubstituteId
	LEFT JOIN [dbo].[Location] as Jbl ON Jbp.[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	LEFT JOIN [dbo].[User] as Jbs ON Jbs.UserId = @UserId
	LEFT JOIN [Subtype] ON Jbs.LocationId = Subtype.[Desc]
	WHERE [Job].StatusId = 1
		  AND [Job].SubtypeId = [Subtype].SubtypeId
		  AND ([Job].[DatetimeStart] >= @jfrom OR @jfrom = CAST('1980-01-01' as datetime))
		  AND ([Job].[DatetimeStart] <= @jto OR @jto = CAST('1980-01-01' as datetime))
		  AND (Jbl.RegionId = @locName OR (@locName=0 AND Jbl.RegionId > 0))
END
GO
/****** Object:  StoredProcedure [dbo].[daab_SearchJobAccepted]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[daab_SearchJobAccepted] 
@jfrom datetime,
@jto datetime,
@SubstituteId int
AS
BEGIN
	SET NOCOUNT OFF;
	SELECT
		[Job].[JobId],
		CONVERT(varchar, [Job].[DatetimeStart], 101) as 'DatetimeStart',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as 'DatetimeEnd',
		Jbl.Name as 'Location',
		Jbr.Name as 'Region',
		[Job].Teacher as 'Teacher'
	FROM [Job]
	LEFT JOIN [dbo].[Preferred] as Jbp ON [Job].[LocationId] = Jbp.[LocationId] AND Jbp.SubstituteId = @SubstituteId
	LEFT JOIN [dbo].[Location] as Jbl ON Jbp.[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	WHERE
			(
				(
					([Job].[DatetimeStart] >= @jfrom OR @jfrom = CAST('1980-01-01' as datetime))
					AND ([Job].[DatetimeStart] <= @jto OR @jto = CAST('1980-01-01' as datetime))
  			    ) 
				OR 
				(
					[Job].[DatetimeEnd] >= @jfrom
				)
			)
	  	    AND [Job].SubstituteId = @SubstituteId
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserCertificates]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetUserCertificates] 
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [Segment851] LEFT JOIN [Segment851Certificate] ON [Segment851].Segment851Id = [Segment851Certificate].Segment851Id 
	WHERE UserId = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[SubstituteExceptionsIsOverlapped]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SubstituteExceptionsIsOverlapped] 
@userId int,
@from datetime,
@to datetime
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SubstituteId int;	
	SET @SubstituteId = (SELECT TOP 1 SubstituteId FROM Substitute WHERE UserId = @userId)

	SELECT dbo.IsAvailable(@SubstituteId, @from, @to)
END
GO
/****** Object:  StoredProcedure [dbo].[LoadLocationBySubstituteId]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadLocationBySubstituteId] 
	@SubstituteId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Substitute.SubstituteId as 'SubstituteId', Location.LocationId as 'LocationId', Location.RegionId as 'RegionId'
	FROM Substitute
	LEFT JOIN Location ON Location.LocationId = Substitute.LocationId
	WHERE Substitute.SubstituteId = @SubstituteId
END
GO
/****** Object:  StoredProcedure [dbo].[LoadRegions]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadRegions]
@SubstituteId  int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Loc.RegionId, Region.Name, case when Loc.CheckRegion > 0 then CAST(0 as bit) else CAST(1 as bit) end as IsChecked  FROM
	(	SELECT RegionId, (count(*) - count(Preferred.LocationId)) as CheckRegion FROM Location 
		LEFT JOIN Preferred ON Location.LocationId=Preferred.LocationId AND Preferred.SubstituteId = @SubstituteId
		GROUP BY RegionId
	) as Loc
	LEFT JOIN Region ON Region.RegionId = Loc.RegionId

END
GO
/****** Object:  StoredProcedure [dbo].[LoadLocations]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadLocations]
	@RegionId  int, 
	@SubstituteId  int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Location.*, case when Preferred.PreferredId is null then CAST(0 AS Bit) else CAST(1 AS Bit) end as IsChecked FROM Location
	LEFT JOIN Preferred ON Location.LocationId = Preferred.LocationId
					AND Preferred.SubstituteId = @SubstituteId
	WHERE Location.RegionId = @RegionId
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromPreferred]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[DeleteFromPreferred]
	@regionId int,
	@substituteId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Preferred
	WHERE Preferred.LocationId IN (
		SELECT Location.LocationId FROM Location
		WHERE Location.RegionId = @regionId)
	AND Preferred.SubstituteId = @substituteId
END
GO
/****** Object:  StoredProcedure [dbo].[LoadLocationsForSearch]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LoadLocationsForSearch]
	@SubstituteId  int 
AS
BEGIN
	SELECT ' All Preferred Locations' as 'Name', '0' as 'Value'
--	SELECT ' Select All' as 'Name', '0' as 'Value'
	UNION ALL
	SELECT Region.Name as 'Name', 'r'+CAST(Region.RegionId AS nvarchar) as 'Value'
	FROM Preferred
	LEFT JOIN Location ON Location.LocationId = Preferred.LocationId
	LEFT JOIN Region ON Location.RegionId = Region.RegionId
	WHERE Preferred.SubstituteId = @SubstituteId
	GROUP BY Region.Name, Region.RegionId
	UNION ALL
	SELECT Region.Name + ' / ' + Location.Name as 'Name', Location.LocationId as 'Value'
	FROM Preferred
	LEFT JOIN Location ON Location.LocationId = Preferred.LocationId
	LEFT JOIN Region ON Location.RegionId = Region.RegionId
	WHERE Preferred.SubstituteId = @SubstituteId
	ORDER BY 'Name'
END
GO
/****** Object:  StoredProcedure [dbo].[LoadRegionsForCombo]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadRegionsForCombo]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT '0' as 'RegionId','Select Region' as 'Name'
	UNION ALL
	SELECT Location.RegionId as 'RegionId', Region.Name as 'Name' FROM Location
		LEFT JOIN Region ON Location.RegionId = Region.RegionId
	GROUP BY Location.RegionId, Region.Name

END
GO
/****** Object:  StoredProcedure [dbo].[LoadLocationsForSearchAll]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadLocationsForSearchAll]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Region.Name + ' / ' + Location.Name as 'Name', Location.LocationId as 'Value'
	FROM Location
	LEFT JOIN Region ON Location.RegionId = Region.RegionId
	ORDER BY Region.RegionId
END
GO
/****** Object:  StoredProcedure [dbo].[GetUsageReportByLocations]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[GetRegionByLocation]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetRegionByLocation]
	-- Add the parameters for the stored procedure here
	@LocationId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RegionId FROM Location WHERE LocationId = @LocationId
END
GO
/****** Object:  StoredProcedure [dbo].[GetLocationByRegion]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetLocationByRegion]
	-- Add the parameters for the stored procedure here
	@RegionId int
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Location WHERE RegionId = @RegionId
END
GO
/****** Object:  StoredProcedure [dbo].[GetLocationByCurrentLocation]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetLocationByCurrentLocation]
	-- Add the parameters for the stored procedure here
	@LocationId int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @RegionId int 
	SET @RegionId = (Select RegionId FROM Location WHERE LocationId = @LocationId)
    -- Insert statements for procedure here
	SELECT * FROM Location WHERE RegionId = @RegionId
END
GO
/****** Object:  StoredProcedure [dbo].[LoadPreferredRegionsForCombo]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[LoadPreferredRegionsForCombo]
@UserId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT '0' as 'RegionId','Select Region' as 'Name'
	UNION ALL
	SELECT Location.RegionId as 'RegionId', Region.Name as 'Name'
	FROM Location
		LEFT JOIN Region ON Location.RegionId = Region.RegionId
--		LEFT JOIN Preferred ON Preferred.LocationId = Location.LocationId
--	WHERE Preferred.LocationId is not null
--		  OR Location.LocationId IN (SELECT DISTINCT LocationId FROM Substitute WHERE UserId = @UserId)
	GROUP BY Location.RegionId, Region.Name

END
GO
/****** Object:  StoredProcedure [dbo].[GetPreferredLocationsByCurrentLocation]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[GetPreferredLocationsByRegion]    Script Date: 09/15/2009 15:55:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetPreferredLocationsByRegion]
	-- Add the parameters for the stored procedure here
	@RegionId int
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *  FROM Location 
	WHERE RegionId = @RegionId 
--	AND LocationId IN (SELECT DISTINCT LocationId FROM Preferred)
END
GO
SET IDENTITY_INSERT [dbo].[Mc_Action] ON
GO
INSERT INTO [WSTA].[dbo].[Mc_Action]
           ([ActionId]
           ,[ParentActionId]
           ,[ActionTypeId]
           ,[Name]
           ,[Description]
           ,[IconUrl]
           ,[ButtonIconUrl]
           ,[NavigateUrl]
           ,[OrderNumber]
           ,[ClassFullName]
           ,[DepartmentRequired]
           ,[Visible]
           ,[ShowInDetailMenu]
           ,[ShowChildrenInDetailMenu]
           ,[GroupInDetailMenu]
           ,[HighlightInDetailMenu]
           ,[Deleted])
     VALUES
           (141, 126,	1,	'Employee Segments','','','','/Admin/EmployeeSegments.aspx',0,'',0,0,0,0,0,0,0)
GO
SET IDENTITY_INSERT [dbo].[Mc_Action] OFF
GO
INSERT INTO [WSTA].[dbo].[Mc_RolesActions]
           ([RoleId]
           ,[ActionId])
     VALUES
           (14, 141)
GO