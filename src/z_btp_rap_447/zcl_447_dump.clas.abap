CLASS zcl_447_dump DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_447_DUMP IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA: lv_mths     TYPE i VALUE 10, "No. of months remaining in year
          lv_hols     TYPE i VALUE 20, "No. of days untaken vacation
          lv_avg_hols TYPE i.


*    IF sy-subrc = 0. "Data returned
*      out->write( cl_abap_char_utilities=>newline ).
*      out->write( |Average vacation days per month { lv_avg_hols }| ).
*    ELSE.
*      out->write( |No data found!| ).
*    ENDIF.

*     IF lv_mths NE 0.
     IF lv_mths <> 0.
      lv_avg_hols = lv_hols / lv_mths.
      out->write( |Average vacation days per month { lv_avg_hols }| ).
    ELSE.
      out->write( |Please ask to roll over remaining vacation| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
