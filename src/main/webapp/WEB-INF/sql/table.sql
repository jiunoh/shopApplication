create table shop(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE,
total_sale INT DEFAULT '0',
total_money INT DEFAULT '0',
is_deleted ENUM('y', 'n') DEFAULT 'n',
reg_date VARCHAR(20),
mod_date VARCHAR(20),
menu VARCHAR(500)
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

create table coffee(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
inventory int,
price int,
register_date VARCHAR(50),
update_date VARCHAR(50)
);

create table totalcoffee(
id int primary key,
name varchar(50),
total_sale int,
total_income int
);


insert into coffee values(0, 'coffee1', 10, 1100, '2018', '2018');
insert into coffee values(0, 'coffee2', 10, 1200, '2018', '2018');
insert into coffee values(0, 'coffee3', 10, 1300, '2018', '2018');
insert into coffee values(0, 'coffee4', 10, 1400, '2018', '2018');
insert into coffee values(0, 'coffee5', 10, 1500, '2018', '2018');
insert into coffee values(0, 'coffee6', 10, 1600, '2018', '2018');
