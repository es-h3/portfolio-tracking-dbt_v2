{{config(materialized='ephemeral')}}

with 
 src_data as (
    SELECT 
     AlphabeticCode AS ALPHABETIC_CODE 
     ,NumericCode as NUMERIC_CODE
     ,DecimalDigits AS DECIMAL_DIGITS
     ,CurrencyName AS CURRENCY_NAME
     ,Locations AS LOCATIONS
     ,LOAD_TS AS LOAD_TS
     ,'SEED.ABC_BANK_CURRENCY_INFO' as RECORD_SOURCE
     FROM {{source("seeds","ABC_BANK_CURRENCY_INFO")}}
 ),
 hashed as (
    SELECT 
        {{dbt_utils.surrogate_key(["ALPHABETIC_CODE"]) }} as CURRENCY_HKEY
       ,{{dbt_utils.surrogate_key(["ALPHABETIC_CODE","NUMERIC_CODE"])}} AS CURRENCY_HDIFF
       ,* EXCLUDE LOAD_TS
       ,LOAD_TS as LOAD_TS_UTC
    FROM src_data
 )
 SELECT * FROM hashed

 