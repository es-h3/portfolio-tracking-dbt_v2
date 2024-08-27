{% macro to_21_century_date(colname)%}
  CASE
    WHEN {{colname}} >'0100-01-01'::date
     THEN {{colname}}
    ELSE DATEADD(year,2000,{{colname}})
  END

  {% endmacro %} 
