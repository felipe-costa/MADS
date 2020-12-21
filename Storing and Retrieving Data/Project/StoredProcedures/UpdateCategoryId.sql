DROP PROCEDURE IF EXISTS UpdateCategoryId ;

DELIMITER //
CREATE PROCEDURE UpdateCategoryId()
BEGIN
	-- Drops the temporary tables being used in the Stored Procedure
	DROP TEMPORARY TABLE IF EXISTS NonLapsedCustomers;
	DROP TEMPORARY TABLE IF EXISTS CategoryAssignment;

	-- Creates a temporary table containing all the customers that have made a purchase in the last 2 months
	CREATE TEMPORARY TABLE NonLapsedCustomers
	SELECT client_id, SUM(total) as TotalSum FROM invoices
	WHERE invoice_date > DATE_SUB(NOW(), INTERVAL 2 MONTH)
	GROUP BY client_id
	;

	-- disable safe update mode
	SET SQL_SAFE_UPDATES=0;

	-- Updates the clients which have no spend in the past 2 months
	UPDATE clients
		SET category_id  = 4
	WHERE id NOT IN (SELECT client_id FROM NonLapsedCustomers);

	-- enable safe update mode
	SET SQL_SAFE_UPDATES=1;


	-- Computes the Average Spend per client in the past 2 months
	SELECT AVG(TotalSum) FROM NonLapsedCustomers INTO @AverageSpend;

	-- Assign a category with the following logic:
	-- 1. Customers with spend below the average
	-- 2. Customers with spend higher than the average and below 2 * Average
	-- 3. Customers with higher than 2*Average spend
	CREATE TEMPORARY TABLE CategoryAssignment
	SELECT 
		*,
		CASE
			WHEN TotalSum < @AverageSpend THEN 1
			WHEN TotalSum >= @AverageSpend AND TotalSum < 2.0 * @AverageSpend THEN 2
			WHEN TotalSum >= 2.0 * @AverageSpend THEN 3
		END AS CategoryId
	FROM NonLapsedCustomers
    ;

	-- Update the client table with the new categories
	UPDATE clients C
	INNER JOIN CategoryAssignment Cat
		ON C.id = Cat.client_id
	SET C.category_id = Cat.CategoryId
	;

END //

DELIMITER ;
CALL UpdateCategoryId();