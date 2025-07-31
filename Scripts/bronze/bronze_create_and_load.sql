-- Script Name     : create_and_load_procedure.sql
-- Purpose         : To create or replace the procedure `bronze.load_bronze`
--                   which prepares the Bronze layer of the Data Warehouse
--                   by creating necessary tables and performing bulk inserts
-- Description     : 
--                  1. Drops and recreates all Bronze tables
--                  2. Loads data into the tables from CSV files
-- 
-- Layer           : Bronze (Raw data ingestion layer)
-- Author          : Farhan Khan
-- Date Created    : 2025-07-31
-- Last Modified   : 2025-07-31
-- 
-- ⚠️ WARNING:
-- This script DROPS AND RECREATES all raw ingestion tables in the Bronze layer.
-- Make sure any dependent objects are managed accordingly.
-- 
-- HOW TO RUN:
-- 1. Run this script in a PostgreSQL-compatible environment.
-- 2. Ensure that the .csv files exist at the specified path on the DB server.
-- 3. Call the procedure using: CALL bronze.load_bronze();
-- ============================================

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
language plpgsql
as $$
BEGIN

-- TABLE 1: CRM Customer Info
	DROP TABLE IF EXISTS bronze.crm_cust_info;
	create table bronze.crm_cust_info(
	cst_id int,
	cst_key varchar(50),
	cst_firstname varchar(50),
	cst_lastname varchar(50),
	cst_marital_status varchar(50),
	cst_gndr varchar(50),
	cst_create_date date
	);
	
	
-- TABLE 2: CRM Product Info
	DROP TABLE IF EXISTS bronze.crm_prd_info;
	create table bronze.crm_prd_info(
	prd_id int,
	prd_key varchar(50),
	prd_nm varchar(50),
	prd_cost int,
	prd_line varchar(50),
	prd_start_date TIMESTAMP,
	prd_end_date TIMESTAMP
	);

	
-- TABLE 3: CRM Sales Details
	DROP TABLE IF EXISTS bronze.crm_sales_details;
	create table bronze.crm_sales_details(
	sls_ord_num varchar(50),
	sls_prd_key varchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int 
	);

	
-- TABLE 4: ERP Customer AZ12
	DROP TABLE IF EXISTS bronze.erp_cust_az12;
	create table bronze.erp_cust_az12(
	cid varchar(50),
	bdate date,
	gen varchar(50)
	);
	
	
-- TABLE 5: ERP Location A101
	DROP TABLE IF EXISTS bronze.erp_loc_a101;
	create table bronze.erp_loc_a101(
	cid varchar(50),
	cntry varchar(50)
	);
	
	
-- TABLE 6: ERP Product Category G1V2
	DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
	create table bronze.erp_px_cat_g1v2(
	id varchar(50),
	cat varchar(50),
	subcat varchar(50),
	maintenance varchar(50)
	);
	
-----------------------------------------------------------------
-- 1) Bulk Insert: crm Customer Info
	TRUNCATE TABLE bronze.crm_cust_info;
	copy bronze.crm_cust_info (
	    cst_id,
	    cst_key,
	    cst_firstname,
	    cst_lastname,
	    cst_marital_status,
	    cst_gndr,
	    cst_create_date)
	FROM 'C:\SQL\cust_info.csv'
	DELIMITER ','
	CSV HEADER;
	
	
-- 2) Bulk Insert: bronze.crm_prd_info
	TRUNCATE TABLE bronze.crm_prd_info;
	copy bronze.crm_prd_info (
	    prd_id,
	    prd_key,
	    prd_nm,
	    prd_cost,
	    prd_line,
	    prd_start_date,
	    prd_end_date)
	FROM 'C:\SQL\prd_info.csv'
	DELIMITER ','
	CSV HEADER;
	
	
-- 3) Bulk Insert: bronze.crm_sales_details
	TRUNCATE TABLE  bronze.crm_sales_details;
	copy bronze.crm_sales_details (
	    sls_ord_num,
	    sls_prd_key,
	    sls_cust_id,
	    sls_order_dt,
	    sls_ship_dt,
	    sls_due_dt,
	    sls_sales,
	    sls_quantity,
	    sls_price)
	FROM 'C:\SQL\sales_details.csv'
	DELIMITER ','
	CSV HEADER;


-- 4) Bulk Insert: bronze.erp_cust_az12
	TRUNCATE TABLE bronze.erp_cust_az12;
	copy bronze.erp_cust_az12 (
	    cid,
	    bdate,
	    gen)
	FROM 'C:\SQL\CUST_AZ12.csv'
	DELIMITER ','
	CSV HEADER;
	
	
-- 5) Bulk Insert: bronze.erp_loc_a101
	TRUNCATE TABLE bronze.erp_loc_a101;
	copy bronze.erp_loc_a101 (
	    cid,
	    cntry)
	FROM 'C:\SQL\loc_a101.csv'
	DELIMITER ','
	CSV HEADER;

	
-- 6) Bulk Insert:bronze.erp_px_cat_g1v2
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	copy bronze.erp_px_cat_g1v2 (
	    id,
	    cat,
	    subcat,
	    maintenance)
	FROM 'C:\SQL\px_cat_g1v2.csv'
	DELIMITER ','
	CSV HEADER;

END;
$$;

-- Run the procedure
CALL bronze.load_bronze();



