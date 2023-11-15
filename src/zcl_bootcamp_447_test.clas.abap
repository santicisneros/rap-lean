CLASS zcl_bootcamp_447_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOOTCAMP_447_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

***********************************************************************
** Ejemplos PPT Declarations
************************************************************************
*    CONSTANTS: lc_ciudad TYPE c LENGTH 7 VALUE 'Rosario'.
*
*    DATA: lwa_factura TYPE zfactura_506,
*          lt_factura  TYPE TABLE OF zfactura_506.
***********************************************************************
** Example 1: SELECT SINGLE
***********************************************************************

*    SELECT SINGLE
*    FROM zfactura_506
*    fields cliente, ciudad, importe, moneda, creado_fecha
*    where id = '00000003'
*    into corresponding fields of @lwa_factura.
*    
*    if sy-subrc = 0. "Data returned
*    out->write( lwa_factura ).
*  ELSE.
*    out->write( |No data found!| ).
*  ENDIF.

**********************************************************************
* Example 2: SELECT
**********************************************************************
*    SELECT *
*      FROM zfactura_506
*      WHERE ciudad = @lc_ciudad
*      INTO TABLE @lt_factura.
*
*    if sy-subrc = 0. "Data returned
*    out->write( lt_factura ).
*  ELSE.
*    out->write( |No data found!| ).
*  ENDIF.

*    CONSTANTS my_const1 TYPE string VALUE 'Hello world'.
*    out->write( my_const1 ).

**********************************************************************
* Operador CORRESPONDING  ANTES
**********************************************************************
*    TYPES: BEGIN OF ty_demo1,
*             col1 TYPE char5,
*             col2 TYPE char5,
*           END OF ty_demo1,
*
*           BEGIN OF ty_demo2,
*             col0 TYPE char5,
*             col1 TYPE char5,
*             col2 TYPE char5,
*           END OF ty_demo2.
*
*    DATA: i_tab1 TYPE TABLE OF ty_demo1,
*          i_tab2 TYPE TABLE OF ty_demo2,
*          r_tab1 TYPE ty_demo1,
*          r_tab2 TYPE ty_demo2.
*
*
*    i_tab1 = VALUE #( ( col1 = 'DATO1' col2 = 'dato2' )
*                      ( col1 = 'DATO3' col2 = 'dato4' )
*                      ( col1 = 'DATO5' col2 = 'dato6' ) ).
*
**    LOOP AT i_tab1 INTO r_tab1.
**    MOVE-CORRESPONDING r_tab1 TO r_tab2.
**    APPEND r_tab2 TO i_tab2.
**    CLEAR: r_tab2, r_tab1.
**    ENDLOOP.
*
***********************************************************************
** Operador CORRESPONDING  ABAP 7.4
***********************************************************************
*
*    i_tab2 = CORRESPONDING #( i_tab1 ).
*    IF sy-subrc = 0. "Data returned
*      out->write( i_tab1 ).
*      out->write( cl_abap_char_utilities=>newline ).
*      out->write( i_tab2 ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.
*
***********************************************************************
** CASE OPERATOR
***********************************************************************
*    TYPES: BEGIN OF lty_flight,
*             carrier_id    TYPE /dmo/carrier_id,
*             connection_id TYPE /dmo/connection_id,
*             flight_date   TYPE /dmo/flight_date,
*             price         TYPE /dmo/flight_price,
*             currency_code TYPE /dmo/currency_code,
*             month_name    TYPE string,
*           END OF lty_flight.
*
*    DATA: lt_flights          TYPE TABLE OF lty_flight,
*          lv_selected_carrier TYPE /dmo/carrier_id VALUE 'SQ',
*          lv_month            TYPE i,
*          lv_month_name       TYPE string.
*
*    CLEAR lt_flights.
*
*    SELECT
*        FROM /dmo/flight
*        FIELDS carrier_id, connection_id, flight_date, price, currency_code
*        WHERE carrier_id = @lv_selected_carrier
*        INTO TABLE @lt_flights.
*
*    IF lt_flights IS NOT INITIAL.
*      LOOP AT lt_flights INTO DATA(ls_flight).
*        lv_month = ls_flight-flight_date+4(2).
*
*        CASE lv_month.
*          WHEN 1.
*            lv_month_name = 'Enero'.
*          WHEN 2.
*            lv_month_name = 'Febrero'.
*          WHEN 3.
*            lv_month_name = 'Marzo'.
*          WHEN 4.
*            lv_month_name = 'Abril'.
*          WHEN 5.
*            lv_month_name = 'Mayo'.
*          WHEN 6.
*            lv_month_name = 'Junio'.
*          WHEN 7.
*            lv_month_name = 'Julio'.
*          WHEN 8.
*            lv_month_name = 'Agosto'.
*          WHEN 9.
*            lv_month_name = 'Septiembre'.
*          WHEN 10.
*            lv_month_name = 'Octubre'.
*          WHEN 11.
*            lv_month_name = 'Noviembre'.
*          WHEN 12.
*            lv_month_name = 'Diciembre'.
*          WHEN OTHERS.
*            lv_month_name = 'Mes incorrecto'.
*        ENDCASE.
*
*        ls_flight-month_name = lv_month_name." Agregar el nombre del mes a la nueva columna
*
*        MODIFY lt_flights
*        FROM ls_flight
*        TRANSPORTING month_name
*        WHERE carrier_id = ls_flight-carrier_id AND
*        connection_id = ls_flight-connection_id AND flight_date = ls_flight-flight_date.
*      ENDLOOP.
*
*    SORT lt_flights BY month_name.
*
*      out->write( lt_flights ). " Imprimir la tabla filtrada con el nombre del mes
*    ELSE.
*      out->write( 'No se encontraron vuelos para el carrier especificado.' ).
*    ENDIF.



*      IF sy-subrc = 0.
*        out->write( |****************************| ).
*        out->write( |   { lv_month_name } | ).
*      ELSE.
*        out->write( |No se encontro el mes!| ).
*      ENDIF.

***********************************************************************
** CARGAR TABLA POR FUERA DEL ELEMENTO
***********************************************************************

******************************************************************
    " CREATE
*    DATA:
*      lt_selection TYPE TABLE FOR READ IMPORT zi_sohnew_447,
*      lt_creation  TYPE TABLE FOR CREATE zi_sohnew_447,
*      lt_update    TYPE TABLE FOR UPDATE zi_sohnew_447.
*
*    READ ENTITIES OF  zi_sohnew_447
*   ENTITY sohNew
*   ALL FIELDS WITH lt_selection
**    ALL FIELDS WITH VALUE #( ( Soid = '400' ) )
*   RESULT DATA(lt_result)
*   FAILED DATA(lt_failed)
*   REPORTED DATA(lt_reported).
*
*
*
*    GET TIME STAMP FIELD DATA(lv_timestampl).
*
*    lt_creation =   VALUE #( (  %cid = 'Key1'
*                                ClientId = '60'
*                                TotalPrice = '500'
*                                CurrencyCode = 'ARS'
*                                Type = 'I'
*
*                                %control-ClientId        = if_abap_behv=>mk-on
*                                %control-TotalPrice     = if_abap_behv=>mk-on
*                                %control-CurrencyCode    = if_abap_behv=>mk-on
*                                %control-Type     = if_abap_behv=>mk-on
*
*                              )
*                            ).
*
*    MODIFY ENTITIES OF zi_sohnew_447
*    ENTITY sohNew
*    CREATE FROM lt_creation
*    FAILED DATA(ls_failed)
*    MAPPED DATA(ls_mapped)
*    REPORTED DATA(ls_reported).
*
*    TRY.
*        out->write( ls_mapped-sohNew[ 1 ]-SoId ).
*        COMMIT ENTITIES.
*
*      CATCH cx_sy_itab_line_not_found.
*        out->write( ls_failed-sohNew[ 1 ]-%cid ).
*        ROLLBACK ENTITIES.
*
*    ENDTRY.

    TYPES: tt_hdr TYPE TABLE OF zasohnew447 WITH DEFAULT KEY.

*    DELETE FROM zaproj914.                              "#EC CI_NOWHERE
*    COMMIT WORK.

    GET TIME STAMP FIELD DATA(lv_timestampl).
*    DATA(lv_uuid) = cl_system_uuid=>create_uuid_x16_static( ).

    TRY.
        DATA(lt_hdr) = VALUE tt_hdr( ( client = sy-mandt


                                    so_id                  = cl_system_uuid=>create_uuid_x16_static( )

                                    created_by          = cl_abap_context_info=>get_user_technical_name( )
                                    created_at          = lv_timestampl
                                    last_changed_by      = cl_abap_context_info=>get_user_technical_name( )
                                    last_changed_at     =  lv_timestampl
            )
*        ( client = sy-mandt
*
*
*                                id                  = cl_system_uuid=>create_uuid_x16_static( )
*                                created_by          = cl_abap_context_info=>get_user_technical_name( )
*                                created_at          = lv_timestampl
*                                last_change_by      = cl_abap_context_info=>get_user_technical_name( )
*                                last_changed_at     =  lv_timestampl
*        )
            ).
      CATCH cx_uuid_error.
        out->write( 'There was an error' ).
        ROLLBACK ENTITIES.
    ENDTRY.
    MODIFY zasohnew447 FROM TABLE @lt_hdr.
    IF sy-subrc IS INITIAL.
      COMMIT WORK.
      out->write( 'se cargo correctamente' ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
