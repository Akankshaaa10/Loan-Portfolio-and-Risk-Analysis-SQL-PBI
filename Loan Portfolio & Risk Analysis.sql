-- ============================================
-- Loan Portfolio & Risk Analysis
-- SQL Reporting Views
-- ============================================



-- ============================================
-- 1. KPI SUMMARY VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_kpi_summary AS

SELECT

    (SELECT COUNT(*) FROM loans) AS total_loan_applications,

    (
        SELECT ROUND(SUM(disbursed_amount),2)
        FROM loans
        WHERE loan_status IN ('Approved','Disbursed')
    ) AS total_disbursed_amount,

    (
        SELECT ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN loan_status IN ('Approved','Disbursed')
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(*),
        2)
        FROM loans
    ) AS approval_rate,

    (
        SELECT ROUND(
            100.0 *
            SUM(amount_paid) /
            NULLIF(SUM(amount_paid + overdue_amount),0),
        2)
        FROM repayments
    ) AS collection_efficiency,

    (
        SELECT ROUND(
            100.0 *
            SUM(
                CASE
                    WHEN repayment_status = 'Overdue'
                    THEN 1
                    ELSE 0
                END
            ) / COUNT(*),
        2)
        FROM repayments
    ) AS delinquency_rate;



-- ============================================
-- 2. LOAN TYPE PERFORMANCE VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_loan_type_performance AS

SELECT

    loan_type,

    COUNT(*) AS total_loans,

    ROUND(SUM(sanctioned_amount),2) AS total_sanctioned_amount,

    ROUND(SUM(disbursed_amount),2) AS total_disbursed_amount,

    ROUND(AVG(interest_rate),2) AS avg_interest_rate

FROM loans

GROUP BY loan_type;



-- ============================================
-- 3. MONTHLY LOAN TREND VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_monthly_loan_trend AS

SELECT

    TO_CHAR(application_date,'YYYY-MM') AS loan_month,

    COUNT(*) AS total_applications,

    ROUND(SUM(disbursed_amount),2) AS total_disbursed_amount

FROM loans

GROUP BY loan_month

ORDER BY loan_month;



-- ============================================
-- 4. LOAN STATUS OVERVIEW VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_loan_status_overview AS

SELECT

    loan_status,

    COUNT(*) AS total_loans

FROM loans

GROUP BY loan_status;



-- ============================================
-- 5. REPAYMENT FUNNEL VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_repayment_funnel AS

SELECT
    'Applications' AS stage,
    COUNT(*) AS total_count
FROM loans

UNION ALL

SELECT
    'Approved',
    COUNT(*)
FROM loans
WHERE loan_status IN ('Approved','Disbursed')

UNION ALL

SELECT
    'Disbursed',
    COUNT(*)
FROM loans
WHERE loan_status = 'Disbursed'

UNION ALL

SELECT
    'Paid',
    COUNT(*)
FROM repayments
WHERE repayment_status = 'Paid';



-- ============================================
-- 6. OVERDUE ANALYSIS VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_overdue_analysis AS

SELECT

    l.loan_type,

    ROUND(SUM(r.overdue_amount),2) AS total_overdue_amount

FROM repayments r

JOIN loans l
ON r.loan_id = l.loan_id

GROUP BY l.loan_type;



-- ============================================
-- 7. TOP RISK CUSTOMERS VIEW
-- ============================================

CREATE OR REPLACE VIEW vw_top_risk_customers AS

SELECT

    c.customer_id,

    c.customer_name,

    c.credit_score,

    ROUND(SUM(r.overdue_amount),2) AS total_overdue_amount,

    COUNT(
        CASE
            WHEN r.repayment_status = 'Overdue'
            THEN 1
        END
    ) AS overdue_instances

FROM customers c

JOIN loans l
ON c.customer_id = l.customer_id

JOIN repayments r
ON l.loan_id = r.loan_id

GROUP BY
    c.customer_id,
    c.customer_name,
    c.credit_score

ORDER BY total_overdue_amount DESC;