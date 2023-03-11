SET NOCOUNT ON

DECLARE CUSR CURSOR LOCAL STATIC FOR
SELECT u.name
FROM sysusers u
JOIN master.dbo.syslogins l ON l.name=u.name
WHERE u.sid!=l.sid AND u.issqluser=1
ORDER BY u.name

OPEN CUSR 
DECLARE @user SYSNAME
WHILE 1=1 BEGIN
FETCH NEXT FROM CUSR INTO @user
IF @@FETCH_STATUS!=0 BREAK

PRINT CHAR(13)+'*** Fixing User '+@user+' ...'
EXEC sp_change_users_login 'auto_fix', @user
END
CLOSE CUSR DEALLOCATE CUSR 

-- SET NOCOUNT ON
-- USE Tempdb
-- GO
-- DECLARE @user sysname, @SQL NVARCHAR(MAX), @Count int

-- IF OBJECT_ID('Tempdb..##cusr') IS NOT NULL DROP TABLE #cusr

-- SELECT u.name INTO #cusr 
-- FROM sysusers u
-- JOIN master.dbo.syslogins l ON l.name=u.name
-- WHERE u.sid!=l.sid AND u.issqluser=1
-- ORDER BY u.name

-- SELECT @Count = Count(*) From #cusr

-- WHILE @Count > 0
-- 	BEGIN
-- 		SELECT TOP 1 @user = name FROM #cusr
-- 		set @sql = 'alter user '+@user+' with login='+@user+';'
-- 		EXEC sp_executesql @SQL; PRINT @SQL;
-- 		DELETE FROM #cusr WHERE name = @user
-- 		SELECT @Count = Count(*) From #cusr
-- 	END
-- IF OBJECT_ID('Tempdb..#dbs') IS NOT NULL DROP TABLE #cusr