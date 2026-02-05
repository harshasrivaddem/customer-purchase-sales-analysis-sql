
# Customer Purchase & Sales Performance Analysis using SQL

## Business Problem
Analyze customer purchase behavior and sales performance across regions, product categories, and time to support data-driven business decisions.

## Tools Used
- MySQL
- SQL (JOINs, CTEs, Window Functions)

## Dataset Overview
The project uses two relational tables:
- **customers**: customer demographics, segment, location, loyalty status
- **orders**: sales transactions including sales, profit, discount, category, region, payment mode, and dates

## Analysis Performed
- Data validation and exploration
- Overall business KPIs (sales, profit, quantity)
- Monthly sales and profit trends
- Regional and product category performance
- Customer purchase behavior analysis
- Top, repeat, and high-value customers
- Discount vs profitability analysis
- Payment mode performance
- Advanced analysis using CTEs and window functions

## Key Insights
- Sales and profitability vary significantly across regions and product categories
- A small group of customers contributes a large share of total revenue
- Repeat and loyal customers generate higher overall sales
- Higher discounts negatively impact profitability
- Clear month-to-month variation in sales trends

## How to Run This Project
1. Run `sample_data.sql` to create the database, tables, and insert sample data
2. Run `analysis_queries.sql` to execute all analysis queries

## Outcome
This project demonstrates the use of SQL to analyze real-world retail data and generate actionable business insights.
