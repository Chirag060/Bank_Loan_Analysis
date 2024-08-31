-- Retrieving Data
SELECT * FROM financial_loan;

--KPI-1 Finding Total Loan Applications
SELECT COUNT(DISTINCT id) AS Total_Loan_Applications 
FROM financial_loan;

--MTD Loan Applications
SELECT COUNT(DISTINCT id) AS MTD_Loan_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--PMTD Loan Applications
SELECT COUNT(DISTINCT id) AS PMTD_Loan_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--KPI-2 Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan;

--MTD Funded Amount
SELECT SUM(loan_amount) AS MTD_Funded_Amount
FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--PMTD Funded Amount
SELECT SUM(loan_amount) AS PMTD_Funded_Amount
FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--KPI-3 Total Amount Recieved
SELECT SUM(total_payment) AS Total_Amount_Recieved
FROM financial_loan;

--MTD Amount Recieved
SELECT SUM(total_payment) AS MTD_Amount_Recieved
FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--PMTD Amount Recieved
SELECT SUM(total_payment) AS PMTD_Amount_Recieved
FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--KPI-4 Average Interest Rate
SELECT ROUND(AVG(int_rate), 4)*100 AS Average_Interest_Rate
FROM financial_loan;

--MTD Average Interest Rate
SELECT ROUND(AVG(int_rate), 4)*100 AS MTD_Average_Interest_Rate
FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--PMTD Amount Recieved
SELECT ROUND(AVG(int_rate), 4)*100 AS PMTD_Average_Interest_Rate
FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--KPI-4 Average DTI Ratio
SELECT ROUND(AVG(dti),4)*100 AS Average_DTI_Ratio
FROM financial_loan;

--MTD Average DTI Ratio
SELECT ROUND(AVG(dti),4)*100 AS MTD_Average_DTI_Ratio
FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

--PMTD Average DTI Ratio
SELECT ROUND(AVG(dti),4)*100 AS PMTD_Average_DTI_Ratio
FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

--Good Loans Issued
--Good Loans Percentage
SELECT ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / COUNT(id), 2) AS Good_Loan_Percentage
FROM financial_loan;

--Good Loans Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--Good Loans Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--Good Loans Total Recieved Amount
SELECT SUM(total_payment) AS Good_Loan_Total_Received_Amount
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--Bad Loans Issued
--Bad Loans Percentage
SELECT ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(id), 2) AS Bad_Loan_Percentage
FROM financial_loan;


--Bad Loans Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM financial_loan
WHERE loan_status = 'Charged Off';

--Bad Loans Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM financial_loan
WHERE loan_status = 'Charged Off';

--Bad Loans Total Recieved Amount
SELECT SUM(total_payment) AS Bad_Loan_Total_Received_Amount
FROM financial_loan
WHERE loan_status = 'Charged Off';


--Evaluating Loan Status
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        ROUND(AVG(int_rate * 100), 2) AS Interest_Rate,
        ROUND(AVG(dti * 100), 2) AS DTI_Ratio
    FROM
        financial_loan
    GROUP BY
        loan_status;

--Evaluating MTD Loan Status
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

--Evaluating PMTD Loan Status
SELECT 
	loan_status, 
	SUM(total_payment) AS PMTD_Total_Amount_Received, 
	SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 11 
GROUP BY loan_status;

--Bank Loan Report
--Month
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

--State
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

--Term
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;

--Employee Duration
SELECT 
	emp_length AS Employee_Duration, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

--Purpose
SELECT 
	purpose AS Purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

--Home Ownership
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY Home_Ownership
ORDER BY Home_Ownership;
