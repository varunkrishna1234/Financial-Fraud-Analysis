-- Total Transactions & Total Value

SELECT COUNT(*) AS TotalTxns, SUM(Amount) AS TotalValue
FROM transactions;

-- Fraudulent Transaction %

SELECT 
  SUM(CASE WHEN Status='Fraud' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS FraudRatePct
FROM transactions;


-- Chargeback Amount

SELECT SUM(Amount) AS ChargebackLoss
FROM transactions
WHERE Status='Chargeback';


-- Top Merchants with Most Fraud

SELECT MerchantID, COUNT(*) AS FraudCount, SUM(Amount) AS FraudValue
FROM transactions
WHERE Status='Fraud'
GROUP BY MerchantID
ORDER BY FraudValue DESC
LIMIT 10;


-- Channel-Wise Breakdown

SELECT Channel, COUNT(*) AS TxnCount, SUM(Amount) AS TotalValue
FROM transactions
GROUP BY Channel
ORDER BY TotalValue DESC;


-- Country Hotspots

SELECT Country, SUM(Amount) AS FraudValue
FROM transactions
WHERE Status='Fraud'
GROUP BY Country
ORDER BY FraudValue DESC;


-- High-Value Outliers

SELECT TransactionID, CustomerID, MerchantID, Amount, TransactionDate
FROM transactions
WHERE Amount > 100000;


-- Revenue Leakage Calculation

SELECT 
  SUM(CASE WHEN Status IN ('Failed','Chargeback') THEN Amount ELSE 0 END) AS RevenueLeakage
FROM transactions;


select * from transactions;


