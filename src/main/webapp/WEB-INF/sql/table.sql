create table shop(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE,
total_sale INT DEFAULT '0',
total_money INT DEFAULT '0',
is_deleted ENUM('y', 'n') DEFAULT 'n',
reg_date VARCHAR(20),
mod_date VARCHAR(20)
);

create table menu(
shop_name VARCHAR(50),
coffee_name VARCHAR(50)
);

create table sale(
shop_name VARCHAR(50),
coffee_name VARCHAR(50),
total_quantity INT
total_price INT
);