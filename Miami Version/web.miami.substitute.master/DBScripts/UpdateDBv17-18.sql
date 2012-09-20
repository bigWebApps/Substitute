UPDATE DB_Version SET [DB_Version] = 18
GO

UPDATE Grade SET [name]='Vocational' WHERE [name] = 'Vacational'
GO

ALTER PROCEDURE [dbo].[SearchSubstituteByName] 
@name nvarchar(255)
AS
BEGIN
	DECLARE @nameProcessed nvarchar(255)
	SET @nameProcessed = replace(@name, ',','')
	SET @nameProcessed = replace(@nameProcessed, ' ','')	
	
	SELECT Firstname, Lastname, Subtype.Name as 'Subtype', [User].UserId as 'UserId'
	FROM [User]
	INNER JOIN Subtype ON Subtype.[Desc] = [User].LocationId
	WHERE replace([User].FirstName, ' ','') + replace([User].LastName, ' ','') LIKE '%'+@nameProcessed+'%'
		OR replace([User].LastName, ' ','') + replace([User].FirstName, ' ','') LIKE '%'+@nameProcessed+'%'				
END
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
	Substitute.SubstituteId as 'SubstituteId', [User].UserId as 'UserId', Subtype.Name as 'Subtype', replicate ('0', 6 - Len([User].UserId)) + Convert(char(6), [User].UserId) as 'EmployeeNumber'
	FROM [User]
	LEFT JOIN Subtype ON Subtype.[Desc] = dbo.IsSubstitute([User].UserId)
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


ALTER PROCEDURE [dbo].[LoadAvailableSubstitutes]
@JobId int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT Substitute.SubstituteId, rtrim([User].LastName) + ', '+[User].FirstName as 'Name',
		   case when Preferred.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsPreferred',
		   case when ClerkPreferredSubs.SubstituteId is null then CAST(0 as bit) else CAST(1 as bit) end as 'IsClerkPreferred', Job.LocationId as 'JobLocationId',
		   null as 'DateLastWorked',null as 'TimeWorked', [UserProfile].Phone as 'Phone', Subtype.Name as 'SubtypeName'
	FROM Substitute
	LEFT JOIN [User] ON [User].UserId = Substitute.UserId
	LEFT JOIN [UserProfile] ON [UserProfile].UserId = Substitute.UserId
	LEFT JOIN Job ON Job.JobId = @JobId
	LEFT JOIN Preferred ON Preferred.LocationId = Job.LocationId AND Preferred.SubstituteId = Substitute.SubstituteId
	LEFT JOIN ClerkPreferredSubs ON ClerkPreferredSubs.LocationId = Job.LocationId AND ClerkPreferredSubs.SubstituteId = Substitute.SubstituteId
	LEFT JOIN Subtype ON Subtype.SubtypeId = Job.SubtypeId
	WHERE (Preferred.LocationId IS NOT NULL OR ClerkPreferredSubs.LocationId IS NOT NULL)
	ORDER BY IsClerkPreferred DESC, IsPreferred DESC
END
GO


ALTER PROCEDURE [dbo].[GetUserForMain] 
	@userId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [User].*, [UserProfile].Email as EmailProfile, Address, Address2, JobPosition, 
		   JobAssignmentDescription, [UserProfile].Phone, Subtype.Name as 'Subtype', [Location].[Name] as 'LocationName', [Region].[Name] as 'RegionName'
	FROM [User] 
	LEFT JOIN [UserProfile] ON [User].UserId = [UserProfile].UserId
	LEFT JOIN [Location] ON (dbo.IsSubstitute([User].UserId) > 0 AND [Location].LocationId = dbo.IsSubstitute([User].UserId)) OR (dbo.IsSubstitute([User].UserId) = 0 AND [Location].LocationId = [User].LocationId)
	LEFT JOIN [Region] ON [Location].RegionId = [Region].RegionId
	LEFT JOIN [Subtype] ON [User].UserId = @UserId 
		  AND Subtype.[Desc]= dbo.IsSubstitute([User].UserId)

	WHERE [User].UserId = @userId
END
GO