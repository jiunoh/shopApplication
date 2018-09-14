create table shop(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
total_sale INT,
total_money INT,
is_deleted ENUM('y', 'n'),
coffee VARCHAR(50)
reg_date VARCHAR(20),
up_date VARCHAR(20)
);

create table menu(
shopname VARCHAR(50),
coffeename VARCHAR(50)
);