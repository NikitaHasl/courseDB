USE shop;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT 'Разделы магазина';
INSERT INTO catalogs (name) VALUES 
('Процессоры'),
('Мат. платы'),
('Видеокарты')
;
SELECT * FROM catalogs;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя пользователя',
    birthday_at DATE COMMENT 'ДР пользователя',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Пользователи';

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название товара',
    description TEXT COMMENT 'Описание товара',
    price DECIMAL(11,2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id)
) COMMENT 'Товарные позиции';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id)
) COMMENT 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
	id SERIAL PRIMARY KEY,
    order_id INT UNSIGNED,
    product_id INT UNSIGNED,
    total INT UNSIGNED DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    product_id INT UNSIGNED,
    discount FLOAT UNSIGNED,
    started_at DATETIME,
    finished_at DATETIME,    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id),
    KEY index_of_product_id(product_id)
) COMMENT 'Состав заказа';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT UNSIGNED,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Запасы на складе';