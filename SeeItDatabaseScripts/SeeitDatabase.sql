/*Check to see if the database exists, and if so, drop the table and re-create*/
IF EXISTS(SELECT 1 FROM master.dbo.sysdatabases WHERE name='SeeItDatabase')
BEGIN
DROP DATABASE SeeItDatabase
END
GO

CREATE DATABASE SeeItDatabase
GO

USE [SeeItDatabase]
GO

/* OBJECT: TABLE [dbo].[Posts] */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Posts]
(
	[PostId]			[INT]				NOT NULL		IDENTITY(1,1),
	[Description]		[VARCHAR](35)		NOT NULL,
	[Details]			[VARCHAR](1000)		NOT NULL,
	[DateCreated]		[DATETIME]			NOT NULL		DEFAULT SYSDATETIME(),
	[UserId]			[VARCHAR](35)		NOT NULL,
	[CategoryId]		[INT]				NOT NULL,
	[Removed]			[BIT]				NOT NULL		DEFAULT(0)
) 	ON [PRIMARY]
GO

ALTER TABLE [dbo].[Posts]
	ADD CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED ([PostId] ASC)
	WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF,IGNORE_DUP_KEY=OFF,ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
GO

/* OBJECT: TABLE [dbo].[Categories] */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId]		[INT]				NOT NULL		IDENTITY(1,1),
	[Name]				[VARCHAR](35)		NOT NULL,
	[Description]		[VARCHAR](500)		NULL,
	[DateCreated]		[DATETIME]			NOT NULL		DEFAULT SYSDATETIME(),
	[UserId]			[VARCHAR](35)		NOT NULL,
	[Removed]			[BIT]				NOT NULL		DEFAULT(0)
) 	ON [PRIMARY]
GO

ALTER TABLE [dbo].[Categories]
	ADD CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
	WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF,IGNORE_DUP_KEY=OFF,ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
GO

/* OBJECT: TABLE [dbo].[Favorites] */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Favorites](
	[PostId]			[INT]				NOT NULL,
	[UserId]			[VARCHAR](35)		NOT NULL,
	[DateFavorited]		[DATETIME]			NOT NULL		DEFAULT SYSDATETIME()
) 	ON [PRIMARY]
GO

ALTER TABLE [dbo].[Favorites]
	ADD CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED ([PostId] ASC, [UserId] ASC) 
	WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF,IGNORE_DUP_KEY=OFF,ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
GO

/* OBJECT: TABLE [dbo].[Comments] */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentId]			[INT]				NOT NULL		IDENTITY(1,1),
	[Comment]			[VARCHAR](500)		NOT NULL,
	[PostId]			[INT]				NOT NULL,
	[UserId]			[VARCHAR](35)		NOT NULL,
	[ParentCommentId]	[INT]				NULL,
	[DateCreated]		[DATETIME]			NOT NULL		DEFAULT SYSDATETIME(),
	[UnderModeration]	[BIT]				NOT NULL		DEFAULT(0),
	[Removed]			[BIT]				NOT NULL		DEFAULT(0)
) 	ON [PRIMARY]
GO

ALTER TABLE [dbo].[Comments]
	ADD CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([CommentId] ASC) 
	WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF,IGNORE_DUP_KEY=OFF,ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
GO

/*Foreign Key Constraints*/
ALTER TABLE [dbo].[Posts] WITH NOCHECK
    ADD CONSTRAINT [FK_Posts.CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Favorites] WITH NOCHECK
    ADD CONSTRAINT [FK_Favorites.PostId] FOREIGN KEY ([PostId]) REFERENCES [dbo].[Posts] ([PostId]) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[Comments] WITH NOCHECK
    ADD CONSTRAINT [FK_Comments.PostId] FOREIGN KEY ([PostId]) REFERENCES [dbo].[Posts] ([PostId]) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

/*StoredProcedures*/
CREATE PROCEDURE [proc_GetAllPosts]
AS
	SELECT * FROM [dbo].[Posts]
	WHERE [Removed] = 0
	ORDER BY [DateCreated] DESC
GO

CREATE PROCEDURE [proc_GetPostsByCategory]
	(@CategoryId	[INT])
AS
	SELECT * FROM [dbo].[Posts]
	WHERE [CategoryId] = @CategoryId
	AND [Removed] = 0
	ORDER BY [DateCreated] DESC
GO

CREATE PROCEDURE [proc_GetRemovedPosts]
AS
	SELECT * FROM [dbo].[Posts]
	WHERE [Removed] = 1
	ORDER BY [DateCreated] DESC
GO

CREATE PROCEDURE [proc_GetPostsByUser]
	(@UserId	[VARCHAR](35))
AS
	SELECT * FROM [dbo].[Posts]
	WHERE [UserId] = @UserId
	AND [Removed] = 0
	ORDER BY [DateCreated] DESC
GO

CREATE PROCEDURE [proc_UpdatePost]
	(@Description			[VARCHAR](35),
	@Details				[VARCHAR](2500),
	@UserId					[VARCHAR](35),
	@CategoryId				[INT],
	@Removed				[BIT],
	@OriginalPostId			[INT],
	@OriginalDescription	[VARCHAR](35),
	@OriginalDetails		[VARCHAR](1000),
	@OriginalDateCreated	[DATETIME],
	@OriginalUserId			[VARCHAR](35),
	@OriginalCategoryId		[INT],
	@OriginalRemoved		[BIT])
AS
	UPDATE [dbo].[Posts]
	SET [Description] = @Description,
		[Details] = @Details,
		[CategoryId] = @CategoryId,
		[Removed] = @Removed
	WHERE [PostId] = @OriginalPostId
	AND [Description] = @OriginalDescription
	AND [Details] = @OriginalDetails
--	AND [DateCreated] = @OriginalDateCreated
	AND [UserId] = @OriginalUserId
	AND [CategoryId] = @OriginalCategoryId
	AND [Removed] = @OriginalRemoved
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_InsertPost]
	(@Description			[VARCHAR](35),
	@Details				[VARCHAR](1000),
	@UserId					[VARCHAR](35),
	@CategoryId				[INT])
AS
	INSERT INTO [dbo].[Posts]
		([Description],[Details],[UserId],[CategoryId])
	VALUES
		(@Description, @Details, @UserId, @CategoryId)
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_RemovePost]
	(@PostId				[INT])
AS
	UPDATE [dbo].[Posts]
	SET [Removed] = 1
	WHERE [PostId] = @PostId
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_RevertRemovePost]
	(@PostId				[INT])
AS
	UPDATE [dbo].[Posts]
	SET [Removed] = 0
	WHERE [PostId] = @PostId
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_GetAllCategories]
AS
	SELECT * FROM [Categories]
	ORDER BY [Name]
GO

CREATE PROCEDURE [proc_InsertCategory]
	(@Name					[VARCHAR](35),
	@Description			[VARCHAR](500),
	@UserId					[VARCHAR](35))
AS
	INSERT INTO [dbo].[Categories]
		([Name], [Description], [UserId])
	VALUES
		(@Name, @Description, @UserId)
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_UpdateCategory]
	(@Name					[VARCHAR](35),
	@Description			[VARCHAR](500),
	@UserId					[VARCHAR](35),
	@Removed				[BIT],
	@OriginalCategoryId		[INT],
	@OriginalName			[VARCHAR](35),
	@OriginalDescription	[VARCHAR](500),
	@DateCreated			[DATETIME],
	@OriginalUserId			[VARCHAR](35),
	@OriginalRemoved		[BIT])
AS 
	UPDATE [dbo].[Categories]
	SET [Name] = @Name,
		[Description] = @Description,
		[UserId] = @UserId,
		[Removed] = @Removed
	WHERE [CategoryId] = @OriginalCategoryId
	AND [Name] = @OriginalName
	AND [Description] = @OriginalDescription
--	AND [DateCreated] = @OriginalDateCreated
	AND [UserId] = @OriginalUserId
	AND [Removed] = @OriginalRemoved
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_RemoveCategory]
	(@CategoryId			[INT])
AS
	UPDATE [dbo].[Categories]
	SET [Removed] = 1
	WHERE [CategoryId] = @CategoryId
RETURN @@ROWCOUNT
GO

CREATE PROCEDURE [proc_GetFavoritesByUser]
	(@UserId				[VARCHAR](35))
AS
	SELECT * FROM [dbo].[Posts]
	WHERE [PostId] IN
	(SELECT [PostId] FROM [dbo].[Favorites]
	WHERE [UserId] = @UserId)
	ORDER BY [DateCreated] DESC
GO

CREATE PROCEDURE [proc_InsertFavorite]
	(@PostId 				[INT],
	@UserId					[VARCHAR](35))
AS
	INSERT INTO [dbo].[Favorites]
		([PostId],[UserId])
	VALUES
		(@PostId, @UserId)
GO

CREATE PROCEDURE [proc_RemoveFavorite]
	(@PostId				[INT])
AS
	DELETE FROM [dbo].[Favorites]
	WHERE [PostId] = @PostId
RETURN @@ROWCOUNT
GO

/*SAMPLE DATA*/
/*Categories*/
INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('Video Games', 'Category for general video game content.', 'Administrator')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('Xbox One', 'Category for xbox one game content.', 'VagrantWade')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('Playstation 4', 'Category for playstation 4 game content', 'BroknOath')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('PC', 'Category for pc game content', 'Administrator')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('Funny', 'Category for funny content.', 'StandardUser')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('Sports', 'Category for sports content.', 'Administrator')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('NBA', 'Category for nba sport content.', 'Kdubwend33')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('NFL', 'Category for nfl sport content.', 'MiikeLaowrey')
GO

INSERT INTO [dbo].[Categories]
	([Name],[Description],[UserId])
VALUES
	('MLB', 'Category for mlb sport content.', 'VagrantWade')
GO

/*Posts*/
INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Sunset Overdrive Updates', 'Sunset Overdrive is an open-world third-person action game-slash-shooter with a heavy emphasis on traversal, and its designed around a brilliant premise. Co-creators Marcus Smith and Drew Murray -- who last collaborated on the Resistance franchise -- have again gone into the realm of the post-apocalyptic, but theres a major, significant twist. In the year 2027, society begins to crumble, but its not all bad. In fact, Sunset Overdrives dystopian future is good. Instead of gloom and doom and the world is over, and now I have to figure out how Im going to eat, Smith said during his presentation, [all of that] is replaced with fun in the end times.', 'VagrantWade', 2)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Evolve', 'Evolve is a multiplayer, first-person shooting sci-fi adventure from Turtle Rock Studios, the designers of Left 4 Dead', 'Kdubwend33', 2)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Dragon Age 3 Plot details', 'Previous leaked information has revealed some plot details: The empire of Orlais is riven by civil war; the Chantry is divided; the Templar order has broken away; the Mage circles have rebelled. Some unseen force is manipulating events, bringing about disorder and destruction. Out of this confusion emerges The Inquisition. According to the leak, youll play as the leader of the Inquisition and can make your character a rogue, warrior or mage and set up your crew from up to ten complex companions to lead them against those who attack you by systematically spying on, revealing and destroying them.', 'Kdubwend33', 1)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('LOTR: Shadow of Mordor', 'Middle-earth: Shadow of Mordor is an upcoming action role-playing video game set in The Lord of the Rings universe, being developed by Monolith Productions and due to be released by Warner Bros. Interactive Entertainment.[1][3] The game will bridge the gap between the events of The Hobbit and The Lord of the Rings saga and is due for release on Microsoft Windows, PlayStation 3, PlayStation 4, Xbox 360 and Xbox One.', 'Kdubwend33', 1)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Titanfall Review IGN', 'From: IGN. By: Ryan McCaffrey. On: 10 Mar 2014. Score: 8.9-10. Details: Titanfall excels at making every moment and every action a fun one. It is a breath of fresh multiplayer FPS air. Pros: Slick soldier/mech action, Excellent balance, High-quality maps. Cons: Few modes, No private groups.', 'MiikeLaowrey', 2)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Witcher 3 Updates', 'Wild Hunt isnt broken up into acts, as the REDengine 3 permits the exploration of a vast, open-world without loading screen interruptions. Enemies wont scale to Geralts level, though, so you can wander into territory filled with too-tough monsters who will wreck our intrepid hero. Along the way, you can expect to encounter friendlies and enemies in a dynamic world affected by unpredictable weather, including randomly generated storms, and water physics while sailing. Fast travel is a go, and Geralt can mount horses for both transportation and combat. Geralt will play the part of monster-hunter and detective throughout his quests, which developer CDP claims will occupy more than 100 hours of players time. Hell have almost five times the amount of unique character animations, too. Each new area of the game – Skellige, the metropolis of Novigrad, and No Mans Land – has its own story.', 'BroknOath', 1)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Game 2: Wizards/Pacers', 'Pacers: 86, Wizards: 82', 'StandardUser', 7)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Game 2: Clippers/Thunder', 'Clippers: 101, Thunder: 112', 'Administrator', 7)
GO	

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Game 1: Nets/Heat', 'Nets: 86, Heat: 107', 'StandardUser', 7)
GO	

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Game 1: Trail Blazers/Spurs', 'Trail Blazers: 92, Spurs: 116', 'Administrator', 7)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Game 1: Wizards/Pacers', 'Pacers: 96, Wizards: 102', 'StandardUser', 7)
GO

INSERT INTO [dbo].[Posts] 
	([Description],[Details],[UserId],[CategoryId])
VALUES
	('Game 1: Clippers/Thunder', 'Clippers: 122, Thunder: 105', 'Administrator', 7)
GO	

/*Favorites*/
INSERT INTO [dbo].[Favorites]
	([PostId], [UserId])
VALUES
	(1, 'StandardUser')
GO

INSERT INTO [dbo].[Favorites]
	([PostId], [UserId])
VALUES
	(7, 'StandardUser')
GO

INSERT INTO [dbo].[Favorites]
	([PostId], [UserId])
VALUES
	(2, 'Administrator')
GO

INSERT INTO [dbo].[Favorites]
	([PostId], [UserId])
VALUES
	(7, 'Administrator')
GO
