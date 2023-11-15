CLASS zcl_bootcamp_447_factura DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOOTCAMP_447_FACTURA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " -----------------------------------------------------------------------
    " Cargar registros en la Tabla y verificar por Data Preview.
    " En el campo ID Cliente ingresar los clientes cargados en la Tabla ZTCLIENTES447.
    " -----------------------------------------------------------------------

*   "Declaration internal table
    DATA lt_factura TYPE TABLE OF ztfactura447.

    " fill internal table
    lt_factura = VALUE #(
        client = '100'
        moneda = 'ARS'
        ( id_factura = '1000000011' id_cliente = '100001' importe_total = '1010.80'  creado_por ='10854726' creado_fecha = '20230100' )
        ( id_factura = '1000000022' id_cliente = '100002' importe_total = '5000.8020'  creado_por ='10854741' creado_fecha = '20230463' )
        ( id_factura = '1000000033' id_cliente = '100003' importe_total = '8000'  creado_por ='10854741' creado_fecha = '20230422' )
        ( id_factura = '1000000044' id_cliente = '100004' importe_total = '7500.10'  creado_por ='10854741' creado_fecha = '20230414' )
        ( id_factura = '1000000055' id_cliente = '100005' importe_total = '7500.10'  creado_por ='10854741' creado_fecha = '20230463' ) ).

    " Delete possible entries
    DELETE FROM ztfactura447.
    " Insert new entries
    INSERT ztfactura447 FROM TABLE @lt_factura.
    " Check result in console
    IF sy-subrc = 0.
      out->write( |****************************| ).
      out->write( |Cantidad de datos cargados: { sy-dbcnt }| ).
      out->write( 'Carga de datos realizada!' ).
      out->write( |****************************| ).
    ELSE.
      out->write( |No se ingreso los datos correctamente!| ).
    ENDIF.

    " -----------------------------------------------------------------------
    " Realizar una consulta y obtener todos los campos salvo el mandante.
    " -----------------------------------------------------------------------

    TYPES: BEGIN OF lty_factura,
             id_factura    TYPE ztfactura447-id_factura,
             id_cliente    TYPE ztfactura447-id_cliente,
             importe_total TYPE zdeimporte_447,
             moneda        TYPE ztfactura447-moneda,
             creado_por    TYPE ztfactura447-creado_por,
             creado_fecha  TYPE ztfactura447-creado_fecha,
           END OF lty_factura.

    DATA lt_facturas TYPE TABLE OF lty_factura.

    CLEAR lt_facturas.

    SELECT
        FROM ztfactura447
        FIELDS id_factura, id_cliente, importe_total, moneda, creado_por, creado_fecha
        INTO TABLE @lt_facturas.

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |****************************| ).
      out->write( |Consulta de datos| ).
      out->write( |****************************| ).
      out->write( lt_facturas ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

    " -----------------------------------------------------------------------
    " Realizar una consulta uniendo la tabla de Facturas y la de Clientes para mostrar el nombre del Cliente junto a todos los campos de la Tabla de Facturas.
    " -----------------------------------------------------------------------

*    TYPES: BEGIN OF lty_factura_con_nombre,
*             id_factura    TYPE ztfactura447-id_factura,
*             id_cliente    TYPE ztfactura447-id_cliente,
*             importe_total TYPE zdeimporte_447,
*             moneda        TYPE ztfactura447-moneda,
*             nombre        TYPE ztcliente447-nombre,
*           END OF lty_factura_con_nombre.
*
*    DATA lt_facturas_con_nombre TYPE TABLE OF lty_factura_con_nombre.
*
*    CLEAR lt_facturas_con_nombre.

    SELECT
    a~id_factura,
    a~id_cliente,
    a~importe_total,
    a~moneda,
    b~nombre
    FROM ztfactura447 AS a
    INNER JOIN ztcliente447 AS b
    ON b~id_cliente = a~id_cliente
    INTO TABLE @DATA(lt_facturas_con_nombre).

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |****************************| ).
      out->write( |Ejemplo Inner Join| ).
      out->write( |****************************| ).
      out->write( lt_facturas_con_nombre ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

    " ----------------------------------------------------------------------
    " Cambiar todas las monedas a USD.
    " ----------------------------------------------------------------------

    DATA lt_facturas_change_curr TYPE TABLE OF ztfactura447.

    SELECT *
    FROM ztfactura447
    INTO TABLE @lt_facturas_change_curr.

    LOOP AT lt_facturas_change_curr INTO DATA(ls_factura).
      ls_factura-moneda = 'USD'.

      MODIFY lt_facturas_change_curr FROM ls_factura.

    ENDLOOP.

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |****************************************| ).
      out->write( |Todas las monedas se han cambiado a USD.| ).
      out->write( |****************************************| ).
      out->write( lt_facturas_change_curr ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

    " -----------------------------------------------------------------------------------------------------------------------------
    " De la tabla resultado de la unión de las 2 tablas, recuperar solo el importe total del registro 3 y mostrarlo por consola.
    " -----------------------------------------------------------------------------------------------------------------------------

    DATA(lv_importe_reg3) = VALUE #( lt_facturas_con_nombre[ 3 ]-importe_total DEFAULT space ).

*    DATA(lv_importe_reg3) = VALUE #( lt_facturas_con_nombre[ id_factura = '1000000033' ]-importe_total DEFAULT space ). "otra opcion para buscar con un registro en particular

    IF sy-subrc = 0.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( |****************************************| ).
      out->write( |Importe total del registro 3: { lv_importe_reg3 }| ).
      out->write( |****************************************| ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.

    " ----------------------------------------------------------------------
    " PRUEBA PREGUNTA EXAMEN
    " ----------------------------------------------------------------------

    TYPES tt_table TYPE STANDARD TABLE OF ztfactura447 WITH NON-UNIQUE KEY id_factura id_cliente.

    DATA table  TYPE tt_table.

    DATA table1 TYPE TABLE OF tt_table.

    out->write( cl_abap_char_utilities=>newline ).
    out->write( |*****************PRUEBA PREGUNTA EXAMEN***********************| ).
    out->write( table  ).
    out->write( cl_abap_char_utilities=>newline ).
    out->write( |****************************************| ).
    out->write( table1  ).
  ENDMETHOD.
ENDCLASS.
