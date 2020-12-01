DELIMITER //
CREATE TRIGGER stock_update_after_invoice
AFTER INSERT
ON invoice_details FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;
END; //

DELIMITER ;