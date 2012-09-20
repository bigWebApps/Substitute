/******  Db Version 4  ******/
UPDATE DB_Version SET [DB_Version] = 4
GO

ALTER VIEW [dbo].[V_LOCATION]
AS
SELECT     LOC_NUM, LOC_NAME, LOC_NAME_SHORT, LOC_ADDR_STREET, LOC_ADDR_CITY, LOC_ADDR_ZIP_CODE, LOC_PHONE_NUM_OFFICE, LOC_REGN_CODE
FROM         DW_Locations.dbo.LOCATION
WHERE     (LOC_REGN_CODE BETWEEN '1' AND '6') OR
                      (LOC_NUM = '9029')
GO

DELETE FROM [Preferred]
GO

DELETE FROM [dbo].[Weekday]
GO

SET IDENTITY_INSERT [dbo].[Weekday] ON

INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (1, 'Sun', 1)
INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (2, 'Mon', 2)
INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (3, 'Tu', 3)
INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (4, 'We', 4)
INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (5, 'Th', 5)
INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (6, 'Fri', 6)
INSERT INTO [Weekday] ([WeekDayId], [Name], [Value]) VALUES (7, 'Sat', 7)

SET IDENTITY_INSERT [dbo].[Weekday] OFF
