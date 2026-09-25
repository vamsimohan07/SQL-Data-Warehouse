/*
=================================================================================

Create Database and Schemas

=================================================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it is already exists.
    If the database exists, It is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'Bronze', 'Silver' and 'Gold'.

WARNING:
    Running the script will drop the entire 'DropWarehouse' database if it exists. All the data in the database
    will be permanently deleted. Proceding with caution and ensure have proper backups before running the script
    is must.
*/

USE master ;
GO

-- Drop and recreate the 'DataWarehouse' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

--Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO


USE DataWarehouse;
GO


--Create Schemas
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
