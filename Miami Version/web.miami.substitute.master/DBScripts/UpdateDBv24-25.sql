SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, CONCAT_NULL_YIELDS_NULL, XACT_ABORT ON
GO
SET NUMERIC_ROUNDABORT OFF
GO

UPDATE DB_Version SET [DB_Version] = 25
GO

UPDATE [dbo].[Status] SET [Name] = N'Confirmed' WHERE [StatusId] = 3
GO

UPDATE [dbo].[Mc_Action] SET [IconUrl] = N'/Images/spacer.gif' WHERE [ActionId] = 126
GO

SET IDENTITY_INSERT [dbo].[Mc_Action] ON
GO
INSERT INTO [dbo].[Mc_Action]([ActionId], [ParentActionId], [ActionTypeId], [Name], [Description], [IconUrl], [ButtonIconUrl], [NavigateUrl], [OrderNumber], [ClassFullName], [DepartmentRequired], [Visible], [ShowInDetailMenu], [ShowChildrenInDetailMenu], [GroupInDetailMenu], [HighlightInDetailMenu], [Deleted]) VALUES (203, 117, 1, N'Confirm Job', N' ', N' ', N'', N'/ConfirmJobModal.aspx', 1, N'', 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Mc_Action] OFF
GO

INSERT INTO [dbo].[Mc_RolesActions]([RoleId], [ActionId]) VALUES (14, 203)
GO


ALTER TABLE [dbo].[Job]
	ADD [ConfirmNote] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
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
			end end as SubstituteStatus,
		[UserProfile].Phone as ''Phone'',
		usersub.CELL_NUMBER,
		Substitute.AltPhone as ''AltPhone'',
		usersub.Email as ''Email'',
		[Grade].Name as ''Grade'',
		[Job].Subject,
		CASE WHEN Job.StatusId = 2 THEN ConfirmNote ELSE NULL END as ConfirmNote
	FROM [Job]
	LEFT JOIN Substitute ON Job.[SubstituteId] = Substitute.[SubstituteId]
	LEFT JOIN [User] as usersub ON Substitute.UserId = usersub.UserId
	LEFT JOIN [UserProfile] ON [UserProfile].UserId = usersub.UserId
	LEFT JOIN Location ON Location.LocationId = Job.[LocationId]
	LEFT JOIN Region ON Location.RegionId = Region.RegionId
	LEFT JOIN Status ON Status.StatusId = dbo.GetJobStatus(Job.StatusId, Job.DatetimeEnd, GETDATE())
	LEFT JOIN Subtype ON Subtype.SubtypeId = Job.SubtypeId
	LEFT JOIN [Grade] ON [Job].GradeId = [Grade].GradeId AND [Job].GradeId > 0
	WHERE (Location.LocationId = @LocationId OR @LocationId = 0) AND
		  (((Status.StatusId = 1 OR Status.StatusId = 3) AND @StatusId = 1) 
		  OR (Status.StatusId = 2 AND @StatusId = 2)
		  )
	ORDER BY CASE WHEN @StatusId = 1 THEN [DatetimeStart]
			 ELSE ''''
			 END ASC, CASE WHEN @StatusId = 2 THEN [DatetimeEnd]
			 ELSE ''''
			 END DESC, JobId 

	SET @Err = @@Error
	RETURN @Err
END')
GO

exec('ALTER PROCEDURE [dbo].[daab_SearchJobOpened] 
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
		CONVERT(varchar, [Job].[DatetimeStart], 101) as ''DatetimeStart'',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as ''DatetimeEnd'',
		Jbl.Name as ''Location'',
		Jbr.Name as ''Region'',
		[Job].Teacher as ''Teacher'',
		(
			SELECT COUNT(*) FROM [Job] jb
			WHERE jb.SubstituteId = @SubstituteId 
				AND (
					   (jb.[DatetimeStart] >= [Job].[DatetimeStart] AND [jb].[DatetimeStart] <= [Job].[DatetimeEnd])
					   OR (jb.[DatetimeEnd] >= [Job].[DatetimeStart] AND [jb].[DatetimeEnd] <= [Job].[DatetimeEnd])
					   OR (jb.[DatetimeStart] <= [Job].[DatetimeStart] AND [jb].[DatetimeEnd] >= [Job].[DatetimeEnd])
					   OR (jb.[DatetimeEnd] < [Job].[DatetimeStart] AND [jb].[DatetimeEnd] > [Job].[DatetimeEnd])					
					)
		) as ''Overlap'',
		[Grade].Name as ''Grade'',
		[Job].Subject		
	FROM [Job]
	LEFT JOIN [dbo].[Preferred] as Jbp ON [Job].[LocationId] = Jbp.[LocationId] AND Jbp.SubstituteId = @SubstituteId
	LEFT JOIN [dbo].[Location] as Jbl ON Job.[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	LEFT JOIN [dbo].[User] as Jbs ON Jbs.UserId = @UserId
	LEFT JOIN [Grade] ON [Job].GradeId = [Grade].GradeId AND [Job].GradeId > 0
	LEFT JOIN [Subtype] ON Jbs.LocationId = Subtype.[Desc]
	WHERE [Job].StatusId = 1
		  AND [Job].SubtypeId = [Subtype].SubtypeId
		  AND ([Job].[DatetimeStart] >= @jfrom OR @jfrom = CAST(''1980-01-01'' as datetime))
		  AND ([Job].[DatetimeStart] <= @jto OR @jto = CAST(''1980-01-01'' as datetime))
		  AND (Jbp.LocationId = @locName OR @SubstituteId = 0 OR (@locName=0 AND Jbp.LocationId > 0))
END')
GO

exec('ALTER PROCEDURE [dbo].[daab_SearchJobOpenedByRegion] 
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
		CONVERT(varchar, [Job].[DatetimeStart], 101) as ''DatetimeStart'',
		CONVERT(varchar, [Job].[DatetimeEnd], 101) as ''DatetimeEnd'',
		Jbl.Name as ''Location'',
		Jbr.Name as ''Region'',
		[Job].Teacher as ''Teacher'',
		[Grade].Name as ''Grade'',
		[Job].Subject	
	FROM [Job]
	LEFT JOIN [dbo].[Preferred] as Jbp ON [Job].[LocationId] = Jbp.[LocationId] AND Jbp.SubstituteId = @SubstituteId
	LEFT JOIN [dbo].[Location] as Jbl ON Jbp.[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	LEFT JOIN [dbo].[User] as Jbs ON Jbs.UserId = @UserId
	LEFT JOIN [Subtype] ON Jbs.LocationId = Subtype.[Desc]
	LEFT JOIN [Grade] ON [Job].GradeId = [Grade].GradeId AND [Job].GradeId > 0
	WHERE [Job].StatusId = 1
		  AND [Job].SubtypeId = [Subtype].SubtypeId
		  AND ([Job].[DatetimeStart] >= @jfrom OR @jfrom = CAST(''1980-01-01'' as datetime))
		  AND ([Job].[DatetimeStart] <= @jto OR @jto = CAST(''1980-01-01'' as datetime))
		  AND (Jbl.RegionId = @locName OR (@locName=0 AND Jbl.RegionId > 0))
END')
GO


exec('ALTER PROCEDURE [dbo].[LoadAllPreferredSubstitutes]
@LocationId int = 0
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT rtrim(LastName)+'', ''+FirstName as ''Name'', UserProfile.Phone as ''Phone'',
	case when Preferred.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as ''IsPreferred'',
	case when ClerkPreferredSubs.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as ''IsClerkPreferred'',
	Substitute.SubstituteId as ''SubstituteId'', [User].UserId as ''UserId'', Subtype.Name as ''Subtype'',
	replicate (''0'', 6 - Len([User].UserId)) + Convert(char(6), [User].UserId) as ''EmployeeNumber'', OFFICE_PHONE_NUMBER, CASE WHEN CELL_NUMBER = '''' THEN ''&nbsp'' ELSE CELL_NUMBER END as CELL_NUMBER, 
	Substitute.AltPhone as ''AltPhone'', SubstituteNotes.Note as ''Note''
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
END')
GO


exec('-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SetConfirmJob]
@JobId int,
@SubstituteId int,
@Status int,
@ConfirmNote nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE Job SET StatusId = @Status, ConfirmNote = @ConfirmNote WHERE JobId = @JobId
	
	IF (@Status = 1)
	BEGIN
		UPDATE Job SET SubstituteId = 0, ConfirmNote = '''' WHERE JobId = @JobId
	END
	
END')
GO

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
		[Job].Teacher as 'Teacher',
		[Job].[LocationId],
		[Job].[GradeId],
		[Job].[StatusId],
		[SubstituteId]
	FROM [Job]
	LEFT JOIN [dbo].[Location] as Jbl ON [Job].[LocationId] = Jbl.[LocationId]
	LEFT JOIN [dbo].[Region] as Jbr ON Jbl.[RegionId] = Jbr.[RegionId]
	LEFT JOIN [dbo].[Subtype] as Jbs ON [Job].[SubtypeId] = Jbs.[SubtypeId]
	LEFT JOIN [dbo].[Status] as Jbst ON [Job].[StatusId] = Jbst.[StatusId]
	LEFT JOIN [dbo].[Grade] as JbGrade ON [Job].[GradeId] = JbGrade.[GradeId] AND [Job].[GradeId]<>0
	WHERE [Job].JobId = @jobId
END
GO