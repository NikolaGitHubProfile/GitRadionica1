drop table if exists price_histories;
drop table if exists compare_product_price;
DROP table if exists products;
DROP table IF EXISTS shops;
DROP TABLE IF exists brands;
drop table if exists categories;
drop table if exists users;
drop table if exists subscriptions;


create table subscriptions 
(
id int auto_increment primary key,
name varchar(100) not null
);

insert into subscriptions 
(name)
values
('gold'),
('platinum');

create table users
(
id int auto_increment primary key,
created_at datetime,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) not null,
password varchar(255) not null,
subscription_id int,
updated_at datetime,

foreign key (subscription_id) references subscriptions(id) on delete set null
);

insert into users 
(created_at, first_name, last_name, email, password, subscription_id, updated_at)
values
(now(), 'Nikola', 'Roginic', 'nikola.roginic@hotmail.com', '12345', 2, now()),
(now(), 'Marko', 'Markic', 'marko.markic@hotmail.com', '12345', 1, now());

create table shops 
(
id int auto_increment primary key,
name varchar(255) not null
);

insert into shops 
(name)
values
('eKupi'),
('abrakadabra');

create table brands 
(
id int auto_increment primary key,
name varchar(50) not null
);

insert into brands 
(name)
values
('Gorenje'),
('Bosch');

create table categories 
(
id int auto_increment primary key,
name varchar(50) not null
);

insert into categories 
(name)
values
('Hladnjaci'),
('Perilice rublja');

create table products
(
id int auto_increment primary key,
created_at datetime,
name varchar(255) not null,
EAN char(13),
model varchar(50),
brand_id int not null,
category_id int not null,

foreign key (brand_id)
references brands(id)
on delete cascade,

foreign key (category_id)
references categories(id)
on delete cascade
);

insert into products 
(created_at, name, EAN, model, brand_id, category_id)
values
(now(),'Gorenje hladnjak NRK6202AXL4',null,'NRK6202AXL4',1,1),
(now(),'Bosch perilica rublja WAN28163BY',null,'WAN28163BY',2,2);

create table compare_product_price
(
id int auto_increment primary key,
created_at datetime,
product_id int not null,
shop_id int not null,
regular_price decimal(18,2) not null,
action_price decimal(18,2),
updated_at datetime,

foreign key (product_id)
references products(id)
on delete cascade,

foreign key (shop_id)
references shops(id)
on delete cascade
);

insert into compare_product_price 
(created_at, product_id, shop_id, regular_price, action_price, updated_at)
values
(now(),1, 1,579.99,649.99,now()),
(now(),2, 1,489.99,599.99,now());

create table price_histories
(
id int auto_increment primary key,
created_at datetime not null,
regular_price decimal(18,2) not null,
action_price decimal(18,2),
product_id int not null,
shop_id int not null,

foreign key (product_id)
references products(id)
on delete cascade,

foreign key (shop_id)
references shops(id)
on delete cascade
);

insert into price_histories 
(created_at, product_id, shop_id, regular_price, action_price)
values
(now(),1, 1,579.99,649.99),
(now(),2, 1,489.99,599.99);


