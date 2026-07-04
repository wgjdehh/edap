## PIPELINE

![data downloaded (1)](https://github.com/user-attachments/assets/256cc2ff-3c15-449b-9f32-d2868d58acae)

# EDA

----------------------------------------------------

Objective: Gain an initial understanding of the dataset’s structure, distribution, and potential issues.

Actions:

Used .info() to inspect data types and null values.

Used .describe() for statistical summaries of numerical columns.

Used .head() to preview the first few rows.

Identified column names, data types, and detect any obvious inconsistencies or outliers.

# Data Cleaning

----------------------------------------------------

Objective: to Prepare the dataset for reliable analysis by ensuring quality and consistency.

Actions:

Removed Duplicates: Eliminate duplicate records using .drop_duplicates() to avoid skewed results.

Handled Missing Values:

Drop rows/columns if missing values are negligible.

Use imputation techniques (e.g., mean, median, mode) for essential missing fields.

Fix Data Types: Convert columns to appropriate formats (e.g., datetime, float).

Currency Formatting: Use .replace() and .str.replace() to clean and convert currency-formatted strings to numerical values.

Validation: Re-check data integrity to ensure no inconsistencies remain after cleaning.

# Feature Engineering

----------------------------------------------------

Objective: Enhance the dataset to support meaningful and efficient analysis.

Actions:

Created New Features:

Added a new column total_amount by calculating unit_price * quantity.

Streamline Analysis:

Used the engineered field to support aggregation and filtering in SQL-based exploration.

# Load Data into Databases (MySQL)

----------------------------------------------------

Objective: Store the cleaned and enriched data in relational databases for robust querying.

Actions:

Set Up Connections: Use SQLAlchemy to establish connections with both MySQL..

Table Creation & Insertion: Automate table creation and insert data using DataFrame .to_sql() method.

Verification: Run initial queries to ensure that data has been accurately loaded and matches the original dataset.

# SQL Analysis – Business Problem Solving

----------------------------------------------------


Objective: Answer strategic business questions using complex SQL queries.

Key Analysis Areas:

Revenue trends across branches and product categories.

Identification of best-selling categories and products.

Sales performance analysis segmented by time, city, and payment method.

Detection of peak sales periods and customer purchase behavior.

Profit margin analysis per branch and category.
