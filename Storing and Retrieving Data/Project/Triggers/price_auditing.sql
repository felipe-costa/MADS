DELIMITER //
CREATE TRIGGER price_auditing
AFTER UPDATE
ON products FOR EACH ROW
BEGIN
	IF NEW.price <> OLD.price THEN
		INSERT INTO `price_history`
		(`product_id`,
		`old_price`,
		`new_price`,
		`updated_by`,
		`updated_ts`)
		VALUES
		(NEW.id,
		 OLD.price,
		 NEW.price,
		 USER(),
		 CURRENT_TIMESTAMP());
	END IF;
END; //

DELIMITER ;