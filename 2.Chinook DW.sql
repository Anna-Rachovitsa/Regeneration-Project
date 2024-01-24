USE master
GO
if exists (select * from sysdatabases where name='ChinookDW')
		alter database ChinookDW set single_user with rollback immediate
		drop database ChinookDW
go

CREATE DATABASE ChinookDW
GO

USE ChinookDW
GO

DROP TABLE IF EXISTS DimCustomer;
DROP TABLE IF EXISTS DimTrack;
DROP TABLE IF EXISTS FactSales;
DROP TABLE IF EXISTS DimPlaylist;

CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CustomerID INT NOT NULL,
    CustomerName VARCHAR(40) NOT NULL,
    CustomerCompany VARCHAR(80) DEFAULT '' NOT NULL,
    CustomerCity VARCHAR(40) NOT NULL,
    CustomerState VARCHAR(40) DEFAULT '' NOT NULL,
    CustomerCountry VARCHAR(40) NOT NULL,
    CustomerPostalCode VARCHAR(10) NOT NULL,
    EmployeeName VARCHAR(40) NOT NULL,
    EmployeeTitle VARCHAR(40) NOT NULL,
    RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL
);

CREATE TABLE DimTrack (
    TrackKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TrackID INT NOT NULL,
    TrackName VARCHAR(200) NOT NULL,
	AlbumName VARCHAR(160) NOT NULL,
	ArtistName VARCHAR(120) NOT NULL,
    GenreName VARCHAR(120) NOT NULL,
    TrackComposer VARCHAR(220) DEFAULT '' NOT NULL,
	TrackMilliseconds INT DEFAULT '' NOT NULL,
    RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL
);


CREATE TABLE DimPlaylist (
    PlaylistKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PlaylistID INT NOT NULL,
	TrackID INT NOT NULL,
    PlaylistName VARCHAR(120) NOT NULL,
    RowIsCurrent INT DEFAULT 1 NOT NULL,
    RowStartDate DATE DEFAULT '1899-12-31' NOT NULL,
    RowEndDate DATE DEFAULT '9999-12-31' NOT NULL,
    RowChangeReason VARCHAR(200) NULL
);

CREATE TABLE FactSales (
    TrackKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    InvoiceDateKey INT NOT NULL,
    InvoiceId INT NOT NULL,
    TrackPrice FLOAT NOT NULL
);



