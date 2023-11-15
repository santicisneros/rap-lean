CLASS lhc_factNew447 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR factNew447 RESULT result.

    METHODS detInvoiceId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR factNew447~detInvoiceId.

    METHODS valType FOR VALIDATE ON SAVE
      IMPORTING keys FOR factNew447~valType.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR factNew447 RESULT result.

    METHODS setStatusPaid FOR MODIFY
      IMPORTING keys FOR ACTION factNew447~setStatusPaid RESULT result.

    METHODS setStatusCancel FOR MODIFY
      IMPORTING keys FOR ACTION factNew447~setStatusCancel RESULT result.

ENDCLASS.

CLASS lhc_factNew447 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD detInvoiceId.

   READ ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    FIELDS ( InvoiceId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_factnew_447).

    SELECT
    FROM  zi_fact_new_447 AS inv
    FIELDS inv~InvoiceId
    INTO TABLE @DATA(lt_invoice).

    DATA(lv_line) = LINES( lt_invoice ).

    IF lv_line = 0.
    MODIFY ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    UPDATE FIELDS ( InvoiceId )
    WITH VALUE #( FOR lw_factnew IN lt_factnew_447 (
    %key = lw_factnew-%key
    InvoiceId = COND #(
    WHEN lw_factnew-Type EQ 'I'
    THEN |I-{ 10 }|
    WHEN lw_factnew-Type EQ 'O'
    THEN |O-{ 10 }|
    WHEN lw_factnew-Type EQ 'Q'
    THEN |Q-{ 10 }|
    )
    ) )
    REPORTED DATA(lt_reported).

    ELSEIF lv_line <> 0.
    MODIFY ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    UPDATE FIELDS ( InvoiceId )
    WITH VALUE #( FOR lw_factnew IN lt_factnew_447 (
    %key = lw_factnew-%key
    InvoiceId = COND #(
    WHEN lw_factnew-Type EQ 'I'
    THEN |I-{ lt_invoice[ lv_line ]-InvoiceId + 10 }|
    WHEN lw_factnew-Type EQ 'O'
    THEN |O-{ lt_invoice[ lv_line ]-InvoiceId + 10 }|
    WHEN lw_factnew-Type EQ 'Q'
    THEN |Q-{ lt_invoice[ lv_line ]-InvoiceId + 10 }|
    ) ) )
   REPORTED lt_reported.
    ENDIF.
ENDMETHOD.

  METHOD valType.

*     READ ENTITIES OF  zi_fact_new_447 IN LOCAL MODE
*     ENTITY factNew447
*     FROM VALUE #( FOR lw_key IN keys (
*                    %key-Mykey = lw_key-Id
*                    %control = VALUE #( Type =  if_abap_behv=>mk-on )
*                                          )
*                                      )
*     RESULT DATA(lt_factnew).
*
*    LOOP AT lt_factnew ASSIGNING FIELD-SYMBOL(<fs_factnew>).
*      IF <fs_factnew>-Type EQ 'I'.
**        APPEND VALUE #( %key = <fs_proj>-%key
**                          id = <fs_proj>-Id )
**                        TO failed-project447.
*        APPEND VALUE #(               %key = <factnew>-%key
*                                      %msg = new_message( id = 'ZMC_331'
*                                    number = '004'
*                                  severity = if_abap_behv_message=>severity-information )
*                        %element-IsSensitive = if_abap_behv=>mk-on
*)
*                        TO reported-project447.
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD setStatusPaid.

    MODIFY ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    UPDATE FROM VALUE #( FOR key IN keys
    ( Mykey = key-mykey
    Status = 'P'
    Type = 'I'
    %control-Status = if_abap_behv=>mk-on
    %control-Type = if_abap_behv=>mk-on
    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    FROM VALUE #( FOR key IN keys ( Mykey = key-mykey ) )
    RESULT DATA(lt_factnew_447).

    result = VALUE #( FOR lw_factnew_447 IN lt_factnew_447
    ( Mykey = lw_factnew_447-mykey
    %param = lw_factnew_447 ) ).


  ENDMETHOD.

  METHOD setStatusCancel.
  MODIFY ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    UPDATE FROM VALUE #( FOR key IN keys
    ( Mykey = key-mykey
    Status = 'C'
*    Type = 'I'
    %control-Status = if_abap_behv=>mk-on
*   %control-Type = if_abap_behv=>mk-on
    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF zi_fact_new_447 IN LOCAL MODE
    ENTITY factNew447
    FROM VALUE #( FOR key IN keys ( Mykey = key-mykey ) )
    RESULT DATA(lt_factnew_447).

    result = VALUE #( FOR lw_factnew_447 IN lt_factnew_447
    ( Mykey = lw_factnew_447-mykey
    %param = lw_factnew_447 ) ).

  ENDMETHOD.

ENDCLASS.
