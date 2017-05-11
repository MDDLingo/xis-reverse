USE [SS-App]
GO

/* Drop Foreign Key Constraints */

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_USERACCOUNT_BENEFICIARY]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[USERACCOUNT] DROP CONSTRAINT [FK_USERACCOUNT_BENEFICIARY]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_TUTOR_DEPENDENT]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[TUTOR] DROP CONSTRAINT [FK_TUTOR_DEPENDENT]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_DOCUMENT_BENEFICIARY]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[DOCUMENT] DROP CONSTRAINT [FK_DOCUMENT_BENEFICIARY]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_DEPENDENTS_BENEFICIARY]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[DEPENDENTS] DROP CONSTRAINT [FK_DEPENDENTS_BENEFICIARY]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_DEPENDENTS_DEPENDENT]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[DEPENDENTS] DROP CONSTRAINT [FK_DEPENDENTS_DEPENDENT]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_DEPENDENT_PERSON]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[DEPENDENT] DROP CONSTRAINT [FK_DEPENDENT_PERSON]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[FK_BENEFICIARY_PERSON]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
ALTER TABLE [dbo].[BENEFICIARY] DROP CONSTRAINT [FK_BENEFICIARY_PERSON]
GO

/* Drop Tables */

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[USERACCOUNT]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[USERACCOUNT]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[SYSTEMDOCUMENT]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[SYSTEMDOCUMENT]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[TUTOR]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[TUTOR]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[PERSON]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[PERSON]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[DOCUMENT]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[DOCUMENT]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[DEPENDENTS]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[DEPENDENTS]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[DEPENDENT]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[DEPENDENT]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[BENEFICIARY]') AND OBJECTPROPERTY(id, 'IsUserTable') = 1) 
DROP TABLE [dbo].[BENEFICIARY]
GO

/* Create Tables */

CREATE TABLE [dbo].[USERACCOUNT]
(
	[Id] int NOT NULL,
	[BenIdNumber] int NOT NULL
)
GO

CREATE TABLE [dbo].[SYSTEMDOCUMENT]
(
	[Id] int NOT NULL,
	[Path] varchar(50) NULL,
	[Description] varchar(50) NULL,
	[Notes] varchar(50) NULL,
	[Status] varchar(50) NULL
)
GO

CREATE TABLE [dbo].[TUTOR]
(
	[Id] int NOT NULL,
	[DepIdNumber] int NOT NULL
)
GO

CREATE TABLE [dbo].[PERSON]
(
	[IdNumber] int NOT NULL,
	[Name] nvarchar(100) NULL
)
GO

CREATE TABLE [dbo].[DOCUMENT]
(
	[Id] int NOT NULL,
	[BenIdNumber] int NOT NULL,
	[Path] varchar(50) NULL,
	[Description] varchar(50) NULL,
	[Notes] varchar(50) NULL
)
GO

CREATE TABLE [dbo].[DEPENDENTS]
(
	[Id] int NOT NULL,
	[BenIdNumber] int NOT NULL,
	[DepIdNumber] int NOT NULL
)
GO

CREATE TABLE [dbo].[DEPENDENT]
(
	[IdNumber] int NOT NULL
)
GO

CREATE TABLE [dbo].[BENEFICIARY]
(
	[IdNumber] int NOT NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [dbo].[USERACCOUNT] 
 ADD CONSTRAINT [PK_USERACCOUNT]
	PRIMARY KEY CLUSTERED ([Id])
GO

CREATE UNIQUE INDEX [AK_UniqPerson] 
 ON [dbo].[USERACCOUNT] ([BenIdNumber] ASC)
GO

ALTER TABLE [dbo].[SYSTEMDOCUMENT] 
 ADD CONSTRAINT [PK_SYSTEMDOCUMENT]
	PRIMARY KEY CLUSTERED ([Id])
GO

ALTER TABLE [dbo].[TUTOR] 
 ADD CONSTRAINT [PK_Table1]
	PRIMARY KEY CLUSTERED ([Id])
GO

CREATE INDEX [IXFK_TUTOR_DEPENDENT] 
 ON [dbo].[TUTOR] ([DepIdNumber] ASC)
GO

CREATE INDEX [IXFK_TUTOR_DEPENDENTS] 
 ON [dbo].[TUTOR] ([DepIdNumber] ASC)
GO

ALTER TABLE [dbo].[PERSON] 
 ADD CONSTRAINT [PK_PERSON]
	PRIMARY KEY CLUSTERED ([IdNumber])
GO

ALTER TABLE [dbo].[DOCUMENT] 
 ADD CONSTRAINT [PK_DOCUMENT]
	PRIMARY KEY CLUSTERED ([Id])
GO

ALTER TABLE [dbo].[DEPENDENTS] 
 ADD CONSTRAINT [PK_DEPENDENTS]
	PRIMARY KEY CLUSTERED ([Id])
GO

ALTER TABLE [dbo].[DEPENDENT] 
 ADD CONSTRAINT [PK_DEPENDENT]
	PRIMARY KEY CLUSTERED ([IdNumber])
GO

ALTER TABLE [dbo].[BENEFICIARY] 
 ADD CONSTRAINT [PK_BENEFICIARY]
	PRIMARY KEY CLUSTERED ([IdNumber])
GO

/* Create Foreign Key Constraints */

ALTER TABLE [dbo].[USERACCOUNT] ADD CONSTRAINT [FK_USERACCOUNT_BENEFICIARY]
	FOREIGN KEY ([BenIdNumber]) REFERENCES [dbo].[BENEFICIARY] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dbo].[TUTOR] ADD CONSTRAINT [FK_TUTOR_DEPENDENT]
	FOREIGN KEY ([DepIdNumber]) REFERENCES [dbo].[DEPENDENT] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dbo].[DOCUMENT] ADD CONSTRAINT [FK_DOCUMENT_BENEFICIARY]
	FOREIGN KEY ([BenIdNumber]) REFERENCES [dbo].[BENEFICIARY] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dbo].[DEPENDENTS] ADD CONSTRAINT [FK_DEPENDENTS_BENEFICIARY]
	FOREIGN KEY ([BenIdNumber]) REFERENCES [dbo].[BENEFICIARY] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dbo].[DEPENDENTS] ADD CONSTRAINT [FK_DEPENDENTS_DEPENDENT]
	FOREIGN KEY ([DepIdNumber]) REFERENCES [dbo].[DEPENDENT] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dbo].[DEPENDENT] ADD CONSTRAINT [FK_DEPENDENT_PERSON]
	FOREIGN KEY ([IdNumber]) REFERENCES [dbo].[PERSON] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [dbo].[BENEFICIARY] ADD CONSTRAINT [FK_BENEFICIARY_PERSON]
	FOREIGN KEY ([IdNumber]) REFERENCES [dbo].[PERSON] ([IdNumber]) ON DELETE No Action ON UPDATE No Action
GO



INSERT INTO [dbo].[PERSON]
           ([IdNumber]
           ,[Name])
     VALUES
           (1
           ,'A')
GO

INSERT INTO [dbo].[PERSON]
           ([IdNumber]
           ,[Name])
     VALUES
           (2
           ,'B')
GO


INSERT INTO [dbo].[BENEFICIARY]
           ([IdNumber])
     VALUES
           (1)
GO

INSERT INTO [dbo].[DEPENDENT]
           ([IdNumber])
     VALUES
           (2)
GO

INSERT INTO [dbo].[DEPENDENTS]
           ([Id]
           ,[BenIdNumber]
           ,[DepIdNumber])
     VALUES
           (1
           ,1
           ,2)
GO

INSERT INTO [dbo].[DOCUMENT]
           ([Id]
           ,[BenIdNumber]
           ,[Path]
           ,[Description]
           ,[Notes])
     VALUES
           (1
           ,1
           ,NULL
           ,NULL
           ,NULL)
GO

INSERT INTO [dbo].[DOCUMENT]
           ([Id]
           ,[BenIdNumber]
           ,[Path]
           ,[Description]
           ,[Notes])
     VALUES
           (2
           ,1
           ,NULL
           ,NULL
           ,NULL)
GO

INSERT INTO [dbo].[SYSTEMDOCUMENT]
           ([Id]
           ,[Path]
           ,[Description]
           ,[Notes]
           ,[Status])
     VALUES
           (1
           ,NULL
           ,NULL
           ,NULL
           ,'Accepted')
GO

INSERT INTO [dbo].[SYSTEMDOCUMENT]
           ([Id]
           ,[Path]
           ,[Description]
           ,[Notes]
           ,[Status])
     VALUES
           (2
           ,NULL
           ,NULL
           ,NULL
           ,'Declined')
GO

INSERT INTO [dbo].[SYSTEMDOCUMENT]
           ([Id]
           ,[Path]
           ,[Description]
           ,[Notes]
           ,[Status])
     VALUES
           (3
           ,NULL
           ,NULL
           ,NULL
           ,'Expired')
GO

INSERT INTO [dbo].[USERACCOUNT]
           ([Id]
           ,[BenIdNumber])
     VALUES
           (1
           ,1)
GO