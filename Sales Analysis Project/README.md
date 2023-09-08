# Sales Analysis

This Python script performs an analysis on sales data. It covers various tasks including data merging, cleaning, and exploration.

## Usage

1. Make sure you have the necessary libraries installed (`os`, `pandas`, `matplotlib`, `seaborn`).
2. Run the script in your Python environment.

## Data Preparation

The script first imports necessary libraries and then merges data from multiple CSV files into a single dataframe for analysis.

## Data Cleaning

1. Drops rows with missing values to ensure data integrity.
2. Removes unwanted text from the 'Order Date' column.

## Data Augmentation

1. Adds a 'Month' column for further analysis.
2. Adds a 'City' column based on the 'Purchase Address' column.

## Data Exploration

### Question 1: What was the best month for sales? How much was earned that month?

This section calculates and visualizes the total sales for each month.

### Question 2: What city sold the most product?

This section calculates and visualizes the total sales for each city.

### Question 3: What time should we display advertisements to maximize likelihood of customer's buying product?

This section analyzes the best time for displaying advertisements based on order timestamps.

### Question 4: What product sold the most? Why do you think it sold the most?

This section identifies the highest selling product and explores its relationship between quantity ordered and price.

## Author

Somansh Achary

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
