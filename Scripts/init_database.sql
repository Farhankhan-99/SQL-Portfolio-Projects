-- ============================================
-- Script: Setup for Data Warehouse Project
-- Purpose: Create database and schemas for ETL pipeline
-- Author: Farhan Khan
-- Date: 2025-07-29

-- ⚠️ WARNING: This will DROP the existing database if it exists!
--      ➤ Make sure you are NOT connected to `data_warehouse`
--      ➤ This script must be run from a higher-level database like `postgres`
-- ============================================

-- Step 1: Drop the database if it exists
DROP DATABASE IF EXISTS data_warehouse;

-- Step 2: Create a fresh database
CREATE DATABASE data_warehouse;

-- 🚨 STOP HERE and connect to the new `data_warehouse` DB before running the next part

-- Step 3: After connecting to `data_warehouse`, run the following:

-- Create schema layers
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
