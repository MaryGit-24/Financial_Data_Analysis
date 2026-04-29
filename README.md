# SQL Assessment Project – Customer and Financial Data Analysis


## Overview

This project contains SQL queries designed to answer four assessment questions using a sample financial dataset. The goal is to analyze customer behavior, savings, investments, and calculate metrics like frequency, transaction activity, and customer lifetime value.


## Files

    question1.sql – Calculates, per customer, their total savings and investments, including counts and total deposit values.

    question2.sql – Categorizes customers into frequency tiers (High, Medium, Low) based on average transactions per month. Also calculates average monthly transaction count.

    question3.sql – Identifies active savings and investment accounts with no transactions in the last 365 days.

    question4.sql – Estimates customer lifetime value based on account tenure and transaction volume, assuming a profit per transaction of 0.1%.


## Key Concepts & Notes

    1. Anchor Table: In questions where metrics are calculated per customer, users_custom_user is used as the anchor table.

    2. CTEs (Common Table Expressions): Used to structure queries in stages, e.g., calculating transactions, categorizing frequency, or computing months active.

    3. Joins: Left joins are used carefully to ensure all relevant records are included, particularly when some tables may not have transactions.

    4. Aggregates & Grouping: COUNT, SUM, MIN, MAX and other aggregates are used along with GROUP BY to summarize per customer or frequency category.

    5. Handling Nulls & Zero Values: COALESCE and CASE WHEN functions are used to avoid errors in calculations and ensure meaningful results.

    6. Formatting: Dollar values are formatted with comma separators for readability.


## SQL Syntax & Conventions

Comments are included before code blocks and specific calculations to explain the logic.

Aliases are used consistently for tables and columns to improve readability.

CASE WHEN statements are used to categorize values and handle conditional calculations.

TIMESTAMPDIFF is used to calculate account tenure and months active.


## How to Use

    1. Clone or download the repository.

    2. Open each .sql file in your SQL client (MySQL Workbench, DBeaver, etc.).

    3. Run the queries in order if dependencies exist (e.g., CTEs).

    4. Review results and adjust any formatting or thresholds as needed.


## Author
Mary Imeabasi Udo – SQL Assessment for Financial & Customer Data Analysis
