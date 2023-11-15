CLASS zcl_deudatype DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DEUDATYPE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*********************************************************************************
** Cargado de registros en la Tabla Tipo de deuda y verificado por Data Preview.
*********************************************************************************

    DATA: lt_deuda_type TYPE TABLE OF zadeudatype.

    lt_deuda_type = VALUE #( ( type = 'P' value ='PRESTAMO')
                        ( type = 'F' value ='FACTURA' )
                        ( type = 'TC' value ='TARJETA DE CREDITO' ) ).

    DELETE FROM zadeudatype.

    INSERT zadeudatype FROM TABLE @lt_deuda_type.

    IF sy-subrc IS INITIAL.
      COMMIT WORK.
      out->write( |Cargado exitosamente.| ).
    ELSE.
      ROLLBACK WORK.
      out->write( |No se ingreso los datos correctamente!| ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
