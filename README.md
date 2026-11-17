![walmart logo](https://github.com/Dhanushkumar04/walmart_sales_analysis/blob/main/walmart_logo.png)

# Walmart Sales Data Analysis Using Python & PostgreSQL

## Project Overview

This project focuses on analyzing Walmart sales data to identify meaningful business insights related to sales performance, customer purchasing behavior, payment preferences, product categories, branch performance, and revenue trends.

The project follows an end-to-end data analytics workflow, starting with data exploration and cleaning using Python (Pandas), followed by database integration with PostgreSQL and SQL-based business analysis.

The primary objective is to transform raw sales data into meaningful insights that can support business decision-making and improve operational performance.

## Project Objectives

- Explore and understand the Walmart sales dataset.
- Identify and handle duplicate records and missing values.
- Clean and transform data using Python.
- Calculate total sales revenue for each transaction.
- Store the cleaned dataset in a PostgreSQL database.
- Analyze sales performance across branches and product categories.
- Identify customer payment preferences and purchasing patterns.
- Evaluate revenue and profit performance.
- Compare yearly revenue to identify declining-performing branches.

## Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| Python | Data exploration and preprocessing |
| Pandas | Data cleaning and manipulation |
| PostgreSQL | Database storage and management |
| SQL | Business analysis and data querying |
| SQLAlchemy | Database connectivity |
| Psycopg2 | PostgreSQL database adapter |
| Jupyter Notebook | Python development and analysis |

## Dataset Description

The Walmart sales dataset contains transactional information about sales across different Walmart branches.

### Dataset Columns

| Column | Description |
|---|---|
| invoice_id | Unique identifier for each transaction |
| branch | Walmart branch identifier |
| city | City where the branch is located |
| category | Product category |
| unit_price | Price per unit of the product |
| quantity | Number of items purchased |
| date | Date of transaction |
| time | Time of transaction |
| payment_method | Payment method used by the customer |
| rating | Customer rating |
| profit_margin | Profit margin associated with the transaction |
| total | Total transaction value |

## Project Workflow

### Step 1: Data Exploration & Loading Using Python

Imported the Walmart dataset using Pandas and performed initial data exploration to understand its structure and characteristics.

**Activities performed:**

- Imported required Python libraries.
- Loaded the CSV dataset using Pandas.
- Examined dataset dimensions using `shape`.
- Previewed records using `head()`.
- Generated descriptive statistics using `describe()`.
- Inspected column information and data types using `info()`.
- Identified duplicate records.
- Checked missing values in each column.

### Step 2: Data Cleaning & Preprocessing

Performed data cleaning to improve data quality and ensure consistency before analysis.

**Activities performed:**

- Identified and removed duplicate records using `drop_duplicates()`.
- Checked for missing values using `isnull().sum()`.
- Removed records containing NULL values using `dropna()`.
- Converted the `unit_price` column from string to numeric format.
- Standardized column names to lowercase.
- Created a new `total` column by multiplying unit price and quantity.

**Calculated Column:**

```python
df['total'] = df['unit_price'] * df['quantity']
```

### Step 3: PostgreSQL Database Integration

Integrated the cleaned Walmart dataset with PostgreSQL for structured data storage and SQL-based analysis.

**Activities performed:**

- Created a PostgreSQL database named `walmart_db`.
- Established a database connection using SQLAlchemy.
- Used Psycopg2 as the PostgreSQL database adapter.
- Exported the cleaned dataset as `Walmart_cleaned.csv`.
- Loaded the cleaned DataFrame into PostgreSQL using Pandas `to_sql()`.

**Database Connection:**

```python
engine_postgres = create_engine(
    'postgresql+psycopg2://postgres:password@localhost:5432/walmart_db'
)
```

**Data Loading:**

```python
df.to_sql(
    name='walmart',
    con=engine_postgres,
    if_exists='append',
    index=False
)
```

### Step 4: SQL-Based Business Analysis

After loading the cleaned data into PostgreSQL, several SQL queries were developed to answer practical business questions.

#### Business Questions & Analysis

**1. General Data Exploration**
- Retrieve all records from the Walmart table.
- Calculate the total number of transactions.
- Identify distinct payment methods.
- Count the number of unique Walmart branches.
- Find the maximum quantity purchased in a transaction.

**2. Payment Method Analysis**
- Identify different payment methods and the number of transactions for each.
- Calculate the total quantity of items sold through each payment method.
- Determine the most commonly used payment method for each branch.

**3. Product Category Analysis**
- Identify the highest-rated product category in each branch.
- Calculate average, minimum, and maximum customer ratings for each category across cities.
- Calculate total revenue and profit for each product category.

**4. Branch Performance Analysis**
- Identify the busiest day of the week for each branch based on transaction volume.
- Analyze transaction patterns across different branches.
- Categorize transactions into Morning, Afternoon, and Evening shifts.
- Identify the top 5 branches with the highest revenue decline compared to the previous year.

**5. Revenue & Profit Analysis**
- Calculate total revenue for each product category.
- Calculate total profit using unit price, quantity, and profit margin.
- Compare branch-wise revenue between 2022 and 2023.
- Calculate the revenue decline percentage for each branch.
- Identify the five branches experiencing the highest revenue decline.

## SQL Concepts Applied

This project demonstrates practical implementation of the following SQL concepts in PostgreSQL:

- **Aggregate Functions:** COUNT(), SUM(), AVG(), MIN(), MAX()
- **Filtering:** WHERE, AND, OR
- **Grouping & Sorting:** GROUP BY, ORDER BY
- **Date & Time Functions:** TO_DATE(), TO_CHAR(), EXTRACT()
- **String & Type Conversion:** CAST, ::TIME, ::NUMERIC
- **Conditional Statements:** CASE WHEN
- **Window Functions:** RANK() OVER(), PARTITION BY
- **Common Table Expressions:** WITH clause (CTEs)
- **Subqueries:** Nested SELECT statements
- **Joins:** INNER JOIN
- **Data Manipulation:** SELECT, DROP TABLE

## Python Concepts & Libraries Applied

- Pandas DataFrame operations.
- Data loading and inspection.
- Handling duplicate records.
- Missing value treatment.
- Data type conversion.
- String manipulation.
- Creating calculated columns.
- CSV export.
- PostgreSQL connectivity using SQLAlchemy and Psycopg2.
- DataFrame-to-database integration using `to_sql()`.

## Key Business Metrics

The analysis focuses on the following business metrics:

| Metric | Purpose |
|---|---|
| Total Transactions | Measures overall sales activity |
| Total Quantity Sold | Measures product sales volume |
| Average Customer Rating | Evaluates customer satisfaction |
| Category-wise Revenue | Identifies revenue-generating categories |
| Category-wise Profit | Measures category profitability |
| Branch-wise Transactions | Evaluates branch activity |
| Preferred Payment Method | Understands customer payment preferences |
| Revenue Decline Ratio | Identifies branches experiencing declining revenue |

## Project Structure

```text
Walmart-Sales-Analysis/
│
├── Walmart.csv
├── Walmart_cleaned.csv
├── Walmart_Sales_Analysis.ipynb
├── Walmart_SQL_Queries.sql
└── README.md
```

## How to Run This Project

### Prerequisites

Install Python and PostgreSQL on your system.

Install the required Python libraries:

```bash
pip install pandas psycopg2-binary sqlalchemy
```

### Execution Steps

**1. Clone the repository**

```bash
git clone <your-github-repository-url>
```

**2. Open the Jupyter Notebook**

Open `Walmart_Sales_Analysis.ipynb` and execute the cells sequentially.

**3. Configure PostgreSQL**

Create the database:

```sql
CREATE DATABASE walmart_db;
```

Update the PostgreSQL connection string in the Python notebook with your database credentials.

**4. Load the cleaned dataset**

Execute the Python code to clean the data and load it into the PostgreSQL `walmart` table.

**5. Execute SQL queries**

Open `Walmart_SQL_Queries.sql` in pgAdmin 4 and execute the queries to perform business analysis.

## Key Learnings

- Gained practical experience in end-to-end data analytics workflows.
- Improved understanding of data exploration and preprocessing using Pandas.
- Learned to identify and handle duplicate records and missing values.
- Developed practical experience connecting Python applications with PostgreSQL.
- Strengthened SQL skills through real-world business problem-solving.
- Applied window functions and CTEs to perform advanced analytical queries.
- Learned to calculate business metrics such as revenue, profit, and revenue decline ratios.
- Understood how data analysis can help businesses evaluate branch performance and customer purchasing patterns.

## Conclusion

This project provided hands-on experience in performing end-to-end data analysis using Python and PostgreSQL.

By combining Python-based data cleaning with SQL-based business analysis, raw Walmart sales data was transformed into structured and meaningful information. The analysis covered customer payment preferences, product category performance, branch-wise sales trends, profitability, and year-over-year revenue comparisons.

This project strengthened my practical knowledge of Python, Pandas, PostgreSQL, and SQL while demonstrating how data analytics can support business decision-making.

---

**Author:** Dhanush Kumar

**Project Domain:** Data Analytics

**Technologies:** Python | Pandas | PostgreSQL | SQL | SQLAlchemy
