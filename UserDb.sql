USE [UsersDb]
GO
/****** Object:  Table [dbo].[Passport]    Script Date: 26.05.2018 4:11:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passport](
	[id] [uniqueidentifier] NOT NULL,
	[passport_number] [nvarchar](255) NOT NULL,
	[nationality] [nvarchar](255) NULL,
	[other] [nvarchar](255) NULL,
	[user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Passport] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Region_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [uniqueidentifier] NOT NULL,
	[fullname] [nvarchar](255) NOT NULL,
	[registration_region_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[uf_SelectUserById]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_SelectUserById]
(	
	@userId uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT u.id, u.fullname, r.id as 'regionId', r.[name], p.id as 'passportId', p.nationality, p.passport_number as 'passportNumber', p.other from [User] u
	INNER JOIN [dbo].[Region] r ON r.id = u.registration_region_id 
	INNER JOIN [dbo].[Passport] p ON p.[user_id] = u.id
)
GO
/****** Object:  Table [dbo].[Answer_variative]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer_variative](
	[id] [uniqueidentifier] NOT NULL,
	[question_id] [uniqueidentifier] NOT NULL,
	[answer_id] [uniqueidentifier] NOT NULL,
	[test_exist_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Answer_variative] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test_Exist]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_Exist](
	[id] [uniqueidentifier] NOT NULL,
	[user_id] [uniqueidentifier] NOT NULL,
	[request_date] [datetime] NOT NULL,
	[test_date] [datetime] NULL,
	[exam_id] [uniqueidentifier] NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_Test_request_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Answer_free]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer_free](
	[id] [uniqueidentifier] NOT NULL,
	[question_id] [uniqueidentifier] NOT NULL,
	[data] [varbinary](max) NOT NULL,
	[test_exist_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Answer_free] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[uf_SelectUserMaterials]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_SelectUserMaterials]
(	
	@userId uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT u.id, u.fullname, p.passport_number, t.exam_id, t.request_date, t.[status], af.[data], av.answer_id from [User] u
	INNER JOIN [Passport] p ON p.[user_id] = u.id
	INNER JOIN [Test_Exist] t ON t.[user_id] = u.id
	INNER JOIN [Answer_free] af ON t.id = af.test_exist_id
	INNER JOIN [Answer_variative] av ON av.test_exist_id = t.id
	WHERE u.id = @userId
)
GO
/****** Object:  UserDefinedFunction [dbo].[uf_SelectUserAnswer]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_SelectUserAnswer]
(	
	@userId uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT u.id, u.fullname, p.passport_number, t.exam_id, t.request_date, t.[status], af.[data], av.answer_id from [User] u
	INNER JOIN [Passport] p ON p.id = u.passport_id
	INNER JOIN [Test_Exist] t ON t.user_id = u.id
	INNER JOIN [Answer_free] af ON t.id = af.test_exist_id
	INNER JOIN [Answer_variative] av ON av.test_exist_id = t.id
	WHERE u.id = @userId
)
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Roles_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[uf_SelectRoleByName]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_SelectRoleByName] 
(	
	-- Add the parameters for the function here
	@name nvarchar(255)
)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT id, name from [Roles] where name = @name
)

GO
/****** Object:  UserDefinedFunction [dbo].[uf_SelectTestInformation]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_SelectTestInformation]
(	
	@testId uniqueidentifier 
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from [Test_Exist] where id = @testId
)
GO
/****** Object:  UserDefinedFunction [dbo].[uf_SelectTestByIdFromRemoteServer]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[uf_SelectTestByIdFromRemoteServer]
(	
	@testId uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
    SELECT  t.id as 'testId', t.[name] as 'testName', s.id as 'sectionId', s.[description], q.[name] as 'questionName',
	q.id as 'questionId', vt.[answer_variant], vt.id as 'VarietiveId' 
	from [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Test] t
	INNER JOIN [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Section] s ON s.[test_id] = t.id
	INNER JOIN [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question] q ON s.id = q.section_id
	INNER JOIN [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Variative_task] vt ON q.id = vt.question_id
	WHERE t.id = @testId
)
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[id] [uniqueidentifier] NOT NULL,
	[status] [nvarchar](255) NOT NULL,
	[test_id] [uniqueidentifier] NOT NULL,
	[certificate_number] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[General_result]    Script Date: 26.05.2018 4:11:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[General_result](
	[id] [uniqueidentifier] NOT NULL,
	[test_exist_id] [uniqueidentifier] NOT NULL,
	[result_date] [datetime] NOT NULL,
	[grade] [decimal](18, 3) NOT NULL,
 CONSTRAINT [PK_General_result] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Section_result]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Section_result](
	[id] [uniqueidentifier] NOT NULL,
	[grade_criteria_id] [uniqueidentifier] NOT NULL,
	[grade] [int] NOT NULL,
	[test_exist_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Section_result] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test_record]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_record](
	[id] [uniqueidentifier] NOT NULL,
	[test_exist_id] [uniqueidentifier] NOT NULL,
	[data] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Test_record] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Role]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role](
	[role_id] [uniqueidentifier] NOT NULL,
	[user_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_User_Role] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Answer_free]  WITH CHECK ADD  CONSTRAINT [FK_Answer_free_Test_Exist] FOREIGN KEY([test_exist_id])
REFERENCES [dbo].[Test_Exist] ([id])
GO
ALTER TABLE [dbo].[Answer_free] CHECK CONSTRAINT [FK_Answer_free_Test_Exist]
GO
ALTER TABLE [dbo].[Answer_variative]  WITH CHECK ADD  CONSTRAINT [FK_Answer_variative_Test_Exist] FOREIGN KEY([test_exist_id])
REFERENCES [dbo].[Test_Exist] ([id])
GO
ALTER TABLE [dbo].[Answer_variative] CHECK CONSTRAINT [FK_Answer_variative_Test_Exist]
GO
ALTER TABLE [dbo].[General_result]  WITH CHECK ADD  CONSTRAINT [FK_General_result_Test_request] FOREIGN KEY([test_exist_id])
REFERENCES [dbo].[Test_Exist] ([id])
GO
ALTER TABLE [dbo].[General_result] CHECK CONSTRAINT [FK_General_result_Test_request]
GO
ALTER TABLE [dbo].[Passport]  WITH CHECK ADD  CONSTRAINT [FK_Passport_User1] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Passport] CHECK CONSTRAINT [FK_Passport_User1]
GO
ALTER TABLE [dbo].[Section_result]  WITH CHECK ADD  CONSTRAINT [FK_Section_result_Test_Exist] FOREIGN KEY([test_exist_id])
REFERENCES [dbo].[Test_Exist] ([id])
GO
ALTER TABLE [dbo].[Section_result] CHECK CONSTRAINT [FK_Section_result_Test_Exist]
GO
ALTER TABLE [dbo].[Test_Exist]  WITH CHECK ADD  CONSTRAINT [FK_Test_Exist_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Test_Exist] CHECK CONSTRAINT [FK_Test_Exist_User]
GO
ALTER TABLE [dbo].[Test_Exist]  WITH CHECK ADD  CONSTRAINT [FK_Test_request_Exam] FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([id])
GO
ALTER TABLE [dbo].[Test_Exist] CHECK CONSTRAINT [FK_Test_request_Exam]
GO
ALTER TABLE [dbo].[Test_record]  WITH CHECK ADD  CONSTRAINT [FK_Test_record_Test_request] FOREIGN KEY([test_exist_id])
REFERENCES [dbo].[Test_Exist] ([id])
GO
ALTER TABLE [dbo].[Test_record] CHECK CONSTRAINT [FK_Test_record_Test_request]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([registration_region_id])
REFERENCES [dbo].[Region] ([id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD  CONSTRAINT [FK_User_Role_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[User_Role] CHECK CONSTRAINT [FK_User_Role_Roles]
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD  CONSTRAINT [FK_User_Role_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[User_Role] CHECK CONSTRAINT [FK_User_Role_User]
GO
/****** Object:  StoredProcedure [dbo].[up_AddUserToRole]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_AddUserToRole] 
(
	@userId uniqueidentifier,
	@roleId uniqueidentifier
)
AS
BEGIN
	
	SET NOCOUNT ON;

	IF (EXISTS (SELECT TOP 1 1 FROM [dbo].[User] WITH(NOLOCK) WHERE id = @userId)) AND 
	   (EXISTS (SELECT TOP 1 1 FROM [dbo].[Roles] WITH(NOLOCK) WHERE id = @roleId)) 
			
			INSERT INTO [dbo].[User_Role](user_id, role_id)
			VALUES(@userId, @roleId)

	ELSE

		THROW 51000, 'Пользователь или роль не существует', 1
   
END
GO
/****** Object:  StoredProcedure [dbo].[up_CreateAnswerFree]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_CreateAnswerFree]
(
	@questionId uniqueidentifier,
	@data varbinary(max),
	@test_exist_id uniqueidentifier
)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	INSERT INTO [Answer_free](id, question_id, test_exist_id, [data])
	VALUES(NEWID(), @questionId, @test_exist_id, @data)
    
END
GO
/****** Object:  StoredProcedure [dbo].[up_CreateAnswerVariative]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_CreateAnswerVariative] 
(
	@questionId uniqueidentifier,
	@answerId uniqueidentifier,
	@test_exist_id uniqueidentifier
)
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	INSERT INTO [Answer_variative](id, question_id, answer_id, test_exist_id)
	VALUES (NEWID(), @questionId, @answerId, @test_exist_id)
    
END
GO
/****** Object:  StoredProcedure [dbo].[up_CreateUserPassportUserRole]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_CreateUserPassportUserRole]
(
	@id uniqueidentifier,
	@fullname nvarchar(255),
	@registrationRegionId uniqueidentifier,
	@passportId uniqueidentifier,
	@passportNumber nvarchar(255),
	@nationality nvarchar(255),
	@other nvarchar(255) = NULL
)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	-- По умолчанию, регистрируем всех как клиентов.
	DECLARE @clientRoleId uniqueidentifier = (SELECT id FROM [dbo].[Roles] WHERE [name] = N'Клиент')

    INSERT INTO [dbo].[User](id, fullname, registration_region_id)
	VALUES(@id, @fullname, @registrationRegionId)

	IF (@passportId <> '00000000-0000-0000-0000-000000000000')
	BEGIN
		INSERT INTO [dbo].[Passport](id, passport_number, nationality, other, [user_id])
		VALUES(@passportId, @passportNumber, @nationality, @other, @id)
	END

	INSERT INTO [dbo].[User_Role]([user_id], role_id)
	VALUES(@id, @clientRoleId)

END
GO
/****** Object:  StoredProcedure [dbo].[up_CreateUserRole]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_CreateUserRole]
(
	@name nvarchar(255),
	@id uniqueidentifier
)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	INSERT INTO [Roles](id, name)
	VALUES(@id, @name)
    
END
GO
/****** Object:  StoredProcedure [dbo].[up_DeleteRole]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_DeleteRole] 
(
	
	@roleId uniqueidentifier
	
	
)
AS
BEGIN 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
    DELETE FROM [User_Role] WHERE [role_id] = @roleId
    DELETE FROM [Roles] WHERE [id] = @roleId
	 
	
END
GO
/****** Object:  StoredProcedure [dbo].[up_DeleteUser]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_DeleteUser]
(
	@userId uniqueidentifier
)
AS
BEGIN

	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
    DELETE FROM [User_Role] WHERE [user_id] = @userId
    DELETE FROM [Passport] WHERE [user_id] = @userId
	DELETE FROM [User] WHERE [id] = @userId
	DELETE FROM [Test_Exist] WHERE [user_id] = @userId
	   
END
GO
/****** Object:  StoredProcedure [dbo].[up_DeleteUserRoleByUserIdAndRoleId]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_DeleteUserRoleByUserIdAndRoleId]
(
	@roleId uniqueidentifier,
	@userId uniqueidentifier
)
AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DELETE FROM [dbo].[User_Role] WHERE role_id = @roleId AND user_id = @userId
    
END
GO
/****** Object:  StoredProcedure [dbo].[up_GenerateRegion]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_GenerateRegion]

AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
		
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'ANN'),(NEWID(),'NSWW'),(NEWID(),'Ayrshire'),(NEWID(),'Małopolskie'),(NEWID(),'Bavaria'),(NEWID(),'ON1'),(NEWID(),'Piemonte'),(NEWID(),'Jharkhand'),(NEWID(),'Dolnośląskie'),(NEWID(),'SI1');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'Oxfordshire'),(NEWID(),'DE'),(NEWID(),'Ulster'),(NEWID(),'NSW'),(NEWID(),'Puglia'),(NEWID(),'BR'),(NEWID(),'ANQ'),(NEWID(),'ZA'),(NEWID(),'SP'),(NEWID(),'ON2');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'Zl'),(NEWID(),'UP'),(NEWID(),'East Lothian'),(NEWID(),'British Columbia'),(NEWID(),'OR'),(NEWID(),'Punjab'),(NEWID(),'West-Vlaanderen'),(NEWID(),'Victoria'),(NEWID(),'SJ'),(NEWID(),'YT');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'VB'),(NEWID(),'Gävleborgs län'),(NEWID(),'Samsun'),(NEWID(),'Ontario'),(NEWID(),'WY'),(NEWID(),'O'),(NEWID(),'MP'),(NEWID(),'South Australia'),(NEWID(),'Saskatchewan'),(NEWID(),'MA');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'BC'),(NEWID(),'Ist'),(NEWID(),'LA'),(NEWID(),'Noord Holland'),(NEWID(),'MB'),(NEWID(),'ON3'),(NEWID(),'AR'),(NEWID(),'Illinois'),(NEWID(),'RJ'),(NEWID(),'O Higgins');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'Rajasthan'),(NEWID(),'LD'),(NEWID(),'O G'),(NEWID(),'Gelderland'),(NEWID(),'G'),(NEWID(),'New South Wales'),(NEWID(),'Marche'),(NEWID(),'Victoria1'),(NEWID(),'Ist1'),(NEWID(),'IM');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'İzm'),(NEWID(),'WV'),(NEWID(),'Västra1 Götalands län'),(NEWID(),'Västra Götalands län'),(NEWID(),'ON4'),(NEWID(),'SI'),(NEWID(),'Luxemburg'),(NEWID(),'NI'),(NEWID(),'Bal'),(NEWID(),'Maranhão');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'PUG'),(NEWID(),'PA'),(NEWID(),'North Island sj'),(NEWID(),'IL'),(NEWID(),'OV'),(NEWID(),'ST'),(NEWID(),'HH'),(NEWID(),'Metropolitana de Santiago'),(NEWID(),'RU'),(NEWID(),'U.');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'Małopolskie1'),(NEWID(),'V'),(NEWID(),'SL'),(NEWID(),'SJ11'),(NEWID(),'Leinster'),(NEWID(),'LAZ'),(NEWID(),'X'),(NEWID(),'North Island'),(NEWID(),'QC'),(NEWID(),'MP_');
	INSERT INTO [dbo].[Region]([id],[name]) VALUES(NEWID(),'Saarland'),(NEWID(),'Anambra'),(NEWID(),'MH'),(NEWID(),'PE'),(NEWID(),'Wielkopolskie'),(NEWID(),'Munster'),(NEWID(),'Berlin'),(NEWID(),'WY_'),(NEWID(),'Leinster_'),(NEWID(),'SP_');

   
END
GO
/****** Object:  StoredProcedure [dbo].[up_GenerateTestInformation]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_GenerateTestInformation] 
	
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO [dbo].[Test_Exist]
	 VALUES ('F7C6EF41-482E-6C6F-ECBB-0B1C8D7C1CB3','BD2DBE73-C031-78B7-23FF-0AEF21483453','03-24-19','04-11-18','09051173-B426-2B14-5C76-951AB7CB511D',1),
	 ('40F98B6A-C2D5-AD52-1DB3-465EA9FFEC12','5A727926-FCE3-A31D-3CE7-10C1CA64F001','07-20-18','09-19-18','C471C515-56B1-B602-25F1-FDB01B526BB6',1),
	 ('ED6B2AD9-F999-B70F-2345-C0B8DDF6D9E4','6E356F27-FEBD-FA59-2E21-1A512C7EC047','09-19-18','08-20-17','408ABB63-EE0E-26C2-CC74-2E56895E0547',0),
	 ('"CAA1447C-7AFB-8D75-DBD0-925AB7523101','82060D57-8A5B-5C1E-FED9-211408A6E7BE','05-24-1','12-24-18','29A69215-9BC8-8499-8372-14B74AAE0FF6',1),
	 ('FEDD2961-E4E8-7D71-2872-9520B4AD4C18','2100BD03-57D7-D31D-BC2B-225BACAEFC93','04-30-19','07-15-18','1F4E06FB-7852-B086-75F4-D20CDDED179D',1),
	 ('D4E2E84E-FFEB-FB6D-4FB4-80E044C43409','4A946346-3EB5-9D97-35F3-2520DF8A807B','12-13-18','02-23-18','2B75D371-BA20-5AB5-5059-227C3FB35150',0),
	 ('FB1A52E7-B203-E9C3-837A-FC0C430DA871','1311B057-5D2E-6202-451F-252178369D4E','07-18-18','12-06-18','E1C431E6-83B3-BB49-BB88-75C3A37D1FE6',0),
	 ('48132D63-AA73-6261-5219-B38BB10C7086','4852FAA9-D5C7-512A-591C-2763105C080C','01-04-19','05-15-18','547DE60A-3A06-497A-18B8-FE3553360E89',1),
	 ('92F7A9BF-EE13-7862-56F1-A2E21648CC5A','49112169-4553-4E64-B5BC-2B919A3A3EE2','10-17-17','08-31-18','BC5A496B-1AF3-620F-3D1F-E022D787ABB5',0),
	 ('31E5B963-5CD0-588C-83BD-C80F50B65DC7','0F7FC6AD-CE86-79FF-E925-2FEE65B139EA','08-25-17','04-07-18','5AA5E0F5-FB7E-93D0-5998-66EDBF0EA519',0);
END
GO
/****** Object:  StoredProcedure [dbo].[up_generateTestRemote]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_generateTestRemote] 
	AS
BEGIN
	
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @errorMessage nvarchar(2000)

	BEGIN TRY

	BEGIN TRAN	
		DELETE FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Variative_task]
		DELETE FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question]
		DELETE FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Section]
		DELETE FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Test]
		DELETE FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Certification_type]
		DELETE FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Open_question_criteria]
		
		-- Создание сертификата
		INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Certification_type]
		VALUES ('A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Certficate')
		
		-- Заполнение критерия открытого вопроса
		INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Open_question_criteria]	
		VALUES 
			('A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572', 'Решение коммуникативной задачи (3 балла), организация текста (3 балла), лексическое оформление (3 балла), грамматика (3 балла)
						орфография и пунктуация (2 балла), количество слов не выходит за рамки 200-250')
	
		INSERT INTO  [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Test]
		VALUES
			('C6D2E786-B817-400F-8C90-D643EBAD1AF8', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 1', '25'),
			('2BE004BA-1351-4023-A4E0-E8F6FEB54B80', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 2', '25'),
			('F6DF8BB9-EB3B-4B07-AFC5-D36981A3C628', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 3', '25'),
			('8A8F917B-1589-4CA3-9FB1-F1804CA26833', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 4', '25'),
			('7C555BB1-538F-4999-AF11-4D9A99BB204D', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 5', '25'),
			('FA088C40-7E1F-4CAF-9E64-DF1C8D695734', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 6', '25'),
			('9D57805F-3FCE-49B9-B6AE-9D80107C28B4', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 7', '25'),
			('C7A81BD0-BB10-4CC3-A13E-E8E5F0E0347F', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 8', '25'),
			('9C4DE66A-759C-428F-B5EC-77AED2D82C79', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 9', '25'),
			('2D4F7CDB-FF5E-4BFD-9FA7-CAB66F3C50A4', 'A46327A7-897C-44DB-A298-1396F8C22C5F', 'English Test Varint 10', '25')
	
	
		INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Section]
		VALUES 
			('AA0C66B9-D793-461F-A03D-12BF500F723D', 'Grammar Test', 'Test your Level of English Grammar', '2D4F7CDB-FF5E-4BFD-9FA7-CAB66F3C50A4'),
			('2DF44FF1-5923-43E3-A2F5-07CCD54D5344', 'Vocablary Test', 'Test your Level of English Vocabulary', '2D4F7CDB-FF5E-4BFD-9FA7-CAB66F3C50A4'),
			('E52D6825-4D8F-4009-877F-2D91D9344F1E', 'Phonetics Test', 'Test your Level of English Phonetics', '2D4F7CDB-FF5E-4BFD-9FA7-CAB66F3C50A4'),
			('18E27AB8-D400-4B2B-837C-0832A52C7DDB', 'Writting', 'Comment on the following statement', '2D4F7CDB-FF5E-4BFD-9FA7-CAB66F3C50A4' ),
			('689CD199-6DF1-4DD4-B625-39E08314B2EE', 'Grammar Test', 'Test your Level of English Grammar', '9C4DE66A-759C-428F-B5EC-77AED2D82C79'),
			('EBCE2236-8031-4BD5-A33F-3910A8ADB00F', 'Vocablary Test', 'Test your Level of English Vocabulary', '9C4DE66A-759C-428F-B5EC-77AED2D82C79'),
			('47038CA1-B2BE-4883-9514-30579CE700BF', 'Phonetics Test', 'Test your Level of English Phonetics', '9C4DE66A-759C-428F-B5EC-77AED2D82C79'),
			('9DCD1F5D-B367-46C6-B2C6-0E7CEFD9BE73', 'Writting', 'Comment on the following statement', '9C4DE66A-759C-428F-B5EC-77AED2D82C79' ),
			('F3FEEEA5-D113-4E1A-87E4-4656A6E88A77', 'Grammar Test', 'Test your Level of English Grammar', 'C7A81BD0-BB10-4CC3-A13E-E8E5F0E0347F'),
			('B7D653CC-0A95-4CA7-8125-7884498E9DE2', 'Vocablary Test', 'Test your Level of English Vocabulary', 'C7A81BD0-BB10-4CC3-A13E-E8E5F0E0347F'),
			('C93E6E89-070E-4F1E-AE74-3886F08FB6F0', 'Phonetics Test', 'Test your Level of English Phonetics', 'C7A81BD0-BB10-4CC3-A13E-E8E5F0E0347F'),
			('5F4239DF-8B41-4138-9556-47224FEFA958', 'Writting', 'Comment on the following statement', 'C7A81BD0-BB10-4CC3-A13E-E8E5F0E0347F' ),
			('D101665A-4608-488A-BB9C-4C4ABB43EBCF', 'Grammar Test', 'Test your Level of English Grammar', '9D57805F-3FCE-49B9-B6AE-9D80107C28B4'),
			('041D1E50-0388-40CB-B582-7CD22751E05F', 'Vocablary Test', 'Test your Level of English Vocabulary', '9D57805F-3FCE-49B9-B6AE-9D80107C28B4'),
			('631AE5B5-B597-4A37-984D-678C01A31C94', 'Phonetics Test', 'Test your Level of English Phonetics', '9D57805F-3FCE-49B9-B6AE-9D80107C28B4'),
			('917DFF3E-74BB-4096-80CA-9EE586539A96', 'Writting', 'Comment on the following statement', '9D57805F-3FCE-49B9-B6AE-9D80107C28B4' ),
			('3E728E7C-C373-48D1-AA90-8DF9FAB3C56B', 'Grammar Test', 'Test your Level of English Grammar', 'FA088C40-7E1F-4CAF-9E64-DF1C8D695734'),
			('2655C0C0-1B63-4785-B248-8EDD8A4AC681', 'Vocablary Test', 'Test your Level of English Vocabulary', 'FA088C40-7E1F-4CAF-9E64-DF1C8D695734'),
			('CE83DEEA-9106-4CA1-AFC2-B13DB2CCA858', 'Phonetics Test', 'Test your Level of English Phonetics', 'FA088C40-7E1F-4CAF-9E64-DF1C8D695734'),
			('1D86FE1C-D46D-4CEC-953A-A37DA3F8DD47', 'Writting', 'Comment on the following statement', 'FA088C40-7E1F-4CAF-9E64-DF1C8D695734' ),
			('EBF62B06-446C-4C6A-ADE5-ACB21C246528', 'Grammar Test', 'Test your Level of English Grammar', '7C555BB1-538F-4999-AF11-4D9A99BB204D'),
			('D242A797-D3A7-4CB3-9DDA-9A55C0F4A465', 'Vocablary Test', 'Test your Level of English Vocabulary', '7C555BB1-538F-4999-AF11-4D9A99BB204D'),
			('75A7A036-14D5-49F5-A7D4-89D42CFC8294', 'Phonetics Test', 'Test your Level of English Phonetics', '7C555BB1-538F-4999-AF11-4D9A99BB204D'),
			('37273045-9908-403C-A99E-A3EE2DB1D93A', 'Writting', 'Comment on the following statement', '7C555BB1-538F-4999-AF11-4D9A99BB204D' ),
			('E28734EC-EFB2-4F93-85C8-B9C146AD60C3', 'Grammar Test', 'Test your Level of English Grammar', '8A8F917B-1589-4CA3-9FB1-F1804CA26833'),
			('010A58AE-EC3D-4315-AC94-C4FE387C2BFB', 'Vocablary Test', 'Test your Level of English Vocabulary', '8A8F917B-1589-4CA3-9FB1-F1804CA26833'),
			('9E190C8B-1ABC-4AE1-8F4B-9F15C5EE67E0', 'Phonetics Test', 'Test your Level of English Phonetics', '8A8F917B-1589-4CA3-9FB1-F1804CA26833'),
			('BCE8D769-E34C-4E65-A9D0-BE6BE7AC70AC', 'Writting', 'Comment on the following statement', '8A8F917B-1589-4CA3-9FB1-F1804CA26833' ),
			('D7A868DE-45A9-4E50-AEFD-BB7197748DE4', 'Grammar Test', 'Test your Level of English Grammar', 'F6DF8BB9-EB3B-4B07-AFC5-D36981A3C628'),
			('DD636CA0-2C43-4B5D-940C-F1EFB3890631', 'Vocablary Test', 'Test your Level of English Vocabulary', 'F6DF8BB9-EB3B-4B07-AFC5-D36981A3C628'),
			('00D349DA-EFEA-4BCB-AD1B-C8DB6731BAED', 'Phonetics Test', 'Test your Level of English Phonetics', 'F6DF8BB9-EB3B-4B07-AFC5-D36981A3C628'),
			('59B6FD60-45EE-4728-A44D-CEAD9C68B0C3', 'Writting', 'Comment on the following statement', 'F6DF8BB9-EB3B-4B07-AFC5-D36981A3C628' ),
			('0EC3FA30-1042-4721-B16F-EB6129227B63', 'Grammar Test', 'Test your Level of English Grammar', '2BE004BA-1351-4023-A4E0-E8F6FEB54B80'),
			('9BA5F627-4CC5-42C4-9EBE-F5ED89AC20A9', 'Vocablary Test', 'Test your Level of English Vocabulary', '2BE004BA-1351-4023-A4E0-E8F6FEB54B80'),
			('DE897AC8-E3F7-4756-B4F5-FB90C3E67615', 'Phonetics Test', 'Test your Level of English Phonetics', '2BE004BA-1351-4023-A4E0-E8F6FEB54B80'),
			('43451969-1EAB-4D24-92D2-D0D508AED5CC', 'Writting', 'Comment on the following statement', '2BE004BA-1351-4023-A4E0-E8F6FEB54B80' ),
			('9091712A-02FF-41CB-92C8-F9CEEB6137A8', 'Grammar Test', 'Test your Level of English Grammar', 'C6D2E786-B817-400F-8C90-D643EBAD1AF8'),
			('4645C722-75A8-4E3E-8142-FB487DF8FB3A','Vocablary Test', 'Test your Level of English Vocabulary', 'C6D2E786-B817-400F-8C90-D643EBAD1AF8'),
			('D270B440-B472-4509-8740-FF0482E1A0FE', 'Phonetics Test', 'Test your Level of English Phonetics', 'C6D2E786-B817-400F-8C90-D643EBAD1AF8'),
			('64F52BD6-9E41-4494-9734-D53F6C33E921', 'Writting', 'Comment on the following statement', 'C6D2E786-B817-400F-8C90-D643EBAD1AF8' )

	INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question](id, [name], section_id,attachment_id,coeff_cost,criteriaid)
	VALUES 
		('BABB1C9B-8CFD-47B4-AC91-08A49CB5A0F4', 'A university degree is a must for success in the modern world.',
			'18E27AB8-D400-4B2B-837C-0832A52C7DDB', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		('CA558704-7062-47E7-9C89-13D3BE66665A', 'Many people watch soap operas because they find them enjoyable and realistic.
			 What is your opinion of soap operas?',
			'9DCD1F5D-B367-46C6-B2C6-0E7CEFD9BE73', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		('CC821FE3-3843-41E2-8581-1CA729D66578', 'Some people prefer to eat out. However, many people still like to cook meals at home.
			What is your opinion about having meals at home?',
			'5F4239DF-8B41-4138-9556-47224FEFA958', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		('E2195A0C-A352-4A92-9D14-255527DBDB32', 'The life of animals in a zoo is safer and happier than in their natural habitat.',
			'917DFF3E-74BB-4096-80CA-9EE586539A96', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		('D9272690-EF40-497C-BC3B-268313841035', 'Some people think that life-long friendship exists only in books and films. Others believe that it exists in real life.',
			'1D86FE1C-D46D-4CEC-953A-A37DA3F8DD47', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		('07D100E9-9539-4E46-A01D-2D89909E7372', 'Friendship increases in visiting friends, but in visiting them seldom.',
			 '37273045-9908-403C-A99E-A3EE2DB1D93A', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		 ('849CB381-B69B-40CB-8F42-34713F76478D', 'The best things in life are free.',
			 'BCE8D769-E34C-4E65-A9D0-BE6BE7AC70AC', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		 ('8C8E783E-FBEB-40CE-AB43-356B3985033A', 'Education polishes good natures and corrects bad ones. What is your opinion?',
			'59B6FD60-45EE-4728-A44D-CEAD9C68B0C3', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		('9A7D8CDE-62BF-4D7E-A7AD-36A5FCD75DDA', 'Some people think that in the future traditional shops will disappear and all shopping will be online with home delivery.',
			 '43451969-1EAB-4D24-92D2-D0D508AED5CC', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572'),
		 ('A8597F7C-1937-4FFC-8F55-3B9C60C34B5D', 'A popular actors life is always fun.',
			'64F52BD6-9E41-4494-9734-D53F6C33E921', NULL, 5, 'A94A62E7-2D5F-466B-8BEC-F9EA2DAB3572')

	INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question](id, [name], section_id,attachment_id,coeff_cost,criteriaid)
	VALUES 
		('93772931-80F5-4FFE-8041-3EF8683D5A15', 'I can`t imagine there is ... on earth who can answer that question.',
			'AA0C66B9-D793-461F-A03D-12BF500F723D', NULL, 2, NULL),
		('751FB23C-CE5C-4207-B63E-4065ABD8D770', 'My purse is ... in the kitchen but I`m not quite sure where.',
			'689CD199-6DF1-4DD4-B625-39E08314B2EE', NULL, 2, NULL),
		('17703D64-3A44-47D5-B9E2-41A8D8711322', 'There isn`t ... food left but there are ... drinks.',
			'F3FEEEA5-D113-4E1A-87E4-4656A6E88A77', NULL, 2, NULL),
		('D9BEE80A-FB8F-4635-BFD8-620C032B0893', 'Please give me ... interesting book to read if you have ... .',
			'D101665A-4608-488A-BB9C-4C4ABB43EBCF', NULL, 2, NULL),
		 ('44D7D2E1-6BE6-4857-BBA9-6514885B0E1E', 'Let`s go ... today as I have a splitting headache.',
			 '3E728E7C-C373-48D1-AA90-8DF9FAB3C56B', NULL, 2, NULL),
		('B6E7DBF3-8F99-40C3-A381-74D285249B56', 'He never puts ... sugar in his coffee.',
			'EBF62B06-446C-4C6A-ADE5-ACB21C246528', NULL, 2, NULL),
		('B79802E7-BA86-4840-B63B-7DA84464424F', 'Could you go to the store and buy ... milk? We don`t have ... more.',
			'E28734EC-EFB2-4F93-85C8-B9C146AD60C3', NULL, 2, NULL),
		('4C09DEE9-F6D3-4E23-9E10-800914D0B2B7', 'We got home late. We were very tired and ... went to bed at once.',
			'D7A868DE-45A9-4E50-AEFD-BB7197748DE4', NULL, 2, NULL),
		('14C3AD43-310F-4A14-AFC7-83D66857989E', 'I can`t find my watch ... . I`ve looked for it ... .',
			'0EC3FA30-1042-4721-B16F-EB6129227B63', NULL, 2, NULL),
		('887CE3F9-3670-480F-9478-8947915D196F', '"But I can`t do ... for him", - the girl told ... friend.',
			'9091712A-02FF-41CB-92C8-F9CEEB6137A8', NULL, 2, NULL)

	 INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question](id, [name], section_id,attachment_id,coeff_cost,criteriaid)
	 VALUES 
		('8E9BFA22-5044-46CB-B7D9-944A1ABAF6C9', 'It is the pride of many people never to have ... time.',
			'2DF44FF1-5923-43E3-A2F5-07CCD54D5344', NULL, 2, NULL),
		('BD47D267-D87E-44BC-AAC3-A0C444CB41DB', 'There was ... snakelike in the boy`s black eyes.',
			'EBCE2236-8031-4BD5-A33F-3910A8ADB00F', NULL, 2, NULL),
		('4F5EDF66-43AD-4752-BE67-A62291138BB6', 'I never have ... for breakfast but a cup of hot milk.',
			'B7D653CC-0A95-4CA7-8125-7884498E9DE2', NULL, 2, NULL),
		('B5BC8E87-760D-41E7-87DE-A746168D6D14', 'Can you give me ... to eat? I`m very hungry.',
			'041D1E50-0388-40CB-B582-7CD22751E05F', NULL, 2, NULL),
		('35247911-43D2-4F64-BDA6-AEE294E04FD7', 'I didn`t want to think about ... else but English.',
			'2655C0C0-1B63-4785-B248-8EDD8A4AC681', NULL, 2, NULL),
		('D25AD340-05E2-4BED-A6D6-B74593825896', 'He always looks unhappy. ... in the world can please him.',
			 'D242A797-D3A7-4CB3-9DDA-9A55C0F4A465', NULL, 2, NULL),
		('FC5932D0-3753-4E33-82AB-BF28B9959F3E', 'I went to the doctor`s yesterday and I ... for half an hour.',
			'010A58AE-EC3D-4315-AC94-C4FE387C2BFB', NULL, 2, NULL),
		('79A92418-88E8-465D-A83A-BF85161AC248', 'You ... stare at people like that; it`s impolite", - said the mother.',
			'DD636CA0-2C43-4B5D-940C-F1EFB3890631', NULL, 2, NULL),
		('5972DC7E-0CA7-4C6B-87BA-C010A033242B', 'His suggestion may be of little value, but you .. discuss it all the same.',
			'9BA5F627-4CC5-42C4-9EBE-F5ED89AC20A9', NULL, 2, NULL),
		('5FAE3B4E-0A05-4B49-81A5-008E7DD35AF0', '"It`s a shame, you devote so little time to the child. You ... give her more attention.',
			'4645C722-75A8-4E3E-8142-FB487DF8FB3A', NULL, 2, NULL)

	INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question](id, [name], section_id,attachment_id,coeff_cost,criteriaid)
	VALUES 
	('2888A418-B67F-48F3-8DEF-CA5EE4ABAEE0', 'The hard work ... have told on her health. She got ill.',
	 'E52D6825-4D8F-4009-877F-2D91D9344F1E', NULL, 2, NULL),
	 ('A460E72A-4D7A-43FA-BD9A-CADAE34B827F', 'Ann is very obedient to her parents. She ... have done anything against her father`s will.',
	 '47038CA1-B2BE-4883-9514-30579CE700BF', NULL, 2, NULL),
	 ('A253920A-D654-4256-9B6F-CD052D159FF9', 'She ... have taken a year`s leave, because her mother was seriously ill',
	 'C93E6E89-070E-4F1E-AE74-3886F08FB6F0', NULL, 2, NULL),
	 ('85AC63A1-CD7C-43BA-B851-D5662EE99B2E', 'Noone realised the letter was important so it ... have been thrown out.',
	 '631AE5B5-B597-4A37-984D-678C01A31C94', NULL, 2, NULL),
	 ('04B10469-E295-44E2-B9D8-D69F9276762B', 'He spoke so quickly that I ... hardly understand him.',
	 '75A7A036-14D5-49F5-A7D4-89D42CFC8294', NULL, 2, NULL),
	 ('25452993-F160-4D85-89B9-D84270C4DB6F', 'I see now that I ... . There was no danger whatever.',
	 '9E190C8B-1ABC-4AE1-8F4B-9F15C5EE67E0', NULL, 2, NULL),
	 ('A4953869-3354-4C31-BEB1-E7FE37E38A89', 'I can`t imagine there is ... on earth who can answer that question.',
	 'CE83DEEA-9106-4CA1-AFC2-B13DB2CCA858', NULL, 2, NULL),
	 ('80E83059-3BC9-44EA-86FF-ED1C3DAF6CCE', 'My purse is ... in the kitchen but I`m not quite sure where.',
	 '00D349DA-EFEA-4BCB-AD1B-C8DB6731BAED', NULL, 2, NULL),
	 ('548C58E9-6ECE-4BF3-9F79-FB8D07FAD1E3', 'There isn`t ... food left but there are ... drinks.',
	 'DE897AC8-E3F7-4756-B4F5-FB90C3E67615', NULL, 2, NULL),
	 ('0CF8C93B-39A1-4698-9EF9-FBC247AEB927', 'Please give me ... interesting book to read if you have ... .',
	 'D270B440-B472-4509-8740-FF0482E1A0FE', NULL,2, NULL)

	INSERT INTO [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Variative_task]
	VALUES 
		(NEWID (), '5FAE3B4E-0A05-4B49-81A5-008E7DD35AF0', 'A) anyone', 1),
		(NEWID (), '5FAE3B4E-0A05-4B49-81A5-008E7DD35AF0', 'B) nowhere', 0),
		(NEWID (), 'BABB1C9B-8CFD-47B4-AC91-08A49CB5A0F4', 'A) somewhere', 0),
		(NEWID (), 'BABB1C9B-8CFD-47B4-AC91-08A49CB5A0F4', 'B) anywhere', 1),
		(NEWID (), 'CA558704-7062-47E7-9C89-13D3BE66665A', 'B) any/some', 1),
		(NEWID (), 'CA558704-7062-47E7-9C89-13D3BE66665A', 'A) any/any', 0),
		(NEWID (), 'CC821FE3-3843-41E2-8581-1CA729D66578', 'A) any/some', 0),
		(NEWID (), 'CC821FE3-3843-41E2-8581-1CA729D66578', 'B) some/any', 1),
		(NEWID (), 'E2195A0C-A352-4A92-9D14-255527DBDB32', 'A) anyone', 1),
		(NEWID (), 'E2195A0C-A352-4A92-9D14-255527DBDB32', 'B) nowhere', 0),
		(NEWID (), 'D9272690-EF40-497C-BC3B-268313841035', 'A) somewhere', 0),
		(NEWID (), 'D9272690-EF40-497C-BC3B-268313841035', 'B) anywhere', 1),
		(NEWID (), '07D100E9-9539-4E46-A01D-2D89909E7372', 'B) any/some', 1),
		(NEWID (), '07D100E9-9539-4E46-A01D-2D89909E7372', 'A) any/any', 0),
		(NEWID (), '849CB381-B69B-40CB-8F42-34713F76478D', 'A) any/some', 0),
		(NEWID (), '849CB381-B69B-40CB-8F42-34713F76478D', 'B) some/any', 1),
		(NEWID (), '8C8E783E-FBEB-40CE-AB43-356B3985033A', 'A) anyone', 1),
		(NEWID (), '8C8E783E-FBEB-40CE-AB43-356B3985033A', 'B) nowhere', 0),
		(NEWID (), '9A7D8CDE-62BF-4D7E-A7AD-36A5FCD75DDA', 'A) somewhere', 0),
		(NEWID (), '9A7D8CDE-62BF-4D7E-A7AD-36A5FCD75DDA', 'B) anywhere', 1),
		(NEWID (), 'A8597F7C-1937-4FFC-8F55-3B9C60C34B5D', 'B) any/some', 1),
		(NEWID (), 'A8597F7C-1937-4FFC-8F55-3B9C60C34B5D', 'A) any/any', 0),
		(NEWID (), '93772931-80F5-4FFE-8041-3EF8683D5A15', 'A) any/some', 0),
		(NEWID (), '93772931-80F5-4FFE-8041-3EF8683D5A15', 'B) some/any', 1),
		(NEWID (), '751FB23C-CE5C-4207-B63E-4065ABD8D770', 'A) anyone', 1),
		(NEWID (), '751FB23C-CE5C-4207-B63E-4065ABD8D770', 'B) nowhere', 0),
		(NEWID (), '17703D64-3A44-47D5-B9E2-41A8D8711322', 'A) somewhere', 0),
		(NEWID (), '17703D64-3A44-47D5-B9E2-41A8D8711322', 'B) anywhere', 1),
		(NEWID (), 'D9BEE80A-FB8F-4635-BFD8-620C032B0893', 'B) any/some', 1),
		(NEWID (), 'D9BEE80A-FB8F-4635-BFD8-620C032B0893', 'A) any/any', 0),
		(NEWID (), '44D7D2E1-6BE6-4857-BBA9-6514885B0E1E', 'A) any/some', 0),
		(NEWID (), '44D7D2E1-6BE6-4857-BBA9-6514885B0E1E', 'B) some/any', 1),
		(NEWID (), 'B6E7DBF3-8F99-40C3-A381-74D285249B56', 'A) anyone', 1),
		(NEWID (), 'B6E7DBF3-8F99-40C3-A381-74D285249B56', 'B) nowhere', 0),
		(NEWID (), 'B79802E7-BA86-4840-B63B-7DA84464424F', 'A) somewhere', 0),
		(NEWID (), 'B79802E7-BA86-4840-B63B-7DA84464424F', 'B) anywhere', 1),
		(NEWID (), '4C09DEE9-F6D3-4E23-9E10-800914D0B2B7', 'B) any/some', 1),
		(NEWID (), '4C09DEE9-F6D3-4E23-9E10-800914D0B2B7', 'A) any/any', 0),
		(NEWID (), '14C3AD43-310F-4A14-AFC7-83D66857989E', 'A) any/some', 0),
		(NEWID (), '14C3AD43-310F-4A14-AFC7-83D66857989E', 'B) some/any', 1),
		(NEWID (), '887CE3F9-3670-480F-9478-8947915D196F', 'A) anyone', 1),
		(NEWID (), '887CE3F9-3670-480F-9478-8947915D196F', 'B) nowhere', 0),
		(NEWID (), '8E9BFA22-5044-46CB-B7D9-944A1ABAF6C9', 'A) somewhere', 0),
		(NEWID (), '8E9BFA22-5044-46CB-B7D9-944A1ABAF6C9', 'B) anywhere', 1),
		(NEWID (), 'BD47D267-D87E-44BC-AAC3-A0C444CB41DB', 'B) any/some', 1),
		(NEWID (), 'BD47D267-D87E-44BC-AAC3-A0C444CB41DB', 'A) any/any', 0),
		(NEWID (), '4F5EDF66-43AD-4752-BE67-A62291138BB6', 'A) any/some', 0),
		(NEWID (), '4F5EDF66-43AD-4752-BE67-A62291138BB6', 'B) some/any', 1),
		(NEWID (), 'B5BC8E87-760D-41E7-87DE-A746168D6D14', 'A) anyone', 1),
		(NEWID (), 'B5BC8E87-760D-41E7-87DE-A746168D6D14', 'B) nowhere', 0),
		(NEWID (), '35247911-43D2-4F64-BDA6-AEE294E04FD7', 'A) somewhere', 0),
		(NEWID (), '35247911-43D2-4F64-BDA6-AEE294E04FD7', 'B) anywhere', 1),
		(NEWID (), 'D25AD340-05E2-4BED-A6D6-B74593825896', 'B) any/some', 1),
		(NEWID (), 'D25AD340-05E2-4BED-A6D6-B74593825896', 'A) any/any', 0),
		(NEWID (), 'FC5932D0-3753-4E33-82AB-BF28B9959F3E', 'A) any/some', 0),
		(NEWID (), 'FC5932D0-3753-4E33-82AB-BF28B9959F3E', 'B) some/any', 1),
		(NEWID (), '79A92418-88E8-465D-A83A-BF85161AC248', 'A) anyone', 1),
		(NEWID (), '79A92418-88E8-465D-A83A-BF85161AC248', 'B) nowhere', 0),
		(NEWID (), '5972DC7E-0CA7-4C6B-87BA-C010A033242B', 'A) somewhere', 0),
		(NEWID (), '5972DC7E-0CA7-4C6B-87BA-C010A033242B', 'B) anywhere', 1),
		(NEWID (), '2888A418-B67F-48F3-8DEF-CA5EE4ABAEE0', 'B) any/some', 1),
		(NEWID (), '2888A418-B67F-48F3-8DEF-CA5EE4ABAEE0', 'A) any/any', 0),
		(NEWID (), 'A460E72A-4D7A-43FA-BD9A-CADAE34B827F', 'A) any/some', 0),
		(NEWID (), 'A460E72A-4D7A-43FA-BD9A-CADAE34B827F', 'B) some/any', 1),
		(NEWID (), 'A253920A-D654-4256-9B6F-CD052D159FF9', 'A) anyone', 1),
		(NEWID (), 'A253920A-D654-4256-9B6F-CD052D159FF9', 'B) nowhere', 0),
		(NEWID (), '85AC63A1-CD7C-43BA-B851-D5662EE99B2E', 'A) somewhere', 0),
		(NEWID (), '85AC63A1-CD7C-43BA-B851-D5662EE99B2E', 'B) anywhere', 1),
		(NEWID (), '04B10469-E295-44E2-B9D8-D69F9276762B', 'B) any/some', 1),
		(NEWID (), '04B10469-E295-44E2-B9D8-D69F9276762B', 'A) any/any', 0),
		(NEWID (), '25452993-F160-4D85-89B9-D84270C4DB6F', 'A) any/some', 0),
		(NEWID (), '25452993-F160-4D85-89B9-D84270C4DB6F', 'B) some/any', 1),
		(NEWID (), 'A4953869-3354-4C31-BEB1-E7FE37E38A89', 'A) anyone', 1),
		(NEWID (), 'A4953869-3354-4C31-BEB1-E7FE37E38A89', 'B) nowhere', 0),
		(NEWID (), '80E83059-3BC9-44EA-86FF-ED1C3DAF6CCE', 'A) somewhere', 0),
		(NEWID (), '80E83059-3BC9-44EA-86FF-ED1C3DAF6CCE', 'B) anywhere', 1),
		(NEWID (), '548C58E9-6ECE-4BF3-9F79-FB8D07FAD1E3', 'B) any/some', 1),
		(NEWID (), '548C58E9-6ECE-4BF3-9F79-FB8D07FAD1E3', 'A) any/any', 0),
		(NEWID (), '0CF8C93B-39A1-4698-9EF9-FBC247AEB927', 'A) any/some', 0),
		(NEWID (), '0CF8C93B-39A1-4698-9EF9-FBC247AEB927', 'B) some/any', 1)

	COMMIT TRAN

	END TRY

	BEGIN CATCH
				
		IF (@@TRANCOUNT > 0)           
			ROLLBACK TRAN
		SET @errorMessage = ERROR_MESSAGE() + 'Строк обработано:' + @@ROWCOUNT;		

		THROW 51000, @errorMessage, 1	

	END CATCH
	
	    
END
GO
/****** Object:  StoredProcedure [dbo].[up_GenerateUserDataRemote]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_GenerateUserDataRemote]
	
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('E2FCB4DD-2F67-129E-3781-86D7C82D6595','Haviva J. Chandler','41E65243-BCE5-4583-B652-3702702B4C46'),
	('1AF13CB1-6094-195E-C449-B2F1E9176A8C','Ryan M. Miles','F9B5BE21-8A89-4E87-9FD3-6FFA0A6B5AD9'),
	('4A946346-3EB5-9D97-35F3-2520DF8A807B','Carson Q. Terry','F9B5BE21-8A89-4E87-9FD3-6FFA0A6B5AD9'),
	('23CDF22B-21CF-430C-F379-C3E8F81AEEB4','Jelani X. Duncan','F18067AC-427C-4238-83E9-F13B62D397AC'),
	('195300C1-3B26-1396-5E5C-33A3EE4EF3AB','Brady Z. Myers','6CA6D949-CE51-4229-892D-44824E95CDAE'),
	('706B09D6-3EBA-3956-D614-7B0623467631','Faith B. Thornton','EF004DAA-FF6F-41B2-B984-96A3981EF56C'),
	('3C613E17-B308-D178-D736-CDB2954AEAE7','Amaya H. Stanley','59443147-3835-45D2-9DBC-D79291C2C4A8'),
	('67502A30-7472-C0F6-707D-ED22E7B538F1','Eaton R. Snow','6B9B0827-6261-4EC2-84B5-912436787A43'),
	('6874FB6E-9033-9AEB-1B2B-1C5B09179B0B','Claire V. Carter','C966EF66-858D-4557-A4F8-AF5C69E3C5D5'),
	('97BAF3B3-96E1-41A9-33FE-4F87AC0881F9','Illana X. Vance','84012F8A-63C2-4921-8B02-05429EB075F1');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id]) 
	VALUES('9723B46A-6FF8-AAFC-FD11-B6611B6D0932','Kerry K. Odom','6212167F-AD26-4987-B78E-08E26B74759F'),
	('673D848A-E332-D7C2-1156-C4B606A112DE','Hunter C. Sexton','2B699CFC-DEA5-46A4-8A85-A957112249D4'),
	('82060D57-8A5B-5C1E-FED9-211408A6E7BE','Josiah J. Barlow','596A0E1D-29B4-4B0D-81FA-3D6BBBC4FD34'),
	('5D83565E-A253-7B54-FCAC-9685428395FA','Blake J. Massey','796A8AAC-E2AD-4D77-8F88-848ECD0594F2'),
	('4B096C6C-139E-1B2A-E0E6-FA2061EFBC2D','Oscar A. Craig','3F2FEB4F-282C-471A-ABC8-7C2C123F6A0F'),
	('F630A1A6-5EC4-9F87-4FF6-7EAA1A88B57D','Lyle E. Burt','B18A6F84-ED3B-49D5-AF18-265F2257B298'),
	('EF1E10E7-088F-F7A3-66A9-C34D99983A62','Gabriel D. Banks','FB7F4A01-41F7-4375-9CED-A4A9D9882ACD'),
	('49112169-4553-4E64-B5BC-2B919A3A3EE2','Phelan R. Booker','CD8DDE98-5AEE-4C9F-BE5A-4408C1861346'),
	('F62E0D0B-8314-6A79-C17C-8D329EEE249F','Larissa P. Randall','776E13F3-E5A0-497A-836B-EF74787C25A3'),
	('C53B749D-B7B7-13F6-57DD-589B2C278043','Xena O. Curtis','11E7FDDF-34B9-4C1F-B38C-4D164324E762');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('765AAA40-A80F-4FA2-461F-8A99439DF861','Irma Z. Byrd','B8AAFC26-03CF-46A9-AD9E-64CBF5CBF70C'),
	('91B933E6-CB55-055D-EA20-36A24D100529','Peter P. Maddox','238C4741-C97E-42D7-B4FB-B344ECC8370A'),
	('509CF12A-AC26-B221-6F50-3701C3F73834','Claire I. Silva','4577EEFE-EF95-4770-9939-D83CDA1526F7'),
	('CFE01182-33BB-6CC2-3A63-6CC4EE6DFE1B','Ciaran K. Nielsen','A31C8AD6-AD5A-47A5-BF3A-E2D749CF6042'),
	('823A0813-E473-50EE-500B-306E471A3D38','Samantha V. Stevens','B391A18D-98A9-4BCD-8EE5-7637794360A9'),
	('AFFC5E84-003E-09AD-5D7B-85A709844D58','Forrest B. Mcclain','71FC8B61-E282-4463-B61C-8D0F0FF93BF4'),
	('694CD54B-304D-4B7E-D2F9-FA6629F5C01D','Trevor J. Beach','9B336C91-650B-4242-A8A5-238CE4FA089D'),
	('D75EB152-EEC6-1302-DCB3-934C10D4DB62','Elizabeth Q. Wright','DBF4513D-FD73-4C48-8182-8A56FC597A83'),
	('F58E3B54-C9F9-62C8-2B02-4C19CBE27621','Yetta U. Miles','14AEA444-3290-4B66-8546-80BB16C9C9D0'),
	('7ABF51F4-0CA2-9ABF-E23C-703C9CD99645','Freya P. Guerra','8250104E-7E17-4D7D-A93D-B609029154AB');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id]) 
	VALUES('B18223A9-A06D-5448-34F0-C357919EEF06','Daquan B. Mcfadden','ED8FE115-1277-4091-9F8B-2F3A1195A398'),
	('3BD27EA6-E6F2-6109-B3D3-8F5D728C8855','Bo M. Savage','80ED033A-EDEA-49DF-8244-AF325CDC2A1E'),
	('434578C4-C08B-A56B-03D5-9272E10B4F23','Linus V. Gibson','68AEB4BA-E6A7-4B68-8ED0-AFDCE2E6BBEF'),
	('6132E573-A9DD-7D2F-5C4B-E3E4F77BE5D1','Amena Z. Shields','6A191EDB-B2AB-40DE-95E5-6AFD6DB7CAA8'),
	('736A3E19-BB74-9A80-6C0F-FB3ECA53E541','Audra B. Hurst','A273CD86-59A2-4D99-8FD5-4214B477FB5A'),
	('44BAC532-E804-C1FF-71D1-301501CD29AE','Elaine J. Beck','6F8424C6-78B3-4EB8-BF96-54100CBD9533'),
	('BD2DBE73-C031-78B7-23FF-0AEF21483453','Cheyenne G. Hardy','90897778-C195-4C90-BD37-A0A2072D78C9'),
	('46D68FAE-B7B1-CC6B-065D-B8C644B997C5','Fritz C. Fox','70DF101C-B8EB-4B35-B2EB-03D446381A7A'),
	('DDE4BFD9-0ECE-99DE-1851-74BABF09B7BB','Shad J. Hinton','2221DFF0-B1AF-457A-9258-1398970D654A'),
	('3E4D4D21-51C2-4BBF-4A31-8E8C07D75494','Thor Q. Schwartz','AA97129C-8417-458D-9775-95FD55137796');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('BB7F6AF8-23E4-CE9D-B5F3-701F7EE37789','Lionel Y. Hansen','D7A49875-CC07-456A-8B60-E9BF0A3846AD'),
	 ('CE98A587-C332-2CC4-FEEA-4B344A3499DC','Arden E. Gomez','95016C9F-C3EA-4BB2-BEC9-5BE285BB9841'),
	 ('4852FAA9-D5C7-512A-591C-2763105C080C','Irene U. Mathews','709605BA-96D5-401B-ADE3-B31575CAC75E'),
	 ('291BA383-4566-BC1C-0545-4A7454CA4AA8','Dylan M. Clark','0CA16B61-1E2B-4110-8BBA-9D7B9F08B328'),
	 ('FC4289E6-0800-343D-9E37-6AD40C8DCBF9','Macon Z. Swanson','59095D17-BAFE-4D6B-A72C-32E3428BB7F4'),
	 ('42C5D440-2963-FAB4-2225-B9F81F79B500','Shelly Y. Brooks','58755E7B-564E-48E6-8767-A346A7508C14'),
	 ('30E714EF-D51C-1BB0-84ED-414BC627670D','Jamal M. Duffy','EB16BD09-BBBD-499F-9AD9-854A5680F05B'),
	 ('73C613C9-A658-A829-57A0-0D665146E6E6','Louis C. Carroll','5F522D21-1DDD-4468-B82C-57A90ABB9C1F'),
	 ('25951C0E-FB8A-501D-97E6-FD601129D51C','Todd M. Odonnell','AC12D151-BC78-4722-92C3-17CF2B6CD3E6'),
	 ('F6283C0E-9E4F-4AA2-D9C4-6724E55FDD68','Edan J. Contreras','DAC66D61-EBB1-4A8B-93BF-133842A26B5E');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('FD9B94DA-F264-71CB-23B3-86592DD9F183','Nathan N. Short','A7C5FE7B-430B-49DF-B868-D08A22EB5112'),
	 ('2100BD03-57D7-D31D-BC2B-225BACAEFC93','Hanna W. Garcia','78562C6A-E261-4FC9-94D7-AF4BE4352473'),
	 ('96610296-F2D1-222A-2BF7-7D4883D60C0E','Flynn S. Wilkinson','53BAD815-E04D-4A2A-82AC-4D37A0238572'),
	 ('234FCBE8-55E2-3529-B426-AEBFBF6F323D','Chadwick V. Fuller','8AA4F828-E904-4BAC-9793-6FCA8B1D8F35'),
	 ('5A727926-FCE3-A31D-3CE7-10C1CA64F001','Octavius Y. Berger','5B252DCD-859A-49B2-9B48-23C160322291'),
	 ('193CBE24-7914-BAA0-6352-870C3F560E84','Quemby S. Bowman','B9929F51-DD2C-42AC-BCEE-E8B44BFA2A41'),
	 ('D5357C75-4B77-6066-770F-D1F7562CA192','Jesse A. Franklin','5E55ABBA-FE03-49D1-98BC-7997627F014C'),
	 ('4C155BB9-4400-2DE9-FBC5-53D9179B37F6','Erin W. Buchanan','D91526C0-1E5D-4D03-BDB2-86FB1B0177D1'),
	 ('5681D222-2963-7B34-ED84-878714339AED','Nissim H. Hardin','2A3FD826-31E6-4FB9-B49E-0EB15A0791A5'),
	 ('1311B057-5D2E-6202-451F-252178369D4E','Ian C. Whitaker','EABAD042-4F65-4985-9E5B-FE6D8B8D4210');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('0F7FC6AD-CE86-79FF-E925-2FEE65B139EA','Amelia A. Lowe','5265D6A9-C728-43F8-85E0-71F4A24EDF3F'),
	 ('EDB55D54-A4E8-7937-1338-F09AE360E156','Fuller R. Powers','334E0C95-9263-4461-B779-F6BE7470C282'),
	 ('18FF1CE4-E05B-5532-C5AE-7D495591C8D3','Moana I. Drake','7BD57AAE-D6D9-404A-BB1D-6911A2CFAD66'),
	 ('6E356F27-FEBD-FA59-2E21-1A512C7EC047','Zachery R. Williamson','641E41FF-1AA0-4ECC-A3F0-0EE0F7FF89A2'),
	 ('915B2559-F13C-B48C-4B7E-47ECC21F38BD','Jade W. Crawford','CEEA532F-245A-4546-A8C2-12BEB13FAC69'),
	 ('C0904395-E29E-7782-27D0-A84CEC3A25A8','Gloria R. Head','B725C558-F3B0-4F3B-BEB9-8C5C8EB4A0F3'),
	 ('C31576E8-9378-7960-BBB1-3B4BA8704803','Lucas U. Hansen','4DF8AE45-E4B9-40FD-8D9E-0DDD364D7C78'),
	 ('B913C321-AF35-DF52-FD8E-DC7F9864F8F7','Kiona N. Ramsey','EC1C3F1B-7D35-4DED-ABE5-B3CDF3ACE2B1'),
	 ('4D367478-2C35-5E8B-ACEB-8AA6176FFAB4','Brent X. Pugh','F8DA99D3-72F5-4F9F-A0F0-7994A87E52D2'),
	 ('47FEBC5A-0F41-15CB-FCAE-A2DC1A642594','Jordan O. Gross','8A729387-6DF1-433C-9FFC-26230EE62BF7');
    INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('37713F12-310C-D77C-885F-03BC98A5EFBA','Quinn M. Riddle','DF26D9EA-3E18-4C80-85FF-7A05FB094C61'),
	 ('94E93621-8DCE-BD42-4EAF-B588A04E3487','Herrod Z. Mercado','1B519EDE-EFCD-45DA-80F9-B981DF0C7CB2'),
	 ('D064AE57-C7EA-F5A5-9BFB-E4F3DE8C57A0','Lester W. Glass','0DAE6CF2-B7D7-4626-BA7D-B8E2AE1C1AF6'),
	 ('5B69647C-898D-ECF5-EEC6-0D0F6E64FA8D','Eve V. Foley','EF9B3E47-E111-4868-A9C3-8973B6DC7F40'),
	 ('08883000-37A4-0F88-8DD5-5CE04DC89FA3','Macy Y. Tanner','05B468E8-2714-42E1-BA21-4F36B4879791'),
	 ('002DF6A2-0236-94CC-CF91-3A0A4E38EA6C','Donovan A. Burgess','5DAC8D2E-C852-4F05-8CC3-606C877038ED'),
	 ('DE612145-ADA1-C414-3D87-F2EA7BE4C8AF','Sandra Z. Hudson','EAAACF77-CD3D-4E0C-BEAE-A939728BACEE'),
	 ('A1C5329A-1587-CAF3-C07E-D908E164FBA4','Ori I. Burgess','16F9DB3F-A8A6-4119-B23A-64F762135BC0'),
	 ('95B3C7BE-453F-F352-9108-E9A0916E812F','Herman K. Knapp','07A58BA8-F1F4-489A-A494-4102609E4C3A'),
	 ('025E0A23-D6ED-C6B1-9602-0E9F8AFDE41A','Sonya Y. Mason','24FDC05D-D855-42DD-BF9C-7A9ED946E92A');
	 INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('37713F12-310C-D77C-885F-03BC98A5EFBA','Quinn M. Riddle','540B3FC2-A908-488A-9764-9A64ED41F38D'),
	 ('94E93621-8DCE-BD42-4EAF-B588A04E3487','Herrod Z. Mercado','4809C019-8CF0-4D1A-BA99-69EB05D20786'),
	 ('D064AE57-C7EA-F5A5-9BFB-E4F3DE8C57A0','Lester W. Glass','BC642512-E362-4ACE-9575-19282554664D'),
	 ('5B69647C-898D-ECF5-EEC6-0D0F6E64FA8D','Eve V. Foley','7C0EB52A-2915-4E90-85C3-3C3BBCF3DA31'),
	 ('08883000-37A4-0F88-8DD5-5CE04DC89FA3','Macy Y. Tanner','7823BB4D-2947-420C-BF9A-FFC4E92CC980'),
	 ('002DF6A2-0236-94CC-CF91-3A0A4E38EA6C','Donovan A. Burgess','AD88166C-F072-4641-B33A-735A3B700494'),
	 ('DE612145-ADA1-C414-3D87-F2EA7BE4C8AF','Sandra Z. Hudson','2A976166-489A-4609-A8E6-EA333F08BD77'),
	 ('A1C5329A-1587-CAF3-C07E-D908E164FBA4','Ori I. Burgess','AD88166C-F072-4641-B33A-735A3B700494'),
	 ('95B3C7BE-453F-F352-9108-E9A0916E812F','Herman K. Knapp','33E0BD02-D33C-4D2F-AEAC-6F325791C349'),
	 ('025E0A23-D6ED-C6B1-9602-0E9F8AFDE41A','Sonya Y. Mason','9B2B4EB3-86C7-47F7-A85E-7D92C2B38834');
	 INSERT INTO [dbo].[User]([id],[fullname],[registration_region_id])
	 VALUES('37713F12-310C-D77C-885F-03BC98A5EFBA','Quinn M. Riddle','99928EF9-C333-47B5-910B-62D0EEB5EC0D'),
	 ('94E93621-8DCE-BD42-4EAF-B588A04E3487','Herrod Z. Mercado','910AA59D-B65A-4C54-A40D-6E13A4B2A62E'),
	 ('D064AE57-C7EA-F5A5-9BFB-E4F3DE8C57A0','Lester W. Glass','5A8A053C-FBF5-4D77-B873-B57429709899'),
	 ('5B69647C-898D-ECF5-EEC6-0D0F6E64FA8D','Eve V. Foley','992B8611-9235-468D-83D1-246BEA41B398'),
	 ('08883000-37A4-0F88-8DD5-5CE04DC89FA3','Macy Y. Tanner','33D1BEF5-B7CA-41AE-B640-AEDF142BAC27'),
	 ('002DF6A2-0236-94CC-CF91-3A0A4E38EA6C','Donovan A. Burgess','AFFF8705-77DF-4883-AE21-C31CFAA01AF9'),
	 ('DE612145-ADA1-C414-3D87-F2EA7BE4C8AF','Sandra Z. Hudson','B1F61ABF-27F3-46A9-89C8-2BA4CD388136'),
	 ('A1C5329A-1587-CAF3-C07E-D908E164FBA4','Ori I. Burgess','CC03FE7A-1214-4692-9600-55B01EF11365'),
	 ('95B3C7BE-453F-F352-9108-E9A0916E812F','Herman K. Knapp','43122DAC-50EC-433E-A7B1-356098A9DF5F'),
	 ('025E0A23-D6ED-C6B1-9602-0E9F8AFDE41A','Sonya Y. Mason','1BC341BB-F3C6-4D23-8424-3E6000ABFF5D');

END

GO
/****** Object:  StoredProcedure [dbo].[up_TestUpdateRemote]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_TestUpdateRemote] 
(
	@questionId uniqueidentifier,
	@name nvarchar(255)
)
AS
BEGIN
	
	SET NOCOUNT ON;

    IF (EXISTS (SELECT TOP 1 1 FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question] WITH(NOLOCK) WHERE id = @questionId))
		UPDATE [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Question] SET name = @name WHERE id = @questionId
	ELSE
		THROW 51000, 'Такой вопрос не зарегистрирован', 1
END
GO
/****** Object:  StoredProcedure [dbo].[up_UpdateUserRole]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_UpdateUserRole]
(
	@userId uniqueidentifier,
	@roleId uniqueidentifier,
	@newRoleId uniqueidentifier
)
AS
BEGIN

	SET NOCOUNT ON;

	-- Если существует пользователь - @userId и имеются роли - @roleId и @newRoleId
	IF (EXISTS (SELECT TOP 1 1 FROM [dbo].[User] WITH(NOLOCK) WHERE id = @userId)) AND 
	   (EXISTS (SELECT TOP 1 1 FROM [dbo].[Roles] WITH(NOLOCK) WHERE id = @roleId)) AND
	   (EXISTS (SELECT TOP 1 1 FROM [dbo].[Roles] WITH(NOLOCK) WHERE id = @newRoleId))
			 
			UPDATE [dbo].[User_Role] SET role_id = @newRoleId WHERE [user_id] = @userId  
						
	ELSE 

		THROW 51000, 'Пользовтаель или роль не существует.', 1
END
GO
/****** Object:  StoredProcedure [dbo].[up_VariativeTaskRemote]    Script Date: 26.05.2018 4:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_VariativeTaskRemote]
	(
	@variativeTaskId uniqueidentifier,
	@answer_variant nvarchar(255)
	
)
AS
BEGIN
	
	SET NOCOUNT ON;

    IF (EXISTS (SELECT TOP 1 1 FROM [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Variative_task] WITH(NOLOCK) WHERE id = @variativeTaskId))
		UPDATE [KATRIN-WIN8\HOME].[EnglishTestDb].[dbo].[Variative_Task] SET answer_variant = @answer_variant WHERE id = @variativeTaskId
	ELSE
		THROW 51000, 'Такой вопрос не зарегистрирован', 1
END
GO
