DROP DATABASE umuzi;  --removes db if exists
CREATE DATABASE umuzi; --creates a database called umuzi
/c umuzi; --connects to DB

--creates a table called customers
CREATE TABLE customers (
  customer_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender VARCHAR(6) NOT NULL,
  address VARCHAR(200) NOT NULL,
  phone INT(10) NOT NULL,
  email VARCHAR (100) UNIQUE NOT NULL,
  city VARCHAR(20) NOT NULL,
  country VARCHAR(50) NOT NULL
);

--creates a table called employees
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR (100) UNIQUE NOT NULL,
  job_title VARCHAR(20) NOT NULL
);

CREATE TABLE payments(
  customer_id INT NOT NULL,
  payment_id INT NOT NULL,
  payment_date DATETIME NOT NULL,
  amount NUMERIC(10,2) NOT NULL
);

CREATE TABLE products(
  product_id INT NOT NULL,
  product_name  VARCHAR(100) NOT NULL,
  description VARCHAR(300) NOT NULL,
  buy_price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE orders(
  order_id INT primary key NOT NULL,
  product_id INT REFERENCES products(product_id) UNIQUE(product_id) NOT NULL,
  payment_id INT REFERENCES payments(payment_id) UNIQUE(payment_id) NOT NULL,
  fulfilled_by_employee_id INT REFERENCES employees(employee_id) UNIQUE(fulfilled_by_employee_id) NOT NULL,
  date_required DATE NOT NULL,
  date_shipped DATE NOT NULL,
  order_status VARCHAR(20) NOT NULL
);
\dt  --list all relations

--insert queries inserting values into all the tables
INSERT INTO customers(first_name, last_name, gender, address, phone, email, city, country) VALUES ('John', 'Hibert', 'Male', '284 chaucer st', '084789657', 'john@gmail.com', 'Johannesburg', 'South Africa');
INSERT INTO customers(first_name, last_name, gender, address, phone, email, city, country) VALUES ('Thando', 'Sithole', 'Female', '240 Sect 1', '0794445584', 'thando@gmail.com', 'Cape Town', 'South Africa');
INSERT INTO customers(first_name, last_name, gender, address, phone, email, city, country) VALUES ('Leon', 'Glen', 'Male', '81 Everton Rd,Gillits', '0820832830', 'Leon@gmail.com', 'Durban', 'South Africa');
INSERT INTO customers(first_name, last_name, gender, address, phone, email, city, country) VALUES ('Charl', 'Muller', 'Mal', '290A Dorset Ecke', '+44856872553', 'Charl.muller@yahoo.com', 'Berlin', 'Germany');
INSERT INTO customers(first_name, last_name, gender, address, phone, email, city, country) VALUES ('Julia', 'Stein', 'Female', '2 Wernerring', '+448672445058', 'Js234@yahoo.com', 'Frankfurt', 'Germany');

INSERT INTO employees(first_name, last_name, email, job_title) VALUES ('Kani','Matthew','mat@gmail.com','manager');
INSERT INTO employees(first_name, last_name, email, job_title) VALUES ('Lesly','Cronje','LesC@gmail.com','Clerk');
INSERT INTO employees(first_name, last_name, email, job_title) VALUES ('Gideon','Maduku','m@gmail.com','Accountant');

INSERT INTO orders(product_id, payment_id, fulfilled_by_employee_id, date_required, order_status) VALUES (1, 1, 2, '05-09-2018', 'Not shipped');
INSERT INTO orders(product_id, payment_id, fulfilled_by_employee_id, date_required, date_shipped,order_status) VALUES (1, 2, 2, '04-09-2018', '03-09-2018', 'Shipped');
INSERT INTO orders(product_id, payment_id, fulfilled_by_employee_id, date_required, order_status) VALUES (3, 3, 3, '06-09-2018', 'Not shipped');

INSERT INTO payments(payment_id, payment_date, amount) values ('1', '01-09-2018', '150.75');
INSERT INTO payments(payment_id, payment_date, amount) values ('2', '03-09-2018', '150.75');
INSERT INTO payments(payment_id, payment_date, amount) values ('3', '03-09-2018', '700.60');

INSERT INTO products(product_name, description, buy_price) VALUES ('Harley Davidson Chopper', 'This replica features working kickstand, front suspension, gear-shift lever', '150.75');
INSERT INTO products(product_name, description, buy_price) VALUES ('Classic Car', 'Turnable front wheels, steering function', '550.75');
INSERT INTO products(product_name, description, buy_price) VALUES ('Sports car', 'Turnable front wheels, steering function', '700.60');

--select queries to view the information that was inserted
SELECT * FROM customers;
SELECT first_name FROM customers;
SELECT * FROM customers WHERE customer_id = 1 ; --Show the name of the Customer whose CustomerID is 1

UPDATE customers SET first_name = 'Lerato', last_name = 'Mabitso' WHERE id = 1; --UPDATE the record for CustomerID = 1 on the Customer table so that the name is “Lerato Mabitso”
DELETE FROM customers where id = 2;  --DELETE the record from the Customers table for customer 2

--Select all unique statuses from the Orders table and get a count of the number of orders for each unique status
SELECT order_status FROM orders, COUNT (*) GROUP BY order_status;

--Return the MAXIMUM payment made on the PAYMENTS table
SELECT MAX(amount) FROM payments;

--Select all customers from the “Customers” table, sorted by the “Country”
SELECT * FROM customers ORDER BY country;

--Select all products with a price BETWEEN R100 and R600
SELECT * FROM products WHERE buy_price BETWEEN 100 AND 600;

--Select all fields from “Customers” where country is “Germany” AND city is “Berlin”.
SELECT * FROM customers WHERE country ='Germany' AND city ='Berlin';

--Select all fields from “Customers” where city is “Cape Town” OR “Durban”.
SELECT * FROM customers WHERE (city = 'Cape Town' OR city = 'Durban');

--Select all records from Products where the Price is GREATER than R500
SELECT * FROM products WHERE buy_price > 500;

--Return the sum of the Amounts on the Payments table
SELECT sum(amount) FROM payments;

--Count the number of shipped orders in the Orders table.
SELECT order_status , count(*) from orders WHERE order_status = 'Shipped';

--Return the average price of all Products, in Rands and in Dollars (assume the exchange rate is R12 to the Dollar).
SELECT avg(buy_price), avg(buy_price * 12) FROM products;

--Using INNER JOIN create a query that selects all Payments with Customer information.
SELECT customer.customer_id, first_name, last_name, email, amount, payment_date FROM customer INNER JOIN payment ON payment.customer_id = customer.customer_id;

--Select all products that have turnable front wheels
SELECT * FROM products WHERE description = 'Turnable front wheels, steering function';


