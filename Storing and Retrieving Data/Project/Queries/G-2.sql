SELECT
IVC.client_id,
SUM( (IVC.subtotal - IVC.discount) * ( (IVC.tax_rate / 100.0 ) + 1) ) / COUNT( DISTINCT(id) ) AverageSpendPerOrder
FROM invoices IVC
WHERE invoice_date > DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR)
GROUP BY IVC.client_id
ORDER BY 2 DESC
LIMIT 3