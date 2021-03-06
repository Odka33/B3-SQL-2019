IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'LA300')
	DROP DATABASE [LA300]
GO

CREATE DATABASE [LA300]  
GO

use [LA300]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PRODUITS_CATEGORIES]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PRODUITS] DROP CONSTRAINT FK_PRODUITS_CATEGORIES
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_COMMANDES_CLIENTS]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[COMMANDES] DROP CONSTRAINT FK_COMMANDES_CLIENTS
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_DETAILS_COMMANDES_COMMANDES]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[DETAILS_COMMANDES] DROP CONSTRAINT FK_DETAILS_COMMANDES_COMMANDES
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_COMMANDES_EMPLOYES]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[COMMANDES] DROP CONSTRAINT FK_COMMANDES_EMPLOYES
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_EMPLOYES_EMPLOYES]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[EMPLOYES] DROP CONSTRAINT FK_EMPLOYES_EMPLOYES
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PRODUITS_FOURNISSEURS]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PRODUITS] DROP CONSTRAINT FK_PRODUITS_FOURNISSEURS
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_DETAILS_COMMANDES_PRODUITS]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[DETAILS_COMMANDES] DROP CONSTRAINT FK_DETAILS_COMMANDES_PRODUITS
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CATEGORIES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CATEGORIES]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CLIENTS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CLIENTS]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[COMMANDES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[COMMANDES]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DETAILS_COMMANDES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DETAILS_COMMANDES]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EMPLOYES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[EMPLOYES]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FOURNISSEURS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FOURNISSEURS]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PRODUITS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PRODUITS]
GO

CREATE TABLE [dbo].[CATEGORIES] (
	[CODE_CATEGORIE] [numeric](6, 0) NOT NULL ,
	[NOM_CATEGORIE] [varchar] (25) COLLATE French_CI_AS NOT NULL ,
	[DESCRIPTION] [varchar] (100) COLLATE French_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CLIENTS] (
	[CODE_CLIENT] [char] (5) COLLATE French_CI_AS NOT NULL ,
	[SOCIETE] [varchar] (40) COLLATE French_CI_AS NOT NULL ,
	[ADRESSE] [varchar] (60) COLLATE French_CI_AS NOT NULL ,
	[VILLE] [varchar] (15) COLLATE French_CI_AS NOT NULL ,
	[CODE_POSTAL] [varchar] (10) COLLATE French_CI_AS NOT NULL ,
	[PAYS] [varchar] (15) COLLATE French_CI_AS NOT NULL ,
	[TELEPHONE] [varchar] (24) COLLATE French_CI_AS NOT NULL ,
	[FAX] [varchar] (24) COLLATE French_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[COMMANDES] (
	[NO_COMMANDE] [numeric](6, 0) NOT NULL ,
	[CODE_CLIENT] [char] (5) COLLATE French_CI_AS NOT NULL ,
	[NO_EMPLOYE] [numeric](6, 0) NOT NULL ,
	[DATE_COMMANDE] [datetime] NOT NULL ,
	[DATE_ENVOI] [datetime] NULL ,
	[PORT] [numeric](8, 2) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[DETAILS_COMMANDES] (
	[NO_COMMANDE] [numeric](6, 0) NOT NULL ,
	[REF_PRODUIT] [numeric](6, 0) NOT NULL ,
	[PRIX_UNITAIRE] [numeric](8, 2) NOT NULL ,
	[QUANTITE] [numeric](5, 0) NOT NULL ,
	[REMISE] [float] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[EMPLOYES] (
	[NO_EMPLOYE] [numeric](6, 0) NOT NULL ,
	[REND_COMPTE] [numeric](6, 0) NULL ,
	[NOM] [varchar] (20) COLLATE French_CI_AS NOT NULL ,
	[PRENOM] [varchar] (10) COLLATE French_CI_AS NOT NULL ,
	[FONCTION] [varchar] (30) COLLATE French_CI_AS NOT NULL ,
	[TITRE] [varchar] (5) COLLATE French_CI_AS NOT NULL ,
	[DATE_NAISSANCE] [datetime] NOT NULL ,
	[DATE_EMBAUCHE] [datetime] NOT NULL ,
	[SALAIRE] [numeric](8, 2) NOT NULL ,
	[COMMISSION] [numeric](8, 2) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FOURNISSEURS] (
	[NO_FOURNISSEUR] [numeric](6, 0) NOT NULL ,
	[SOCIETE] [varchar] (40) COLLATE French_CI_AS NOT NULL ,
	[ADRESSE] [varchar] (60) COLLATE French_CI_AS NOT NULL ,
	[VILLE] [varchar] (20) COLLATE French_CI_AS NOT NULL ,
	[CODE_POSTAL] [varchar] (10) COLLATE French_CI_AS NOT NULL ,
	[PAYS] [varchar] (15) COLLATE French_CI_AS NOT NULL ,
	[TELEPHONE] [varchar] (24) COLLATE French_CI_AS NOT NULL ,
	[FAX] [varchar] (24) COLLATE French_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PRODUITS] (
	[REF_PRODUIT] [numeric](6, 0) NOT NULL ,
	[NOM_PRODUIT] [varchar] (40) COLLATE French_CI_AS NOT NULL ,
	[NO_FOURNISSEUR] [numeric](6, 0) NOT NULL ,
	[CODE_CATEGORIE] [numeric](6, 0) NOT NULL ,
	[QUANTITE] [varchar] (30) COLLATE French_CI_AS NULL ,
	[PRIX_UNITAIRE] [numeric](8, 2) NOT NULL ,
	[UNITES_STOCK] [numeric](5, 0) NULL ,
	[UNITES_COMMANDEES] [numeric](5, 0) NULL ,
	[INDISPONIBLE] [numeric](1, 0) NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CATEGORIES] WITH NOCHECK ADD 
	CONSTRAINT [PK_CATEGORIES] PRIMARY KEY  CLUSTERED 
	(
		[CODE_CATEGORIE]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[CLIENTS] WITH NOCHECK ADD 
	CONSTRAINT [PK_CLIENTS] PRIMARY KEY  CLUSTERED 
	(
		[CODE_CLIENT]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[COMMANDES] WITH NOCHECK ADD 
	CONSTRAINT [PK_COMMANDES] PRIMARY KEY  CLUSTERED 
	(
		[NO_COMMANDE]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[EMPLOYES] WITH NOCHECK ADD 
	CONSTRAINT [PK_EMPLOYES] PRIMARY KEY  CLUSTERED 
	(
		[NO_EMPLOYE]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[FOURNISSEURS] WITH NOCHECK ADD 
	CONSTRAINT [PK_FOURNISSEURS] PRIMARY KEY  CLUSTERED 
	(
		[NO_FOURNISSEUR]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[PRODUITS] WITH NOCHECK ADD 
	CONSTRAINT [PK_PRODUITS] PRIMARY KEY  CLUSTERED 
	(
		[REF_PRODUIT]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[COMMANDES] ADD 
	CONSTRAINT [FK_COMMANDES_CLIENTS] FOREIGN KEY 
	(
		[CODE_CLIENT]
	) REFERENCES [dbo].[CLIENTS] (
		[CODE_CLIENT]
	),
	CONSTRAINT [FK_COMMANDES_EMPLOYES] FOREIGN KEY 
	(
		[NO_EMPLOYE]
	) REFERENCES [dbo].[EMPLOYES] (
		[NO_EMPLOYE]
	)
GO

ALTER TABLE [dbo].[DETAILS_COMMANDES] ADD 
	CONSTRAINT [FK_DETAILS_COMMANDES_COMMANDES] FOREIGN KEY 
	(
		[NO_COMMANDE]
	) REFERENCES [dbo].[COMMANDES] (
		[NO_COMMANDE]
	),
	CONSTRAINT [FK_DETAILS_COMMANDES_PRODUITS] FOREIGN KEY 
	(
		[REF_PRODUIT]
	) REFERENCES [dbo].[PRODUITS] (
		[REF_PRODUIT]
	)
GO

ALTER TABLE [dbo].[EMPLOYES] ADD 
	CONSTRAINT [FK_EMPLOYES_EMPLOYES] FOREIGN KEY 
	(
		[REND_COMPTE]
	) REFERENCES [dbo].[EMPLOYES] (
		[NO_EMPLOYE]
	)
GO

ALTER TABLE [dbo].[PRODUITS] ADD 
	CONSTRAINT [FK_PRODUITS_CATEGORIES] FOREIGN KEY 
	(
		[CODE_CATEGORIE]
	) REFERENCES [dbo].[CATEGORIES] (
		[CODE_CATEGORIE]
	),
	CONSTRAINT [FK_PRODUITS_FOURNISSEURS] FOREIGN KEY 
	(
		[NO_FOURNISSEUR]
	) REFERENCES [dbo].[FOURNISSEURS] (
		[NO_FOURNISSEUR]
	)
GO

