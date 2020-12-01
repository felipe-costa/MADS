SELECT 
	DISTINCT city
FROM invoices IVC
INNER JOIN invoice_details IVC_D
	ON IVC.id = IVC_D.invoice_id
INNER JOIN products P
	ON IVC_D.product_id = P.id
INNER JOIN clients C
	ON IVC.client_id = C.id
WHERE P.avg_rating IS NOT NULL