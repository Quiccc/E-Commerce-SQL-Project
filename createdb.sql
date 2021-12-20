create schema "QuiccExpress";
CREATE TABLE "QuiccExpress".address (
	address_id int4 NOT NULL,
	street_name varchar(50) NULL,
	city_name varchar(50) NULL,
	state varchar(50) NULL,
        zip_code int,
	username varchar(50) NULL,
	CONSTRAINT address_pkey PRIMARY KEY (address_id)
);
CREATE TABLE "QuiccExpress".brands (
	brand_name varchar(50) NULL,
	brand_id int4 NOT NULL,
	CONSTRAINT brand_ckey UNIQUE (brand_name),
	CONSTRAINT brand_pkey PRIMARY KEY (brand_id)
);
CREATE TABLE "QuiccExpress".cart_content (
	cart_id int4 NOT NULL,
	product_id int8 NOT NULL,
	quantity int2 NULL
);
CREATE TABLE "QuiccExpress".categories (
	category_name varchar(50) NULL,
	category_id int4 NOT NULL,
	CONSTRAINT category_ckey UNIQUE (category_name),
	CONSTRAINT category_pkey PRIMARY KEY (category_id)
);
CREATE TABLE "QuiccExpress".credit_card (
	card_number int8 NOT NULL,
	card_cvv int2 NULL,
	card_owner varchar(50) NULL,
	expire_date date NULL,
	username varchar(50) NULL,
	CONSTRAINT credit_card_pkey PRIMARY KEY (card_number)
);
CREATE TABLE "QuiccExpress".invoices (
	invoice_id int4 NOT NULL,
	invoice_date date NULL,
	username varchar(50) NULL,
	address_id int4 NULL,
	card_number int8 NULL,
	CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id)
);
CREATE TABLE "QuiccExpress".orders (
	order_id int4 NOT NULL,
	username varchar(50) NULL,
	payment_id int4 NULL,
	invoice_id int4 NULL,
	product_id int8 NULL,
	order_date date NULL,
	quantity int2 NULL,
	CONSTRAINT order_pkey PRIMARY KEY (order_id)
);
CREATE TABLE "QuiccExpress".payment (
	payment_id int4 NOT NULL,
	price float8 NULL,
	payment_date date NOT NULL,
	card_number int8 NULL,
	CONSTRAINT payment_pkey PRIMARY KEY (payment_id)
);
CREATE TABLE "QuiccExpress".product_type (
	type_name varchar(50) NULL,
	subcategory_id int4 NOT NULL,
	type_id int4 NOT NULL,
	CONSTRAINT type_ckey UNIQUE (type_name),
	CONSTRAINT type_pkey PRIMARY KEY (type_id)
);
CREATE TABLE "QuiccExpress".products (
	product_name varchar(300) NULL,
	product_price float8 NULL,
	product_stock int4 NULL,
	brand_id int4 NOT NULL,
	type_id int4 NOT NULL,
	product_id int8 NOT NULL,
	CONSTRAINT product_pkey PRIMARY KEY (product_id)
);
CREATE TABLE "QuiccExpress".reviews (
	review_text varchar(300) NULL,
	username varchar(50) NULL,
	review_id int4 NOT NULL,
	product_id int8 NOT NULL,
	rating numeric(5) NULL,
	CONSTRAINT reviews_pkey PRIMARY KEY (review_id)
);
CREATE TABLE "QuiccExpress".shipping (
	shipping_id int4 NOT NULL,
	shipping_type varchar(50) NULL,
	address_id int4 NULL,
	order_id int4 NULL,
	invoice_id int4 NULL,
	CONSTRAINT shipping_pkey PRIMARY KEY (shipping_id)
);
CREATE TABLE "QuiccExpress".shopping_cart (
	is_active bool NULL,
	expires date NULL,
	username varchar(50) NOT NULL,
	cart_id int4 NOT NULL,
	CONSTRAINT cart_pkey PRIMARY KEY (cart_id)
);
CREATE TABLE "QuiccExpress".subcategories (
	subcategory_name varchar(50) NULL,
	category_id int4 NOT NULL,
	subcategory_id int4 NOT NULL,
	CONSTRAINT subcategory_ckey UNIQUE (subcategory_name),
	CONSTRAINT subcategory_pkey PRIMARY KEY (subcategory_id)
);
CREATE TABLE "QuiccExpress".user_account (
	username varchar(50) NOT NULL,
	user_password varchar(50) NULL,
	user_dob date NULL,
	user_email varchar(50) NULL,
	user_cellphone_num varchar(30) NULL,
	CONSTRAINT cellphone_ckey UNIQUE (user_cellphone_num),
	CONSTRAINT email_ckey UNIQUE (user_email),
	CONSTRAINT user_account_pkey PRIMARY KEY (username)
);

ALTER TABLE "QuiccExpress".address ADD CONSTRAINT username_fkey FOREIGN KEY (username) REFERENCES "QuiccExpress".user_account(username) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".cart_content ADD CONSTRAINT cart_fkey FOREIGN KEY (cart_id) REFERENCES "QuiccExpress".shopping_cart(cart_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".cart_content ADD CONSTRAINT product_fkey FOREIGN KEY (product_id) REFERENCES "QuiccExpress".products(product_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".credit_card ADD CONSTRAINT credit_card_fkey FOREIGN KEY (username) REFERENCES "QuiccExpress".user_account(username) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".invoices ADD CONSTRAINT address_fkey FOREIGN KEY (address_id) REFERENCES "QuiccExpress".address(address_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".invoices ADD CONSTRAINT card_number_fkey FOREIGN KEY (card_number) REFERENCES "QuiccExpress".credit_card(card_number) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".invoices ADD CONSTRAINT username_fkey FOREIGN KEY (username) REFERENCES "QuiccExpress".user_account(username) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".orders ADD CONSTRAINT invoice_fkey FOREIGN KEY (invoice_id) REFERENCES "QuiccExpress".invoices(invoice_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".orders ADD CONSTRAINT payment_fkey FOREIGN KEY (payment_id) REFERENCES "QuiccExpress".payment(payment_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".orders ADD CONSTRAINT product_fkey FOREIGN KEY (product_id) REFERENCES "QuiccExpress".products(product_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".orders ADD CONSTRAINT username_fkey FOREIGN KEY (username) REFERENCES "QuiccExpress".user_account(username) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".payment ADD CONSTRAINT credit_card_fkey FOREIGN KEY (card_number) REFERENCES "QuiccExpress".credit_card(card_number) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".product_type ADD CONSTRAINT subcategory_fkey FOREIGN KEY (subcategory_id) REFERENCES "QuiccExpress".subcategories(subcategory_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".products ADD CONSTRAINT brand_fkey FOREIGN KEY (brand_id) REFERENCES "QuiccExpress".brands(brand_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".products ADD CONSTRAINT product_type_fkey FOREIGN KEY (type_id) REFERENCES "QuiccExpress".product_type(type_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".reviews ADD CONSTRAINT product_fkey FOREIGN KEY (product_id) REFERENCES "QuiccExpress".products(product_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".reviews ADD CONSTRAINT username_fkey FOREIGN KEY (username) REFERENCES "QuiccExpress".user_account(username) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".shipping ADD CONSTRAINT address_fkey FOREIGN KEY (address_id) REFERENCES "QuiccExpress".address(address_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".shipping ADD CONSTRAINT invoice_fkey FOREIGN KEY (invoice_id) REFERENCES "QuiccExpress".invoices(invoice_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".shipping ADD CONSTRAINT order_fkey FOREIGN KEY (order_id) REFERENCES "QuiccExpress".orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".shopping_cart ADD CONSTRAINT username_fkey FOREIGN KEY (username) REFERENCES "QuiccExpress".user_account(username) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "QuiccExpress".subcategories ADD CONSTRAINT category_fkey FOREIGN KEY (category_id) REFERENCES "QuiccExpress".categories(category_id) ON UPDATE CASCADE ON DELETE CASCADE;

INSERT INTO "QuiccExpress".user_account (username,user_password,user_dob,user_email,user_cellphone_num) VALUES 
('EcstaticRam','elvis.888','1991-02-17','averycahn40@gmail.com','2996248')
,('DopeyBison','scott922','1972-10-10','jasonwafford57@gmail.com','7199987')
,('BeautifulHero','chloe.423','1993-09-18','abigailsmith13@gmail.com','5920915')
,('ActionOlive','aydan.644','1970-12-21','oliviaclark57@gmail.com','5772287')
,('BuffaLou','barbarolinnet','1985-10-10','hunterwalker06@gmail.com','8779839')
,('ChangeSeer','greyhoundhoopoe','1977-03-11','danielwalker99@gmail.com','9931154')
,('AwkwardCoconut','iroquoisptarmigan','1993-03-02','martinlewis00@gmail.com','5151443')
,('Gangstereo','affirmedoxbird','1989-07-21','joytormey60@gmail.com','8596419')
,('Bingoddess','assaultmule','1991-08-06','dannywalker11@gmail.com','5700116')
,('BalloonMoose','seabiscuitsnipe','1988-06-20','gregoryscott60@gmail.com','6406812')
;
INSERT INTO "QuiccExpress".user_account (username,user_password,user_dob,user_email,user_cellphone_num) VALUES 
('AcrobaticLady','shergarbongo','1993-09-30','gradyserban86@gmail.com','6208951')
,('BakingSunflower','azerbulbul69','1994-06-13','ryanviana46@gmail.com','8739724')
,('Update','randompassword','1988-06-20','omegaLUL60@gmail.com','6416812')
;

INSERT INTO "QuiccExpress".brands (brand_name,brand_id) VALUES 
('AMD',600001)
,('ASUS',600002)
,('Acer',600003)
,('Alienware',600004)
,('AmazonBasics',600005)
,('Apple',600006)
,('BENFEI',600007)
,('BenQ',600008)
,('Blue',600009)
,('Bose',600010)
,('C2G',600011)
;
INSERT INTO "QuiccExpress".brands (brand_name,brand_id) VALUES 
('CMTECK',600012)
,('CORSAIR',600013)
,('CYBERPOWERPC',600015)
,('CableCreation',600016)
,('CableMatters',600017)
,('D-Link',600019)
,('DeepCool',600020)
,('DanYee',600021)
,('Dell',600022)
,('EVGA',600023)
;
INSERT INTO "QuiccExpress".brands (brand_name,brand_id) VALUES 
('G.SKILL',600024)
,('GIGABYTE',600025)
,('HyperX',600027)
,('Intel',600028)
,('JBL',600029)
,('Lenovo',600030)
,('Logitech',600031)
,('Philips',600037)
,('Plantronics',600038)
,('QGeeM',600039)
;
INSERT INTO "QuiccExpress".brands (brand_name,brand_id) VALUES 
('RATEL',600040)
,('Razer',600041)
,('Relper-Lineso',600042)
,('Sabrent',600043)
,('Samsung',600044)
,('Seagate',600045)
,('Sennheiser',600046)
,('Sony',600047)
,('SteelSeries',600048)
,('Tp-Link',600050)
;
INSERT INTO "QuiccExpress".brands (brand_name,brand_id) VALUES 
('Thermaltake',600051)
,('Toshiba',600052)
,('Transcend',600053)
,('Western Digital',600054)
,('XFX',600055)
,('ZOTAC',600056)
,('COVID-19',600014)
,('Cooler Master',600018)
,('HP',600026)
,('Mediabridge',600032)
;
INSERT INTO "QuiccExpress".brands (brand_name,brand_id) VALUES 
('MSI',600034)
,('Microsoft',600033)
,('Nintendo',600035)
,('NZXT',600036)
,('TONOR',600049)
,('Update',600057)
;

INSERT INTO "QuiccExpress".categories (category_name,category_id) VALUES 
('Computer Accessories',701)
,('Computer Components',702)
,('Computers and Tablets',703)
,('Gaming Consoles and Accessories',704)
,('Update',705)
;

INSERT INTO "QuiccExpress".subcategories (subcategory_name,category_id,subcategory_id) VALUES 
('Audio & Video',701,701001)
,('Cables',701,701002)
,('Keyboard, Mice & Accessories',701,701003)
,('External Components',702,702001)
,('Internal Components',702,702002)
,('Computers and Tablets',703,703001)
,('Consoles',704,704001)
,('Update',705,704009)
;

INSERT INTO "QuiccExpress".product_type (type_name,subcategory_id,type_id) VALUES 
('Headsets',701001,701001001)
,('Microphones',701001,701001002)
,('Speakers',701001,701001003)
,('Webcams',701001,701001004)
,('Ethernet Cables',701002,701002001)
,('Power Cables',701002,701002002)
,('SATA Cables',701002,701002003)
,('Thunderbolt Cables',701002,701002004)
,('USB Cables',701002,701002005)
,('Keyboards',701003,701003001)
;
INSERT INTO "QuiccExpress".product_type (type_name,subcategory_id,type_id) VALUES 
('Mice',701003,701003002)
,('Keyboard & Mice Sets',701003,701003003)
,('Mousepads',701003,701003004)
,('Computer Cases',702001,702001001)
,('External Hard Drives',702001,702001002)
,('External Solid State Drives',702001,702001003)
,('Monitors',702001,702001004)
,('Routers',702001,702001005)
,('Processors',702002,702002001)
,('Graphics Cards',702002,702002002)
;
INSERT INTO "QuiccExpress".product_type (type_name,subcategory_id,type_id) VALUES 
('CPU Coolers',702002,702002003)
,('Internal Hard Drives',702002,702002004)
,('Internal Solid Drives',702002,702002005)
,('Memory',702002,702002006)
,('Motherboards',702002,702002007)
,('Power Supplies',702002,702002008)
,('Laptops',703001,703001001)
,('Desktops',703001,703001002)
,('All in One Computers',703001,703001003)
,('HDMI Cables',701002,701002006)
;
INSERT INTO "QuiccExpress".product_type (type_name,subcategory_id,type_id) VALUES 
('Tablets',703001,703001004)
,('Playstation 4',704001,704001001)
,('Xbox One',704001,704001002)
,('Nintendo Switch',704001,704001003)
,('Update',704001,704001004)
;

INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Logitech MK710 Wireless Keyboard and Mouse Combo',41.1,78,600031,701003003,701003003007)
,('COVID-19 HDMI Cable 10 ft, High Speed HDMI 2.0',3.61,76,600014,701002006,701002006003)
,('COVID-19 USB C to USB C 60W Fast Charging Cable ',9.99,100,600014,701002005,701002005006)
,('COVID-19 USB Type C Cable 3A Fast Charging',9.99,36,600014,701002005,701002005007)
,('CYBERPOWERPC Gamer Supreme Liquid Cool Gaming PC, AMD Ryzen 7 3700X 3.6GHz, NVIDIA GeForce GTX 1660 Super 6GB, 16GB DDR4, 1TB PCI-E NVMe SSD',1020.2,33,600015,703001002,703001002001)
,('AmazonBasics Braided 4K HDMI',11.99,99,600005,701002006,701002006005)
,('AmazonBasics High-Speed HDMI Cable',10.99,359,600005,701002006,701002006007)
,('AmazonBasics RJ45 Cat-6 Ethernet Patch Internet Cable - 5 Feet (1.5 Meters)',4.99,55,600005,701002001,701002001005)
,('AmazonBasics RJ45 Cat7 Network Ethernet Patch Internet Cable - 3 Feet',6.55,42,600005,701002001,701002001001)
,('AmazonBasics Replacement Power Cable for PS4 Slim and Xbox One S / X - 6 Foot Cord, Black',8.25,52,600005,701002002,701002002001)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('AmazonBasics USB 2.0 Printer Type Cable',6.44,101,600005,701002005,701002005004)
,('AmazonBasics USB Type-C to USB-A 2.0',8.51,204,600005,701002005,701002005003)
,('AmazonBasics Wireless Computer Keyboard and Mouse Combo',39.5,77,600005,701003003,701003003004)
,('Apple Thunderbolt cable',29.15,150,600006,701002004,701002004002)
,('Apple USB-C Charge Cable',13.99,67,600006,701002005,701002005005)
,('BENFEI SATA Cable III, 3 Pack SATA Cable III 6Gbps Straight HDD SDD Data Cable',6.99,54,600007,701002003,701002003003)
,('Blue Yeti X Professional Condenser',170.99,7,600009,701001002,701001002001)
,('Bose Companion 2 Series III Multimedia Speakers',99.15,20,600010,701001003,701001003009)
,('C2G  4K UHD High Speed HDMI to Micro HDMI Cable',9.57,43,600011,701002006,701002006001)
,('C2G 125ft High Speed HDMI Active Optical Cable',356.28,89,600011,701002006,701002006002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('CMTECK USB Desktop Computer CM001 Microphone',25.99,18,600012,701001002,701001002004)
,('COVID-19 Plugable Thunderbolt 3 Cable 40Gbps Supports 100W Charging',25.95,59,600014,701002004,701002004001)
,('CableMatters 3-Pack Straight SATA III 6.0 Gbps SATA Cable (SATA 3 Cable) Black - 18 Inches',7.99,58,600017,701002003,701002003002)
,('CableCreation Active USB Extension Cable',15.99,67,600016,701002005,701002005002)
,('CableCreation USB C to Micro B 3.0 Cable',6.39,175,600016,701002005,701002005001)
,('COVID-19 Pebble 2.0 USB-Powered Desktop Speakers',19.99,32,600014,701001003,701001003008)
,('DanYee Cat 7 Ethernet Cable, Nylon Braided 10ft CAT7 High Speed Professional Gold Plated Plug',9.99,46,600021,701002001,701002001002)
,('Dell A225 DJ406 313-4323 USB Powered Speakers New Box',22.49,63,600022,701001003,701001003003)
,('Dell AX210 USB Stereo Speaker System',34.76,56,600022,701001003,701001003004)
,('Dell KM636 Wireless Keyboard & Mouse Combo',26.15,96,600022,701003003,701003003006)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('HyperX QuadCast - USB Condenser Gaming Microphone',132.49,12,600027,701001002,701001002006)
,('COVID-19 HDMI Cable with Gold Plated Connectors',10.98,165,600014,701002006,701002006004)
,('COVID-19 Mini DisplayPort to HDMI Adapter',16.99,74,600014,701002004,701002004006)
,('COVID-19 USB C to DisplayPort Cable [4K@60Hz] 6.6ft',18.99,50,600014,701002004,701002004005)
,('JBL Flip 3 Splashproof Portable Bluetooth Speaker',99.95,21,600029,701001003,701001003001)
,('JBL Pebbles 2.0 Speaker System',119.98,11,600029,701001003,701001003002)
,('Logitech ConferenceCam Connect All-in-One Video Collaboration',407.15,9,600031,701001004,701001004004)
,('Logitech G533 Wireless Gaming Headset – DTS 7.1 Surround Sound',74.99,32,600031,701001001,701001001001)
,('Logitech MeetUp HD Video and Audio Conferencing System',818.47,2,600031,701001004,701001004005)
,('Logitech MK320 Wireless Desktop Keyboard and Mouse Combo',24.99,98,600031,701003003,701003003008)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Logitech MK545 Advanced Wireless Keyboard and Mouse Combo',48.88,76,600031,701003003,701003003009)
,('Logitech MK550 Wireless Wave Keyboard and Mouse Combo',38.1,74,600031,701003003,701003003010)
,('Logitech Multimedia Speakers Z200 with Stereo Sound',16.99,22,600031,701001003,701001003006)
,('Logitech PTZ Pro 2 Camera – USB HD 1080P Video Camera',749.99,67,600031,701001004,701001004003)
,('Mediabridge Ethernet Cable (100 Feet) - Supports Cat6',19.99,67,600032,701002001,701002001003)
,('Mediabridge Ethernet Cable (15 Feet) - Supports Cat6/5e/5, 550MHz, 10Gbps',8.99,43,600032,701002001,701002001004)
,('Microsoft LifeCam Cinema 720p HD Webcam',89.95,121,600033,701001004,701001004001)
,('Microsoft LifeCam HD-6000',41.89,105,600033,701001004,701001004002)
,('Microsoft Wireless Desktop 3050 with AES',32.2,66,600033,701003003,701003003002)
,('Microsoft Wireless Desktop 900',34.99,73,600033,701003003,701003003005)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Philips LFH-3500',289.99,3,600037,701001002,701001002003)
,('Plantronics Voyager Focus UC Bluetooth USB B825 202652-01 Headset with Active Noise Cancelling',99.99,23,600038,701001001,701001001002)
,('QGeeM USB C to HDMI Adapter 4K Cable, USB Type-C to HDMI Adapter',14.99,78,600039,701002004,701002004004)
,('QGeeM USB C to HDMI Cable, 10ft Braided 4K@60Hz Cable Adapter',21.99,44,600039,701002004,701002004003)
,('RATEL Wireless Keyboard Mouse Combo',28.99,87,600040,701003003,701003003003)
,('Razer Kiyo Streaming Webcam: 1080p 30 FPS / 720p 60 FPS',93.86,28,600041,701001004,701001004006)
,('Razer Kraken X 7.1',48.2,10,600041,701001001,701001001008)
,('Razer Nommo Chroma: Custom Woven 3" Glass Fiber Drivers',136.63,17,600041,701001003,701001003005)
,('Razer Seiren X',67.99,14,600041,701001002,701001002002)
,('Relper-Lineso 6 Pack 90 Degree Right-Angle SATA III Cable)',7.99,54,600042,701002003,701002003001)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Sabrent USB 3.0 to SSD / 2.5-Inch SATA I/II/IIIHard Drive Adapter (EC-SSHD)',7.15,43,600043,701002003,701002003004)
,('Sennheiser HMDC 27',650,4,600046,701001001,701001001005)
,('Sennheiser SDW 5065',279.99,13,600046,701001001,701001001004)
,('SteelSeries Arctis Pro Wireless - Gaming Headset',338.14,34,600048,701001001,701001001003)
,('SteelSeries Siberia V2 Full-Size Gaming Headset (Green)',84.95,23,600048,701001001,701001001009)
,('TONOR USB Gaming Microphone',33.99,27,600049,701001002,701001002005)
,('ASUS Chromebook C202SA-YS04 11.6" Ruggedized and Spill Resistant Design with 180 Degree Screen (Intel Celeron 4GB DDR3)',229.99,14,600002,703001001,703001001035)
,('ASUS ROG Strix Scar III (2019) Gaming Laptop, 17.3” 240Hz IPS Type FHD, NVIDIA GeForce RTX 2070, Intel Core i7-9750H, 16GB DDR4, 1TB PCIe SSD',1899.99,14,600002,703001001,703001001029)
,('ASUS VivoBook 15 Thin and Light Laptop, 15.6” Full HD, AMD Quad Core R5-3500U CPU, 8GB DDR4 RAM, 256GB PCIe SSD, AMD Radeon Vega 8 Graphics',419.99,22,600002,703001001,703001001034)
,('ASUS VivoBook L203MA Ultra-Thin Laptop, 11.6” HD, Intel Celeron N4000 Processor (up to 2.6 GHz), 4GB RAM',233.99,7,600002,703001001,703001001036)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('ASUS ZenBook 13 Ultra Slim Laptop, 13.3” FHD WideView, 8th-Gen Intel Core i7-8565U CPU, 16GB RAM, 512GB PCIe SSD',999.99,19,600002,703001001,703001001033)
,('Acer 15.6" HD WLED Chromebook 15 with 3X Faster WiFi Laptop Computer, Intel Celeron Core N3060 up to 2.48GHz, 4GB RAM',249.99,11,600003,703001001,703001001045)
,('Acer Aspire 5 Slim Laptop, 15.6 inches Full HD IPS Display, AMD Ryzen 3 3200U, Vega 3 Graphics, 4GB DDR4, 128GB SSD',349.99,99,600003,703001001,703001001048)
,('Acer Nitro 7 Gaming Laptop, 15.6" Full HD IPS Display, 9th Gen Intel i7-9750H, GeForce GTX 1050 3GB, 8GB DDR4, 256GB PCIe NVMe SSD',699.99,17,600003,703001001,703001001044)
,('Acer Predator Helios 300 Gaming Laptop PC, 15.6" Full HD 144Hz 3ms IPS Display, Intel i7-9750H, GeForce GTX 1660 Ti 6GB, 16GB DDR4, 256GB NVMe SSD',973.48,8,600003,703001001,703001001046)
,('Acer Predator Orion 3000 Gaming Desktop, 9th Gen Intel Core i7-9700, NVIDIA GeForce RTX 2060 Super, 16GB DDR4, 512GB PCIe NVMe SSD',1279.99,27,600003,703001002,703001002002)
,('Acer Spin 3 Convertible Laptop, 14 inches Full HD IPS Touch, 8th Gen Intel Core i7-8565U, 16GB DDR4, 512GB PCIe NVMe SSD',709.99,20,600003,703001001,703001001047)
,('AmazonBasics Wireless Computer Mouse with Nano Receiver',12.97,156,600005,701003002,701003002008)
,('AmazonBasics Wireless Trackball Mouse',27.99,135,600005,701003002,701003002007)
,('AmazonBasics XXL Gaming Computer Mouse Pad - Black',12.99,82,600005,701003004,701003004005)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('ASUS ZenBook Pro Duo UX581 15.6” 4K UHD NanoEdge Bezel Touch, Intel Core i7-9750H, 16GB RAM, 1TB PCIe SSD, GeForce RTX 2060',2799.99,15,600002,703001001,703001001031)
,('Apple Magic Keyboard',86.25,131,600006,701003001,701003001011)
,('ASUS TUF FX505DT Gaming Laptop, 15.6” 120Hz Full HD, AMD Ryzen 5 R5-3550H Processor, GeForce GTX 1650 Graphics, 8GB DDR4, 256GB PCIe SSD',649.99,33,600002,703001001,703001001037)
,('Apple Magic Keyboard with Numeric Keypad',119.15,125,600006,701003001,701003001010)
,('Apple Magic Mouse 2',72.21,76,600006,701003002,701003002009)
,('CORSAIR MM300 - Anti-Fray Cloth Gaming Mouse Pad',22.1,54,600013,701003004,701003004008)
,('Dell 2GR91 Slim USB 104-Key Keyboard',39.99,102,600022,701003001,701003001002)
,('Dell G5 15 Gaming Laptop (Windows 10 Home, 9th Gen Intel Core i7-9750H, NVIDIA GTX 1650, 15.6" FHD LCD Screen, 256GB SSD and 1TB SATA, 16 GB RAM)',1099.99,24,600022,703001001,703001001026)
,('Dell Inspiron 2020 Premium 14” HD Laptop Notebook Computer, 4-Core 10th Gen Intel Core i5-1035G4 up to 3.7 GHz, Iris Plus Graphics, 8GB RAM, 128GB SSD,',429.99,30,600022,703001001,703001001027)
,('Dell Latitude 2-in-1 Travel Keyboard',91.15,21,600022,701003001,701003001001)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Dell Latitude E7470 14in Laptop, Core i5-6300U 2.4GHz, 8GB Ram, 256GB SSD',374.99,19,600022,703001001,703001001024)
,('Dell XPS 15 laptop 15.6", 4K UHD InfinityEdge Touch, 9th Gen Intel Core i7-9750H, NVIDIA GeForce GTX 1650 4GB GDDR5, 1TB SSD storage, 16GB RAM',1999.99,21,600022,703001001,703001001028)
,('Lenovo 11.6" HD IPS Touchscreen 2-in-1 Chromebook, Quad-Core MediaTek MT8173C',184.99,32,600030,703001001,703001001042)
,('Lenovo Flex 14 2-in-1 Convertible Laptop, 14 Inch FHD Touchscreen Display, AMD Ryzen 5 3500U Processor, 12GB DDR4 RAM, 256GB NVMe SSD',530.99,24,600030,703001001,703001001043)
,('Lenovo Ideapad 330 15.6" Anti Glared HD Premium Business Laptop (AMD A9-9425 up to 3.7 GHz, 8GB DDR4 Memory, 256GB SSD, AMD Radeon R5 Graphic',389.99,51,600030,703001001,703001001041)
,('Lenovo ThinkBook 13s-IWL 13.3" Notebook - 1920 x 1080 - Core i5 i5-8265U - 8 GB RAM - 256 GB SSD',559.99,6,600030,703001001,703001001038)
,('Lenovo ThinkPad Essential Wireless Mouse',20.97,96,600030,701003002,701003002001)
,('Lenovo ThinkPad T480 14" HD Business Laptop (Intel 8th Gen Quad-Core i5-8250U, 16GB DDR4 RAM, Toshiba 256GB PCIe NVMe 2242 M.2 SSD)',999.99,29,600030,703001001,703001001040)
,('Lenovo ThinkPad X1 Carbon 7th Generation Ultrabook: Core i7-8565U, 16GB RAM, 512GB SSD, 14" FHD Touchscreen Display',1554.99,12,600030,703001001,703001001039)
,('Logitech B100 Corded Mouse – Wired USB Mouse',8.99,136,600031,701003002,701003002010)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Logitech G440 Hard Gaming Mouse Pad for High DPI Gaming',24.99,67,600031,701003004,701003004004)
,('Logitech G640 Large Cloth Gaming Mousepad',28.99,36,600031,701003004,701003004003)
,('Logitech G840 XL Cloth Gaming Mouse Pad',49.99,31,600031,701003004,701003004002)
,('Logitech K350 Wireless Wave Keyboard with Unifying Wireless',27.95,67,600031,701003001,701003001008)
,('Logitech M510 Wireless Computer Mouse',13.85,157,600031,701003002,701003002011)
,('Logitech MX Keys Advanced Wireless Illuminated Keyboard',99.99,106,600031,701003001,701003001009)
,('Microsoft Arc Mouse',68.99,62,600033,701003002,701003002006)
,('Microsoft Bluetooth Mouse',18.95,167,600033,701003002,701003002004)
,('Microsoft Sculpt Ergonomic Keyboard for Business',54.99,69,600033,701003001,701003001004)
,('Microsoft Surface Keyboard',89.99,87,600033,701003001,701003001003)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Philips 3-Button Wired Computer Mouse with RGB',9.99,57,600037,701003002,701003002003)
,('Philips USB Optical Mouse',6.99,93,600037,701003002,701003002002)
,('Razer Doubleshot PBT Keycap Upgrade Set for Mechanical',29.99,23,600041,701003001,701003001006)
,('Razer Goliathus - Medium (Speed) - Overwatch Lucio Edition',26.8,65,600041,701003004,701003004001)
,('Razer Goliathus Extended Chroma Gaming Mousepad',59.99,56,600041,701003004,701003004009)
,('Razer Sphex V2 Gaming Mouse Pad',15.35,44,600041,701003004,701003004006)
,('ROG Zephyrus M Thin and Portable Gaming Laptop, 15.6” 240Hz FHD IPS, NVIDIA GeForce RTX 2070, Intel Core i7-9750H, 16GB DDR4 RAM, 1TB PCIe SSD,',1699.99,29,600002,703001001,703001001032)
,('SteelSeries QcK Gaming Surface - Medium Cloth',9.99,126,600048,701003004,701003004010)
,('ASUS - ROG Strix GL12CX Gaming Desktop - Intel Core i9 - 9900K - 32GB Memory - NVIDIA GeForce RTX 2080 Ti - 1TB SSD',3199.99,33,600002,703001002,703001002015)
,('Alienware - Aurora R9 Gaming Desktop - Intel Core i7-9700 - 16GB Memory - NVIDIA GeForce RTX 2080 SUPER - 1TB HDD + 512GB SSD',1899.99,18,600004,703001002,703001002014)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('AmazonBasics USB-Powered PC Computer Speakers with Dynamic Sound',17.67,45,600005,701001003,701001003007)
,('Apple - Mac mini - Intel Core i5 - 8GB Memory - 256GB Solid-State Drive - Space Gray',899.99,61,600006,703001002,703001002012)
,('Apple 13in MacBook Pro, Retina, Touch Bar, 3.1GHz Intel Core i5 Dual Core, 8GB RAM, 256GB SSD, Space Gray',1099.99,4,600006,703001001,703001001018)
,('Apple MacBook Air (13-inch Retina display, 1.6GHz dual-core Intel Core i5, 128GB) - Space Gray)',799.99,18,600006,703001001,703001001017)
,('Blue Yeti USB Mic for Recording & Streaming on PC and Mac',128.88,8,600009,701001002,701001002007)
,('CORSAIR Vengeance LPX 16GB (2 x 8GB) 288-Pin DDR4 SDRAM DDR4 3600',89.99,197,600013,702002006,702002006003)
,('Dell - G5 Gaming Desktop - Intel Core i7 - 9700 - 16GB Memory - NVIDIA GeForce GTX 1660 - 1TB HDD + 256GB SSD',1149.99,52,600022,703001002,703001002013)
,('Dell XPS 13 7390 Laptop 13.3 inch, FHD InfinityEdge Touch, 10th Gen Intel Core i7-10710U, UHD Graphics, 256GB SSD, 16GB RAM',1459.99,17,600022,703001001,703001001025)
,('Dell XPS 8930 Special Edition Tower Desktop - 9th Gen Intel 8-Core i7-9700K Processor up to 4.9 GHz, 32GB Memory, 1TB SSD + 3TB Hard Drive',1699.99,37,600022,703001002,703001002005)
,('Dell XPS 8930 Tower Desktop - 8th Gen. Intel Core i7-8700, 32GB DDR4 Memory, 1TB SSD + 3TB SATA Hard Drive, 4GB Nvidia GeForce GTX 1050Ti',1449.99,41,600022,703001002,703001002003)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('HP - OMEN Gaming - Intel Core i7-9700 - 16GB Memory - NVIDIA GeForce GTX 1660 Ti - 1TB Hard Drive + 256GB SSD',1249.99,39,600026,703001002,703001002010)
,('HP 15 15.6" HD Touchscreen Premium Laptop - 10th Gen Intel Core i5-1035G1, 16GB DDR4, 512GB SSD',619.99,29,600026,703001001,703001001023)
,('HP Chromebook 14-inch Laptop with 180-Degree Swivel, AMD Dual-Core A4-9120 Processor, 4 GB SDRAM',249.99,37,600026,703001001,703001001022)
,('HP ENVY 13 Inch Thin Laptop w/ Fingerprint Reader, 4K Touchscreen, Intel Core i7-8565U, NVIDIA GeForce MX250 Graphics, 16GB SDRAM, 512GB SSD',1199.99,9,600026,703001001,703001001021)
,('HP Pavilion 590 Desktop Computer, 8th Generation Intel 6 Cores i5-8400 2.8GHz up to 4.0GHz, 12GB DDR4 RAM, 1TB HDD',594.8,51,600026,703001002,703001002008)
,('HP Stream 14" HD(1366x768) Display, Intel Celeron N4000 Dual-Core Processor, 4GB RAM, 32GB eMMC',239.99,42,600026,703001001,703001001019)
,('COVID-19 - Gaming Desktop - Intel Core i7-9700F - 16GB Memory - NVIDIA GeForce RTX 2070 SUPER - 1TB HDD + 480GB Solid State',1299.99,12,600014,703001002,703001002011)
,('Lenovo 30BE004YUS ThinkStation P520 Intel Xeon W-2123 Windows 10 Pro 64',1299.99,21,600030,703001002,703001002006)
,('Logitech G935 Wireless DTS:X 7.1 Surround Sound LIGHTSYNC RGB PC Gaming Headset',128.99,36,600031,701001001,701001001006)
,('Logitech MX900 Performance Premium Backlit Keyboard and MX Master Mouse Combo',156.99,43,600031,701003003,701003003001)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('MSI - Infinite X Plus Gaming Desktop - Intel Core i7-9700KF - 16GB Memory - NVIDIA GeForce RTX 2070 SUPER - 3TB HDD + 1TB SSD - Black-RGB',1949.99,19,600034,703001002,703001002017)
,('MSI - Prestige P100 Gaming Desktop - Intel Core i9-9900K - 32GB Memory - NVIDIA GeForce RTX 2080 SUPER - 2TB HDD + 1TB SSD',2499.99,7,600034,703001002,703001002018)
,('MSI - Trident X Plus Gaming Desktop - Intel Core i9-9900KF - 16GB Memory - NVIDIA GeForce RTX 2080 SUPER - 2TB HDD + 1TB SSD',2299.99,29,600034,703001002,703001002016)
,('MSI GE63 Raider RGB-608 15.6" Gaming Laptop, 144Hz Display, Intel Core i7-9750H, NVIDIA GeForce RTX2070, 16GB, 256GB NVMe SSD + 1TB HDD',1699.99,22,600034,703001001,703001001006)
,('MSI GE75 Raider-287 17.3" Gaming Laptop, 144Hz Display, Thin Bezel, Intel Core i7-9750H, NVIDIA GeForce RTX2060, 16GB, 512GB NVMe SSD',1569.99,31,600034,703001001,703001001008)
,('MSI GF63 Thin 9SC-066 15.6" Gaming Laptop, Thin Bezel, Intel Core i7-9750H, NVIDIA GeForce GTX1650, 16GB, 512GB NVMe SSD',899.99,11,600034,703001001,703001001013)
,('MSI GF65 Thin 9SD-004 15.6" 120Hz Gaming Laptop Intel Core i7-9750H GTX1660Ti 16GB 512GB NVMe SSD',949.99,29,600034,703001001,703001001016)
,('MSI GF75 17.3" Gaming Laptop Intel Core i7-9750H 8GB RAM 512GB SSD 120Hz GTX 1660 Ti Aluminum Black',1049.99,21,600034,703001001,703001001007)
,('MSI GL73 9SDK-219 17.3" Gaming Laptop, 144Hz Display, Intel Core i7-9750H, NVIDIA GeForce GTX1660Ti, 16GB, 512GB NVMe SSD',1369.99,27,600034,703001001,703001001009)
,('MSI GL75 9SDK-057 17.3" FHD 120Hz Gaming Laptop, Intel Core i7-9750H, NVIDIA GTX 1660Ti, 16GB, 512GB NVMe SSD, Win 10',1249.99,31,600034,703001001,703001001005)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('MSI GS65 Stealth-432 15.6" Gaming Laptop, 240Hz Display, Thin Bezel, Intel Core i7-9750H, NVIDIA GeForce RTX2070, 32GB, 1TB NVMe NVMe SSD, Thunderbolt 3',2449.99,22,600034,703001001,703001001012)
,('MSI GS75 Stealth-413 17.3" Gaming Laptop, 144Hz Display, Thin Bezel, Intel Core i7-9750H, NVIDIA GeForce GTX1660Ti, 16GB, 1TB NVMe NVMe SSD, Thunderbolt 3',1719.99,24,600034,703001001,703001001015)
,('MSI P65 Creator-654 15.6" Productivity Laptop, 4K Display, Ultra Portable, Thin Bezel, Intel Core i9-9880H, NVIDIA GeForce RTX2070, 32GB, 1TB NVMe SSD, Thunderbolt 3',2649.99,8,600034,703001001,703001001011)
,('MSI Prestige 15 A10SC-011 15.6" Ultra Thin and Light Professional Laptop Intel Core i7-10710U GTX1650 MAX-Q 16GB DDR4 512GB NVMe SSD Win10Pro',1399.99,19,600034,703001001,703001001010)
,('Omen by HP 2019 15-Inch Gaming Laptop, Intel i7-9750H Processor, GeForce RTX 2070 8 GB, 32 GB RAM, 512 GB SSD',1569.99,14,600026,703001001,703001001020)
,('Razer BlackWidow Mechanical Gaming Keyboard: Green Mechanical Switches',119.99,30,600041,701003001,701003001007)
,('Razer Blade 15 Gaming Laptop 2019: Intel Core i7-9750H 6 Core, NVIDIA GeForce GTX 1660Ti, 15.6" FHD 1080p 60Hz, 16GB RAM, 128GB SSD + 1TB HDD',1499.99,22,600041,703001001,703001001004)
,('Razer Blade 15 Gaming Laptop 2019: Intel Core i7-9750H 6 Core, NVIDIA GeForce RTX 2080 Max-Q, 15.6" FHD 1080p 240Hz, 16GB RAM, 512GB SSD',2699.99,10,600041,703001001,703001001003)
,('Razer Blade Pro 17 Gaming Laptop 2019: Intel Core i7-9750H, NVIDIA GeForce RTX 2080 Max-Q, 17.3" FHD 240Hz, 16GB RAM, 512GB SSD',2999.99,6,600041,703001001,703001001001)
,('Razer Blade Stealth 13 Ultrabook Gaming Laptop: Intel Core i7-1065G7 4 Core, NVIDIA GeForce GTX 1650 Max-Q, 13.3" FHD 1080p 60Hz, 16GB RAM, 512GB SSD',1499.99,15,600041,703001001,703001001002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('ZOTAC Gaming MEK Ultra Gaming PC GeForce RTX 2080 Ti 11GB GDDR6 Z370 6-core Liquid-Cooled Intel Core i7-8700K 32GB DDR4/500GB NVMe SSD/2TB HDD',2099.99,21,600056,703001002,703001002004)
,('Samsung Galaxy Tab S6 SM-T865 LTE Factory Unlocked 10.5" (8GB RAM / 256GB ROM)',884.91,45,600044,703001004,703001004004)
,('ASUS - Vivo AiO 23.8" Touch-Screen All-In-One - Intel Core i5 - 8GB Memory - 1TB HDD + 128GB SSD - Black',849.99,11,600002,703001003,703001003013)
,('ASUS - Zen AiO 23.8" Touch-Screen All-In-One - Intel Core i7 - 12GB Memory - 1TB Hard Drive + 128GB Solid State Drive - Icicle Silver',1199.99,22,600002,703001003,703001003016)
,('Acer - Aspire 23.8" Refurbished All-In-One - Intel Core i5 - 12GB Memory - 512GB SSD - Black/Silver',519.99,33,600003,703001003,703001003008)
,('Apple - 11-Inch iPad Pro 256GB',899.99,131,600006,703001004,703001004011)
,('Apple - 12.9-Inch iPad Pro 256 GB',1099.99,75,600006,703001004,703001004010)
,('Apple - 21.5" iMac® with Retina 4K display (Latest Model) - Intel Core i3 (3.6GHz) - 8GB Memory - 1TB Hard Drive',1099.99,44,600006,703001003,703001003001)
,('Apple - 27" iMac Pro with Retina 5K display - Intel Xeon W - 32GB Memory - 1TB Solid State Drive - Black',4499.99,27,600006,703001003,703001003014)
,('Apple - 27" iMac® with Retina 5K display (Latest Model) - Intel Core i5 (3.0GHz) - 8GB Memory - 1TB Fusion Drive - Silver',1799.99,21,600006,703001003,703001003009)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Apple - 27" iMac® with Retina 5K display (Latest Model) - Intel Core i5 (3.7GHz) - 8GB Memory - 2TB Fusion Drive - Silver',2299.99,33,600006,703001003,703001003007)
,('Apple - iPad 256GB',699.99,125,600006,703001004,703001004014)
,('Apple - iPad Air 256GB',649.99,153,600006,703001004,703001004012)
,('Apple - iPad mini 256GB',499.99,241,600006,703001004,703001004013)
,('CORSAIR - Carbide Series ATX Mid-Tower Case',79.99,23,600013,702001001,702001001013)
,('CORSAIR - Crystal Series 570X RGB ATX Mid-Tower Case',189.89,13,600013,702001001,702001001014)
,('CORSAIR - Graphite Series 780T Full-Tower PC Case',179.99,41,600013,702001001,702001001016)
,('CORSAIR - ONE Gaming Desktop - Intel Core i7-9700K - 32GB Memory - NVIDIA GeForce RTX 2080 - 960GB SSD + 2TB HDD',2899.99,22,600013,703001002,703001002020)
,('CORSAIR - iCUE 220T RGB Airflow ATX Mid-Tower Smart Case',99.99,22,600013,702001001,702001001012)
,('CORSAIR - iCUE 465X RGB ATX Mid-Tower Smart Case',149.99,19,600013,702001001,702001001015)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Cooler Master Elite 120 Mini ITX PC Computer Case',39.99,47,600018,702001001,702001001007)
,('Cooler Master K380 Micro-ATX/ATX Mid Tower Chassis',61.99,35,600018,702001001,702001001004)
,('Cooler Master MasterBox Lite 3.1 TG Computer Case',59.99,12,600018,702001001,702001001006)
,('DEEPCOOL New ARK 90SE E-ATX Case',154.99,7,600020,702001001,702001001009)
,('DEEPCOOL TESSERACT SW RD Mid Tower Computer Case',54.99,24,600020,702001001,702001001008)
,('Dell - Inspiron 21.5" Touch-Screen All-In-One - AMD A6-Series - 4GB Memory - 1TB Hard Drive - Black',489.99,49,600022,703001003,703001003004)
,('HP - ENVY 31.5" All-In-One - Intel Core i7 - 16GB Memory - 512GB SSD - Nightfall Black',1999.99,17,600026,703001003,703001003010)
,('HP - Pavilion 23.8" Touch-Screen All-In-One - Intel Core i5 - 12GB Memory - 256GB Solid State Drive - Snowflake White',949.5,56,600026,703001003,703001003002)
,('HP - Pavilion 27" Touch-Screen All-In-One - Intel Core i7 - 12GB Memory - 256GB Solid State Drive - Snowflake White',1299.99,37,600026,703001003,703001003003)
,('Lenovo - A540-24API 23.8" Touch-Screen All-In-One - AMD Ryzen 3-Series - 8GB Memory - 256GB Solid State Drive - Black',729.99,61,600030,703001003,703001003005)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Lenovo - IdeaCentre A340-22IGM 21.5" Touch-Screen All-In-One - Intel Pentium Silver - 8GB Memory - 1TB Hard Drive - Black',549.99,52,600030,703001003,703001003006)
,('Lenovo - Yoga A940-27ICB 27" Touch-Screen All-In-One - Intel Core i7 - 16GB Memory - 1TB Hard Drive + 256GB Solid State Drive - Gray',2349.99,32,600030,703001003,703001003012)
,('Microsoft - Surface Go - 10" Touch-Screen - Intel Pentium Gold - 4GB Memory - 64GB Storage',399.1,81,600033,703001004,703001004005)
,('Microsoft - Surface Go - 10" Touch-Screen - Intel Pentium Gold - 8GB Memory - 128GB Storage',549.99,43,600033,703001004,703001004006)
,('Microsoft - Surface Pro 7 - 12.3" Touch Screen - Intel Core i3 - 4GB Memory - 128GB SSD',599.99,87,600033,703001004,703001004007)
,('Microsoft - Surface Pro 7 - 12.3" Touch Screen - Intel Core i5 - 8GB Memory - 128GB SSD',899.99,101,600033,703001004,703001004008)
,('Microsoft - Surface Pro 7 - 12.3" Touch Screen - Intel Core i7 - 16GB Memory - 256GB SSD',1499.99,55,600033,703001004,703001004009)
,('Microsoft - Surface Studio 2 - 28" Touch-Screen All-In-One - Intel Core i7 - 16GB Memory - 1TB Solid State Drive (Latest Model) - Platinum',3399.99,32,600033,703001003,703001003015)
,('MSI - Aegis R Gaming Desktop - Intel Core i7 - 9700 - 16GB Memory - NVIDIA GeForce RTX 2070 - 1TB SSD',1399.99,44,600034,703001002,703001002019)
,('NZXT - H510 Compact ATX Mid-Tower Case with Tempered Glass',69.99,33,600036,702001001,702001001010)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('NZXT - H510 Elite Compact ATX Mid-Tower Case with Dual-Tempered Glass',149.99,44,600036,702001001,702001001011)
,('Samsung Galaxy Note Pro 12.2 (64GB)',449.95,71,600044,703001004,703001004003)
,('Samsung Galaxy Tab Active 2 8.0" 16GB, 3GB RAM (WiFi + Cellular) SM-T395, IP68 Water Resistant, 4G LTE Tablet & Phone GSM Unlocked w/ S Pen',459.99,56,600044,703001004,703001004001)
,('Samsung Galaxy Tab Pro 12.2 (32GB)',299.95,67,600044,703001004,703001004002)
,('Seagate 8 TB Game USB 3.0, 3.5 Inch External Hard Drive with Integrated 2-Port USB Hub',130.55,22,600045,702001002,702001002004)
,('Seagate Backup Plus Slim Portable 1TB USB 3.0 2.5" External Hard Drive',55.55,34,600045,702001002,702001002007)
,('Seagate Game Drive 2000GB White External Hard Drive',65.55,54,600045,702001002,702001002005)
,('Seagate Slim 1.5TB Portable Hard Drive',44.99,44,600045,702001002,702001002006)
,('Thermaltake H200 Tempered Glass Snow Edition RGB Light Strip ATX Mid Tower Case',84.99,33,600051,702001001,702001001001)
,('Thermaltake LEVEL 10 GTS Snow Edition White ATX Mid Tower Gaming Computer Case',87.7,21,600051,702001001,702001001002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Thermaltake V200 TG',54.99,142,600051,702001001,702001001003)
,('Toshiba - External Hard Drive Toshiba HDTB410EK3AA 1 TB 2,5" USB 3.0',50.5,67,600052,702001002,702001002002)
,('Toshiba 2TB Canvio Slim External USB 3.0 Hard Drive',67.77,77,600052,702001002,702001002003)
,('Toshiba Canvio Basics 3.0 1 TB Portable Hard Drive',51.99,55,600052,702001002,702001002001)
,('Transcend 1TB USB 3.1 Gen 1 StoreJet 25H3B SJ25H3B Rugged External Hard Drive',54.99,56,600053,702001002,702001002008)
,('WD - My Book Essential 750 GB USB 2.0 Desktop External Hard Drive',99.99,14,600054,702001002,702001002012)
,('AMD - Ryzen 3 3200G Quad-Core 3.6 GHz Socket AM4 Desktop Processor,',99.99,50,600001,702002001,702002001001)
,('AMD - Ryzen 5 3400G Quad-Core 3.7 GHz Socket AM4 Desktop Processor',149.99,43,600001,702002001,702002001002)
,('AMD - Ryzen 5 3600 Six-Core 3.6 GHz Socket AM4 Desktop Processor',199.99,61,600001,702002001,702002001003)
,('AMD - Ryzen 7 3700X Octa-Core 3.6 GHz Socket AM4 Desktop Processor',329.99,47,600001,702002001,702002001004)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('AMD - Ryzen 9 3900X 12-core 3.8 GHz Socket AM4 Desktop Processor',499.99,31,600001,702002001,702002001006)
,('AMD - Ryzen 9 3950X 16-core 3.5 GHz Socket AM4 Desktop Processor',749.99,28,600001,702002001,702002001007)
,('AMD - Ryzen ThreadRipper 3960X 24-core 3.8 GHz Socket sTRX4 Desktop Processor',1399.99,20,600001,702002001,702002001008)
,('AMD - Ryzen ThreadRipper 3970X 32-core 3.7 GHz Socket sTRX4 Desktop Processor',1999.99,19,600001,702002001,702002001009)
,('AMD - Ryzen ThreadRipper 3990X 64-core 2.9 GHz Desktop Socket sTRX4 Processor',3990.9,10,600001,702002001,702002001010)
,('ASUS - MG28UQ 28" LED 4K UHD Monitor',489.89,14,600002,702001004,702001004010)
,('ASUS - ROG Swift 24" LCD FHD G-SYNC Monitor',399.99,23,600002,702001004,702001004009)
,('ASUS - VG278Q 27" LCD FHD FreeSync Monitor',239.78,24,600002,702001004,702001004011)
,('ASUS RT-N66W Dual-Band Wireless-N900 Gigabit Router',79.9,91,600002,702001005,702001005005)
,('ASUSDual Band Wireless-N 600 SOHO Router',74.99,101,600002,702001005,702001005006)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('BenQ - DesignVue PD series PD2700U 27" IPS LED 4K UHD Monitor',539.9,17,600008,702001004,702001004012)
,('ASUS AC1900 Dual Band Gigabit WiFi Router',139.99,87,600002,702001005,702001005004)
,('BenQ - EX3203R 31.5" LED Curved QHD FreeSync Monitor',399.99,19,600008,702001004,702001004014)
,('BenQ - ZOWIE XL-series XL2540 24.5" LCD FHD FreeSync/G-SYNC Monitor',399.99,22,600008,702001004,702001004013)
,('D-Link Wireless AC1900 Dual Band WiFi Gigabit Router',79.99,65,600019,702001005,702001005007)
,('D-Link Wireless N 300 Mbps Home Cloud App-Enabled Gigabit Router',54.99,65,600019,702001005,702001005009)
,('D-Link Wireless N 900 Mbps Home Cloud App-Enabled Dual-Band Gigabit Router',119.9,76,600019,702001005,702001005008)
,('EVGA - SC ULTRA GAMING NVIDIA GeForce GTX 1660 Ti 6GB GDDR6 PCI Express 3.0 Graphics Card',299.99,41,600023,702002002,702002002002)
,('Intel - Core i3-8100 Coffee Lake Quad-Core 3.6 GHz Socket LGA 1151 Desktop Processor',119.9,20,600028,702002001,702002001011)
,('Intel - Core i3-9100 Quad-Core 3.6 GHz Socket LGA 1151 Desktop Processor',124.9,53,600028,702002001,702002001012)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Intel - Core i5-8400 Coffee Lake Six-Core 2.8 GHz Socket LGA 1151 Desktop Processor',189.99,17,600028,702002001,702002001013)
,('Intel - Core i5-9400 Six-Core 2.9 GHz Socket LGA 1151 Desktop Processor',184.99,61,600028,702002001,702002001015)
,('Intel - Core i5-9400F Six-Core 2.9 GHz Socket LGA 1151 Desktop Processor without Graphics',119.9,44,600028,702002001,702002001014)
,('Intel - Core i5-9600K Six-Core 3.7 GHz Socket LGA 1151 Desktop Processor',219.9,65,600028,702002001,702002001016)
,('Intel - Core i7-8700 Coffee Lake Six-Core 3.2 GHz Socket LGA 1151 Desktop Processor',309.9,5,600028,702002001,702002001017)
,('Intel - Core i7-8700K Coffee Lake Six-Core 3.7 GHz Socket LGA 1151 Desktop Processor',349.99,3,600028,702002001,702002001018)
,('Intel - Core i7-9700F Octa-Core 3 GHz Socket LGA 1151 Desktop Processor with Enhanced Speedstep Technology',319.99,54,600028,702002001,702002001019)
,('Intel - Core i7-9700K Octa-Core 3.6 GHz Socket LGA 1151 Desktop Processor',369.99,71,600028,702002001,702002001022)
,('Intel - Core i7-9700KF Octa-Core 3.6 GHz Socket LGA 1151 Desktop Processor with Enhanced Speedstep Technology',359.9,60,600028,702002001,702002001021)
,('Intel - Core i9-9900 Octa-Core 3.1 GHz Socket LGA 1151 Desktop Processor with Enhanced Speedstep Technology',459.99,33,600028,702002001,702002001023)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Intel - Core i9-9900KF Octa-Core 3.6 GHz Socket LGA 1151 Desktop Processor with Enhanced Speedstep Technology',499.99,29,600028,702002001,702002001024)
,('MSI - GAMING X NVIDIA GeForce GTX 1660 SUPER 6GB GDDR6 PCI Express 3.0 Graphics Card',264.99,44,600034,702002002,702002002001)
,('MSI - GeForce GTX 1660 Ti Gaming X 6GB GDDR6 PCI Express 3.0 Graphics Card',319.99,59,600034,702002002,702002002003)
,('MSI - GeForce RTX 2060 GAMING Z 6GB GDDR6 PCI Express 3.0 Graphics Card',339.99,66,600034,702002002,702002002004)
,('MSI - Oculux NXG251R 24.5" LED FHD G-SYNC Monitor',499.99,7,600034,702001004,702001004016)
,('MSI - Optix 31.5" LED Curved QHD FreeSync Monitor',459.99,14,600034,702001004,702001004015)
,('Samsung - 390 Series 24" LED Curved FHD FreeSync Monitor',149.99,17,600044,702001004,702001004008)
,('Samsung - CF591 Series C27F591FDN 27" LED Curved FHD FreeSync Monitor',249.9,27,600044,702001004,702001004004)
,('Samsung - CHG7 Series C32HG70QQN 32" HDR Curved QHD FreeSync Monitor',499.99,19,600044,702001004,702001004005)
,('Samsung - CHG9 Series C49HG90DMN 49" HDR LED Curved FHD FreeSync Monitor',899.99,7,600044,702001004,702001004003)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Samsung - CRG5 Series 27" LED Curved FHD G-Sync Monitor',369.99,13,600044,702001004,702001004006)
,('Samsung - SF350 Series S24F350FHN 24" LED FHD FreeSync Monitor',129.99,8,600044,702001004,702001004007)
,('Samsung - UJ59 Series U32J590UQN 32" LED 4K UHD FreeSync Monitor ',369.99,15,600044,702001004,702001004001)
,('Samsung - UR55 Series 28" IPS 4K UHD Monitor',329.99,21,600044,702001004,702001004002)
,('Samsung 2 TB External Solid State Drive - Portable - USB 3.1 Type C',314.15,22,600044,702001003,702001003001)
,('Seagate 500 GB One SSD',59.99,66,600045,702001003,702001003004)
,('Seagate 500 GB One Touch Special Edition SSD Camo Grey',69.99,28,600045,702001003,702001003003)
,('Seagate 500 GB One Touch Special Edition SSD Camo Red',69.99,32,600045,702001003,702001003002)
,('TP-Link AC750 Wireless Wi-Fi Gigabit Router',39.99,67,600050,702001005,702001005003)
,('TP-Link N450 Wi-Fi Router - Wireless Internet Router',24.99,88,600050,702001005,702001005001)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('TP-Link N600 Wireless Wi-Fi Dual Band Router',79.95,78,600050,702001005,702001005002)
,('Transcend 1TB StoreJet M3 Military Drop Tested USB 3.0 External Hard Drive',64.44,43,600053,702001002,702001002009)
,('Transcend 4TB StoreJet 25H3 2.5-inch USB3.0 Portable Hard Drive',134.44,32,600053,702001002,702001002010)
,('WD - Easystore 10TB External USB 3.0 Hard Drive',239.99,12,600054,702001002,702001002011)
,('ASUS - NVIDIA GeForce RTX 2080 Super 8GB GDDR6 PCI Express 3.0 Graphics Card',784.99,76,600002,702002002,702002002011)
,('ASUS - NVIDIA GeForce RTX 2080 Ti OC Edition 11GB GDDR6 PCI Express 3.0 Graphics Card',1279.99,55,600002,702002002,702002002013)
,('CORSAIR - Hydro Series 120mm Liquid Cooling System',79.99,125,600013,702002003,702002003001)
,('CORSAIR - Hydro Series H100i RGB Platinum 120mm Processor Liquid Cooling System with RGB Lighting',159.99,137,600013,702002003,702002003003)
,('CORSAIR - Hydro Series H115i RGB Platinum 140mm Processor Liquid Cooling System with RGB Lighting',169.99,114,600013,702002003,702002003002)
,('CORSAIR - iCUE SP120 RGB PRO 120mm System Cabinet Fan Kit with RGB Lighting',79.99,77,600013,702002003,702002003004)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Cooler Master - Hyper 212 Black Edition 120mm CPU Cooling Fan - Black',39.99,156,600018,702002003,702002003005)
,('Cooler Master - MasterLiquid ML120L RGB 120mm Processor Liquid Cooling System with RGB Lighting',64.99,147,600018,702002003,702002003007)
,('Cooler Master - MasterLiquid ML240R RGB 120mm Processor Liquid Cooling System with RGB Lighting',129.99,121,600018,702002003,702002003008)
,('Cooler Master - MasterLiquid ML360R RGB 120mm Processor Liquid Cooling System with RGB Lighting',169.99,111,600018,702002003,702002003006)
,('EVGA - FTW3 ULTRA GAMING NVIDIA GeForce RTX 2080 Ti 11GB GDDR6 PCI Express 3.0 Graphics Card',1499.99,34,600023,702002002,702002002014)
,('EVGA - GeForce RTX 2060 XC Ultra Gaming 6GB GDDR6 PCI Express 3.0 Graphics Card',429.99,34,600023,702002002,702002002005)
,('EVGA - GeForce RTX 2080 XC Ultra Gaming 8GB GDDR6 PCI Express 3.0 Graphics Card',679.99,32,600023,702002002,702002002010)
,('EVGA - SUPER XC ULTRA GAMING NVIDIA GeForce RTX 2070 Super 8GB GDDR6 PCI Express 3.0 Graphics Card',519.99,57,600023,702002002,702002002008)
,('G.SKILL Ripjaws V Series 16GB (2 x 8GB) 288-Pin DDR4 SDRAM DDR4 2400',69.99,214,600024,702002006,702002006001)
,('G.SKILL TridentZ RGB Series 16GB (2 x 8GB) 288-Pin DDR4 SDRAM DDR4 3200',97.99,202,600024,702002006,702002006002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('HyperX - FURY 240GB Internal SATA Solid State Drive with Multi-color RGB Lighting',73.99,197,600027,702002005,702002005009)
,('HyperX - FURY 480GB Internal SATA Solid State Drive with Multi-color RGB Lighting',97.99,124,600027,702002005,702002005010)
,('Intel - Core i9-9900K Octa-Core 3.6 GHz Socket LGA 1151 Desktop Processor',509.9,32,600028,702002001,702002001025)
,('MSI - AMD Radeon RX 5500 XT 8GB GDDR6 PCI Express 4.0 Graphics Card',204.99,44,600034,702002002,702002002015)
,('MSI - AMD Radeon RX 580 ARMOR MK2 OC 8G GDDR5 PCI Express 3.0 Graphics Card',239.99,12,600034,702002002,702002002018)
,('MSI - GeForce RTX 2080 Gaming X Trio 8GB GDDR6 PCI Express 3.0 Graphics Card',619.99,54,600034,702002002,702002002009)
,('MSI - GeForce RTX 2080 Ti Gaming X Trio 11GB GDDR6 PCI Express 3.0 Graphics Card',1299.99,42,600034,702002002,702002002012)
,('MSI - MECH OC AMD Radeon RX 5700 8GB GDDR6 PCI Express 4.0 Graphics Card',359.99,23,600034,702002002,702002002021)
,('MSI - NVIDIA GeForce RTX 2070 Super 8GB GDDR6 PCI Express 3.0 Graphics Card',509.99,66,600034,702002002,702002002007)
,('Samsung - 860 EVO 1TB Internal SATA Solid State Drive',149.99,167,600044,702002005,702002005002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Samsung - 860 EVO 500GB Internal SATA Solid State Drive',79.99,132,600044,702002005,702002005001)
,('Samsung - 970 EVO Plus 1TB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive with V-NAND Technology',199.99,125,600044,702002005,702002005004)
,('Samsung - 970 EVO Plus 500GB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive with V-NAND Technology',109.99,98,600044,702002005,702002005003)
,('Seagate - Barracuda 1TB Internal SATA Hard Drive for Desktops',44.99,232,600045,702002004,702002004005)
,('Seagate - Barracuda 2TB Internal SATA Hard Drive for Desktops',49.99,127,600045,702002004,702002004006)
,('Seagate - Barracuda 4TB Internal SATA Hard Drive for Desktops',94.99,158,600045,702002004,702002004007)
,('Thermaltake - Water 3.0 120 120mm Processor Liquid Cooling System',89.99,103,600051,702002003,702002003009)
,('WD - Black SN750 NVMe SSD 1TB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive for Laptops & Desktops',209.99,111,600054,702002005,702002005008)
,('WD - Black SN750 NVMe SSD 500GB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive for Laptops & Desktops',99.99,187,600054,702002005,702002005007)
,('WD - Blue 1TB Internal SATA Hard Drive for Desktops',49.99,164,600054,702002004,702002004003)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('WD - Blue 1TB Internal SATA Solid State Drive',114.99,145,600054,702002005,702002005006)
,('WD - Blue 3TB Internal SATA Hard Drive for Desktops',91.99,153,600054,702002004,702002004004)
,('WD - Blue 500GB Internal SATA Solid State Drive',64.99,129,600054,702002005,702002005005)
,('WD - Mainstream 1TB Internal Serial ATA Hard Drive for Desktops',49.99,222,600054,702002004,702002004001)
,('WD - Mainstream 3TB Internal Serial ATA Hard Drive for Desktops',89.99,197,600054,702002004,702002004002)
,('XFX - AMD Radeon RX 5600 XT RAW II PRO 6GB GDDR6 PCI Express 4.0 Graphics Card',289.99,32,600055,702002002,702002002019)
,('XFX - AMD Radeon RX 590 Fatboy OC+ 8GB GDDR5 PCI Express 3.0 Graphics Card',229.99,14,600055,702002002,702002002017)
,('XFX - DD Ultra AMD Radeon RX 5700 8GB GDDR6 PCI Express 4.0 Graphics Card',329.99,27,600055,702002002,702002002020)
,('XFX - THICC II Pro AMD Radeon RX 5500 XT 8GB GDDR6 PCI Express 4.0 Graphics Card',219.99,23,600055,702002002,702002002016)
,('ASUS AMD AM4 ROG Strix X570-E Gaming ATX Motherboard with PCIe 4.0',288.88,37,600002,702002007,702002007014)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('ASUS PRIME TRX40-PRO sTRX4 AMD TRX40 SATA 6Gb/s ATX AMD Motherboard',424.99,18,600002,702002007,702002007015)
,('ASUS Prime X570-Pro Ryzen 3 AM4 with PCIe 4.0',239.99,43,600002,702002007,702002007013)
,('ASUS ROG STRIX B360-H GAMING LGA1151 (300 Series) DDR4 HDMI DVI M.2 ATX Motherboard',206.99,18,600002,702002007,702002007011)
,('ASUS ROG STRIX TRX40-E GAMING sTRX4 AMD TRX40 SATA 6Gb/s ATX AMD Motherboard',519.99,23,600002,702002007,702002007016)
,('ASUS ROG Strix Z370-H Gaming LGA 1151 (300 Series) Intel Z370 HDMI SATA 6Gb/s USB 3.1 ATX Intel Motherboard',392.32,34,600002,702002007,702002007009)
,('ASUS TUF Z390-Plus Gaming (Wi-Fi) LGA 1151 (300 Series) Intel Z390 HDMI SATA 6Gb/s USB 3.1 ATX Intel Motherboard',161.99,23,600002,702002007,702002007010)
,('Acer Extensa Flagship High Performance Desktop | Intel Pentium J3710 Quad-Core | 8GB RAM | 500GB HDD | HDMI+VGA |',279.99,49,600003,703001002,703001002007)
,('CORSAIR AXi Series AX1200i Digital 1200W 80 PLUS PLATINUM',369.99,56,600013,702002008,702002008006)
,('CORSAIR AXi Series AX1600i CP-9020087-NA 1600W ATX 80 PLUS TITANIUM ',499.99,47,600013,702002008,702002008007)
,('CORSAIR HXi Series HX1000i 1000W 80 PLUS PLATINUM',244.99,43,600013,702002008,702002008005)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('CORSAIR HXi Series HX750i 750W 80 PLUS PLATINUM',199.99,55,600013,702002008,702002008003)
,('CORSAIR HXi Series HX850i 850W 80 PLUS PLATINUM',219.99,32,600013,702002008,702002008004)
,('CORSAIR RMx Series RM750x CP-9020179-NA 750W ATX12V / EPS12V 80 PLUS GOLD Certified Full Modular Power Supply',129.99,49,600013,702002008,702002008001)
,('CORSAIR RMx Series RM850x CP-9020180-NA 850W ATX12V / EPS12V 80 PLUS GOLD Certified Full Modular Power Supply',144.99,55,600013,702002008,702002008002)
,('CORSAIR Vengeance RGB Pro 16GB (2 x 8GB) 288-Pin DDR4 SDRAM DDR4 3600',103.98,234,600013,702002006,702002006004)
,('EVGA SuperNOVA 1000 G2 120-G2-1000-XR 80+ GOLD 1000W',287.99,34,600023,702002008,702002008009)
,('EVGA SuperNOVA 1300 G2 120-G2-1300-XR 80+ GOLD 1300W',319.99,42,600023,702002008,702002008010)
,('EVGA SuperNOVA 850 G2 220-G2-0850-XR 80+ GOLD 850W',139.99,54,600023,702002008,702002008008)
,('GIGABYTE TRX40 AORUS PRO WIFI sTRX4 AMD TRX40 SATA 6Gb/s ATX AMD Motherboard',429.99,14,600025,702002007,702002007024)
,('GIGABYTE X299 DESIGNARE EX (rev. 1.0) LGA 2066 Intel X299 SATA 6Gb/s USB 3.1 ATX Intel Motherboard',461.87,23,600025,702002007,702002007004)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('GIGABYTE X570 AORUS ELITE AMD Ryzen 3000 PCIe 4.0 SATA 6Gb/s USB 3.2 AMD X570 ATX Motherboard',199.99,36,600025,702002007,702002007021)
,('GIGABYTE X570 AORUS MASTER AMD Ryzen 3000 PCIe 4.0 SATA 6Gb/s USB 3.2 AMD X570 ATX Motherboard',372.99,14,600025,702002007,702002007023)
,('GIGABYTE X570 AORUS PRO WIFI AMD Ryzen 3000 PCIe 4.0 SATA 6Gb/s USB 3.2 AMD X570 ATX Motherboard',269.99,32,600025,702002007,702002007022)
,('GIGABYTE Z390 AORUS ELITE LGA 1151 (300 Series) Intel Z390 HDMI SATA 6Gb/s USB 3.1 ATX Intel Motherboard',192.99,32,600025,702002007,702002007001)
,('GIGABYTE Z390 AORUS MASTER LGA 1151 (300 Series) Intel Z390 SATA 6Gb/s ATX Intel Motherboard',269.99,37,600025,702002007,702002007003)
,('GIGABYTE Z390 AORUS PRO LGA 1151 (300 Series) Intel Z390 HDMI SATA 6Gb/s USB 3.1 ATX Intel Motherboard',200.55,54,600025,702002007,702002007002)
,('HyperX Cloud Core Gaming Headset',87.15,11,600027,701001001,701001001007)
,('Microsoft Xbox One X - 1TB - Gears 5 Bundle',449.99,142,600033,704001002,704001002005)
,('Microsoft Xbox One X 1TB Solid State Drive Black Gaming Console with Wireless Controller',399.99,165,600033,704001002,704001002001)
,('Microsoft Xbox One X 2TB Solid State Hybrid Drive Black Gaming Console with Wireless Controller',499.99,186,600033,704001002,704001002002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Microsoft Xbox One X 2TB SSHD Gears Complete Bundle with Wireless Controller and Xbox Game Pass Live Gold Trial',559.99,175,600033,704001002,704001002008)
,('Microsoft Xbox One X 2TB SSHD NBA 2K20 Bundle with Wireless Controller and Xbox Game Pass Live Gold Trial',559.99,127,600033,704001002,704001002006)
,('Microsoft Xbox One X 2TB SSHD PUBG Bundle with Wireless Controller and Xbox Game Pass Live Gold Trial',559.99,124,600033,704001002,704001002007)
,('MSI B360-A PRO LGA 1151 (300 Series) Intel B360 SATA 6Gb/s USB 3.1 ATX Intel Motherboard',125.98,62,600034,702002007,702002007007)
,('MSI MPG X570 GAMING EDGE WIFI Gaming Motherboard AMD AM4',183.99,32,600034,702002007,702002007018)
,('MSI MPG X570 GAMING PLUS Gaming Motherboard AMD AM4',164.99,51,600034,702002007,702002007017)
,('MSI MPG X570 GAMING PRO CARBON WIFI Gaming Motherboard AMD AM4',237.23,22,600034,702002007,702002007019)
,('MSI MPG Z390 GAMING EDGE AC LGA 1151 (300 Series) Intel Z390 HDMI SATA 6Gb/s USB 3.1 ATX Intel Motherboard',179.99,44,600034,702002007,702002007005)
,('MSI MPG Z390 GAMING PRO CARBON AC LGA 1151 (300 Series) Intel Z390 HDMI SATA 6Gb/s USB 3.1 ATX Intel Motherboard',209.98,32,600034,702002007,702002007006)
,('MSI PRO H310-F PRO LGA 1151 (300 Series) Intel H310 SATA 6Gb/s ATX Intel Motherboard',233.33,22,600034,702002007,702002007008)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('MSI PRO TRX40 PRO 10G sTRX4 AMD TRX40 SATA 6Gb/s ATX AMD Motherboard',476.99,32,600034,702002007,702002007020)
,('Nintendo - Switch 32GB Console - Gray Joy-Con',299.99,654,600035,704001003,704001003006)
,('Nintendo - Switch 32GB Console - Neon Red/Neon Blue Joy-Con',299.99,564,600035,704001003,704001003005)
,('Nintendo - Switch 32GB Lite - Coral',199.99,347,600035,704001003,704001003003)
,('Nintendo - Switch 32GB Lite - Gray',199.99,345,600035,704001003,704001003002)
,('Nintendo - Switch 32GB Lite - Turquoise',199.99,348,600035,704001003,704001003004)
,('Nintendo - Switch 32GB Lite - Yellow',199.99,341,600035,704001003,704001003001)
,('Sony - Geek Squad Certified Refurbished PlayStation 4 1TB Console',299.99,143,600047,704001001,704001001005)
,('Sony - Geek Squad Certified Refurbished PlayStation 4 Pro Console',399.99,198,600047,704001001,704001001006)
,('Sony - PlayStation 4 1TB Console',299.99,203,600047,704001001,704001001001)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('Sony - PlayStation 4 1TB Fortnite Neo Versa Console Bundle',319.99,132,600047,704001001,704001001003)
,('Sony - PlayStation 4 Pro 1TB Call of Duty: Modern Warfare Console Bundle',429.99,187,600047,704001001,704001001004)
,('Sony - PlayStation 4 Pro Console',399.99,192,600047,704001001,704001001002)
,('Microsoft Xbox One X 1TB Console - Fallout 76 Bundle',449.99,213,600033,704001002,704001002003)
,('Microsoft Xbox One X 1TB Console - Tom Clancys The Division 2 Bundle',449.99,97,600033,704001002,704001002004)
,('AMD - Ryzen 7 3800X Octa-Core 3.9 GHz Socket AM4 Desktop Processor',399.99,36,600001,702002001,702002001005)
,('ASUS - NVIDIA GeForce RTX 2060 SUPER Advanced Edition 8GB GDDR6 PCI Express 3.0 Graphics Card',449.99,78,600002,702002002,702002002006)
,('ASUS AM4 TUF Gaming X570-Plus (Wi-Fi) ATX Motherboard with PCIe 4.0',179.99,32,600002,702002007,702002007012)
,('Alienware Gaming PC Desktop Aurora R7-8th Gen Intel Core i7-8700, 16GB DDR4 Memory, 2TB Hard Drive, NVIDIA GeForce GTX 1080 8GB GDDR5X',1399.99,1,600004,703001002,703001002009)
,('AmazonBasics Computer Monitor TV Replacement Power Cord - 10-Foot, Black',8.55,55,600005,701002002,701002002002)
;
INSERT INTO "QuiccExpress".products (product_name,product_price,product_stock,brand_id,type_id,product_id) VALUES 
('ASUS ROG Zephyrus S GX701 (2019) Gaming Laptop, 17.3” 144Hz Pantone Validated Full HD IPS, GeForce RTX 2070, Intel Core i7-9750H, 16GB DDR4, 1TB PCIe Nvme SSD Hyper Drive',2499.99,11,600002,703001001,703001001030)
,('HP - ENVY Curved 34" All-In-One - Intel Core i7 - 16GB Memory - 1TB Hard Drive + 256GB Solid State Drive - Ash Silver',2249.99,14,600026,703001003,703001003011)
,('HyperX Fury S - Pro Gaming Mouse Pad, Cloth Surface Optimized for Precision',19.99,38,600027,701003004,701003004007)
,('Intel - Core i7-9700 Octa-Core 3 GHz Socket LGA 1151 Desktop Processor with Enhanced Speedstep Technology',329.99,49,600028,702002001,702002001020)
,('Cooler Master MasterCase Maker 5 EDITION Midi Tower PC Case',174.99,17,600018,702001001,702001001005)
,('Update',174.99,17,600018,702001001,702)
;

INSERT INTO "QuiccExpress".shopping_cart (is_active,expires,username,cart_id) VALUES 
(false,NULL,'AcrobaticLady',110000001)
,(false,NULL,'ActionOlive',110000002)
,(true,'2020-06-01','AwkwardCoconut',110000003)
,(true,'2020-06-01','BakingSunflower',110000004)
,(true,'2020-06-01','BalloonMoose',110000005)
,(true,'2020-06-01','BeautifulHero',110000006)
,(true,'2020-06-01','Bingoddess',110000007)
,(true,'2020-06-01','BuffaLou',110000008)
,(true,'2020-06-01','ChangeSeer',110000009)
,(true,'2020-06-01','DopeyBison',110000010)
,(true,'2020-06-01','EcstaticRam',110000011)
;
INSERT INTO "QuiccExpress".shopping_cart (is_active,expires,username,cart_id) VALUES 
(true,'2020-06-01','Gangstereo',110000012)
,(true,'2020-06-01','Update',110000013)
;

INSERT INTO "QuiccExpress".cart_content (cart_id,product_id,quantity) VALUES 
(110000003,701002001001,3)
,(110000004,701002006002,2)
,(110000005,701002005005,4)
,(110000006,701002003002,1)
,(110000007,701001003002,6)
,(110000008,701001001001,5)
,(110000009,701002005002,8)
,(110000010,701001004006,1)
,(110000011,701001001003,1)
,(110000012,703001001031,2)
,(110000013,703001001031,31)
;

INSERT INTO "QuiccExpress".reviews (review_text,username,review_id,product_id,rating) VALUES 
('Very Nice','AcrobaticLady',210000001,701002005006,4)
,('Great','ActionOlive',210000002,701002006007,4)
,('IT SUCKS!!','BakingSunflower',210000004,701002003003,1)
,('You should buy it','BalloonMoose',210000005,701002006002,4)
,('DONT BUY!!!!','BeautifulHero',210000006,701002005001,0)
,('Perfection','Bingoddess',210000007,701001003003,5)
,('Avoid it at all costs','BuffaLou',210000008,701002004006,0)
,('Loving it','ChangeSeer',210000009,701001001001,5)
,('Very Nice','DopeyBison',210000010,701003003007,5)
,('Average','AwkwardCoconut',210000003,701002006002,5)
,('Average','Update',210000015,701002006002,5)
;

INSERT INTO "QuiccExpress".address (address_id,street_name,city_name,state,zip_code,username) VALUES 
(430000006,'4810 50th St','Moline','IL',61265,'ActionOlive')
,(430000013,'50 Laddins Rock Rd','Old Greenwich','CT',6870,'AwkwardCoconut')
,(430000005,'26021 Rock St','Coolville','OH',45723,'BakingSunflower')
,(430000004,'26557 S Jacob Dr','Channahon','IL',60410,'BalloonMoose')
,(430000012,'26 Birch Rd','Darien','CT',6820,'BeautifulHero')
,(430000003,'7910 Leigh Ann Dr','Dallas','TX',75232,'Bingoddess')
,(430000011,'108 Warren Hill Rd','Cornwall Bridge','CT',6754,'BuffaLou')
,(430000009,'333 Murfreesboro Pike','Nashville','TN',37210,'ChangeSeer')
,(430000002,'546 Sylvan St','Nashville','TN',37206,'DopeyBison')
,(430000008,'95 Houcks Gin Rd','Elloree','SC',29047,'EcstaticRam')
;
INSERT INTO "QuiccExpress".address (address_id,street_name,city_name,state,zip_code,username) VALUES 
(430000001,'24 Pine Acres Dr','Cassadaga','NY',14718,'Gangstereo')
,(430000007,'5977 S 1050th W','Owensville','IN',47665,'AcrobaticLady')
,(430000020,'Update','Owensville','IN',47665,'AcrobaticLady')
;

INSERT INTO "QuiccExpress".credit_card (card_number,card_cvv,card_owner,expire_date,username) VALUES 
(5582065671112900,309,'Clara Woods','2020-05-10 00:00:00.000','AcrobaticLady')
,(5447276423918347,372,'Jeanne Kennedy','2021-05-30 00:00:00.000','ActionOlive')
,(5415961438106644,327,'Salvatore Terry','2025-09-27 00:00:00.000','AwkwardCoconut')
,(5349131472833872,688,'Dianne Sherman','2025-08-14 00:00:00.000','BakingSunflower')
,(5245845448103319,666,'Nina Hardy','2023-07-11 00:00:00.000','BalloonMoose')
,(5305989379932382,359,'Stephanie Powell','2024-02-26 00:00:00.000','BeautifulHero')
,(5342787927165413,520,'Meredith Cox','2023-09-07 00:00:00.000','Bingoddess')
,(5314156477826143,419,'Preston Hernandez','2021-07-23 00:00:00.000','BuffaLou')
,(5289745531885938,650,'Erin Martin','2020-11-12 00:00:00.000','ChangeSeer')
,(5506028441952362,486,'Omar Nunez','2020-08-14 00:00:00.000','DopeyBison')
,(5506028441952369,486,'Omer Nunez','2020-08-14 00:00:00.000','Update')
;
INSERT INTO "QuiccExpress".credit_card (card_number,card_cvv,card_owner,expire_date,username) VALUES 
(5141804257271951,685,'Dana Douglas','2021-07-23 00:00:00.000','EcstaticRam')
,(5169160243378393,661,'Kağan Aslan','2024-02-15 00:00:00.000','Gangstereo')
;

INSERT INTO "QuiccExpress".payment (payment_id,price,payment_date,card_number) VALUES 
(410000006,1,'2020-02-24',5245845448103319)
,(410000008,1,'2020-01-16',5305989379932382)
,(410000009,1,'2019-12-24',5342787927165413)
,(410000010,1,'2020-02-09',5314156477826143)
,(410000016,1,'2020-03-19',5506028441952362)
,(410000018,1,'2020-02-04',5141804257271951)
,(410000002,1,'2019-12-22',5582065671112900)
,(410000015,1,'2020-05-04',5289745531885938)
,(410000019,1,'2020-05-04',5169160243378393)
,(410000003,1,'2020-05-04',5447276423918347)
;
INSERT INTO "QuiccExpress".payment (payment_id,price,payment_date,card_number) VALUES 
(410000004,1,'2020-05-04',5415961438106644)
,(410000005,1,'2020-05-04',5349131472833872)
,(410000001,1,'2020-05-04',5349131472833872)
;

INSERT INTO "QuiccExpress".invoices (invoice_id,invoice_date,username,address_id,card_number) VALUES 
(520000006,'2020-01-16','BeautifulHero',430000012,5305989379932382)
,(520000007,'2019-12-24','Bingoddess',430000003,5342787927165413)
,(520000008,'2020-02-09','BuffaLou',430000011,5314156477826143)
,(520000009,'2020-02-16','ChangeSeer',430000009,5289745531885938)
,(520000010,'2020-03-19','DopeyBison',430000002,5506028441952362)
,(520000011,'2020-02-04','EcstaticRam',430000008,5141804257271951)
,(520000012,'2020-03-10','Gangstereo',430000001,5169160243378393)
,(520000001,'2020-05-04','AcrobaticLady',430000007,5582065671112900)
,(520000002,'2020-05-04','ActionOlive',430000006,5447276423918347)
,(520000003,'2020-05-04','AwkwardCoconut',430000013,5415961438106644)
;
INSERT INTO "QuiccExpress".invoices (invoice_id,invoice_date,username,address_id,card_number) VALUES 
(520000004,'2020-05-04','BakingSunflower',430000005,5349131472833872)
,(520000005,'2020-05-04','BalloonMoose',430000004,5245845448103319)
,(520000013,'2020-05-04','Update',430000004,5245845448103319)
;

INSERT INTO "QuiccExpress".orders (order_id,username,payment_id,invoice_id,product_id,order_date,quantity) VALUES 
(530000006,'BeautifulHero',410000008,520000006,701002005001,'2020-01-16',4)
,(530000007,'Bingoddess',410000009,520000007,701001003003,'2019-12-24',3)
,(530000008,'BuffaLou',410000010,520000008,701002004006,'2020-02-09',8)
,(530000009,'ChangeSeer',410000015,520000009,701001001001,'2020-02-16',8)
,(530000011,'EcstaticRam',410000018,520000011,701003003007,'2020-02-04',2)
,(530000012,'Gangstereo',410000019,520000012,701003003007,'2020-03-10',3)
,(530000002,'ActionOlive',410000003,520000002,701002006007,'2020-05-04',1)
,(530000010,'DopeyBison',410000016,520000010,701003003007,'2020-04-19',6)
,(530000001,'AcrobaticLady',410000002,520000001,701003003007,'2020-04-04',3)
,(530000003,'AwkwardCoconut',410000004,520000003,701003003004,'2020-04-03',1)
;
INSERT INTO "QuiccExpress".orders (order_id,username,payment_id,invoice_id,product_id,order_date,quantity) VALUES 
(530000004,'BakingSunflower',410000005,520000004,701003001002,'2020-04-02',2)
,(530000005,'BalloonMoose',410000006,520000005,701003001002,'2020-04-11',5)
,(530000013,'Update',410000004,520000003,701003003004,'2020-05-04',1)
;

INSERT INTO "QuiccExpress".shipping (shipping_id,shipping_type,address_id,order_id,invoice_id) VALUES 
(510000001,'Standard',430000007,530000001,520000001)
,(510000002,'OneDay',430000006,530000002,520000002)
,(510000003,'OneDay',430000013,530000003,520000003)
,(510000004,'Standard',430000005,530000004,520000004)
,(510000005,'OneDay',430000004,530000005,520000005)
,(510000006,'Standard',430000012,530000006,520000006)
,(510000007,'OneDay',430000003,530000007,520000007)
,(510000008,'Standard',430000011,530000008,520000008)
,(510000009,'OneDay',430000009,530000009,520000009)
,(510000010,'Standard',430000002,530000010,520000010)
;
INSERT INTO "QuiccExpress".shipping (shipping_id,shipping_type,address_id,order_id,invoice_id) VALUES 
(510000011,'Standard',430000008,530000011,520000011)
,(510000012,'Standard',430000001,530000012,520000012)
,(510000013,'Update',430000001,530000012,520000012)
;

update "QuiccExpress".user_account 
set username = 'Delete'
where username = 'Update';

update "QuiccExpress".brands 
set brand_name = 'Delete'
where brand_name = 'Update';

update "QuiccExpress".categories 
set category_name = 'Delete'
where category_name = 'Update';

update "QuiccExpress".subcategories 
set subcategory_name = 'Delete'
where subcategory_name = 'Update';

update "QuiccExpress".product_type 
set type_name = 'Delete'
where type_name = 'Update';

update "QuiccExpress".products 
set product_name = 'Delete'
where product_name = 'Update';

update "QuiccExpress".shopping_cart 
set cart_id = 110000014
where cart_id = 110000013;

update "QuiccExpress".cart_content 
set quantity = 28
where quantity = 31;

update "QuiccExpress".reviews 
set review_id = 210000016
where review_id = 210000015;

update "QuiccExpress".address 
set street_name = 'Delete'
where street_name = 'Update';

update "QuiccExpress".credit_card 
set card_number = 5506028441952368
where card_number = 5506028441952369;

update "QuiccExpress".payment 
set payment_id = 410000026
where payment_id = 410000001;

update "QuiccExpress".invoices 
set invoice_id = 520000018
where invoice_id = 520000013;

update "QuiccExpress".orders 
set order_id = 530000018
where order_id = 530000013;

update "QuiccExpress".shipping 
set shipping_id = 510000015
where shipping_id = 510000013;

delete from "QuiccExpress".shipping 
where shipping_id = 510000015;

delete from "QuiccExpress".orders 
where order_id = 530000018;

delete from "QuiccExpress".invoices 
where invoice_id = 520000018;

delete from "QuiccExpress".payment 
where payment_id = 410000026;

delete from "QuiccExpress".credit_card 
where card_number = 5506028441952368;

delete from "QuiccExpress".address 
where street_name = 'Delete';

delete from "QuiccExpress".reviews 
where review_id = 210000016;

delete from "QuiccExpress".cart_content 
where quantity = 28;

delete from "QuiccExpress".shopping_cart 
where cart_id = 110000014;

delete from "QuiccExpress".products 
where product_name = 'Delete';

delete from "QuiccExpress".product_type 
where type_name = 'Delete';

delete from "QuiccExpress".subcategories 
where subcategory_name = 'Delete';

delete from "QuiccExpress".categories 
where category_name = 'Delete';

delete from "QuiccExpress".brands 
where brand_name = 'Delete';

delete from "QuiccExpress".user_account 
where username = 'Delete';

create view "QuiccExpress"."ActiveBrands" 
as select brand_name, brand_id
from "QuiccExpress".brands;

insert into "QuiccExpress"."ActiveBrands"
  select 'ViewBrand', 1956;

 update "QuiccExpress"."ActiveBrands"
set brand_name = 'Delete'
where brand_name = 'ViewBrand';

delete from "QuiccExpress"."ActiveBrands"
where brand_name = 'Delete';


  
