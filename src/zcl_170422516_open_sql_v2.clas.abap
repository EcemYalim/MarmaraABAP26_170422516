CLASS zcl_170422516_open_sql_v2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422516_open_sql_v2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

DATA:
      lt_emp    TYPE TABLE OF z170422516_t_emp,
      lt_insert TYPE TABLE OF z170422516_t_emp.

    DELETE FROM z170422516_t_emp.


    lt_insert = VALUE #(
      ( emp_id = '0000000001' name = 'Ali'   currency = 'TRY' unit = 'PC' amount = '1000.01' quantity = 10 )
      ( emp_id = '0000000002' name = 'Veli'  currency = 'TRY' unit = 'PC' amount = '2000.45' quantity = 20 )
      ( emp_id = '0000000003' name = 'Ayse'  currency = 'USD' unit = 'KG' amount = '5000.55' quantity = 5 )
      ( emp_id = '0000000004' name = 'John'  currency = 'EUR' unit = 'KG' amount = '7000.00' quantity = 7 )
      ( emp_id = '0000000005' name = 'Ahmet' currency = 'TRY' unit = 'PC' amount = '3000.99' quantity = 15 )
    ).

    INSERT z170422516_t_emp FROM TABLE @lt_insert.
    out->write( 'DATA INSERTED' ).


    SELECT emp_id,
           abs( amount )            AS abs_val,
           ceil( amount )           AS ceil_val,
           floor( amount )          AS floor_val,
           round( amount, 0 )       AS round_val,
           round( amount, 1 )       AS round_val2,
           round( amount, 2 )       AS round_val3
      FROM z170422516_t_emp
      INTO TABLE @DATA(lt_num).


    SELECT emp_id,
           concat( name, '_EMP' )         AS c1,
           substring( name, 1, 2 )        AS sub,
           length( name )                 AS len,
           upper( name )                  AS upper,
           lower( name )                  AS lower,
           lpad( name, 10, '*' )          AS lpad,
           rpad( name, 10, '*' )          AS rpad,
           replace( name, 'A', 'X' )      AS repl
      FROM z170422516_t_emp
      INTO TABLE @DATA(lt_str).


    SELECT emp_id,
           CASE
             WHEN amount > 6000 THEN 'VERY HIGH'
             WHEN amount BETWEEN 3000 AND 6000 THEN 'HIGH'
             WHEN amount BETWEEN 1000 AND 3000 THEN 'MEDIUM'
             ELSE 'LOW'
           END AS category
      FROM z170422516_t_emp
      INTO TABLE @DATA(lt_case).

    SELECT currency,
           COUNT( * )     AS cnt,
           SUM( amount )  AS total,
           MAX( amount )  AS max,
           MIN( amount )  AS min,
           AVG( amount )  AS avg
      FROM z170422516_t_emp
      GROUP BY currency
      HAVING COUNT(*) > 0
      INTO TABLE @DATA(lt_agg).


    SELECT emp_id FROM z170422516_t_emp
    UNION ALL
    SELECT emp_id FROM z170422516_t_emp
    INTO TABLE @DATA(lt_union).


    SELECT *
      FROM z170422516_t_emp
      ORDER BY amount DESCENDING
      INTO TABLE @DATA(lt_page)
      UP TO 3 ROWS OFFSET 1.


    DATA(lv_where) = `amount > 2000`.

    SELECT *
      FROM z170422516_t_emp
      WHERE (lv_where)
            INTO TABLE @DATA(lt_dyn).


    SELECT emp_id,
           amount,
           quantity,
           ( amount * quantity ) AS total_stock_value
      FROM z170422516_t_emp
      INTO TABLE @DATA(lt_calc).


    SELECT emp_id,
           concat_with_space( 'ID:', emp_id, 1 ) AS id_label
      FROM z170422516_t_emp
      INTO TABLE @DATA(lt_concat_space).

    SELECT DISTINCT currency
      FROM z170422516_t_emp
      INTO TABLE @DATA(lt_distinct).


    SELECT *
      FROM z170422516_t_emp
      WHERE amount BETWEEN 2000 AND 5000
      INTO TABLE @DATA(lt_between).


    SELECT *
      FROM z170422516_t_emp
      WHERE name LIKE 'A%'
      INTO TABLE @DATA(lt_like).


    SELECT *
      FROM z170422516_t_emp
      WHERE currency IN ( 'TRY', 'USD' )
      INTO TABLE @DATA(lt_in).



    out->write( 'SQL Queries Executed.' ).



  ENDMETHOD.
ENDCLASS.
