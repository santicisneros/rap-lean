CLASS zcl_bootcamp_447 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOOTCAMP_447 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*********************************************************************************************
* Declarations --- CONSULTA PARA INGRESAR DATOS EN TABLA Y BORRA SI HAY ALGO Y CARGA LO NUEVO
********************************************************************************************

*    out->write( 'Hello World' )
*    DATA: lt_clientes TYPE TABLE OF ztcliente447.
*
*    "fill internal table
*    lt_clientes = VALUE #(
*    ( client ='100' id_cliente = '100001' nombre = 'YPF' ciudad = 'CABA' provincia = 'Buenos Aires' pais = 'ARG' creado_por ='10854726' creado_fecha = '20230901' )
*    ( client ='100' id_cliente = '100002' nombre = 'SHELL' ciudad = 'Sante Fe' provincia = 'Santa Fe' pais = 'ARG' creado_por ='10854369' creado_fecha = '20230801' )
*    ( client ='100' id_cliente = '100003' nombre = 'AXION' ciudad = 'San Francisco' provincia = 'Córdoba' pais = 'ARG' creado_por ='10845447' creado_fecha = '20230701' )
*    ).
*
*    "Delete possible entries
*    DELETE FROM ztcliente447.
*
*    "Insert new entries
*    INSERT ztcliente447 FROM TABLE @lt_clientes.
*
*
*
*    "Check result in console
*    out->write( sy-dbcnt ).
*    out->write( 'DONE!' ).

*    DATA: i_ztcliente447 TYPE TABLE OF ztcliente447.

***********************************************************************
* Declarations --- CONSULTA A BASE DE DATOS SIMPLE
***********************************************************************
*    CONSTANTS lc_airport_fra TYPE c LENGTH 3 VALUE 'FRI'.
*
*    DATA      lwa_airport    TYPE /dmo/airport.
*
*    SELECT SINGLE
*      FROM /dmo/airport
*      FIELDS airport_id, name, country
*      WHERE airport_id = @lc_airport_fra
*      INTO @lwa_airport.
*
*    IF sy-subrc = 0. "Data returned
*      out->write( lwa_airport ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.

*****************************************************************
* CONSULTA PARA TRAER TODOS LOS PAISES CON COUNTRY 'DE'
*****************************************************************

*  DATA:      lwa_airport    TYPE /dmo/airport,
*               lt_airport     TYPE STANDARD TABLE OF /dmo/airport.
*
*
*    SELECT *
*      FROM /dmo/airport
**      FIELDS airport_id, name, country
*      WHERE country = 'DE'
*      INTO TABLE @lt_airport.
*
*    IF sy-subrc = 0. "Data returned
*      out->write( lt_airport ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.

***********************************************************
*
*    SELECT * FROM ztcliente447 INTO TABLE @DATA(lt_ztcliente447).
*    out->write( lt_ztcliente447 ).
*
*************************************************************
*
*    SELECT SINGLE nombre FROM ztcliente447 WHERE id_cliente = '100003' INTO @DATA(l_nombre).
*
*    out->write( |DONE! Nombre: { l_nombre }| ).
*
*    DATA: lv_id_cliente    TYPE string,
*          lwa_ztcliente447 TYPE ztcliente447.
*
***************************************************************
*
*    " SELECT SINGLE con una condición específica y usando una variable para comparar
*    lv_id_cliente = '100002'.
*    SELECT SINGLE * FROM ztcliente447 WHERE id_cliente = @lv_id_cliente INTO @lwa_ztcliente447.
*
*    IF sy-subrc = 0.
*      out->write( lwa_ztcliente447 ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.
***********************************************************
*    " SELECT con condición
*    DATA: lt1_ztcliente447 TYPE TABLE OF ztcliente447,
*          ls_ztcliente447  TYPE ztcliente447.
*
*    SELECT * FROM ztcliente447 WHERE ciudad = 'CABA' INTO TABLE @lt1_ztcliente447.
*    IF sy-subrc = 0.
*      out->write( lt1_ztcliente447 ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.
*
****************************************************
*    " Actualizar el nombre en la base de datos
*    DATA: lv_new_name    TYPE string,
*          lv1_id_cliente TYPE string.
*
*    lv_new_name = 'Leandro'.
*    lv1_id_cliente = '100001'.
*
*    UPDATE ztcliente447 SET nombre = @lv_new_name WHERE id_cliente = @lv1_id_cliente.

*************************************************************

*    DATA: lt2_result    TYPE STANDARD TABLE OF ztcliente447,
*          lv2_id_cliente TYPE string,
*          lv2_nombre     TYPE string.
*
*    lv2_id_cliente = '100003'.
*
*    " Realizar una consulta SELECT con FIELDS
*      SELECT *
*      FROM ztcliente447
*      FIELDS id_cliente nombre
*      WHERE id_cliente = @lv2_id_cliente
*      INTO TABLE @lt2_result.
*
*      out->write( |ID Cliente: { lv2_id_cliente }, Nombre: { lv2_nombre }| ).


***********************************************************************
*Ejemplo 3 - Se obtiene una tabla interna
**************************************************
    TYPES: BEGIN OF lty_cliente,
             id_cliente TYPE zdeclienteid_447,
             nombre     TYPE zdenombre_447,
             cuidad     TYPE ztcliente447-ciudad,
             provincia  TYPE ztcliente447-provincia,
             pais       TYPE land1,
           END OF lty_cliente.

    DATA      lt_clientes TYPE TABLE OF lty_cliente. "tabla interna,no se modifica tabla transparente

    CONSTANTS lc_pais_arg TYPE c LENGTH 3 VALUE 'ARG'.

    CLEAR lt_clientes.

    SELECT
        FROM ztcliente447
        FIELDS id_cliente, nombre, ciudad, provincia, pais
        WHERE pais = @lc_pais_arg
        INTO TABLE @lt_clientes.

    IF sy-subrc = 0.
      out->write( |************** Ejemplo 3 **************| ).
      out->write( lt_clientes ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

*********************************************************************
** FIELD-SYMBOLS vs Work Area
*************************************************************************
*
*    DATA(lt_clientes_fs) = lt_clientes. "fields symbol
*    DATA(lt_clientes_wa) = lt_clientes. "work area
*
**    DATA lv_tabix TYPE i. "para ver sy-tabix
**    LOOP AT lt_clientes_fs ASSIGNING FIELD-SYMBOL(<lfs_cliente>).
**      lv_tabix = sy-tabix.
**      out->write( lv_tabix ).
***      <lfs_cliente>-ciudad = 'Posadas'.
**    ENDLOOP.
*
*    LOOP AT lt_clientes_fs ASSIGNING FIELD-SYMBOL(<lfs_cliente>).
**    UNASSIGN lfs_cliente "rompe o da error hacer esto / la asignacion le libera el asignado (recordar que marca/indica espacio en memoria)
*      <lfs_cliente>-provincia = 'Misiones'.
*    ENDLOOP.
*
*    out->write( |************** Usando Field-Symbols **************| ).
*    out->write( lt_clientes_fs ).
*
*    LOOP AT lt_clientes_wa INTO DATA(lwa_cliente).
*      out->write( sy-index ). "VER BIEN LA IMPRESION DE TABIX E INDEX
*      out->write( sy-tabix ).
*      lwa_cliente-provincia = 'Misiones'.
*      MODIFY lt_clientes_wa FROM lwa_cliente. "sino agrego el modify no funciona el cambio en la wa
*    ENDLOOP.
*
*
*
*
*    out->write( |************** Usando una Work Area **************| ).
*    out->write( lt_clientes_wa ).


***********************************************************************
*otro ej cambiando el CONSTANTS lc_pais_arg TYPE c LENGTH 3 VALUE 'USA'.
***********************************************************************

*    DATA(lt1_clientes_fs) = lt_clientes. "fields symbol
*    DATA(lt1_clientes_wa) = lt_clientes. "work area
*
*    LOOP AT lt1_clientes_fs ASSIGNING FIELD-SYMBOL(<lfs1_cliente>).
*      <lfs1_cliente>-provincia = 'California'. "Cambiar la provincia de los clientes en USA
*    ENDLOOP.
*
*    out->write( |************** Usando Field-Symbols - Cambio de Provincia a California **************| ).
*    out->write( lt_clientes_fs ).
*
*    LOOP AT lt1_clientes_wa INTO DATA(lwa1_cliente).
*      lwa_cliente-provincia = 'Texas'. "Cambiar la provincia de los clientes en USA
*      MODIFY lt_clientes_wa FROM lwa_cliente TRANSPORTING provincia WHERE nombre = lwa_cliente-nombre. "Actualizar la tabla interna
*    ENDLOOP.
*
*    out->write( |************** Usando una Work Area - Cambio de Provincia a Texas y Actualización **************| ).
*    out->write( lt_clientes_wa ).

****************************************************************************************
* EJEMPLOS READ O VALUE # CON TABLA INTERNA
********************************************************************************
*
*    DATA lv_nombre TYPE zdenombre_447.
*    lv_nombre = 'AXION'.
*    DATA lv_idcliente TYPE zdeclienteid_447 VALUE '100002'.
*
*    DATA r_cliente TYPE lty_cliente. "consulta para traer en base a nombre con todo los datos de la tabla interne lt_clientes
*    r_cliente = VALUE #( lt_clientes[ nombre = lv_nombre ] DEFAULT space ).
*
*    DATA lv_ciudad TYPE zdeciudad_447. " consulta de ciudad
*    lv_ciudad = VALUE #( lt_clientes[ id_cliente = lv_idcliente ]-cuidad DEFAULT space ).
*
*    IF sy-subrc = 0.
*      out->write( cl_abap_char_utilities=>newline ).
*      out->write( |************** Ejemplo VALUE # CON TABLA INTERNA **************| ).
*      out->write( r_cliente ).
*      out->write( cl_abap_char_utilities=>newline ).
*      out->write( lv_ciudad ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.


***********************************************************************
** READ TABLE vs VALUE #
***********************************************************************

*    SELECT *
*      FROM ztcliente506
*      INTO TABLE @DATA(lt_clientes).
*
*    IF sy-subrc EQ 0.
*
*      out->write( |************** Usando Read Table **************| ).
*      out->write( lt_clientes ).
*      out->write( cl_abap_char_utilities=>newline ).
*
***------------------------------------------------------------------------
*** Ejemplo 1 - Uso de Read Table
***------------------------------------------------------------------------
    READ TABLE lt_clientes ASSIGNING FIELD-SYMBOL(<lfs_cliente_r>)
         WITH KEY id_cliente = '100002'.

*    IF sy-subrc = 0.
*      <lfs_cliente_r>-ciudad = 'La Plata'.
*    ENDIF.

    out->write( |************** Usando Read Table **************| ).
    out->write( lt_clientes ).
*
***------------------------------------------------------------------------
*** Ejemplo 2 - Uso de VALUE #
***------------------------------------------------------------------------
**      DATA(lv_cliente_nombre) = VALUE #( lt_clientes[ id_cliente = '100003' ]-nombre DEFAULT space ).
**
*   ENDIF.

*****************************************************************
* CONSULTA PROCESAMIENTO DE DATOS DE STRINGS
*****************************************************************

    DATA: lv_full_name  TYPE string VALUE 'Leandro Fiore',
          lv_first_name TYPE string,
          lv_last_name  TYPE string.

    SPLIT lv_full_name AT ' ' INTO lv_first_name lv_last_name.

    out->write( |************** Separando strings **************| ).
    out->write( |User: { lv_first_Name } | ).

*****************************************************************
* CONSULTA DATOS DE CONECCTION CON SELECT SINGLE
*****************************************************************

*    DATA lv_airport_from_id TYPE /dmo/connection-airport_from_id.
*    DATA lv_airport_to_id   TYPE /dmo/connection-airport_from_id.
*
*    SELECT SINGLE
*                    FROM /dmo/connection
*                    FIELDS airport_from_id, airport_to_id
*                     WHERE carrier_id = 'LH'
*                     AND   connection_id = '0400'
*                     INTO (@lv_airport_from_id, @lv_airport_to_id).
*
*    out->write( lv_airport_from_id ).
*    out->write( lv_airport_to_id ).
*
*    DATA var1         TYPE c LENGTH 15 VALUE 'DELIVERY ACC.'.
*    DATA var2         TYPE c LENGTH 15 VALUE 'HOLA'.
*    DATA new_variable TYPE string.
*    MOVE-CORRESPONDING var1+9(4) TO var2+5(4).
*    new_variable = var2.
*    out->write( new_variable ).





  ENDMETHOD.
ENDCLASS.
