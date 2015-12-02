@ECHO off
:: Uses the SQLCMD utility to run a SQL script that creates the SeeIt Database.

ECHO Attempting to create the SeeIt database...
sqlcmd -S localhost\SQLExpress -E /i SeeItDatabase.sql
ECHO.
ECHO If no error is shown the SeeIt Database was created successfully.
ECHO.
PAUSE