/******  Db Version 5  ******/
UPDATE DB_Version SET [DB_Version] = 5
GO

ALTER FUNCTION [dbo].[IsAvailable]
(	
	@SubstituteId int,
	@Start DATETIME,
	@End DATETIME
)
RETURNS INT 
AS
BEGIN 
	DECLARE @gencalendar TABLE (cal_date DATETIME PRIMARY KEY);
	DECLARE @p_Start DATETIME;
	DECLARE @Result int;


	SET @p_Start = @Start
	WHILE @p_Start <= @End
	BEGIN
		INSERT INTO @gencalendar(cal_date) VALUES(@p_Start)
	    SET @p_Start = dateadd(d, 1, @p_Start)
	END

	DECLARE @CountDays int
	SET @CountDays = (SELECT Count(*) FROM
	(
		SELECT * FROM @gencalendar 
		WHERE (SELECT AvailabilityWeekDays + '1,7' FROM Substitute WHERE SubstituteId = @SubstituteId) 
			LIKE '%'+CONVERT(nvarchar, DatePart(dw, cal_date))+'%'
			AND DatePart(dw, cal_date) NOT IN (SELECT DatePart(dw,DateStart) FROM SubstituteExceptions 
			WHERE SubstituteId = @SubstituteId AND DateStart >= @Start AND DateStart <= @End )
	) as AvailableDays)

	SET @Result = (SELECT CASE WHEN DateDiff(d,@Start,@End)+1 = @CountDays THEN 0 ELSE 1 END)
	RETURN @Result
END
GO
