# Nashville Housing Prices Database - SQL Data Cleaning Project
## Introduction
This project involves the cleaning and transformation of data from the Nashville housing prices database to ensure accurate and meaningful analysis. The dataset, named 'datum,' contains information about property sales, including sale date, property address, owner details, and other relevant attributes.

## Data Cleaning Steps
### 1. Converting Sale Date Format
The sale date format is standardized by converting it to the Date data type. An additional column, 'SaleDateConv,' is added to store the converted dates.

### 2. Removing Null Values from Property Address
Null values in the 'PropertyAddress' column are addressed by updating them with corresponding values from other rows with the same ParcelID.

### 3. Breaking Property Address into Address, City, State
The 'PropertyAddress' column is split into separate columns for address, city, and state.

### 4. Breaking Down Owner Address
Similar to property address, the 'OwnerAddress' column is split into separate columns for address, city, and state.

### 5. Convert 'SoldAsVacant' Column to Yes/No
The 'SoldAsVacant' column values are converted to 'Yes' or 'No' for consistency.

### 6. Removing Duplicate Records
Duplicate records based on specific columns are identified and removed, keeping only one instance.

### 7. Deleting Unnecessary Columns
Columns that are no longer needed are dropped from the 'datum' table.

## Conclusion
By executing these SQL data cleaning steps, the 'datum' table is now prepared for further analysis. The data is cleansed, standardized, and duplicates are removed, ensuring a reliable foundation for Nashville housing prices analysis.

