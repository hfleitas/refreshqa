use LicenseManagement
go
-- truncate table License.NIPRServiceLog 
/*
    Msg 4712, Level 16, State 1, Line 3
    Cannot truncate table 'License.NIPRServiceLog' because it is being referenced by a FOREIGN KEY constraint.
    Table is referenced by foreign key
    LicenseManagement.License.PdbAlerts: FK_PdbAlerts_NiprServiceLogId
*/
go
truncate table License.NIPRServiceLogProdPdbDetails
go
truncate table License.ApiErrorLog
go
truncate table License.ErrorLog
go