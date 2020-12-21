DROP USER IF EXISTS 'PDI_User'@'localhost';

CREATE USER 'PDI_User'@'localhost' IDENTIFIED WITH mysql_native_password BY 'awesomepassword';
GRANT ALL PRIVILEGES ON * . * TO 'PDI_User'@'localhost';
FLUSH PRIVILEGES;