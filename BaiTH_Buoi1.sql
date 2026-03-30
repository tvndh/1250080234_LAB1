SHOW USER;
-- B?ng s_region
CREATE TABLE s_region (
id NUMBER(7) CONSTRAINT s_region_id_pk PRIMARY KEY,
name VARCHAR2(50) NOT NULL
);
-- B?ng s_dept
CREATE TABLE s_dept (
id NUMBER(7) CONSTRAINT s_dept_id_pk PRIMARY KEY,
name VARCHAR2(25) NOT NULL,
region_id NUMBER(7) CONSTRAINT s_dept_region_id_fk REFERENCES s_region(id)
);
-- B?ng s_title
CREATE TABLE s_title (
id NUMBER(7) CONSTRAINT s_title_id_pk PRIMARY KEY,
title VARCHAR2(50) NOT NULL
);
-- B?ng s_emp
CREATE TABLE s_emp (
id NUMBER(7) CONSTRAINT s_emp_id_pk PRIMARY KEY,
Last_name VARCHAR2(50) NOT NULL,
First_name VARCHAR2(50),
Userid VARCHAR2(8) UNIQUE,
Start_date DATE,
Comments VARCHAR2(255),
Manager_id NUMBER(7),
Salary NUMBER(11,2),
Commission_pct NUMBER(4,2),
title_id NUMBER(7) CONSTRAINT s_emp_title_id_fk REFERENCES s_title(id),
dept_id NUMBER(7) CONSTRAINT s_emp_dept_id_fk REFERENCES s_dept(id)
);
-- B?ng s_customer
CREATE TABLE s_customer (
id NUMBER(7) CONSTRAINT s_customer_id_pk PRIMARY KEY,
Name VARCHAR2(50) NOT NULL,
Phone VARCHAR2(25),
Address VARCHAR2(100),
City VARCHAR2(50),
State VARCHAR2(50),
Country VARCHAR2(50),
Zip_code VARCHAR2(15),
Credit_rating VARCHAR2(20),
Sales_rep_id NUMBER(7) CONSTRAINT s_customer_sales_rep_fk REFERENCES s_emp(id),
Comments VARCHAR2(100),
region_id NUMBER(7) CONSTRAINT s_customer_region_id_fk REFERENCES s_region(id)
);
-- B?ng s_image
CREATE TABLE  s_image (
id NUMBER(7) CONSTRAINT  s_image_id_pk PRIMARY KEY,
Format VARCHAR2(20),
Use_filename CHAR(1),
Filename VARCHAR2(255),
image BLOB
);
-- B?ng s_longtext
CREATE TABLE  s_longtext (
id NUMBER(7) CONSTRAINT  s_longtext_id_pk PRIMARY KEY,
Use_filename CHAR(1),
Filename VARCHAR2(255),
text CLOB
);
-- B?ng s_product
CREATE TABLE  s_product (
id NUMBER(7) CONSTRAINT  s_product_id_pk PRIMARY KEY,
Name VARCHAR2(50) NOT NULL,
Short_desc VARCHAR2(255),
longtext_id NUMBER(7) CONSTRAINT s_product_longtext_fk REFERENCES s_longtext(id),
image_id NUMBER(7) CONSTRAINT s_product_image_fk REFERENCES s_image(id),
suggested_whlsl_price NUMBER(11,2),
whlsl_units VARCHAR2(25)
);
-- B?ng s_ord
CREATE TABLE  s_ord (
id NUMBER(7) CONSTRAINT  s_ord_id_pk PRIMARY KEY,
customer_id NUMBER(7) CONSTRAINT s_ord_customer_id_fk REFERENCES s_customer(id),
date_ordered DATE,
date_shipped DATE,
sales_rep_id NUMBER(7) CONSTRAINT s_ord_sales_rep_id_fk REFERENCES s_emp(id),
total NUMBER(11,2),
payment_type VARCHAR2(50),
order_filled CHAR(1) CONSTRAINT s_ord_filled_ck CHECK (order_filled IN ('Y', 'N'))
);
-- B?ng s_item 
CREATE TABLE  s_item (
ord_id NUMBER(7),
item_id NUMBER(7),
price NUMBER(11,2),
quantity NUMBER(7),
quantity_shipped NUMBER(7),
CONSTRAINT s_item_pk PRIMARY KEY (ord_id, item_id),
CONSTRAINT s_item_ord_id_fk FOREIGN KEY (ord_id) REFERENCES s_ord(id),
product_id NUMBER(7) CONSTRAINT s_item_product_id_fk REFERENCES s_product(id)
);
-- B?ng s_inventory
CREATE TABLE  s_inventory (
product_id NUMBER(7) CONSTRAINT s_inv_product_id_fk REFERENCES s_product(id),
warehouse_id NUMBER(7),
amount_in_stock NUMBER(7),
reorder_point NUMBER(7),
max_in_stock NUMBER(7),
out_of_stock_explanation VARCHAR2(255),
restock_date DATE,
CONSTRAINT s_inventory_pk PRIMARY KEY (product_id, warehouse_id)
);
-- B?ng s_warehouse
CREATE TABLE  s_warehouse (
id NUMBER(7) CONSTRAINT s_warehouse_id_pk PRIMARY KEY,
region_id NUMBER(7) CONSTRAINT s_warehouse_region_id_fk REFERENCES s_region(id),
address VARCHAR2(100),
city VARCHAR2(50),
state VARCHAR2(50),
country VARCHAR2(50),
zip_code VARCHAR2(15),
phone VARCHAR2(25),
manager_id NUMBER(7) CONSTRAINT s_warehouse_manager_id_fk REFERENCES s_emp(id)
);
-- Ki?m tra c?u trúc d? li?u b?ng
DESC s_emp;
DESC s_dept;
DESC  s_region 
DESC  s_title 
DESC s_customer 
DESC s_image
DESC s_longtext
DESC s_product 
DESC s_ord 
DESC s_item 
DESC s_inventory
DESC s_warehouse. 
-- Nh?p d? li?u b?ng
-- s_region;
INSERT INTO s_region (id, name) VALUES (1, 'North America');
INSERT INTO s_region (id, name) VALUES (2, 'South America');
INSERT INTO s_region (id, name) VALUES (3, 'Central America');
INSERT INTO s_region (id, name) VALUES (4, 'Caribbean');
INSERT INTO s_region (id, name) VALUES (5, 'Western Europe');
INSERT INTO s_region (id, name) VALUES (6, 'Eastern Europe');
INSERT INTO s_region (id, name) VALUES (7, 'Northern Europe');
INSERT INTO s_region (id, name) VALUES (8, 'Southern Europe');
INSERT INTO s_region (id, name) VALUES (9, 'East Asia');
INSERT INTO s_region (id, name) VALUES (10, 'Southeast Asia');
INSERT INTO s_region (id, name) VALUES (11, 'South Asia');
INSERT INTO s_region (id, name) VALUES (12, 'Central Asia');
INSERT INTO s_region (id, name) VALUES (13, 'Middle East');
INSERT INTO s_region (id, name) VALUES (14, 'North Africa');
INSERT INTO s_region (id, name) VALUES (15, 'Sub-Saharan Africa');
INSERT INTO s_region (id, name) VALUES (16, 'Oceania');
INSERT INTO s_region (id, name) VALUES (17, 'Asia Pacific (APAC)');
INSERT INTO s_region (id, name) VALUES (18, 'Latin America (LATAM)');
INSERT INTO s_region (id, name) VALUES (19, 'Europe, Middle East, Africa (EMEA)');
INSERT INTO s_region (id, name) VALUES (20, 'Nordics');

COMMIT;
-- s_emp;
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (1, 'Smith', 'John', 'jsmith', TO_DATE('2018-01-15', 'YYYY-MM-DD'), 'Ð?i di?n pháp lu?t', NULL, 50000, NULL, 1, 150);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (2, 'Tran', 'Binh', 'btran', TO_DATE('2019-03-01', 'YYYY-MM-DD'), 'Qu?n l? m?ng kinh doanh', 1, 40000, NULL, 2, 10);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (3, 'Nguyen', 'Lan', 'lnguyen', TO_DATE('2019-06-20', 'YYYY-MM-DD'), 'CEO ði?u hành', 1, 45000, NULL, 3, 150);

INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (4, 'Le', 'Hoang', 'hle', TO_DATE('2020-01-10', 'YYYY-MM-DD'), 'Giám ð?c tài chính', 1, 38000, NULL, 4, 50);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (5, 'Pham', 'Duy', 'dpham', TO_DATE('2020-05-12', 'YYYY-MM-DD'), 'Giám ð?c công ngh?', 1, 39000, NULL, 5, 60);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (6, 'Vu', 'Thanh', 'tvu', TO_DATE('2021-02-18', 'YYYY-MM-DD'), 'Qu?n l? khu v?c B?c M?', 2, 25000, NULL, 6, 10);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (7, 'Ho', 'Mai', 'mho', TO_DATE('2021-07-25', 'YYYY-MM-DD'), 'Qu?n l? chi nhánh chính', 2, 22000, NULL, 7, 100);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (8, 'Dang', 'Khoa', 'kdang', TO_DATE('2021-11-30', 'YYYY-MM-DD'), 'Qu?n l? kho v?n', 3, 20000, NULL, 18, 110);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (9, 'Bui', 'Tuan', 'tbui', TO_DATE('2022-01-05', 'YYYY-MM-DD'), 'Nhân viên bán hàng xu?t s?c', 6, 12000, 0.15, 8, 10);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (10, 'Do', 'Quyen', 'qdo', TO_DATE('2022-03-14', 'YYYY-MM-DD'), 'Chuyên viên Marketing', 7, 15000, NULL, 9, 20);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (11, 'Ngo', 'Tien', 'tngo', TO_DATE('2022-04-22', 'YYYY-MM-DD'), 'H? tr? IT n?i b?', 5, 14000, NULL, 10, 30);

INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (12, 'Duong', 'Hoa', 'hduong', TO_DATE('2022-06-11', 'YYYY-MM-DD'), 'Chuyên viên nhân s?', 3, 13000, NULL, 11, 40);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (13, 'Ly', 'Nam', 'nly', TO_DATE('2022-08-09', 'YYYY-MM-DD'), 'Phân tích tài chính', 4, 16000, NULL, 12, 50);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (14, 'Mac', 'Dinh', 'dmac', TO_DATE('2022-10-15', 'YYYY-MM-DD'), 'K? sý ph?n m?m (Backend)', 5, 18000, NULL, 13, 60);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (15, 'Trinh', 'Kieu', 'ktrinh', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Khoa h?c d? li?u', 5, 19000, NULL, 14, 180);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (16, 'Dinh', 'Van', 'vdinh', TO_DATE('2023-02-28', 'YYYY-MM-DD'), 'Chãm sóc khách hàng', 7, 10000, NULL, 15, 80);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (17, 'Lam', 'Phong', 'plam', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'C? v?n pháp l?', 3, 21000, NULL, 16, 90);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (18, 'Phan', 'Chau', 'cphan', TO_DATE('2023-07-07', 'YYYY-MM-DD'), 'Ði?u ph?i v?n hành', 8, 13500, NULL, 17, 100);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (19, 'Ton', 'Nu', 'nton', TO_DATE('2023-09-12', 'YYYY-MM-DD'), 'Ki?m th? ph?n m?m QA/QC', 5, 14500, NULL, 19, 120);
INSERT INTO s_emp (id, Last_name, First_name, Userid, Start_date, Comments, Manager_id, Salary, Commission_pct, title_id, dept_id) 
VALUES (20, 'Vo', 'Ngan', 'nvo', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Tr? l? hành chính', 3, 9000, NULL, 20, 150);
COMMIT;
-- s_dept;
INSERT INTO s_dept (id, name, region_id) VALUES (10, 'Sales', 1);
INSERT INTO s_dept (id, name, region_id) VALUES (20, 'Marketing', 2);
INSERT INTO s_dept (id, name, region_id) VALUES (30, 'IT Support', 3);
INSERT INTO s_dept (id, name, region_id) VALUES (40, 'Human Resources', 4);
INSERT INTO s_dept (id, name, region_id) VALUES (50, 'Finance', 5);
INSERT INTO s_dept (id, name, region_id) VALUES (60, 'Engineering', 6);
INSERT INTO s_dept (id, name, region_id) VALUES (70, 'Research and Dev', 7);
INSERT INTO s_dept (id, name, region_id) VALUES (80, 'Customer Service', 8);
INSERT INTO s_dept (id, name, region_id) VALUES (90, 'Legal', 9);
INSERT INTO s_dept (id, name, region_id) VALUES (100, 'Operations', 10);
INSERT INTO s_dept (id, name, region_id) VALUES (110, 'Logistics', 11);
INSERT INTO s_dept (id, name, region_id) VALUES (120, 'Quality Assurance', 12);
INSERT INTO s_dept (id, name, region_id) VALUES (130, 'Procurement', 13);
INSERT INTO s_dept (id, name, region_id) VALUES (140, 'Public Relations', 14);
INSERT INTO s_dept (id, name, region_id) VALUES (150, 'Administration', 15);
INSERT INTO s_dept (id, name, region_id) VALUES (160, 'Training', 16);
INSERT INTO s_dept (id, name, region_id) VALUES (170, 'Product Management', 17);
INSERT INTO s_dept (id, name, region_id) VALUES (180, 'Data Analytics', 18);
INSERT INTO s_dept (id, name, region_id) VALUES (190, 'Security', 19);
INSERT INTO s_dept (id, name, region_id) VALUES (200, 'Facilities', 20);

COMMIT;
-- s_title 
INSERT INTO s_title (id, title) VALUES (1, 'President');
INSERT INTO s_title (id, title) VALUES (2, 'Vice President');
INSERT INTO s_title (id, title) VALUES (3, 'Chief Executive Officer (CEO)');
INSERT INTO s_title (id, title) VALUES (4, 'Chief Financial Officer (CFO)');
INSERT INTO s_title (id, title) VALUES (5, 'Chief Technology Officer (CTO)');
INSERT INTO s_title (id, title) VALUES (6, 'Regional Manager');
INSERT INTO s_title (id, title) VALUES (7, 'Branch Manager');
INSERT INTO s_title (id, title) VALUES (8, 'Sales Representative');
INSERT INTO s_title (id, title) VALUES (9, 'Marketing Specialist');
INSERT INTO s_title (id, title) VALUES (10, 'IT Support Specialist');
INSERT INTO s_title (id, title) VALUES (11, 'Human Resources Generalist');
INSERT INTO s_title (id, title) VALUES (12, 'Financial Analyst');
INSERT INTO s_title (id, title) VALUES (13, 'Software Engineer');
INSERT INTO s_title (id, title) VALUES (14, 'Data Scientist');
INSERT INTO s_title (id, title) VALUES (15, 'Customer Service Representative');
INSERT INTO s_title (id, title) VALUES (16, 'Legal Counsel');
INSERT INTO s_title (id, title) VALUES (17, 'Operations Coordinator');
INSERT INTO s_title (id, title) VALUES (18, 'Logistics Manager');
INSERT INTO s_title (id, title) VALUES (19, 'Quality Assurance Tester');
INSERT INTO s_title (id, title) VALUES (20, 'Administrative Assistant');
COMMIT;
-- s_customer 
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (1, 'TechCorp', '555-0101', '100 Silicon Way', 'San Jose', 'CA', 'USA', '95112', 'EXCELLENT', 9, 'Khách hàng VIP', 1);

INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (2, 'Global Logistics', '555-0102', '200 Harbor Dr', 'Seattle', 'WA', 'USA', '98101', 'GOOD', 6, 'Giao hàng ðý?ng bi?n', 1);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (3, 'Rio Import', '55-21-9999-0000', 'Copacabana Ave 10', 'Rio de Janeiro', 'RJ', 'Brazil', '22070', 'FAIR', 7, 'Thanh toán ch?m 5 ngày', 2);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (4, 'EuroTrade', '44-20-7946-0111', '50 Bank St', 'London', 'LND', 'UK', 'E14 5NT', 'GOOD', 16, 'Khách hàng m?i', 5);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (5, 'Berlin Motors', '49-30-123456', 'Alexanderplatz 1', 'Berlin', 'BE', 'Germany', '10178', 'EXCELLENT', 6, 'Ð?i tác chi?n lý?c', 5);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (6, 'Krakow Goods', '48-12-345-678', 'Rynek Glowny 5', 'Krakow', 'MA', 'Poland', '31-042', 'POOR', 16, 'C?n nh?c n?', 6);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (7, 'Tokyo Electronics', '81-3-3211-1234', '1-1 Marunouchi', 'Tokyo', 'TKY', 'Japan', '100-0005', 'EXCELLENT', 9, 'Thanh toán ðúng h?n', 9);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (8, 'Seoul Tech', '82-2-123-4567', 'Gangnam-daero 100', 'Seoul', 'SEL', 'South Korea', '06234', 'GOOD', 7, 'Hay mua s?', 9);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (9, 'Vietnam Import Export', '028-3829-1111', '1 Le Duan', 'Ho Chi Minh', 'SG', 'Vietnam', '700000', 'EXCELLENT', 9, 'Ðang m? r?ng quy mô', 10);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (10, 'Thai Silk Co', '66-2-987-6543', 'Sukhumvit Rd', 'Bangkok', 'BKK', 'Thailand', '10110', 'GOOD', 16, 'Khách hàng lâu nãm', 10);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (11, 'Maju Logistics', '60-3-1111-2222', 'Jalan Ampang', 'Kuala Lumpur', 'KL', 'Malaysia', '50450', 'FAIR', 6, 'C?n chãm sóc thêm', 10);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (12, 'Dubai Traders', '971-4-1234567', 'Sheikh Zayed Rd', 'Dubai', 'DU', 'UAE', '12345', 'EXCELLENT', 7, 'S?c mua r?t l?n', 13);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (13, 'Cairo Bazaars', '20-2-7654321', 'Tahrir Square', 'Cairo', 'CAI', 'Egypt', '11511', 'POOR', 16, 'H?n m?c tín d?ng th?p', 14);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (14, 'Cape Town Mining', '27-21-555-4444', 'Long Street 50', 'Cape Town', 'WC', 'South Africa', '8001', 'GOOD', 9, 'Thý?ng xuyên ð?t hàng', 15);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (15, 'Sydney Imports', '61-2-9876-5432', 'George St 100', 'Sydney', 'NSW', 'Australia', '2000', 'EXCELLENT', 6, 'Giao hàng nhanh', 16);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (16, 'Kiwi Fruits', '64-9-123-4567', 'Queen St', 'Auckland', 'AUK', 'New Zealand', '1010', 'GOOD', 7, 'Khách buôn s?', 16);

INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (17, 'Toronto Maple Goods', '1-416-555-0198', 'Bay Street 200', 'Toronto', 'ON', 'Canada', 'M5J 2J5', 'EXCELLENT', 9, 'Ð?i tác ð?c quy?n', 1);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (18, 'Mumbai Textiles', '91-22-2222-3333', 'Marine Drive', 'Mumbai', 'MH', 'India', '400020', 'FAIR', 16, 'Khách hàng nh?y c?m v? giá', 11);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (19, 'Nordic Designs', '46-8-123-45-67', 'Sveavägen 50', 'Stockholm', 'ST', 'Sweden', '111 34', 'GOOD', 6, 'Yêu c?u ch?t lý?ng cao', 20);
INSERT INTO s_customer (id, Name, Phone, Address, City, State, Country, Zip_code, Credit_rating, Sales_rep_id, Comments, region_id) 
VALUES (20, 'Mexican Flavors', '52-55-1234-5678', 'Reforma 222', 'Mexico City', 'CDMX', 'Mexico', '06600', 'GOOD', 7, 'Ð?t hàng theo qu?', 18);
COMMIT;
-- s_image
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (1, 'JPEG', 'Y', 'product_101.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (2, 'PNG', 'Y', 'product_102.png', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (3, 'JPEG', 'Y', 'product_103.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (4, 'GIF', 'Y', 'banner_summer.gif', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (5, 'JPEG', 'N', NULL, EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (6, 'PNG', 'Y', 'logo_company.png', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (7, 'JPEG', 'Y', 'product_107.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (8, 'JPEG', 'Y', 'product_108.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (9, 'PNG', 'N', NULL, EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (10, 'JPEG', 'Y', 'product_110.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (11, 'JPEG', 'Y', 'product_111.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (12, 'PNG', 'Y', 'product_112.png', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (13, 'JPEG', 'Y', 'product_113.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (14, 'GIF', 'Y', 'sale_animation.gif', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (15, 'JPEG', 'Y', 'product_115.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (16, 'PNG', 'Y', 'product_116.png', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (17, 'JPEG', 'N', NULL, EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (18, 'JPEG', 'Y', 'product_118.jpg', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (19, 'PNG', 'Y', 'product_119.png', EMPTY_BLOB());
INSERT INTO s_image (id, Format, Use_filename, Filename, image) VALUES (20, 'JPEG', 'Y', 'product_120.jpg', EMPTY_BLOB());
COMMIT;
-- s_longtext
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (1, 'Y', 'desc_101.txt', 'Mô t? chi ti?t cho s?n ph?m 101.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (2, 'Y', 'desc_102.txt', 'Mô t? chi ti?t cho s?n ph?m 102. Tính nãng vý?t tr?i.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (3, 'N', NULL, 'Bài vi?t hý?ng d?n s? d?ng s?n ph?m 103.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (4, 'Y', 'manual_104.txt', 'Tài li?u k? thu?t và b?o hành s?n ph?m 104.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (5, 'N', NULL, 'Chính sách ð?i tr? và quy ð?nh chung.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (6, 'Y', 'desc_106.txt', 'Mô t? chi ti?t cho s?n ph?m 106. Thi?t k? sang tr?ng.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (7, 'Y', 'desc_107.txt', 'Ðánh giá chuyên sâu v? hi?u nãng c?a m?t hàng 107.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (8, 'N', NULL, 'Thông tin khuy?n m?i áp d?ng cho tháng này.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (9, 'Y', 'desc_109.txt', 'Mô t? chi ti?t cho s?n ph?m 109. D? dàng s? d?ng.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (10, 'Y', 'desc_110.txt', 'Mô t? chi ti?t cho s?n ph?m 110. Ti?t ki?m nãng lý?ng.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (11, 'N', NULL, 'Ði?u kho?n d?ch v? dành cho khách hàng VIP.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (12, 'Y', 'desc_112.txt', 'Mô t? chi ti?t cho s?n ph?m 112. Phù h?p m?i l?a tu?i.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (13, 'Y', 'desc_113.txt', 'Hý?ng d?n l?p ð?t và cài ð?t ph?n m?m cho thi?t b? 113.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (14, 'N', NULL, 'L?ch s? h?nh thành và phát tri?n c?a công ty.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (15, 'Y', 'desc_115.txt', 'Mô t? chi ti?t cho s?n ph?m 115. Ð? b?n cao.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (16, 'Y', 'desc_116.txt', 'Thông s? k? thu?t c?a h? th?ng 116.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (17, 'N', NULL, 'Các câu h?i thý?ng g?p (FAQ) v? s?n ph?m.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (18, 'Y', 'desc_118.txt', 'Mô t? chi ti?t cho s?n ph?m 118. Màu s?c ða d?ng.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (19, 'Y', 'desc_119.txt', 'Báo cáo ki?m ð?nh ch?t lý?ng s?n ph?m 119.');
INSERT INTO s_longtext (id, Use_filename, Filename, text) VALUES (20, 'N', NULL, 'Cam k?t b?o v? môi trý?ng và phát tri?n b?n v?ng.');
COMMIT;
-- s_product 
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (1, 'Laptop Pro 15', 'Laptop cao c?p m?ng nh?', 1, 1, 1500.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (2, 'Smartphone Ultra', 'Màn h?nh OLED 6.7 inch', 2, 2, 900.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (3, 'Bàn phím cõ', 'Switch Cherry MX Red', 3, 3, 85.50, 'B?');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (4, 'Chu?t không dây', 'Ð? tr? siêu th?p', 4, 4, 45.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (5, 'Màn h?nh 4K', 'T?n s? quét 144Hz', 5, 5, 350.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (6, 'Tai nghe ch?ng ?n', 'Pin 30 gi? liên t?c', 6, 6, 120.00, 'H?p');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (7, '? c?ng SSD 1TB', 'T?c ð? ð?c ghi siêu t?c', 7, 7, 95.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (8, 'RAM 16GB DDR4', 'Bus 3200MHz', 8, 8, 60.00, 'Thanh');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (9, 'Card ð? h?a RTX', 'H? tr? Ray Tracing', 9, 9, 750.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (10, 'Bo m?ch ch?', 'Chipset th? h? m?i nh?t', 10, 10, 180.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (11, 'Ngu?n máy tính 750W', 'Ch?ng nh?n 80 Plus Gold', 11, 11, 80.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (12, 'V? case máy tính', 'Kính cý?ng l?c', 12, 12, 55.00, 'Thùng');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (13, 'T?n nhi?t ný?c', 'H? tr? socket m?i nh?t', 13, 13, 110.00, 'B?');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (14, 'Webcam HD', 'Ð? phân gi?i 1080p', 14, 14, 40.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (15, 'Microphone Studio', 'Thu âm podcast chuyên nghi?p', 15, 15, 150.00, 'B?');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (16, 'Loa Bluetooth', 'Kháng ný?c IP67', 16, 16, 65.00, 'H?p');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (17, 'Cáp s?c ða nãng', 'H? tr? s?c nhanh 65W', 17, 17, 15.00, 'S?i');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (18, 'Pin s?c d? ph?ng', 'Dung lý?ng 20000mAh', 18, 18, 30.00, 'H?p');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (19, 'Giá ð? ði?n tho?i', 'H?p kim nhôm nguyên kh?i', 19, 19, 12.00, 'Cái');
INSERT INTO s_product (id, Name, Short_desc, longtext_id, image_id, suggested_whlsl_price, whlsl_units) VALUES (20, 'Balo ch?ng s?c', 'Ð?ng v?a laptop 15.6 inch', 20, 20, 25.00, 'Cái');
COMMIT;
-- s_ord 
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (1, 1, TO_DATE('2025-01-05', 'YYYY-MM-DD'), TO_DATE('2025-01-08', 'YYYY-MM-DD'), 9, 1500.50, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (2, 5, TO_DATE('2025-01-10', 'YYYY-MM-DD'), TO_DATE('2025-01-12', 'YYYY-MM-DD'), 6, 2300.00, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (3, 12, TO_DATE('2025-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-20', 'YYYY-MM-DD'), 7, 5400.75, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (4, 4, TO_DATE('2025-01-18', 'YYYY-MM-DD'), TO_DATE('2025-01-22', 'YYYY-MM-DD'), 16, 850.00, 'CASH', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (5, 8, TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-05', 'YYYY-MM-DD'), 7, 1250.25, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (6, 15, TO_DATE('2025-02-10', 'YYYY-MM-DD'), TO_DATE('2025-02-14', 'YYYY-MM-DD'), 6, 3100.00, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (7, 20, TO_DATE('2025-02-15', 'YYYY-MM-DD'), NULL, 7, 450.00, 'CREDIT CARD', 'N');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (8, 9, TO_DATE('2025-03-01', 'YYYY-MM-DD'), TO_DATE('2025-03-03', 'YYYY-MM-DD'), 9, 6200.50, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (9, 3, TO_DATE('2025-03-05', 'YYYY-MM-DD'), TO_DATE('2025-03-10', 'YYYY-MM-DD'), 7, 1150.00, 'CASH', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (10, 18, TO_DATE('2025-03-12', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'), 16, 2750.00, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (11, 2, TO_DATE('2025-04-02', 'YYYY-MM-DD'), TO_DATE('2025-04-06', 'YYYY-MM-DD'), 6, 890.00, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (12, 11, TO_DATE('2025-04-10', 'YYYY-MM-DD'), NULL, 6, 1340.50, 'CREDIT CARD', 'N');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (13, 14, TO_DATE('2025-04-20', 'YYYY-MM-DD'), TO_DATE('2025-04-25', 'YYYY-MM-DD'), 9, 4100.00, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (14, 7, TO_DATE('2025-05-05', 'YYYY-MM-DD'), TO_DATE('2025-05-08', 'YYYY-MM-DD'), 9, 530.25, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (15, 17, TO_DATE('2025-05-15', 'YYYY-MM-DD'), TO_DATE('2025-05-20', 'YYYY-MM-DD'), 9, 2900.00, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (16, 10, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), 16, 1650.00, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (17, 19, TO_DATE('2025-06-10', 'YYYY-MM-DD'), NULL, 6, 780.00, 'CASH', 'N');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (18, 13, TO_DATE('2025-06-20', 'YYYY-MM-DD'), TO_DATE('2025-06-25', 'YYYY-MM-DD'), 16, 3450.75, 'BANK TRANSFER', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (19, 6, TO_DATE('2025-07-05', 'YYYY-MM-DD'), TO_DATE('2025-07-09', 'YYYY-MM-DD'), 16, 1200.00, 'CREDIT CARD', 'Y');
INSERT INTO s_ord (id, customer_id, date_ordered, date_shipped, sales_rep_id, total, payment_type, order_filled) VALUES (20, 1, TO_DATE('2025-07-15', 'YYYY-MM-DD'), TO_DATE('2025-07-18', 'YYYY-MM-DD'), 9, 4900.50, 'BANK TRANSFER', 'Y');
COMMIT;
-- s_item 
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (1, 1, 1, 1500.00, 1, 1);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (1, 2, 4, 45.00, 2, 2);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (2, 1, 2, 900.00, 2, 2);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (2, 2, 6, 120.00, 4, 4);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (3, 1, 5, 350.00, 10, 10);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (3, 2, 9, 750.00, 2, 2);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (3, 3, 11, 80.00, 5, 5);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (4, 1, 3, 85.50, 10, 10);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (5, 1, 10, 180.00, 5, 5);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (5, 2, 8, 60.00, 6, 6);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (6, 1, 1, 1500.00, 2, 2);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (7, 1, 7, 95.00, 4, 0);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (7, 2, 12, 55.00, 1, 0);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (8, 1, 2, 900.00, 5, 5);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (8, 2, 16, 65.00, 10, 10);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (9, 1, 14, 40.00, 25, 25);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (10, 1, 13, 110.00, 20, 20);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (10, 2, 15, 150.00, 3, 3);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (11, 1, 19, 12.00, 50, 50);
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity, quantity_shipped) VALUES (12, 1, 20, 25.00, 40, 0);
COMMIT;
-- s_inventory
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (1, 1, 50, 10, 100, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (2, 1, 5, 20, 150, 'Thi?u linh ki?n l?p ráp', TO_DATE('2026-04-15', 'YYYY-MM-DD'));
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (3, 2, 200, 50, 500, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (4, 2, 0, 30, 200, 'Nhà cung c?p ch?m tr?', TO_DATE('2026-04-10', 'YYYY-MM-DD'));
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (5, 3, 45, 15, 100, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (6, 3, 120, 40, 300, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (7, 4, 80, 25, 200, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (8, 4, 300, 100, 1000, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (9, 5, 12, 10, 50, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (10, 5, 0, 5, 30, 'T?m ng?ng s?n xu?t', NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (11, 1, 60, 20, 150, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (12, 2, 15, 50, 200, 'Ðang ch? thông quan', TO_DATE('2026-05-01', 'YYYY-MM-DD'));
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (13, 3, 85, 30, 250, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (14, 4, 210, 80, 500, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (15, 5, 40, 15, 100, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (16, 1, 150, 40, 400, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (17, 2, 500, 150, 2000, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (18, 3, 0, 100, 500, 'L?i v?n chuy?n', TO_DATE('2026-04-05', 'YYYY-MM-DD'));
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (19, 4, 320, 100, 800, NULL, NULL);
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point, max_in_stock, out_of_stock_explanation, restock_date) VALUES (20, 5, 90, 30, 300, NULL, NULL);
COMMIT;
-- s_warehouse
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (1, 1, '100 Warehouse Blvd', 'San Jose', 'CA', 'USA', '95112', '555-0201', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (2, 2, '200 Logistics Way', 'Rio de Janeiro', 'RJ', 'Brazil', '22070', '55-21-1234', 7);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (3, 5, '300 Storage Str', 'London', 'LND', 'UK', 'E14 5NT', '44-20-8888', 8);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (4, 5, '400 Industrial Pkwy', 'Berlin', 'BE', 'Germany', '10178', '49-30-4444', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (5, 9, '500 Cargo Ave', 'Tokyo', 'TKY', 'Japan', '100-0005', '81-3-3333', 7);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (6, 10, '600 Distribution Rd', 'Ho Chi Minh', 'SG', 'Vietnam', '700000', '028-3333', 8);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (7, 13, '700 Desert Port', 'Dubai', 'DU', 'UAE', '12345', '971-4-5555', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (8, 16, '800 Outback Way', 'Sydney', 'NSW', 'Australia', '2000', '61-2-6666', 7);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (9, 1, '900 Maple Leaf Dr', 'Toronto', 'ON', 'Canada', 'M5J 2J5', '1-416-7777', 8);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (10, 18, '1000 Fiesta Blvd', 'Mexico City', 'CDMX', 'Mexico', '06600', '52-55-8888', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (11, 3, '1100 Central Way', 'Panama City', 'PA', 'Panama', '0801', '507-222-3333', 7);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (12, 4, '1200 Island Dr', 'Nassau', 'NP', 'Bahamas', 'N-123', '1-242-444-5555', 8);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (13, 6, '1300 Eastern Rd', 'Warsaw', 'MZ', 'Poland', '00-001', '48-22-555-6666', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (14, 7, '1400 Nordic Pkwy', 'Oslo', 'OSL', 'Norway', '0150', '47-22-666-7777', 7);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (15, 8, '1500 Med Coast', 'Rome', 'RM', 'Italy', '00100', '39-06-777-8888', 8);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (16, 11, '1600 Monsoon Dr', 'Mumbai', 'MH', 'India', '400001', '91-22-888-9999', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (17, 12, '1700 Steppe Rd', 'Almaty', 'ALA', 'Kazakhstan', '050000', '7-727-999-0000', 7);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (18, 14, '1800 Oasis Str', 'Cairo', 'C', 'Egypt', '11511', '20-2-111-2222', 8);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (19, 15, '1900 Safari Blvd', 'Nairobi', 'NB', 'Kenya', '00100', '254-20-222-3333', 6);
INSERT INTO s_warehouse (id, region_id, address, city, state, country, zip_code, phone, manager_id) VALUES (20, 17, '2000 Pacific Way', 'Singapore', 'SG', 'Singapore', '018956', '65-6333-4444', 7);
COMMIT;
--Ki?m tra d? li?u b?ng
SELECT * FROM s_region;
SELECT * FROM s_emp;
SELECT * FROM s_dept;
SELECT * FROM s_region 
SELECT * FROM s_title 
SELECT * FROMs_customer 
SELECT * FROM s_image
SELECT * FROM s_longtext
SELECT * FROM s_product 
SELECT * FROM s_ord 
SELECT * FROM s_item 
SELECT * FROM s_inventory
SELECT * FROM s_warehouse. 
-- BÀI 2: Truy V?n D? Li?u Cõ B?n
-- Câu 1
SELECT name AS "Ten khach hang",
id AS "Ma khach hang"
FROM s_customer
ORDER BY id DESC;
