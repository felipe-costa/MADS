DROP DATABASE IF EXISTS onlinestore;

CREATE DATABASE onlinestore;

USE onlinestore;

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
  `vat` varchar(50)
);

CREATE TABLE `products` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(50),
  `description` varchar(50),
  `type` varchar(50),
  `segment` varchar(50),
  `brand` varchar(50),
  `price` decimal(38,2),
  `stock` int
);

CREATE TABLE `price_history` (
  `product_id` int NOT NULL,
  `price` decimal(38,10),
  `updated_ts` timestamp NOT NULL,
  PRIMARY KEY (`product_id`, `updated_ts`)
);

CREATE TABLE `invoices` (
  `id` int PRIMARY KEY NOT NULL,
  `client_id` int,
  `invoice_date` datetime,
  `subtotal` decimal(38,2),
  `discount` decimal(38,2),
  `tax_rate` varchar(50)
);

CREATE TABLE `invoice_details` (
  `invoice_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` decimal(38,10),
  `amount` decimal(38,2),
  PRIMARY KEY (`invoice_id`, `product_id`)
);

CREATE TABLE `tax` (
  `id` int PRIMARY KEY NOT NULL,
  `description` varchar(50),
  `rate` float NOT NULL
);

CREATE TABLE `client_category` (
  `id` int PRIMARY KEY NOT NULL,
  `code` varchar(50),
  `description` varchar(100)
);

ALTER TABLE `price_history` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

ALTER TABLE `clients` ADD FOREIGN KEY (`tax_id`) REFERENCES `tax` (`id`);

ALTER TABLE `clients` ADD FOREIGN KEY (`category_id`) REFERENCES `client_category` (`id`);

ALTER TABLE `invoice_details` ADD FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`);

ALTER TABLE `invoice_details` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

