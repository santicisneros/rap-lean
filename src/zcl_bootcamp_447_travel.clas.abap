CLASS zcl_bootcamp_447_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOOTCAMP_447_TRAVEL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

************************************************************************
** Cargar registros en la Tabla
************************************************************************
    "Declaration internal table
    DATA: lt_travel TYPE TABLE OF zttravel447.

    "fill internal table
    lt_travel = VALUE #(

    ( client = '100'
      mykey = '02D5290E594C1EDA93815057FD945555'
      travel_id = '00000022' " /DMO/travel
      agency_id = '999999'   "/DMO/I_Agency
      customer_id = '000077' " /DMO/I_Customer
      begin_date = '20200624'
      end_date = '20200628'
      booking_fee = '80.00'
      total_price =  '900.00'
      currency_code = 'USD' "/DMO/I_Currency
      description = 'primer viaje cargado'
      overall_status = 'A'
      created_by = sy-uname
      created_at = '20200612133945.5960060'
      last_changed_by = sy-uname
      last_changed_at = '20200702105400.3647680' )

    ( client = '100'
      mykey = '02D5290E594C1EDA93815C50CD7A4444'
      travel_id = '00000106'
      agency_id = '888888' " /DMO/I_Agency
      customer_id = '000005' "/DMO/I_Customer
      begin_date = '20200613'
      end_date = '20200716'
      booking_fee = '50.00'
      total_price = '1050.00'
      currency_code = 'AUD' "/DMO/I_Currency
      description = 'segundo viaje cargado'
      overall_status = 'A'
      created_by = 'RMANN'
      created_at = '20200613111129.2391370'
      last_changed_by = 'RMANN'
      last_changed_at = '20200711140753.1472620' )

    ( client = '100'
      mykey = '02D5290E594C1EDA93858EED2DA23333'
      travel_id = '00000103'
      agency_id = '777777'   " /DMO/I_Agency
      customer_id = '000011' "/DMO/I_Customer
      begin_date = '20200610'
      end_date = '20200714'
      booking_fee = '55.00'
      total_price = '900.00'
      currency_code = 'ARS'  "/DMO/I_Currency
      description = 'tercer viaje cargado'
      overall_status = 'D'
      created_by = 'LEANDRO'
      created_at = '20200613105654.4296640'
      last_changed_by = 'LEANDROFRAU'
      last_changed_at = '20200613111041.2251330' )    ).
    "Delete possible entries
    DELETE FROM zttravel447.
    "Insert new entries
    INSERT zttravel447 FROM TABLE @lt_travel.
    "Check result in console
    IF sy-subrc = 0.
      out->write( |****************************| ).
      out->write( |Cantidad de datos cargados: { sy-dbcnt }| ).
      out->write( 'Carga de datos realizada!' ).
      out->write( |****************************| ).
    ELSE.
      out->write( |No se ingreso los datos correctamente!| ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
