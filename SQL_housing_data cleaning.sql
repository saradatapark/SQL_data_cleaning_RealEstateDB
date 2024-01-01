-- SQL DATA CLEANING for Nashville Housing Prices Database

-- Converting sale date format
ALTER TABLE datum
ADD SaleDateConv DATE;

UPDATE datum
SET SaleDateConv = CONVERT(DATE, SaleDate);

-- Removing null from property address
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM datum a
JOIN datum b ON a.ParcelID = b.ParcelID AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL;

-- Breaking property address into address, city, state
ALTER TABLE datum
ADD PropAddress NVARCHAR(255),
    PropCity NVARCHAR(255);

UPDATE datum
SET PropAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
    PropCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));

-- Breaking down Owner address
ALTER TABLE datum
ADD OwnerAdd NVARCHAR(255),
    OwnerCity NVARCHAR(255),
    OwnerState NVARCHAR(255);

UPDATE datum
SET OwnerAdd = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

-- Convert 'SoldAsVacant' column to Yes/No
UPDATE datum
SET SoldAsVacant = 
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;

-- Removing duplicate records
WITH RowNumCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM datum
)
DELETE FROM RowNumCTE
WHERE row_num > 1;

-- Deleting unnecessary columns
ALTER TABLE datum
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict, SaleDate;
