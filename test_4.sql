-- 4.由多种大小、属性和关系的表组成的数据库
-- 创建用户表
CREATE TABLE users (
    id SERIAL PRIMARY KEY,  -- 自动增长的用户ID
    name VARCHAR(255) NOT NULL,  -- 用户姓名
    email VARCHAR(255) UNIQUE NOT NULL,  -- 用户邮箱
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 注册时间
);

-- 创建产品表
CREATE TABLE products (
    id SERIAL PRIMARY KEY,  -- 自动增长的产品ID
    name VARCHAR(255) NOT NULL,  -- 产品名称
    price DECIMAL(10, 2) NOT NULL,  -- 产品价格
    stock INT DEFAULT 0  -- 产品库存
);

-- 创建订单表
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,  -- 自动增长的订单ID
    user_id INT REFERENCES users(id),  -- 外键关联到用户表
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 订单时间
    status VARCHAR(50) DEFAULT 'pending'  -- 订单状态
);

-- 创建订单-产品关联表 (多对多关系)
CREATE TABLE order_items (
    order_id INT REFERENCES orders(id),  -- 外键关联到订单表
    product_id INT REFERENCES products(id),  -- 外键关联到产品表
    quantity INT DEFAULT 1,  -- 产品数量
    PRIMARY KEY (order_id, product_id)  -- 复合主键，保证每个订单每个产品唯一
);

-- 示例数据插入 (多个表涉及)
-- 插入一些用户数据
INSERT INTO users (name, email) VALUES
    ('Alice', 'alice@example.com'),
    ('Bob', 'bob@example.com'),
    ('Charlie', 'charlie@example.com');

-- 插入一些产品数据
INSERT INTO products (name, price, stock) VALUES
    ('Product A', 10.00, 100),
    ('Product B', 20.00, 50),
    ('Product C', 30.00, 200);

-- 插入一些订单数据
INSERT INTO orders (user_id, order_date, status) VALUES
    (1, '2024-12-01', 'pending'),
    (2, '2024-12-02', 'shipped'),
    (3, '2024-12-03', 'delivered');

-- 插入订单-产品关联数据
INSERT INTO order_items (order_id, product_id, quantity) VALUES
    (1, 1, 2),  -- 订单1，购买产品A，2件
    (1, 2, 1),  -- 订单1，购买产品B，1件
    (2, 3, 3),  -- 订单2，购买产品C，3件
    (3, 1, 1);  -- 订单3，购买产品A，1件

INSERT INTO users (name, email)
SELECT 'user' || generate_series(1, 1000000), 'user' || generate_series(1, 1000000) || '@examp';


EXPLAIN ANALYSE
SELECT o.id AS order_id, u.name AS user_name, p.name AS product_name, oi.quantity
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.status = 'shipped';

EXPLAIN ANALYSE
UPDATE products
SET stock = stock - 1
WHERE id IN (SELECT product_id FROM order_items WHERE order_id = 1);

EXPLAIN ANALYSE
DELETE FROM order_items WHERE order_id = 1;

EXPLAIN ANALYSE
SELECT u.name, COUNT(o.id) AS order_count, SUM(oi.quantity) AS total_quantity
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY u.id
ORDER BY total_quantity DESC;

-- 4.1 数据量测试
INSERT INTO users (name, email)
SELECT 'user' || generate_series(1, 1000000), 'user' || generate_series(1, 1000000) || '@examp'

-- 4.2 关联查询测试
SELECT o.id AS order_id, u.name AS user_name, p.name AS product_name, oi.quantity
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.status = 'shipped';

-- 4.3 更新测试
UPDATE products
SET stock = stock - 1
WHERE id IN (SELECT product_id FROM order_items WHERE order_id = 1);

-- 4.4 删除测试
DELETE FROM order_items WHERE order_id = 1;

-- 4.5 复杂查询测试
SELECT u.name, COUNT(o.id) AS order_count, SUM(oi.quantity) AS total_quantity
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY u.id
ORDER BY total_quantity DESC;

