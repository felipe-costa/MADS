SET @MinDate = '2020-01-01';
SET @MaxDate = '2020-11-30';

SELECT
	C.`first_name`,
	C.`last_name`,
	IVC.`invoice_date`,
	IVC_D.`product_id`,
	P.`type`
FROM invoices IVC
INNER JOIN invoice_details IVC_D
	ON IVC.id = IVC_D.invoice_id
INNER JOIN clients C
	ON IVC.client_id = C.id
INNER JOIN products P
	ON IVC_D.product_id = P.id
WHERE 1=1
AND IVC.invoice_date between @MinDate AND @MaxDate
;