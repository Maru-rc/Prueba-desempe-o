-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE public.riwi_inventory_id_inventory_seq;

CREATE SEQUENCE public.riwi_inventory_id_inventory_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.riwi_product_categorie_id_categorie_seq;

CREATE SEQUENCE public.riwi_product_categorie_id_categorie_seq
	MINVALUE 0
	NO MAXVALUE
	START 0
	NO CYCLE;
-- DROP SEQUENCE public.riwi_product_id_product_seq;

CREATE SEQUENCE public.riwi_product_id_product_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.riwi_supplier_id_supplier_seq;

CREATE SEQUENCE public.riwi_supplier_id_supplier_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.riwi_transaction_id_transaction_seq;

CREATE SEQUENCE public.riwi_transaction_id_transaction_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.riwi_warehouse_id_warehouse_seq;

CREATE SEQUENCE public.riwi_warehouse_id_warehouse_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.dataset_riwisupply definition

-- Drop table

-- DROP TABLE public.dataset_riwisupply;

CREATE TABLE public.dataset_riwisupply (
	"MovementDate" varchar(50) NULL,
	"SupplierName" varchar(50) NULL,
	"SupplierCity" varchar(50) NULL,
	"Warehouse" varchar(50) NULL,
	"WarehouseCity" varchar(50) NULL,
	"ProductName" varchar(50) NULL,
	"Category" varchar(50) NULL,
	"Quantity" int4 NULL,
	"UnitPrice" int4 NULL,
	"MovementType" varchar(50) NULL,
	"PurchaseOrder" varchar(50) NULL
);


-- public.riwi_product definition

-- Drop table

-- DROP TABLE public.riwi_product;

CREATE TABLE public.riwi_product (
	id_product serial4 NOT NULL,
	product_name varchar(150) NOT NULL,
	unit_price float8 NOT NULL,
	category varchar NULL,
	CONSTRAINT riwi_product_pkey PRIMARY KEY (id_product)
);


-- public.riwi_supplier definition

-- Drop table

-- DROP TABLE public.riwi_supplier;

CREATE TABLE public.riwi_supplier (
	id_supplier serial4 NOT NULL,
	supplier_name varchar(150) NOT NULL,
	supplier_city varchar(100) NOT NULL,
	CONSTRAINT riwi_supplier_pkey PRIMARY KEY (id_supplier)
);


-- public.riwi_warehouse definition

-- Drop table

-- DROP TABLE public.riwi_warehouse;

CREATE TABLE public.riwi_warehouse (
	id_warehouse serial4 NOT NULL,
	warehouse_name varchar(100) NOT NULL,
	warehouse_city varchar(100) NOT NULL,
	CONSTRAINT riwi_warehouse_pkey PRIMARY KEY (id_warehouse)
);


-- public.riwi_product_supplier definition

-- Drop table

-- DROP TABLE public.riwi_product_supplier;

CREATE TABLE public.riwi_product_supplier (
	product_id int4 NOT NULL,
	supplier_id int4 NOT NULL,
	CONSTRAINT fk_product_supplier FOREIGN KEY (product_id) REFERENCES public.riwi_product(id_product),
	CONSTRAINT fk_supplier_product FOREIGN KEY (supplier_id) REFERENCES public.riwi_supplier(id_supplier)
);


-- public.riwi_transaction definition

-- Drop table

-- DROP TABLE public.riwi_transaction;

CREATE TABLE public.riwi_transaction (
	id_transaction serial4 NOT NULL,
	movement_date date NOT NULL,
	product_id int4 NOT NULL,
	quantity int4 NOT NULL,
	transaction_price float8 NOT NULL,
	movement_type varchar(30) NOT NULL,
	warehouse_id int4 NOT NULL,
	CONSTRAINT riwi_transaction_pkey PRIMARY KEY (id_transaction),
	CONSTRAINT fk_transaction_product FOREIGN KEY (product_id) REFERENCES public.riwi_product(id_product),
	CONSTRAINT fk_transaction_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.riwi_warehouse(id_warehouse)
);


-- public.riwi_inventory definition

-- Drop table

-- DROP TABLE public.riwi_inventory;

CREATE TABLE public.riwi_inventory (
	id_inventory serial4 NOT NULL,
	inventory_name varchar(150) NOT NULL,
	id_warehouse int4 NOT NULL,
	id_product int4 NOT NULL,
	product_quantity int4 NULL,
	id_transaction int4 NOT NULL,
	CONSTRAINT riwi_inventory_pkey PRIMARY KEY (id_inventory),
	CONSTRAINT fk_inventory_product FOREIGN KEY (id_product) REFERENCES public.riwi_product(id_product),
	CONSTRAINT fk_inventory_transaction FOREIGN KEY (id_transaction) REFERENCES public.riwi_transaction(id_transaction),
	CONSTRAINT fk_inventory_warehouse FOREIGN KEY (id_warehouse) REFERENCES public.riwi_warehouse(id_warehouse)
);