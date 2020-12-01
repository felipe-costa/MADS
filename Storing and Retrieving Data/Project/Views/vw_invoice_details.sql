CREATE OR REPLACE VIEW vw_invoice_details
AS
SELECT 
	IVC_D.invoice_id AS `INVOICE ID`,
    P.name AS `PRODUCT NAME`,
    P.price AS `UNIT COST`,
    IVC_D.quantity AS `QUANTITY`,
    IVC_D.amount AS `AMOUNT`
FROM
    invoice_details IVC_D
        INNER JOIN
    products AS P ON IVC_D.product_id = P.id
;