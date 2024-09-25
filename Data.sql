-- Tạo cơ sở dữ liệu
Drop database if exists webbanhang;  
CREATE DATABASE webbanhang;
USE webbanhang;

-- Tạo bảng ProductTypes
CREATE TABLE ProductTypes (
    product_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Tạo bảng Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    brand VARCHAR(100),
    quantity INT NOT NULL,
    description TEXT,
    product_type_id INT,
    FOREIGN KEY (product_type_id) REFERENCES ProductTypes(product_type_id)
);

-- Tạo bảng Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL, -- Một số điện thoại chính
    mail VARCHAR(100),
    address TEXT,
    role ENUM('Customer', 'Admin') NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Tạo bảng Discounts
CREATE TABLE Discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    discount_value DECIMAL(5, 2),
    code VARCHAR(50),
    start_date DATE,
    end_date DATE,
    quantity INT,
    discount_type ENUM('Percentage', 'Fixed Amount'),
    cond_discount TEXT,
    active BOOLEAN
);

-- Nếu muốn lưu trữ nhiều số điện thoại cho mỗi người dùng (dạng đa trị):
CREATE TABLE UserPhoneNumbers (
    user_id INT,
    phone_number VARCHAR(15),
    PRIMARY KEY (user_id, phone_number),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2),
    status ENUM('Pending', 'Shipped', 'Delivered', 'Canceled'),
    discount_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id)
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Tạo bảng Carts
CREATE TABLE Carts (
	cart_id INT AUTO_INCREMENT primary key,
    user_id INT,
    total_quantity INT NOT NULL,
    total_price decimal(20,10),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

create table CartDetails(
	cart_id int,
    product_id int,
    quantity int not null,
    total_price decimal(20,10),
    primary key(cart_id, product_id),
    foreign key (cart_id) references Carts(cart_id),
    foreign key (product_id) references Products(product_id)
);

-- Tạo bảng PaymentMethods
CREATE TABLE PaymentMethods (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Tạo bảng Payments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method_id INT,
    date DATETIME,
    amount DECIMAL(10, 2),
    order_id INT,
    FOREIGN KEY (payment_method_id) REFERENCES PaymentMethods(payment_method_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Tạo bảng DiscountDetails
CREATE TABLE DiscountDetails (
    time DATETIME,
    discount_id INT,
    order_id INT,
    PRIMARY KEY (discount_id, order_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
