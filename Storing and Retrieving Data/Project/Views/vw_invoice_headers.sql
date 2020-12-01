CREATE OR REPLACE VIEW vw_invoice_headers AS
    SELECT 
        IVC.id AS INVOICE_NUMBER,
        IVC.invoice_date AS DATE_OF_ISSUE,
        IVC.payment_due_date AS PAYMENT_DUE_DATE,
        CONCAT(C.first_name, ' ', C.last_name) AS CLIENT_NAME,
        C.street_address AS CLIENT_ADDRESS,
        C.city AS CLIENT_CITY,
        C.state AS CLIENT_STATE,
        C.country AS CLIENT_COUNTRY,
        C.zip_code AS CLIENT_ZIP_CODE,
        CO.name AS COMPANY_NAME,
        CO.street_address_1 AS COMPANY_STREET_1,
        CO.street_address_2 AS COMPANY_STREET_2,
        CO.phone_number AS COMPANY_PHONE,
        CO.email_address AS COMPANY_EMAIL,
        CO.website AS COMPANY_WEBSITE,
        IVC.total AS MEASURES_TOTAL,
        IVC.subtotal AS MEASURES_SUBTOTAL,
        IVC.discount AS MEASURES_DISCOUNT,
        IVC.tax_rate AS MEASURES_TAX_RATE,
        IVC.tax_amount AS MEASURES_TAX_AMOUNT
    FROM
        invoices IVC
            INNER JOIN
        clients C ON IVC.client_id = C.id
            INNER JOIN
        company CO ON IVC.company_id = CO.id
;