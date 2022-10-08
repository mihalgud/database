drop database if exists marketplace;
create database if not exists marketplace;
use marketplace;

create table users(
id int primary key auto_increment,
email varchar(50) not null,
phone varchar(15) not null,
password_hash varchar(30) not null,
registration_date datetime not null default now(),
first_name varchar(15) not null,
last_name varchar(20) null);

create table shops(
id int primary key auto_increment,
title varchar(30) not null,
adress varchar(100) not null,
working_hours varchar(50) not null);

create table factories(
id int primary key auto_increment,
title varchar(30) not null,
adress varchar(100) not null,
registration_date datetime not null default now());

create table products(
id int primary key auto_increment,
title varchar(30) not null,
price int unsigned not null,
discount tinyint unsigned not null default 0,
factory_id int,
foreign key (factory_id) references factories (id)
on delete restrict on update cascade);

create table favorite_shops(
user_id int,
shop_id int,
primary key(user_id, shop_id),
foreign key (user_id) references users (id)
on delete restrict on update cascade,
foreign key (shop_id) references shops (id)
on delete restrict on update cascade);

create table favorite_products(
user_id int,
product_id int,
primary key(user_id, product_id),
foreign key (user_id) references users (id)
on delete restrict on update cascade,
foreign key (product_id) references products (id)
on delete restrict on update cascade);

create table buckets(
user_id int,
product_id int,
primary key(user_id, product_id),
foreign key (user_id) references users (id)
on delete restrict on update cascade,
foreign key (product_id) references products (id)
on delete restrict on update cascade);

create table orders(
id int primary key auto_increment,
total_without_discount int unsigned not null,
discount tinyint unsigned not null,
order_datetime datetime not null default now(),
user_id int,
foreign key (user_id) references users (id)
on delete restrict on update cascade);

create table shops_products(
shop_id int,
product_id int,
primary key(shop_id, product_id),
foreign key (product_id) references products (id)
on delete restrict on update cascade,
foreign key (shop_id) references shops (id)
on delete restrict on update cascade);

create table orders_products(
order_id int,
product_id int,
primary key(order_id, product_id),
foreign key (order_id) references orders (id)
on delete restrict on update cascade,
foreign key (product_id) references products (id)
on delete restrict on update cascade);