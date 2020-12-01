CREATE TABLE `clients` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `category_id` int,
  `tax_id` int,
  `first_name` varchar(50),
  `last_name` varchar(50),
  `age` int,
  `phone_number` varchar(50),
  `email` varchar(100),
  `street_address` varchar(100),
  `city` varchar(50),
  `state` varchar(50),
  `country` varchar(50),
  `zip_code` varchar(50),
  `vat_number` varchar(50)
);

CREATE TABLE `products` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(50),
  `description` varchar(50),
  `type` varchar(50),
  `segment` varchar(50),
  `brand` varchar(50),
  `price` decimal(38,2),
  `stock` int,
  `avg_rating` float
);

CREATE TABLE `price_history` (
  `product_id` int NOT NULL,
  `old_price` decimal(38,2),
  `new_price` decimal(38,2),
  `updated_by` varchar(100),
  `updated_ts` timestamp NOT NULL,
  PRIMARY KEY (`product_id`, `updated_ts`)
);

CREATE TABLE `invoices` (
  `id` int PRIMARY KEY NOT NULL,
  `client_id` int,
  `company_id` int,
  `invoice_status_id` int,
  `invoice_date` date,
  `payment_due_date` date,
  `subtotal` decimal(38,2),
  `discount` decimal(38,2),
  `tax_rate` float,
  `tax_amount` decimal(38,2),
  `total` decimal(38,2)
);

CREATE TABLE `invoice_status` (
  `id` int PRIMARY KEY NOT NULL,
  `description` varchar(50)
);

CREATE TABLE `invoice_details` (
  `invoice_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int,
  `amount` decimal(38,2),
  PRIMARY KEY (`invoice_id`, `product_id`)
);

CREATE TABLE `tax` (
  `id` int PRIMARY KEY NOT NULL,
  `description` varchar(100),
  `rate` float NOT NULL
);

CREATE TABLE `client_category` (
  `id` int PRIMARY KEY NOT NULL,
  `code` varchar(50),
  `description` varchar(100)
);

CREATE TABLE `company` (
  `id` int PRIMARY KEY NOT NULL,
  `name` varchar(100),
  `vat_number` varchar(100),
  `created_date` date,
  `street_address_1` varchar(100),
  `street_address_2` varchar(100),
  `city` varchar(100),
  `state` varchar(100),
  `country` varchar(100),
  `phone_number` varchar(100),
  `email_address` varchar(100),
  `website` varchar(100)
);

ALTER TABLE `price_history` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

ALTER TABLE `clients` ADD FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`);

ALTER TABLE `clients` ADD FOREIGN KEY (`category_id`) REFERENCES `client_category` (`id`);

ALTER TABLE `invoice_details` ADD FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`);

ALTER TABLE `invoice_details` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`company_id`) REFERENCES `company` (`id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`invoice_status_id`) REFERENCES `invoice_status` (`id`);

