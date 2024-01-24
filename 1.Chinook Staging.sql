--CREATE DATABASE ChinookStaging --drop the comment if executed for first time
GO

USE ChinookStaging
GO

DROP TABLE IF EXISTS ChinookStaging.dbo.Customers;
DROP TABLE IF EXISTS ChinookStaging.dbo.Tracks;
DROP TABLE IF EXISTS ChinookStaging.dbo.Invoices;
DROP TABLE IF EXISTS ChinookStaging.dbo.Playlists;

--get data from Customer:  CustomerId, FirstName,LastName, Company, Address, City,
--  State, Country, PostalCode

SELECT
    Customer.CustomerId,
    Customer.FirstName AS CustomerFirstName,
    Customer.LastName AS CustomerLastName,
    Customer.Company AS CustomerCompany,
    Customer.City AS CustomerCity,
    Customer.State AS CustomerState,
    Customer.Country AS CustomerCountry,
    Customer.PostalCode AS CustomerPostalCode,
    Employee.FirstName AS EmployeeFirstName,
    Employee.LastName AS EmployeeLastName,
    Employee.Title AS EmployeeTitle
INTO dbo.Customers
FROM [Chinook].[dbo].[Customer] Customer
INNER JOIN [Chinook].[dbo].[Employee] Employee ON Customer.SupportRepId = Employee.EmployeeId;


-- Copy data from Track, Album, Artist, PlaylistTrack, Playlist, and Genre tables to a new Tracks table
-- Include track, album, artist, playlist, and genre information

SELECT
    Track.TrackId,
    Track.Name AS TrackName,
    Album.Title AS AlbumTitle,
    Artist.Name AS ArtistName,
    Genre.Name AS GenreName,
    Track.Composer,
    Track.Milliseconds
INTO dbo.Tracks
FROM [Chinook].[dbo].[Track] Track
INNER JOIN [Chinook].[dbo].[Album] Album ON Track.AlbumId = Album.AlbumId
INNER JOIN [Chinook].[dbo].[Artist] Artist ON Artist.ArtistId = Album.ArtistId
INNER JOIN [Chinook].[dbo].[PlaylistTrack] PlaylistTrack ON PlaylistTrack.TrackId = Track.TrackId
INNER JOIN [Chinook].[dbo].[Playlist] Playlist ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
INNER JOIN [Chinook].[dbo].[Genre] Genre ON Genre.GenreId = Track.GenreId;

-- Copy data from PlaylistTrack and Playlist tables to a new Playlists table
-- Include track and playlist information

SELECT 
    PlaylistTrack.TrackId,
    PlaylistTrack.PlaylistId,
    Playlist.Name AS PlaylistName
INTO dbo.Playlists
FROM [Chinook].[dbo].[PlaylistTrack] PlaylistTrack
INNER JOIN [Chinook].[dbo].[Playlist] Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId;

-- Copy data from Invoice and InvoiceLine tables to a new Invoices table
-- Include track, invoice, and customer information
SELECT
    InvoiceLine.TrackId,
    Invoice.InvoiceId,
    Invoice.CustomerId,
    Invoice.InvoiceDate,
    InvoiceLine.UnitPrice
INTO dbo.Invoices 
FROM [Chinook].[dbo].[Invoice] Invoice
INNER JOIN [Chinook].[dbo].[InvoiceLine] InvoiceLine
ON Invoice.InvoiceId = InvoiceLine.InvoiceId;

SELECT MIN(InvoiceDate) AS minDate, MAX(InvoiceDate) AS maxDate FROM dbo.Invoices;
