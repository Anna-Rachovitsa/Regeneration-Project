USE ChinookDW

-- Only for the first load
--DELETE FROM FactSales;
--DELETE FROM DimTrack;
--DELETE FROM DimCustomer;
--DELETE FROM DimPlaylist;

--1
INSERT INTO DimCustomer (
    CustomerID,
    CustomerName,
    CustomerCompany,
    CustomerCity,
    CustomerState,
    CustomerCountry,
    CustomerPostalCode,
    EmployeeName,
    EmployeeTitle
)
SELECT 
    CustomerId,
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    ISNULL(Company, 'n/a') AS CustomerCompany,
    ISNULL(City, 'n/a') AS CustomerCity,
    ISNULL(State, 'n/a') AS CustomerState,
    ISNULL(Country, 'n/a') AS CustomerCountry,
    COALESCE(PostalCode, 'n/a') AS CustomerPostalCode,
    CONCAT(EmployeeFirstName, ' ', EmployeeLastName) AS EmployeeName,
    ISNULL(EmployeeTitle, 'n/a') AS EmployeeTitle
FROM [ChinookStaging].[dbo].[Customers];


--2
INSERT INTO DimTrack (
    TrackID,
    TrackName,
    AlbumName,
    ArtistName,
    GenreName,
    TrackComposer,
    TrackMilliseconds
)
SELECT 
    TrackId,
    Name AS TrackName,
    AlbumTitle AS AlbumName,
    ISNULL(ArtistName, 'n/a') AS ArtistName,
    ISNULL(GenreName, 'n/a') AS GenreName,
    ISNULL(Composer, 'n/a') AS TrackComposer,
    Milliseconds AS TrackMilliseconds
FROM [ChinookStaging].[dbo].[Tracks];



--3
INSERT INTO DimPlaylist (
    TrackID,
    PlaylistID,
    PlaylistName
)
SELECT 
    TrackId,
    PlaylistId,
    COALESCE(Name, 'n/a') AS PlaylistName
FROM [ChinookStaging].[dbo].[Playlists];

--4
INSERT INTO FactSales (
    TrackKey,
    CustomerKey,
    InvoiceDateKey,
    InvoiceId,
    TrackPrice
)
SELECT  
    t.TrackKey,
    c.CustomerKey,
    CONVERT(INT, CONVERT(VARCHAR(8), [InvoiceDate], 112)),
    InvoiceId,
    UnitPrice
FROM [ChinookStaging].[dbo].[Invoices] i
INNER JOIN [ChinookDW].[dbo].DimCustomer c ON i.CustomerId = c.CustomerId
INNER JOIN [ChinookDW].[dbo].DimTrack t ON t.TrackId = i.TrackId;
select * from FactSales
