# Loan Portfolio & Risk Analysis (SQL & Power BI)

## Project Overview

This project analyzes loan portfolio performance and borrower risk using PostgreSQL and Power BI. It focuses on loan applications, approvals, disbursements, repayment behavior, overdue amounts, collection efficiency, and high-risk customer identification.

The goal of this project is to help banks, NBFCs, and fintech lenders monitor portfolio health, improve collections, and make better lending decisions.

---

## Problem Statement

Lending businesses manage thousands of loans across different customer segments and loan types. Without proper analysis, it becomes difficult to track approvals, identify risky borrowers, monitor repayments, and manage delinquency.

This project answers the following questions:

- How many loan applications were received?
- What is the approval rate?
- Which loan types generate the highest disbursed amount?
- How is loan performance trending over time?
- What is the collection efficiency?
- Which loan types have the highest overdue amounts?
- Who are the highest-risk customers?

---

## Tools Used

- PostgreSQL – database creation, SQL analysis, and reporting views
- Power BI – dashboard development, DAX measures, and visual storytelling

---

## Dataset

The dataset is synthetically generated but realistic for lending analytics.

### Main Tables
- customers
- loans
- repayments

---

## Table Structure

### 1. customers
Stores borrower details.

### Key Fields
- customer_id
- customer_name
- gender
- age
- city
- employment_type
- annual_income
- credit_score

### 2. loans
Stores loan application and disbursement details.

### Key Fields
- loan_id
- customer_id
- loan_type
- application_date
- sanctioned_amount
- disbursed_amount
- interest_rate
- loan_term_months
- loan_status
- emi_amount

### 3. repayments
Stores repayment and overdue tracking.

### Key Fields
- repayment_id
- loan_id
- repayment_date
- amount_paid
- overdue_amount
- repayment_status

---

## Database Design

The project follows a relational model:

- One Customer → Many Loans
- One Loan → Many Repayments

Workflow:

CSV Files → PostgreSQL → SQL Reporting Views → Power BI Dashboard

---

## Key Analysis Steps

### 1. Data Preparation
- Generated realistic loan portfolio data
- Applied business logic for approvals, disbursements, and repayments
- Ensured clean relationships between tables
- Maintained proper date and numeric formatting

### 2. SQL Analysis
- Built KPI calculations
- Analyzed loan type performance
- Created monthly loan trend analysis
- Measured overdue amounts
- Identified high-risk customers

### 3. Reporting Views
Created SQL views for reporting and dashboarding:
- vw_kpi_summary
- vw_loan_type_performance
- vw_monthly_loan_trend
- vw_loan_status_overview
- vw_repayment_funnel
- vw_overdue_analysis
- vw_top_risk_customers

### 4. Power BI Modeling
- Imported raw tables and SQL views
- Created relationships between tables
- Built DAX measures for KPIs
- Designed an interactive one-page dashboard

---

## DAX Measures

Key KPIs created in Power BI:

- Total Loan Applications
- Total Disbursed Amount
- Approval Rate
- Collection Efficiency
- Delinquency Rate

---

## Dashboard Metrics

The dashboard includes:
- Total Loan Applications
- Approval Rate
- Total Disbursed Amount
- Collection Efficiency
- Delinquency Rate

---

## Dashboard Insights

Key insights from the analysis:
- Home Loans generated the highest disbursed amount.
- Collection efficiency remained strong across the portfolio.
- Delinquency rate stayed within a realistic risk range.
- Overdue exposure was highest in high-value loan categories.
- A small set of customers contributed disproportionately to overdue amounts.

---

## Business Recommendations

Based on the analysis:
- Strengthen monitoring for high-risk customers
- Focus collections on loan categories with high overdue amounts
- Review approval criteria for riskier segments
- Track delinquency trends monthly
- Prioritize operational follow-up for overdue accounts

---

## Project Outcome

This project demonstrates a complete lending analytics workflow using PostgreSQL and Power BI.

It showcases:
- Relational database design
- SQL reporting views
- KPI analysis
- Risk analysis
- Portfolio performance tracking
- Interactive dashboard development
