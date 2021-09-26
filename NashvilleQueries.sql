
-- Showing Average Price By Land Use Type
CREATE VIEW AvgPriceByLandUse AS
SELECT 
	ROUND(AVG(SalePrice), 0) AS AVGSalePrice, 
	LandUse FROM NashvilleHousing
GROUP BY LandUse



-- Number of purchases per land use
CREATE VIEW PurchasesByLandUse AS
SELECT LandUse, COUNT(*) AS NumberOfPurchases
FROM NashvilleHousing
GROUP BY LandUse


-- Showing total number of purchases per day
CREATE VIEW PurchasesByDay AS
SELECT 
	CONVERT(Date, SaleDate) AS SaleDate, 
	Count(*) AS NumberOfPushases
FROM NashvilleHousing
GROUP BY SaleDate


-- Showing Average Sell Price of Single Family Homes by Date
CREATE VIEW AVGSingleFamilyHomesPrices AS
SELECT
	CONVERT(Date, SaleDate) AS SaleDate, 
	ROUND(AVG(SalePrice), 0) AS AVGSalePrice,
	ROUND(AVG(LandValue), 0) AS AVGLandValue,
	ROUND(AVG(BuildingValue), 0) AS AVGBuildingValue
FROM NashvilleHousing
WHERE LandUse = 'Single Family'
GROUP BY SaleDate



-- Showing single family sale price vs the value of the home
CREATE VIEW SingleFamilyPricing AS
SELECT
	LandUse,
	SalePrice,
	LandValue + BuildingValue AS TotalValue
FROM NashvilleHousing
WHERE LandUse = 'Single Family'
AND TotalValue IS NOT NULL
AND SalePrice < TotalValue


-- Average acreage by land use type
CREATE VIEW AverageAcreage AS
SELECT LandUse, ROUND(AVG(Acreage), 2) AS AVGAcreage 
FROM NashvilleHousing
WHERE Acreage IS NOT NULL
GROUP BY LandUse

CREATE VIEW AVGPrices AS
SELECT
	CONVERT(Date, SaleDate) AS SaleDate, 
	ROUND(AVG(SalePrice), 0) AS AVGSalePrice,
	ROUND(AVG(LandValue), 0) AS AVGLandValue,
	ROUND(AVG(BuildingValue), 0) AS AVGBuildingValue
FROM NashvilleHousing
--WHERE LandUse = 'Single Family'
GROUP BY SaleDate



	

