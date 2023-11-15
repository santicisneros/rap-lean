CLASS zcl_carga_datos DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CARGA_DATOS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


***********************************************************************
** Carga de datos directos en la tabla
***********************************************************************

    TYPES: tt_carga_datos TYPE TABLE OF zaacreedores WITH DEFAULT KEY.

*    activar el delete en caso de ser necesario para borrar datos de la tabla

    DELETE FROM zaacreedores.
    COMMIT WORK.

    GET TIME STAMP FIELD DATA(lv_timestampl).
    TRY.
        DATA(lt_carga_datos) = VALUE tt_carga_datos( ( client = sy-mandt
                                    id                  = cl_system_uuid=>create_uuid_x16_static( )
                                    acreedor_id         = '400'
                                    acreedor_nombre     = 'Prueba carga'
                                    factura_deuda_id    = '00000080'
                                    monto_deuda         = '900'
                                    currency_code       = 'ARS'
                                    type                = 'F'
                                    fecha_emision       = cl_abap_context_info=>get_system_date( )
                                    fecha_venc          = ( cl_abap_context_info=>get_system_date( ) + 1 )
                                    created_by          = cl_abap_context_info=>get_user_technical_name( )
                                    created_at          = lv_timestampl
                                    last_change_by      = cl_abap_context_info=>get_user_technical_name( )
                                    last_changed_at     =  lv_timestampl
            ) ).
    CATCH cx_uuid_error.
        out->write( 'Hubo un error en la carga' ).
    ROLLBACK ENTITIES.
    ENDTRY.
    MODIFY zaacreedores FROM TABLE @lt_carga_datos.
    IF sy-subrc IS INITIAL.
    COMMIT WORK.
    out->write( 'Se cargo correctamente' ).
    ENDIF.



***********************************************************************
** Leer BO creado y modificar y cargar datos
***********************************************************************

    " CREATE
    DATA:
      lt_selection TYPE TABLE FOR READ IMPORT zi_acreedores,
      lt_creation  TYPE TABLE FOR CREATE zi_acreedores,
      lt_update    TYPE TABLE FOR UPDATE zi_acreedores.

   READ ENTITIES OF  zi_acreedores
   ENTITY acreedores
   ALL FIELDS WITH lt_selection
*    ALL FIELDS WITH VALUE #( ( acreedor_id = '400' ) )
   RESULT DATA(lt_result)
   FAILED DATA(lt_failed)
   REPORTED DATA(lt_reported).

*   activar el get stamp en caso de desactivar el de arriba
*   GET TIME STAMP FIELD DATA(lv_timestampl).

    lt_creation =   VALUE #( (  %cid = 'Key1'
                                AcreedorId = '20'
                                AcreedorNombre = 'Prueba 2'
                                MontoDeuda = '800'
                                CurrencyCode = 'ARS'
                                Type = 'P'
                                FechaEmision = cl_abap_context_info=>get_system_date( )
                                FechaVenc    = ( cl_abap_context_info=>get_system_date( ) + 1 )

                                %control-AcreedorId        = if_abap_behv=>mk-on
                                %control-AcreedorNombre     = if_abap_behv=>mk-on
                                %control-MontoDeuda    = if_abap_behv=>mk-on
                                %control-CurrencyCode    = if_abap_behv=>mk-on
                                %control-Type     = if_abap_behv=>mk-on
                                %control-FechaEmision     = if_abap_behv=>mk-on
                                %control-FechaVenc     = if_abap_behv=>mk-on

                              )  ).
    MODIFY ENTITIES OF zi_acreedores
    ENTITY acreedores
    CREATE FROM lt_creation
    FAILED DATA(ls_failed)
    MAPPED DATA(ls_mapped)
    REPORTED DATA(ls_reported).

    TRY.
        out->write( ls_mapped-acreedores[ 1 ]-Id ).
        COMMIT ENTITIES.

      CATCH cx_sy_itab_line_not_found.
        out->write( ls_failed-acreedores[ 1 ]-%cid ).
        ROLLBACK ENTITIES.

    ENDTRY.


  ENDMETHOD.
ENDCLASS.
