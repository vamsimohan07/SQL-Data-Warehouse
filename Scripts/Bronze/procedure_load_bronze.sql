/*
==========================================================================================
Stored Procedure: Load Bronze (Source -> Bronze)
==========================================================================================
Script Purpose:
This stored procedure loads data into the 'Bronze' schema from external files.
It performs the following action:
- truncztes the bronze tables before loading data.
- uses 'BULK INSERT' command to load data from CSv Files to Bronze tables.

Parameters:
none
Usage Example:
    EXEC Bronze.load_bronze;
==========================================================================================
*/
CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME;
  BEGIN TRY
      print'==============================================================================';
      print'LODING BRONZE LAYER';
      print'==============================================================================';

      print'------------------------------------------------------------------------------';
      print'Loding CRM Tables';
      print'------------------------------------------------------------------------------';
      
      SET @batch_start_time = GETDATE();
      SET @start_time = GETDATE(); 
      print'>> Truncating Table: Bronze.crm_cust_info';
      TRUNCATE TABLE Bronze.crm_cust_info;
      print'>> Inserting Data into Table: Bronze.crm_cust_info';
      BULK INSERT Bronze.crm_cust_info
      FROM 'C:\PROJECTS SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
      WITH(
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
      );
      SET @end_time = GETDATE(); 
      print'>>load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
      print'---------------------------';

      SET @start_time = GETDATE(); 
      print'>> Truncating Table: Bronze.crm_prd_info';
      TRUNCATE TABLE Bronze.crm_prd_info;
      print'>> Inserting Data into Table:Bronze.crm_prd_info';
      BULK INSERT Bronze.crm_prd_info
      FROM 'C:\PROJECTS SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
      WITH(
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
      );
      SET @end_time = GETDATE(); 
      print'>>load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
      print'---------------------------';

      SET @start_time = GETDATE(); 
      print'>> Truncating Table: Bronze.crm_sales_details';
      TRUNCATE TABLE Bronze.crm_sales_details;
      print'>> Inserting Data into Table: Bronze.crm_sales_details';
      BULK INSERT Bronze.crm_sales_details
      FROM 'C:\PROJECTS SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
      WITH(
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
      );
      SET @end_time = GETDATE(); 
      print'>>load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
      print'---------------------------';


      print'------------------------------------------------------------------------------';
      print'Loding ERP Tables';
      print'------------------------------------------------------------------------------';

      SET @start_time = GETDATE(); 
      print'>> Truncating Table: Bronze.erp_cust_az12';
      TRUNCATE TABLE Bronze.erp_cust_az12;
      print'>> Inserting Data into Table: Bronze.erp_cust_az12';
      BULK INSERT Bronze.erp_cust_az12
      FROM 'C:\PROJECTS SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
      WITH(
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
      );
      SET @end_time = GETDATE(); 
      print'>>load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
      print'---------------------------';


      SET @start_time = GETDATE(); 
      print'>> Truncating Table: Bronze.erp_loc_a101';
      TRUNCATE TABLE Bronze.erp_loc_a101;
      print'>> Inserting Data into Table: Bronze.erp_loc_a101';
      BULK INSERT Bronze.erp_loc_a101
      FROM 'C:\PROJECTS SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
      WITH(
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
      );
      SET @end_time = GETDATE(); 
      print'>>load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 'SECONDS';
      print'---------------------------';


      SET @start_time = GETDATE(); 
      print'>> Truncating Table: Bronze.erp_px_cat_g1v2';
      TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
      print'>> Inserting Data into Table: Bronze.erp_px_cat_g1v2';
      BULK INSERT Bronze.erp_px_cat_g1v2
      FROM 'C:\PROJECTS SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
      WITH(
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
      );
      SET @end_time = GETDATE(); 
      print'>>load duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
      print'---------------------------';

      SET @batch_end_time = GETDATE(); 
      print'===========================';
      print'LOADING BRONZE LAYER IS COMPLETED';
      print'>>--TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
      print'============================';



    END TRY
    BEGIN CATCH
    print'==============================================================================';
    print'ERROR OCCURED DURING LOADING BRONZE LAYER';
    print'ERROR MESSAGE' + ERROR_MESSAGE();
    print'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
    print'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
    print'==============================================================================';
    END CATCH
END
