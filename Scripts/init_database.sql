-- ============================================
-- Script: Setup for Data Warehouse Project
-- Purpose: Create database and schemas for ETL pipeline
-- Author: Farhan Khan
-- Date: 2025-07-29

-- 🛠️ Create the database (Run this from the "Databases" level, not inside another DB)
CREATE DATABASE Data_warehouse;
-- =============================================
-- ⬇️ The following should be run inside data_warehouse database
-- =============================================
-- 🔁 Switch to the new database before running this (in pgAdmin: open new query in data_warehouse)


-- 📂 Create Bronze Layer Schema (Raw Data)
CREATE SCHEMA bronze;

-- 📂 Create Silver Layer Schema (Cleaned Data)
CREATE SCHEMA silver;

-- 📂 Create Gold Layer Schema (Aggregated/Final Data)
CREATE SCHEMA gold;
