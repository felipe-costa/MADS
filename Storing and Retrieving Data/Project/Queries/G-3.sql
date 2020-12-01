select 
	CONCAT(MinDate, ' - ' , MaxDate) AS `PeriodOfSales`,
    TotalSales AS `TotalSales (euros)`,
    TotalSales / NumberOfYears AS `YearlyAverage`,
    TotalSales / NumberOfMonths AS `MonthlyAverage`
from 
(
	SELECT 
		SUM(total) as TotalSales,
        COUNT(DISTINCT(YEAR(invoice_date))) AS NumberOfYears,
        COUNT(DISTINCT(DATE_FORMAT(invoice_date, '%Y%m'))) AS NumberOfMonths,
        DATE_FORMAT(MIN(invoice_date),'%Y/%m') AS MinDate,
        DATE_FORMAT(MAX(invoice_date),'%Y/%m') AS MaxDate
	FROM invoices IVC
) aux