{{config(materialized='ephemeral')}}

with 
 src_data as (
    SELECT 
     SECURITY_CODE AS SECURITY_CODE 
     ,SECURITY_NAME as SECURITY_NAME
     ,SECTOR AS SECTOR_NAME
     ,INDUSTRY AS INDUSTRY_NAME
     ,COUNTRY AS COUNTRY_CODE
     ,EXCHANGE AS EXCHANGE_CODE
     ,LOAD_TS AS LOAD_TS
     ,'SEED.ABC_BANK_SECURITY_INFO' as RECORD_SOURCE
     FROM {{source("seeds","ABC_BANK_SECURITY_INFO")}}
 ),
 hashed as (
    SELECT 
        concat_ws('|',SECURITY_CODE) as SECURITY_HKEY
       ,concat_ws('|',SECURITY_CODE,SECTOR_NAME,INDUSTRY_NAME,COUNTRY_CODE,EXCHANGE_CODE) AS SECURITY_HDIFF
       ,* EXCLUDE LOAD_TS
       ,LOAD_TS as LOAD_TS_UTC
    FROM src_data
 )
 SELECT * FROM hashed
