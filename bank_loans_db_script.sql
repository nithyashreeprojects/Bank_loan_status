-- Drop the existing table
DROP TABLE IF EXISTS loan_applications;

-- Recreate with correct data types
CREATE TABLE loan_applications (
  loan_id VARCHAR(50),
  customer_id VARCHAR(50),
  loan_status VARCHAR(20),
  current_loan_amount NUMERIC(12,2),
  term VARCHAR(20),
  credit_score NUMERIC(5,1),              
  annual_income NUMERIC(14,2),
  years_in_current_job VARCHAR(20),
  home_ownership VARCHAR(20),
  purpose VARCHAR(50),
  monthly_debt NUMERIC(12,2),
  years_of_credit_history NUMERIC(5,2),
  months_since_last_delinquent NUMERIC(6,1),  
  number_of_open_accounts NUMERIC(4,1),       
  number_of_credit_problems NUMERIC(4,1),     
  current_credit_balance NUMERIC(12,2),
  maximum_open_credit NUMERIC(12,2),
  bankruptcies NUMERIC(3,1),                  
  tax_liens NUMERIC(3,1),                     
  debt_to_income_ratio NUMERIC(5,4),
  credit_utilization NUMERIC(5,4),
  loan_to_income_ratio NUMERIC(7,4),
  risk_score NUMERIC(5,1),                    
  customer_segment VARCHAR(20)
);

TRUNCATE TABLE loan_applications;
copy loan_applications FROM '/Users/starboy/Documents/Projects/Bank_loan_status/clean_for_excel.csv' CSV HEADER;


CREATE OR REPLACE VIEW vw_portfolio_overview AS
SELECT
  COUNT(*) AS total_loans,
  ROUND(AVG(current_loan_amount),2) AS avg_loan_amount,
  ROUND(AVG(credit_score),2) AS avg_credit_score,
  ROUND(AVG(annual_income),2) AS avg_income,
  ROUND(AVG(CASE WHEN customer_segment = 'High Risk' THEN 1 ELSE 0 END) * 100,2) AS pct_high_risk,
  ROUND(AVG(CASE WHEN customer_segment = 'Premium' THEN 1 ELSE 0 END) * 100,2) AS pct_premium,
  ROUND(AVG(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100,2) AS pct_default
FROM loan_applications;
