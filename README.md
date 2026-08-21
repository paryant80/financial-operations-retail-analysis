# Financial Operations & Retail Transaction Analysis

## Overview

A simple financial operations reporting project built on the UCI Online Retail transaction dataset.

The project focuses on the type of work commonly seen in operations/reporting roles:
- data cleaning and transformation
- transaction-status monitoring
- revenue and cancellation reporting
- data-quality checks
- country/product/monthly analysis
- SQL-based reporting
- basic Python validation

## Tools

- Excel
- Power Query
- MySQL
- Python (Pandas)

## Business Questions

1. What is the total transaction volume?
2. How much revenue was generated from completed transactions?
3. What is the cancelled transaction value?
4. What is the net revenue after cancellations?
5. What is the cancellation rate?
6. Which countries contribute the most revenue?
7. Which products contribute the most revenue?
8. Which months show the highest revenue?
9. How many records have negative quantities?
10. How many records are missing Customer IDs?

## Key Results

- Transaction lines: 541,909
- Completed revenue: 10,644,560.42
- Cancelled value: 896,812.49
- Net revenue: 9,747,747.93
- Cancellation rate: approximately 1.71%
- Negative quantity lines: 10,624
- Missing Customer IDs: 135,080

## Dataset

Source: UCI Online Retail dataset.

Dataset page:
https://archive.ics.uci.edu/dataset/352/online+retail

## Suggested Workflow

Raw Excel -> Power Query -> CleanData -> MySQL -> SQL analysis -> Python validation -> Financial Summary

