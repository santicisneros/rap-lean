CLASS zcl_bootcamp_447_flight DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOOTCAMP_447_FLIGHT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
**********************************************************************
* CONSULTAS SELECT Y ARMADO DE TABLAS LOCALES
**********************************************************************

**Definir estructuras. Dejando espacio para agregar columnas en caso de ser necesario


    TYPES: BEGIN OF lty_travel,
             travel_id     TYPE /dmo/travel-travel_id,
             agency_id     TYPE /dmo/travel-agency_id,
             customer_id   TYPE /dmo/travel-customer_id,
             total_price   TYPE /dmo/travel-total_price,
             currency_code TYPE /dmo/travel-currency_code,
             status        TYPE /dmo/travel-status,
           END OF lty_travel.

    TYPES: BEGIN OF lty_customer,
             customer_id TYPE /dmo/customer_id,
             first_name  TYPE /dmo/first_name,
             last_name   TYPE /dmo/last_name,
           END OF lty_customer.

    TYPES: BEGIN OF lty_booking,
             travel_id  TYPE /dmo/travel_id,
             booking_id TYPE /dmo/booking_id,
           END OF lty_booking.


    DATA: lt_customer           TYPE TABLE OF lty_customer,
          lt_booking            TYPE TABLE OF lty_booking,
          lt_travel             TYPE TABLE OF lty_travel,
          lv_selected_status    TYPE /dmo/travel-status VALUE 'P',
          lv_selected_customer  TYPE /dmo/last_name VALUE 'Jeremias',
          lv_selected_travel_id TYPE /dmo/travel_id VALUE '00000001'.


    CLEAR lt_customer.
    CLEAR lt_booking.
    CLEAR lt_travel.
*
*    SELECT
*    FROM /dmo/customer
*    FIELDS customer_id, first_name, last_name
*    WHERE last_name = @lv_selected_customer
*    INTO TABLE @lt_customer.
*
    SELECT
    FROM /dmo/travel
    FIELDS travel_id, agency_id, customer_id,total_price, currency_code, status
    WHERE  customer_id = '000014'
    INTO TABLE @lt_travel.
*

*
*    SELECT
*    FROM /dmo/booking
*    FIELDS travel_id, booking_id
*    WHERE travel_id = @lv_selected_travel_id
*    INTO TABLE @lt_booking.
*
    IF sy-subrc = 0.
      out->write( |******************************| ).
      out->write( |Consulta de datos Tabla Travel| ).
      out->write( |******************************| ).
      out->write( lt_travel ).
      out->write( cl_abap_char_utilities=>newline ).
**      out->write( |****************************| ).
**      out->write( lt_customer ).
**      out->write( cl_abap_char_utilities=>newline ).
**      out->write( |****************************| ).
**      out->write( lt_booking ).
*
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

**********************************************************************
* AGREGAR OCUPACION DEL AVION EN NUEVA COLUMNA
**********************************************************************
*    LOOP AT lt_flights INTO DATA(ls_flight).
*      ls_flight-seats_left = ls_flight-seats_max - ls_flight-seats_occupied.
*      MODIFY lt_flights
*      FROM ls_flight TRANSPORTING seats_left
*      WHERE carrier_id = ls_flight-carrier_id
*      AND connection_id = ls_flight-connection_id
*      AND flight_date = ls_flight-flight_date.
*
*    ENDLOOP.
*
*    IF sy-subrc = 0.
*      out->write( cl_abap_char_utilities=>newline ).
*      out->write( |****************************| ).
*      out->write( |Tabla con asientos libres| ).
*      out->write( |****************************| ).
*      out->write( lt_flights ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.

****************************************************************************
* JOIN CON LA TABLA /DMO/CUSTOMER Y OBTENER LOS CAMPOS LUEGO DEL CUSTOMER_ID
****************************************************************************


    SELECT
    FROM /dmo/travel AS a
    INNER JOIN /dmo/customer AS b
    ON  a~customer_id = b~customer_id
    FIELDS
    a~travel_id,
    a~agency_id,
    a~customer_id,
    b~first_name,
    b~last_name,
    b~city,
    b~country_code,
    a~total_price,
    a~currency_code,
    a~status
    WHERE a~customer_id = '000014'
    INTO TABLE @DATA(lt_innerjoin_travel_customer).

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |*******************************************| ).
      out->write( |Ejemplo Inner Join Tablas Travel - Customer| ).
      out->write( |*******************************************| ).
      out->write( lt_innerjoin_travel_customer ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

************************************************************************************
* JOIN DE LO ULTIMO REALIZADO CON LA TABLE /DMO/TRVL_STAT_T Y OBTENER EL CAMPO TEXT DE STATUS
************************************************************************************


    SELECT
    FROM /dmo/travel AS a
    INNER JOIN /dmo/customer AS b
    ON  a~customer_id = b~customer_id
    INNER JOIN /dmo/trvl_stat_t AS c
    ON  a~status = c~travel_status
    FIELDS
    a~travel_id,
    a~agency_id,
    a~customer_id,
    b~first_name,
    b~last_name,
    b~city,
    b~country_code,
    a~total_price,
    a~currency_code,
    a~status,
    c~text
    WHERE a~customer_id = '000014'
    INTO TABLE @DATA(lt_innerjoin_trav_cust_stat).

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |****************************************************| ).
      out->write( |Ejemplo Inner Join Tablas Travel - Customer - Status| ).
      out->write( |****************************************************| ).
      out->write( lt_innerjoin_trav_cust_stat ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

**********************************************************************************
* REALIZAR LA CONSULTA A TABLA /DMO/FLIGHT / OBTENER CAMPOS SEGUN CARRIED_ID = AA
**********************************************************************************

    TYPES: BEGIN OF lty_flight,
             carrier_id    TYPE /dmo/carrier_id,
             connection_id TYPE /dmo/connection_id,
             flight_date   TYPE /dmo/flight_date,
             price         TYPE /dmo/flight_price,
             currency_code TYPE /dmo/currency_code,
           END OF lty_flight.

    DATA: lt_flights          TYPE TABLE OF lty_flight,
          lv_selected_carrier TYPE /dmo/carrier_id VALUE 'AA'.

    CLEAR lt_flights.

    SELECT
    FROM /dmo/flight
    FIELDS carrier_id, connection_id, flight_date, price, currency_code
    WHERE carrier_id = @lv_selected_carrier
    INTO TABLE @lt_flights.

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |****************************************************| ).
      out->write( |Ejemplo Tabla flights| ).
      out->write( |****************************************************| ).
      out->write( lt_flights ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.


********************************************************************************
* JOIN CON LA TABLA /DMO/CONNECTION Y OBTENER LOS CAMPOS LUEGO DEL CONNECTION_ID
********************************************************************************

    SELECT
    FROM /dmo/flight AS a
    INNER JOIN /dmo/connection AS b
    ON  a~connection_id = b~connection_id AND
    a~carrier_id = b~carrier_id
    FIELDS
    a~carrier_id,
    a~connection_id,
    a~flight_date,
    a~price,
    a~currency_code,
    b~airport_from_id,
    b~airport_to_id
    WHERE a~carrier_id = @lv_selected_carrier
    INTO TABLE @DATA(lt_innerjoin_flight_connect).

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |*******************************************| ).
      out->write( |Ejemplo Inner Join Tablas Flight - Connect| ).
      out->write( |*******************************************| ).
      out->write( lt_innerjoin_flight_connect ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

*******************************************************************************************
* JOIN DE LO ULTIMO REALIZADO CON LA TABLE /DMO/AIRPORT Y OBTENER CAMPOS DE ORIGEN Y DESTINO
*******************************************************************************************

    SELECT
    FROM /dmo/flight AS a
    INNER JOIN /dmo/connection AS b
    ON  a~carrier_id = b~carrier_id  AND
    a~connection_id = b~connection_id
    INNER JOIN /dmo/airport AS c
    ON  c~airport_id = b~airport_from_id
    INNER JOIN /dmo/airport AS d
    ON  d~airport_id = b~airport_to_id
    FIELDS
    a~carrier_id,
    a~connection_id,
    a~flight_date,
    a~price,
    a~currency_code,
    b~airport_from_id,
    c~name,
    c~city,
    c~country,
    b~airport_to_id,
    d~name AS airport_to,
    d~city AS city_to,
    d~country AS country_to
    WHERE a~carrier_id = @lv_selected_carrier
    INTO TABLE @DATA(lt_injoin_flg_conect_airt).

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |*******************************************************| ).
      out->write( |Ejemplo Inner Join Tablas Flight - connection - airport| ).
      out->write( |*******************************************************| ).
      out->write( lt_injoin_flg_conect_airt ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
