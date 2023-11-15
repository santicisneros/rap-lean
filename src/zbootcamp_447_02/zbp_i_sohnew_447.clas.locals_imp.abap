CLASS lhc_sohNew DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR sohNew RESULT result.

    METHODS detSaleId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR sohNew~detSaleId.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR sohNew RESULT result.

    METHODS setStatusPaid FOR MODIFY
      IMPORTING keys FOR ACTION sohNew~setStatusPaid RESULT result.

    METHODS setStatusCancel FOR MODIFY
      IMPORTING keys FOR ACTION sohNew~setStatusCancel RESULT result.
    METHODS valType FOR VALIDATE ON SAVE
      IMPORTING keys FOR sohNew~valType.
    METHODS valPrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR sohNew~valPrice.

ENDCLASS.

CLASS lhc_sohNew IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD detSaleId.

    READ ENTITIES OF  zi_sohnew_447 IN LOCAL MODE
        ENTITY sohNew
        FIELDS ( SaleId )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_sohnew).

    SELECT
    FROM zi_sohnew_447 AS r
    FIELDS r~SaleId
    INTO TABLE @DATA(lt_sohnew1).

    DATA(lv_line) = lines( lt_sohnew1 ).

    IF lv_line = 0.
      MODIFY ENTITIES OF zi_sohnew_447 IN LOCAL MODE
      ENTITY sohNew
      UPDATE FIELDS ( SaleId )
      WITH VALUE #( FOR lw_sohnew IN lt_sohnew (
                              %key = lw_sohnew-%key
                              SaleId = 10 )
                          )
      REPORTED DATA(lt_reported).

    ELSEIF lv_line <> 0.
      MODIFY ENTITIES OF zi_sohnew_447 IN LOCAL MODE
      ENTITY sohNew
      UPDATE FIELDS ( SaleId )
      WITH VALUE #( FOR lw_sohnew IN lt_sohnew (
                              %key = lw_sohnew-%key
                             SaleId = lt_sohnew1[ lv_line ]-SaleId + 10 )
                         )
     REPORTED lt_reported.

    ENDIF.

  ENDMETHOD.

  METHOD get_instance_features.

     READ ENTITIES OF zi_sohnew_447 IN LOCAL MODE
     ENTITY sohNew
     FIELDS ( Status )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_sohnew)
     FAILED failed.

    LOOP AT lt_sohnew INTO DATA(ls_sohnew).
      result = VALUE #( FOR lw_sohnew IN lt_sohnew
                        ( %key = lw_sohnew-%key
                        %features-%update = COND #(
                            WHEN lw_sohnew-Status = 'P'
                            THEN if_abap_behv=>fc-o-disabled
                            ELSE if_abap_behv=>fc-o-enabled
                                )
                                %action = VALUE #( setStatusPaid = COND #( WHEN lw_sohnew-Status = 'P' THEN if_abap_behv=>fc-o-disabled ) )
                            )
                        ).
    ENDLOOP.

  ENDMETHOD.

  METHOD setStatusPaid.

    MODIFY ENTITIES OF zi_sohnew_447 IN LOCAL MODE
    ENTITY sohNew
    UPDATE FROM VALUE #( FOR key IN keys
    ( SoId = key-SoId
    Status = 'P'
    Type = 'I'
    %control-Status = if_abap_behv=>mk-on
    %control-Type = if_abap_behv=>mk-on
    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF zi_sohnew_447 IN LOCAL MODE
    ENTITY sohNew
    FROM VALUE #( FOR key IN keys ( SoId = key-SoId ) )
    RESULT DATA(lt_sohnew_447).

    result = VALUE #( FOR lw_sohnew_447 IN lt_sohnew_447
    ( SoId = lw_sohnew_447-SoId
    %param = lw_sohnew_447 ) ).

  ENDMETHOD.

  METHOD setStatusCancel.

    MODIFY ENTITIES OF zi_sohnew_447 IN LOCAL MODE
       ENTITY sohNew
       UPDATE FROM VALUE #( FOR key IN keys
       ( SoId = key-SoId
       Status = 'C'
       %control-Status = if_abap_behv=>mk-on
       ) )
       FAILED failed
       REPORTED reported.

    READ ENTITIES OF zi_sohnew_447 IN LOCAL MODE
    ENTITY sohNew
    FROM VALUE #( FOR key IN keys ( SoId = key-SoId ) )
    RESULT DATA(lt_sohnew_447).

    result = VALUE #( FOR lw_sohnew_447 IN lt_sohnew_447
    ( SoId = lw_sohnew_447-SoId
    %param = lw_sohnew_447 ) ).
  ENDMETHOD.

  METHOD valType.

   READ ENTITIES OF  zi_sohnew_447 IN LOCAL MODE
        ENTITY sohNew
*  CAMPOS A VALIDAR
   FROM VALUE #( FOR lw_key IN keys (
                  %key-SoId = lw_key-SoId
                  %control = VALUE #( Type =  if_abap_behv=>mk-on )
                                        )
                                    )
    RESULT DATA(lt_sohnew).
    LOOP AT lt_sohnew ASSIGNING FIELD-SYMBOL(<fs_sohnew>).
      IF <fs_sohnew>-Type EQ 'O' OR <fs_sohnew>-Type EQ 'Q'.
*        APPEND VALUE #( %key = <fs_proj>-%key
*                          id = <fs_proj>-Id )
*                        TO failed-project447.
        APPEND VALUE #(               %key = <fs_sohnew>-%key
                                      %msg = new_message( id = 'ZMC447'
                                    number = '004'
                                  severity = if_abap_behv_message=>severity-warning )
                        %element-type = if_abap_behv=>mk-on
)
                        TO reported-sohnew.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD valPrice.

  READ ENTITIES OF  zi_sohnew_447 IN LOCAL MODE
        ENTITY sohNew
*  CAMPOS A VALIDAR
   FROM VALUE #( FOR lw_key IN keys (
                  %key-SoId = lw_key-SoId
                  %control = VALUE #( TotalPrice =  if_abap_behv=>mk-on )
                                        )
                                    )
    RESULT DATA(lt_sohnew).
    LOOP AT lt_sohnew ASSIGNING FIELD-SYMBOL(<fs_sohnew>).
      IF <fs_sohnew>-TotalPrice < 0.
*        APPEND VALUE #( %key = <fs_proj>-%key
*                          id = <fs_proj>-Id )
*                        TO failed-project447.
        APPEND VALUE #(               %key = <fs_sohnew>-%key
                                      %msg = new_message( id = 'ZMC447'
                                    number = '006'
                                  severity = if_abap_behv_message=>severity-error )
                        %element-TotalPrice = if_abap_behv=>mk-on
)
                        TO reported-sohnew.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
