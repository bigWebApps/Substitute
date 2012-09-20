UPDATE DB_Version SET [DB_Version] = 26
GO

UPDATE [dbo].[Mc_Action] SET [Name] = N'Admin Area', [Visible] = 0, ShowInDetailMenu = 0 WHERE [ActionId] = 126
GO

UPDATE [dbo].[Mc_Action] SET [Visible] = 0, ShowInDetailMenu = 0 WHERE [ActionId] = 138
GO

ALTER PROCEDURE [dbo].[LoadLocationUser]
@LocationId int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 	
	(select count(*) from Preferred WHERE LocationId = Location.LocationId) as 'CountUsers',
	(select count(*) from ClerkPreferredSubs WHERE LocationId = Location.LocationId) as 'CountPreferredUsers',
	(select count(*) from UserLocation WHERE LocationId = Location.LocationId) as 'ClerksCount',
 	[User].Email, Location.Name + ' &nbsp;&nbsp;' + Location.LocationId as 'LName', ltrim(rtrim([User].LastName) + ', '+[User].FirstName) as 'UName'
	FROM Location
	LEFT JOIN UserLocation ON UserLocation.LocationId = Location.LocationId
	LEFT JOIN [User] ON [User].UserId = UserLocation.UserId
	WHERE UserLocation.LocationId = @LocationId OR @LocationId = 0
	ORDER BY Location.Name ASC
END
GO