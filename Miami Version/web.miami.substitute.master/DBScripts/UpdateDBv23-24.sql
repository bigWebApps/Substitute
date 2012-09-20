SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL, XACT_ABORT ON
GO
SET NUMERIC_ROUNDABORT OFF
GO

UPDATE DB_Version SET [DB_Version] = 24
GO

UPDATE [dbo].[Grade] SET [Name] = N'Mixed / All' WHERE [GradeId] = 15
GO

UPDATE [dbo].[Mc_Action] SET [IconUrl] = N'/Images/spacer.gif' WHERE [ActionId] = 138
GO

SET IDENTITY_INSERT [dbo].[Mc_Action] ON
GO
INSERT INTO [dbo].[Mc_Action]([ActionId], [ParentActionId], [ActionTypeId], [Name], [Description], [IconUrl], [ButtonIconUrl], [NavigateUrl], [OrderNumber], [ClassFullName], [DepartmentRequired], [Visible], [ShowInDetailMenu], [ShowChildrenInDetailMenu], [GroupInDetailMenu], [HighlightInDetailMenu], [Deleted]) VALUES (202, 117, 1, N'Update Substitute', N' ', N' ', N'', N'/UpdateUserModal.aspx', 1, N'', 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Mc_Action] OFF
GO

INSERT INTO [dbo].[Mc_RolesActions]([RoleId], [ActionId]) VALUES (14, 202)
GO

CREATE TABLE [dbo].[SubstituteNotes] (
   [SubstituteNoteId] [int] IDENTITY (1, 1) NOT NULL,
   [SubstituteId] [int] NOT NULL,
   [ClerkId] [int] NOT NULL,
   [Note] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO

ALTER TABLE [dbo].[SubstituteNotes] ADD CONSTRAINT [PK_SubstituteNotes] PRIMARY KEY CLUSTERED ([SubstituteNoteId])
GO

ALTER TABLE [dbo].[Substitute]
	ADD [AltPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO

exec('-- =============================================
-- Author:		Artem Korzhavin
-- Create date: 2009-01-27
-- =============================================
CREATE FUNCTION [dbo].[GetJobStatus]
(	
	@Status int,
	@End DATETIME,
	@Now DATETIME
)
RETURNS INT 
AS
BEGIN 
	DECLARE @Result int;

	SET @Result = case when @Now > @End then 2
		else case when @Status <> 2 then 1 else 3 
		end end
	RETURN @Result
END')
GO

exec('ALTER PROCEDURE [dbo].[daab_GetAllJob]
@LocationId int = 0,
@StatusId int = 0,
@DateSelected datetime = ''1990-01-01'',
@DateSelectedTo datetime = ''1990-01-01''
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
		CONVERT(varchar, Job.DatetimeStart, 1)+'' - ''+CONVERT(varchar, Job.DatetimeEnd, 1) as ''Period'',
		[Room],
		[Subject],
		[Note],
		rtrim(usersub.LastName)+'',''+usersub.FirstName as ''Substitute'',
		Job.Teacher as ''Teacher'',
		Location.Name as ''Location'',
		Region.Name as ''Region'',
		Subtype.Name as ''Subtype'',
		Status.StatusId as JobStatus,
		''<img hspace="2" src="Images/''+Status.Name+''.gif" alt="''+Status.Name+''" />'' as ''Status'',
		case when Job.StatusId = 1 then ''Not Assigned'' else
		   case when Job.StatusId = 3 then ''Awaiting Confirmation'' else	''Confirmed''
			end end as SubstituteStatus			
	FROM [Job]
	LEFT JOIN Substitute ON Job.[SubstituteId] = Substitute.[SubstituteId]
	LEFT JOIN [User] as usersub ON Substitute.UserId = usersub.UserId
	LEFT JOIN Location ON Location.LocationId = Job.[LocationId]
	LEFT JOIN Region ON Location.RegionId = Region.RegionId
	LEFT JOIN Status ON Status.StatusId = dbo.GetJobStatus(Job.StatusId, Job.DatetimeEnd, GETDATE())
	LEFT JOIN Subtype ON Subtype.SubtypeId = Job.SubtypeId
	WHERE (Location.LocationId = @LocationId OR @LocationId = 0) AND
		  (((Status.StatusId = 1 OR Status.StatusId = 3) AND @StatusId = 1) 
		  OR (Status.StatusId = 2 AND @StatusId = 2)
		  )
	ORDER BY [DatetimeStart], [Job].JobId

	SET @Err = @@Error
	RETURN @Err
END')
GO

exec('CREATE PROCEDURE [dbo].[GetSubstituteForUpdate]
@LocationId int = 0,
@UserId int 
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT 
	case when ClerkPreferredSubs.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as ''IsClerkPreferred'',
	Substitute.AltPhone as ''AltPhone'', SubstituteNotes.Note as ''Note''
	FROM [User]
	LEFT JOIN Substitute ON Substitute.UserId = [User].UserId
	LEFT JOIN SubstituteNotes ON Substitute.SubstituteId = SubstituteNotes.SubstituteId
	LEFT JOIN ClerkPreferredSubs ON ClerkPreferredSubs.LocationId = @LocationId AND ClerkPreferredSubs.SubstituteId = Substitute.SubstituteId
	WHERE [User].UserId = @UserId
	SET @Err = @@Error

	RETURN @Err
END')
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
	Substitute.SubstituteId as 'SubstituteId', [User].UserId as 'UserId', Subtype.Name as 'Subtype',
	replicate ('0', 6 - Len([User].UserId)) + Convert(char(6), [User].UserId) as 'EmployeeNumber', OFFICE_PHONE_NUMBER, CELL_NUMBER, 
	Substitute.AltPhone as 'AltPhone', SubstituteNotes.Note as 'Note'
	FROM [User]
	LEFT JOIN Subtype ON Subtype.[Desc] = dbo.IsSubstitute([User].UserId)
	LEFT JOIN UserProfile ON UserProfile.UserId = [User].UserId
	LEFT JOIN Substitute ON Substitute.UserId = [User].UserId
	LEFT JOIN Preferred ON Preferred.LocationId = @LocationId AND Preferred.SubstituteId = Substitute.SubstituteId
	LEFT JOIN ClerkPreferredSubs ON ClerkPreferredSubs.LocationId = @LocationId AND ClerkPreferredSubs.SubstituteId = Substitute.SubstituteId
	LEFT JOIN SubstituteNotes ON Substitute.SubstituteId = SubstituteNotes.SubstituteId
	WHERE Preferred.SubstituteId is not null		 
	ORDER BY rtrim(LastName) ASC
	SET @Err = @@Error

	RETURN @Err

END
GO

ALTER PROCEDURE [dbo].[LoadAvailableSubstitutes]
@JobId int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT Substitute.SubstituteId, rtrim([User].LastName) + ', '+[User].FirstName as 'Name',
		   case when Preferred.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsPreferred',
		   case when ClerkPreferredSubs.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsClerkPreferred', Job.LocationId as 'JobLocationId',
		   null as 'DateLastWorked',null as 'TimeWorked', [UserProfile].Phone as 'Phone', Subtype.Name as 'SubtypeName',
		   OFFICE_PHONE_NUMBER, CASE WHEN CELL_NUMBER = '' THEN '&nbsp' ELSE CELL_NUMBER END as CELL_NUMBER, Substitute.AltPhone as 'AltPhone', SubstituteNotes.Note as 'Note', Substitute.UserId as 'UserId'
	FROM Substitute
	LEFT JOIN [User] ON Substitute.UserId = [User].UserId
	LEFT JOIN [UserProfile] ON [UserProfile].UserId = [User].UserId
	LEFT JOIN Job ON Job.JobId = @JobId
	LEFT JOIN Preferred ON Preferred.LocationId = Job.LocationId AND Preferred.SubstituteId = Substitute.SubstituteId
	LEFT JOIN ClerkPreferredSubs ON ClerkPreferredSubs.LocationId = Job.LocationId AND ClerkPreferredSubs.SubstituteId = Substitute.SubstituteId
	LEFT JOIN Subtype ON Subtype.SubtypeId = Job.SubtypeId	
	LEFT JOIN SubstituteNotes ON Substitute.SubstituteId = SubstituteNotes.SubstituteId
	WHERE (Preferred.LocationId IS NOT NULL OR ClerkPreferredSubs.LocationId IS NOT NULL)
	ORDER BY IsClerkPreferred DESC, [User].LastName ASC, [User].FirstName ASC
END
GO

exec('ALTER PROCEDURE [dbo].[LoadLastJobBySubstitute]
(
	@SubstituteId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT                
		[Job].Teacher as ''Name'',
		CONVERT(varchar, DatetimeStart, 1) as ''DatetimeStart'',
		1 as ''TimeWorks''
	FROM [Job]
	WHERE
		([SubstituteId] = @SubstituteId)
	ORDER BY [Datetimeend] DESC

	SET @Err = @@Error

	RETURN @Err
END')
GO

exec('ALTER PROCEDURE [dbo].[SearchSubstituteByName] 
@name nvarchar(255)
AS
BEGIN
	SELECT Firstname, Lastname, Subtype.Name as ''Subtype'', [User].UserId as ''UserId''
	FROM [User]
	INNER JOIN Subtype ON Subtype.[Desc] = [User].LocationId
	WHERE [User].FirstName LIKE @name+''%'' OR [User].LastName LIKE @name+''%''					
END')
GO

exec('CREATE PROCEDURE [dbo].[SubstituteUpdate]
@LocationId int = 0,
@ClerkId int,
@SubstituteId int,
@IsClerkPreferred bit,
@AltPhone nvarchar(255),
@Note nvarchar(255)

AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	DELETE FROM ClerkPreferredSubs WHERE SubstituteId = @SubstituteId AND LocationId = @LocationId
	
	IF (@IsClerkPreferred = 1)
	BEGIN		
		INSERT INTO ClerkPreferredSubs (SubstituteId, LocationId) VALUES (@SubstituteId, @LocationId)	
	END 
	
	UPDATE Substitute SET AltPhone = @AltPhone WHERE SubstituteId = @SubstituteId
	
	DECLARE @count int
	SET @count = (SELECT count(*) FROM SubstituteNotes WHERE SubstituteId = @SubstituteId AND ClerkId = @ClerkId)
	IF (@count = 0)
	BEGIN
		INSERT INTO SubstituteNotes (SubstituteId, ClerkId, Note) VALUES (@SubstituteId, @ClerkId, @Note)			
	END
	ELSE
	BEGIN
		UPDATE SubstituteNotes SET SubstituteId = @SubstituteId, ClerkId = @ClerkId, Note = @Note WHERE SubstituteId = @SubstituteId AND ClerkId = @ClerkId
	END
	
	SET @Err = @@Error
	RETURN @Err
END')
GO

exec('CREATE PROCEDURE [dbo].[SubstituteUpdateAltPhone]
@SubstituteId int,
@AltPhone nvarchar(255)
AS
BEGIN

	UPDATE Substitute SET AltPhone = @AltPhone WHERE SubstituteId = @SubstituteId

END')
GO

ALTER VIEW [dbo].[User]
AS
SELECT     CAST(EMPLOYEE_NUMBER AS int) AS UserId, CAST(EMPLOYEE_NUMBER AS nvarchar(255)) AS LoginName, CAST(REPLACE(CONVERT(varchar, BIRTH_DATE, 1), '/', 
                      '') AS nvarchar(50)) AS Password, CAST(EMPLOYEE_EMAIL_ADDRESS AS nvarchar(255)) AS Email, CAST(FIRST_NAME AS nvarchar(255)) AS FirstName, 
                      CAST(LAST_NAME AS nvarchar(255)) AS LastName, CAST(MIDDLE_NAME AS nvarchar(255)) AS MiddleName, CAST(NULL AS datetime) AS LastLoginDate, CAST(0 AS bit)
                       AS IsOrganizationAdministrator, CAST(0 AS bit) AS Deleted, PAYCODE, JOB_BOARD_CODE AS BoardCode, LOCATION AS LocationId, 
                      RESIDENCE_PHONE_NUMBER AS CellPhone, SALARY_SCHEDULE, OFFICE_PHONE_NUMBER, CELL_NUMBER
FROM         DW_PERQ.dbo.V_EMPLOYEE
WHERE     (STATUS = '1')
UNION
SELECT     CAST(EMPLOYEE_NUMBER AS int) AS UserId, EMPLOYEE_NUMBER AS LoginName, '000000' AS Password, EMPLOYEE_EMAIL_ADDRESS AS Email, 
                      FULL_NAME AS FirstName, '' AS LastName, '' AS MiddleName, CAST(NULL AS datetime) AS LastLoginDate, CAST(0 AS bit) AS IsOrganizationAdministrator, 
                      CAST(0 AS bit) AS Deleted, '0' AS Expr1, '0' AS BoardCode, LOCATION AS LocationId, NULL AS CellPhone, '' AS SALARY_SCHEDULE, 
                      '' AS OFFICE_PHONE_NUMBER, '' AS CELL_NUMBER
FROM         dbo.V_AUTHORIZED_USER
WHERE     (EMPLOYEE_NUMBER = 910658)

GO