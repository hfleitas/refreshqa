SET NOCOUNT ON;
DECLARE @kill nvarchar(max) = '';

IF EXISTS (SELECT 1 FROM sys.dm_exec_sessions WHERE database_id  = db_id('hiramdb'))
BEGIN
	SELECT @kill = @kill + 'KILL ' + CONVERT(VARCHAR(5), session_id) + ';'
	FROM sys.dm_exec_sessions
	WHERE database_id  = db_id('hiramdb')

	EXEC sp_executesql @kill;
END
--GO

--ALTER DATABASE [hiramdb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
