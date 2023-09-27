/*
Cleaning Data in SQL Queries
*/

-- Standardize Date Format
UPDATE NashvilleHousing
SET SaleDate = STR_TO_DATE(SaleDateConverted, '%m/%d/%y %H:%i');

-- Populate Property Address data
UPDATE NashvilleHousing a
JOIN NashvilleHousing b ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress);

-- Breaking out Address into Individual Columns (Address, City, State)
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1),
    PropertySplitCity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(PropertyAddress, ',', -2), ',', 1));

-- Owner Address
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255),
    OwnerSplitCity NVARCHAR(255),
    OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', -3),
    OwnerSplitCity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1)),
    OwnerSplitState = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1));

-- Change Y and N to Yes and No in "Sold as Vacant" field
UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                   END;

-- Remove Duplicates
DELETE t1
FROM NashvilleHousing t1
JOIN NashvilleHousing t2
ON t1.ParcelID = t2.ParcelID
   AND t1.PropertyAddress = t2.PropertyAddress
   AND t1.SalePrice = t2.SalePrice
   AND t1.SaleDate = t2.SaleDate
   AND t1.LegalReference = t2.LegalReference
   AND t1.UniqueID > t2.UniqueID;

-- Delete Unused Columns
ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDateConverted;
