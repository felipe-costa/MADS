-- QUERY G-1
SET @MinDate = '2020-01-01'; -- Define the Minimum Date to Search
SET @MaxDate = '2020-11-30'; -- Define the Maximum Date to Search

SELECT
	C.`first_name`,
	C.`last_name`,
	IVC.`invoice_date`,
	IVC_D.`product_id`,
	P.`type`
FROM invoices IVC
INNER JOIN invoice_details IVC_D -- Joins with the invoice_details table to retrieve the products sold in each invoice
	ON IVC.id = IVC_D.invoice_id
INNER JOIN clients C -- Join with the clients table to retrieve the first and last name
	ON IVC.client_id = C.id
INNER JOIN products P -- Join with the products table to retrieve the type of service
	ON IVC_D.product_id = P.id
WHERE IVC.invoice_date between @MinDate AND @MaxDate -- Filter the invoices for the dates in between the parameters provided
;


-- QUERY G-2
-- The criteria to evaluate the "best" customer is the customer with the highest average spend in a period of 1 year
SELECT
	IVC.client_id,
	AVG(Total) AverageSpendPerOrder
FROM invoices IVC
WHERE invoice_date > DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) -- Filters the Invoices by selecting only the ones within the past year
GROUP BY IVC.client_id -- Groups the data by Client ID
ORDER BY 2 DESC -- Order by the second column (Average Spend)
LIMIT 3 -- Retrieve only the top 3 customers
;

-- QUERY G-3
select 
	CONCAT(MinDate, ' - ' , MaxDate) AS `PeriodOfSales`, -- Construct the field using the min and max date
    TotalSales AS `TotalSales (euros)`,
    TotalSales / NumberOfYears AS `YearlyAverage`,
    TotalSales / NumberOfMonths AS `MonthlyAverage`
from 
(
	SELECT 
		SUM(total) as TotalSales, -- Compute the total amount of sales in the system
        COUNT(DISTINCT(YEAR(invoice_date))) AS NumberOfYears, -- Counts the number of years in the database
        COUNT(DISTINCT(DATE_FORMAT(invoice_date, '%Y%m'))) AS NumberOfMonths, -- Counts the number of Months in the database by computing the YearMonth first
        DATE_FORMAT(MIN(invoice_date),'%Y/%m') AS MinDate, -- Computes the Minimum date in the Database
        DATE_FORMAT(MAX(invoice_date),'%Y/%m') AS MaxDate  -- Computes the Maximum date in the Database
	FROM invoices IVC
) aux
;

-- QUERY G-4
SELECT
	C.city AS City,
	SUM(IVC.total) as TotalSales
FROM invoices IVC
INNER JOIN clients C -- Joins with the clients table to retrieve the city field
	ON IVC.client_id = C.id
GROUP BY C.city
ORDER BY 2 DESC -- Order by the second column (Total Spend)
;

-- QUERY G-5
SELECT 
	DISTINCT city
FROM invoices IVC
INNER JOIN invoice_details IVC_D -- Joins with the invoice_details table to retrieve the produts per invoice
	ON IVC.id = IVC_D.invoice_id
INNER JOIN products P -- Joins with the produtcs table to retrieve the avg_rating
	ON IVC_D.product_id = P.id
INNER JOIN clients C -- Joins with the clients table to retrieve the city field
	ON IVC.client_id = C.id
WHERE P.avg_rating IS NOT NULL -- Filter by products which have a rating
;