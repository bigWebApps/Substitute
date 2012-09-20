UPDATE DB_Version SET [DB_Version] = 16
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
	LEFT JOIN [Location] ON [Location].LocationId = dbo.IsSubstitute([User].UserId) OR (dbo.IsSubstitute([User].UserId) = 0 AND [Location].LocationId = [User].LocationId)
	LEFT JOIN [Region] ON [Location].RegionId = [Region].RegionId
	LEFT JOIN [Subtype] ON [User].UserId = @UserId 
		  AND Subtype.[Desc]= dbo.IsSubstitute([User].UserId)

	WHERE [User].UserId = @userId
END
GO