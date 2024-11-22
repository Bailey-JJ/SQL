--create a table of insert statements
SELECT 'insert into Seller values (' +
       QUOTENAME(seller_id, '''') + ',' + QUOTENAME(seller_name, '''') + QUOTENAME(Street, '''') + ',' + QUOTENAME(City, '''') + QUOTENAME(State, '''') + ',' + QUOTENAME(ZIP, '''') + QUOTENAME(Email, '''') + ',' + ');'
FROM Seller;

--Use to drop tables

drop table if exists [Repairs];
drop table if exists [PaymentTransaction];
drop table if exists [Payments];
drop table if exists [CarsSold];
drop table if exists [Employment];
drop table if exists [PurchasedCars];
drop table if exists [SalesHeader];
drop table if exists [PurchaseHeader];
drop table if exists [Warranty];
drop table if exists [Customer];
drop table if exists [SalesPerson];
drop table if exists [Car];
drop table if exists [ConditionLookup];
drop table if exists [ShopLookup];
drop table if exists [Seller];


--start of table creation script


create table [SalesPerson] (
  [employee_id] char (8),
  [first_name] varchar (50),
  [last_name] varchar (50),
  [commission] decimal (10, 2),
  [phone] char (12),
  PRIMARY KEY ([employee_id])
);

create table [Customer] (
  [customer_id] char (8),
  [tax_payer_id] char (9),
  [last_name] varchar (50),
  [first_name] varchar (50),
  [date_of_birth] date,
  [gender] varchar (10),
  [street] varchar (50),
  [city] varchar (50),
  [state] char (2),
  [zip] char (5),
  [phone] char (12),
  PRIMARY KEY ([customer_id])
);

create table [SalesHeader] (
  [sale_id] char (8),
  [employee_id] char (8),
  [customer_id] char (8),
  [sale_date] date,
  [total_due] decimal (10, 2),
  [down_payment] decimal (10, 2),
  [financed_amount] decimal (10, 2),
  PRIMARY KEY ([sale_id]),
  FOREIGN KEY ([employee_id]) REFERENCES [SalesPerson]([employee_id]),
  FOREIGN KEY ([customer_id]) REFERENCES [Customer]([customer_id])
);

create table [Car] (
  [VIN] char (17),
  [make] varchar (50),
  [model] varchar (50),
  [year] char(4),
  [color] varchar (20),
  [style] varchar (20),
  PRIMARY KEY ([VIN])
);

create table [ConditionLookup] (
  [condition_id] varchar(10),
  [condition] varchar(10),
  PRIMARY KEY ([condition_id])
);

create table [CarsSold] (
  [sale_id] char (8),
  [item_id] char (8),
  [condition_id] varchar(10),
  [VIN] char (17),
  [warrant_id] int,
  [miles_at_sale] int,
  [sale_price] decimal (10, 2),
  PRIMARY KEY ([sale_id], [item_id]),
  FOREIGN KEY ([sale_id]) REFERENCES [SalesHeader]([sale_id]),
  FOREIGN KEY ([VIN]) REFERENCES [Car]([VIN]),
  FOREIGN KEY ([condition_id]) REFERENCES [ConditionLookup]([condition_id])
);

create table [Payments] (
  [payment_id] char (8),
  [sale_id] char(8),
  [item_id] char (8),
  [bank_acc] char (12),
  [payment_date] date,
  [amount_due] decimal (10, 2),
  [amount] decimal (10, 2),
  PRIMARY KEY ([payment_id]),
  FOREIGN KEY ([sale_id], [item_id]) REFERENCES [CarsSold]([sale_id], [item_id])
);


create table [Seller] (
  [seller_id] int,
  [seller_name] varchar (50),
  [Street] varchar (50),
  [City] varchar (50),
  [State] char (2),
  [ZIP] char (5),
  [Email] varchar (50),
  PRIMARY KEY ([seller_id])
);

create table [PurchaseHeader] (
  [purchase_id] char (8),
  [seller_id] int,
  [tax_id] varchar(9),
  [purchase_date] date,
  [location] varchar(100),
  [auction] bit,
  PRIMARY KEY ([purchase_id]),
  FOREIGN KEY ([seller_id]) REFERENCES [Seller]([seller_id])
);

create table [PaymentTransaction] (
  [payment_id] char (8),
  [payment_date] date,
  [amount_due] decimal (10, 2),
  [amount_paid] decimal (10, 2),
  PRIMARY KEY ([payment_id], [payment_date]),
  FOREIGN KEY ([payment_id]) REFERENCES [Payments]([payment_id])
);

create table [ShopLookup] (
  [shop_id] int,
  [shop_name] varchar(10),
  PRIMARY KEY ([shop_id])
);

create table [PurchasedCars] (
  [purchase_id] char (8),
  [item_id] char (8),
  [condition_id] varchar (10),
  [VIN] char (17),
  [miles_at_purchase] int,
  [price_paid] decimal (10,2),
  [list_price] decimal  (10, 2),
  PRIMARY KEY ([purchase_id], [item_id]),
  FOREIGN KEY ([VIN]) REFERENCES [Car]([VIN]),
  FOREIGN KEY ([purchase_id]) REFERENCES [PurchaseHeader]([purchase_id]),
  FOREIGN KEY ([condition_id]) REFERENCES [ConditionLookup]([condition_id])
);

create table [Repairs] (
  [repair_date] date,
  [VIN] char (17),
  [shop_id] int,
  [repair_description] varchar (100),
  [repair_cost] decimal(10, 2),
  PRIMARY KEY ([repair_date]),
  FOREIGN KEY ([shop_id]) REFERENCES [ShopLookup]([shop_id]),
  FOREIGN KEY ([VIN]) REFERENCES [Car]([VIN])
);

create table [Warranty] (
  [warranty_id] int,
  [cost] decimal (10, 2),
  [end_date] date,
  PRIMARY KEY ([warranty_id])
);

create table [Employment] (
  [customer_id] char (8),
  [employer_name] varchar(50),
  [title] varchar (50),
  [supervisor_name] varchar (50),
  [phone] char (12),
  [street] varchar (50),
  [city] varchar (50),
  [state] char (2),
  [zip] char (5),
  [start_date] date,
  [end_date] date,
  PRIMARY KEY ([customer_id], [employer_name]),
  FOREIGN KEY ([customer_id]) REFERENCES [Customer]([customer_id])
);

