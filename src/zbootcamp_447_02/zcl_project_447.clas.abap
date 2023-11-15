CLASS zcl_project_447 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PROJECT_447 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

************************************************************************
** Cargar registros en la Tabla Boolean y verificar por Data Preview.
************************************************************************

    DATA: lt_boolean TYPE TABLE OF zaboolean447.

    lt_boolean = VALUE #( ( type = 'Y' value ='YES')
                        ( type = 'N' value ='NO' ) ).

    DELETE FROM zaboolean447.

    INSERT zaboolean447 FROM TABLE @lt_boolean.

    IF sy-subrc IS INITIAL.
      COMMIT WORK.
      out->write( |Cargado exitosamente.| ).
    ELSE.
    ROLLBACK WORK.
      out->write( |No se ingreso los datos correctamente!| ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
