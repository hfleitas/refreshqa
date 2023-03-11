-- [-- DB CONTEXT --] --
USE [LicenseManagement]
 
-- [-- DB USERS --] --
 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'AtlasUser') BEGIN CREATE USER  [AtlasUser] FOR LOGIN [AtlasUser] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'dbo') BEGIN CREATE USER  [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'guest') BEGIN CREATE USER  [guest] FOR LOGIN [guest] WITH DEFAULT_SCHEMA = [guest] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\abrown5') BEGIN CREATE USER  [UPCIC\abrown5] FOR LOGIN [UPCIC\abrown5] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\AtlasDevelopers') BEGIN CREATE USER  [UPCIC\AtlasDevelopers] FOR LOGIN [UPCIC\AtlasDevelopers] WITH DEFAULT_SCHEMA = [UPCIC\AtlasDevelopers] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\djinna') BEGIN CREATE USER  [UPCIC\djinna] FOR LOGIN [UPCIC\djinna] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\jhillegass') BEGIN CREATE USER  [UPCIC\jhillegass] FOR LOGIN [UPCIC\jhillegass] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\lboni') BEGIN CREATE USER  [UPCIC\lboni] FOR LOGIN [UPCIC\lboni] WITH DEFAULT_SCHEMA = [UPCIC\lboni] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\mallen2') BEGIN CREATE USER  [UPCIC\mallen2] FOR LOGIN [UPCIC\mallen2] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\rnambiar') BEGIN CREATE USER  [UPCIC\rnambiar] FOR LOGIN [UPCIC\rnambiar] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\TeamFoundation') BEGIN CREATE USER  [UPCIC\TeamFoundation] FOR LOGIN [UPCIC\TeamFoundation] WITH DEFAULT_SCHEMA = [dbo] END; 
IF NOT EXISTS (SELECT [name] FROM sys.database_principals WHERE [name] =  'UPCIC\TFS_RDGlobal_QA') BEGIN CREATE USER  [UPCIC\TFS_RDGlobal_QA] FOR LOGIN [UPCIC\TFS_RDGlobal_QA] WITH DEFAULT_SCHEMA = [UPCIC\TFS_RDGlobal_QA] END; 
-- [-- DB ROLES --] --
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'AtlasUser'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\abrown5'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\AtlasDevelopers'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\djinna'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\RD-Global-Developers'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\rnambiar'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\rptsvr_ro'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\TeamFoundation'
EXEC sp_addrolemember @rolename = 'db_datareader', @membername = 'UPCIC\TFS_RDGlobal_QA'
EXEC sp_addrolemember @rolename = 'db_datawriter', @membername = 'UPCIC\TeamFoundation'
EXEC sp_addrolemember @rolename = 'db_datawriter', @membername = 'UPCIC\TFS_RDGlobal_QA'
EXEC sp_addrolemember @rolename = 'db_ddladmin', @membername = 'UPCIC\TeamFoundation'
EXEC sp_addrolemember @rolename = 'db_ddladmin', @membername = 'UPCIC\TFS_RDGlobal_QA'
EXEC sp_addrolemember @rolename = 'db_executor', @membername = 'UPCIC\TeamFoundation'
EXEC sp_addrolemember @rolename = 'db_executor', @membername = 'UPCIC\TFS_RDGlobal_QA'
EXEC sp_addrolemember @rolename = 'db_owner', @membername = 'AtlasUser'
EXEC sp_addrolemember @rolename = 'db_owner', @membername = 'UPCIC\TeamFoundation'
EXEC sp_addrolemember @rolename = 'db_securityadmin', @membername = 'UPCIC\TeamFoundation'
 
-- [-- OBJECT LEVEL PERMISSIONS --] --
 
-- [--DB LEVEL PERMISSIONS --] --
GRANT CONNECT TO [AtlasUser]
GRANT CONNECT TO [UPCIC\abrown5]
GRANT CONNECT TO [UPCIC\AtlasDevelopers]
GRANT CONNECT TO [UPCIC\djinna]
GRANT CONNECT TO [UPCIC\jhillegass]
GRANT CONNECT TO [UPCIC\mallen2]
GRANT CONNECT TO [UPCIC\RD-Global-Developers]
GRANT CONNECT TO [UPCIC\rnambiar]
GRANT CONNECT TO [UPCIC\rptsvr_ro]
GRANT CONNECT TO [UPCIC\TeamFoundation]
GRANT CONNECT TO [UPCIC\TFS_RDGlobal_QA]
GRANT SHOWPLAN TO [UPCIC\lboni]
GRANT VIEW DEFINITION TO [UPCIC\TeamFoundation]
GRANT VIEW DEFINITION TO [UPCIC\TFS_RDGlobal_QA]
 
-- [--DB LEVEL SCHEMA PERMISSIONS --] --
