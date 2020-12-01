SELECT
	C.city AS City,
	SUM(IVC.total) as TotalSales
FROM invoices IVC
INNER JOIN clients C
	ON IVC.client_id = C.id
GROUP BY C.city
ORDER BY 2 DESC