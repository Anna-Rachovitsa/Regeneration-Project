USE [Chinook]
GO



-- Display all records in the Customer table
SELECT * FROM [dbo].[Customer]

-- Update the address of CustomerID 10 
 
UPDATE [dbo].[Customer]
SET 
    [Address] = '221B Baker Street',
    [City] = 'London',
    [State] = NULL,
    [PostalCode] = 'NW1 6XE.',
    [Country] = 'United Kingdom'
WHERE [CustomerID] = 10; 