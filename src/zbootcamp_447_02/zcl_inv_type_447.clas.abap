CLASS zcl_inv_type_447 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_INV_TYPE_447 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

************************************************************************
** Cargar registros en la Tabla Boolean y verificar por Data Preview.
************************************************************************

    DATA: lt_inv_type TYPE TABLE OF zainvtype447.

    lt_inv_type = VALUE #( ( type = 'I' value ='INVOICE')
                        ( type = 'O' value ='ORDER' )
                        ( type = 'Q' value ='QUOTE' ) ).

    DELETE FROM zainvtype447.

    INSERT zainvtype447 FROM TABLE @lt_inv_type.

    IF sy-subrc IS INITIAL.
      COMMIT WORK.
      out->write( |Cargado exitosamente.| ).
    ELSE.
      ROLLBACK WORK.
      out->write( |No se ingreso los datos correctamente!| ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
