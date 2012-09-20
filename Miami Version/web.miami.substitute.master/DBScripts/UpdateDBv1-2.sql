/******  Db Version 2  ******/
IF  NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DB_Version]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
CREATE TABLE [dbo].[DB_Version](
	[DB_Version] [int] NOT NULL
) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM [DB_Version])
	INSERT INTO [DB_Version] VALUES (2)

UPDATE Mc_Action SET ParentActionId = 126 WHERE ActionId = 138