CLASS lhc_acreedores DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR acreedores RESULT result.

    METHODS detdeudaid FOR DETERMINE ON MODIFY
      IMPORTING keys FOR acreedores~detdeudaid.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR acreedores RESULT result.

    METHODS setstatuspagado FOR MODIFY
      IMPORTING keys FOR ACTION acreedores~setstatuspagado RESULT result.

    METHODS setstatuscancel FOR MODIFY
      IMPORTING keys FOR ACTION acreedores~setstatuscancel RESULT result.

    METHODS valdeuda FOR VALIDATE ON SAVE
      IMPORTING keys FOR acreedores~valdeuda.

    METHODS valfecha FOR VALIDATE ON SAVE
      IMPORTING keys FOR acreedores~valfecha.

ENDCLASS.

CLASS lhc_acreedores IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD detDeudaId.

    READ ENTITIES OF  zi_acreedores IN LOCAL MODE
          ENTITY acreedores
          FIELDS ( FacturaDeudaId )
          WITH CORRESPONDING #( keys )
          RESULT DATA(lt_acreedor).

    SELECT
    FROM zi_acreedores AS a
    FIELDS a~FacturaDeudaId
    INTO TABLE @DATA(lt_acreedor1).

    DATA(lv_line) = lines( lt_acreedor1 ).

    IF lv_line = 0.
      MODIFY ENTITIES OF zi_acreedores IN LOCAL MODE
      ENTITY acreedores
      UPDATE FIELDS ( FacturaDeudaId )
      WITH VALUE #( FOR lw_acreedor IN lt_acreedor (
                              %key = lw_acreedor-%key
                              FacturaDeudaId = 00000010 )
                          )
      REPORTED DATA(lt_reported).

    ELSEIF lv_line <> 0.
      MODIFY ENTITIES OF zi_acreedores IN LOCAL MODE
      ENTITY acreedores
      UPDATE FIELDS ( FacturaDeudaId )
      WITH VALUE #( FOR lw_acreedor IN lt_acreedor (
                              %key = lw_acreedor-%key
                             FacturaDeudaId = lt_acreedor1[ lv_line ]-FacturaDeudaId + 10 )
                         )
     REPORTED lt_reported.

    ENDIF.



  ENDMETHOD.

  METHOD get_instance_features.

  READ ENTITIES OF zi_acreedores IN LOCAL MODE
     ENTITY acreedores
     FIELDS ( Status )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_acreedor)
     FAILED failed.

    LOOP AT lt_acreedor INTO DATA(ls_acreedor).
      result = VALUE #( FOR lw_acreedor IN lt_acreedor
                        ( %key = lw_acreedor-%key
                        %features-%update = COND #(
                            WHEN lw_acreedor-Status = 'P'
                            THEN if_abap_behv=>fc-o-disabled
                            ELSE if_abap_behv=>fc-o-enabled
                                )
                                %action = VALUE #( setStatusPagado = COND #( WHEN lw_acreedor-Status = 'P' THEN if_abap_behv=>fc-o-disabled ) )
                            )
                        ).
    ENDLOOP.

  ENDMETHOD.

  METHOD setStatusPagado.

    MODIFY ENTITIES OF zi_acreedores IN LOCAL MODE
      ENTITY acreedores
      UPDATE FROM VALUE #( FOR key IN keys
      ( Id = key-Id
      Status = 'P'
      %control-Status = if_abap_behv=>mk-on
      ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zi_acreedores IN LOCAL MODE
    ENTITY acreedores
    FROM VALUE #( FOR key IN keys (  Id = key-Id ) )
    RESULT DATA(lt_acreedor).

    result = VALUE #( FOR lw_acreedor IN lt_acreedor
    ( Id = lw_acreedor-Id
    %param = lw_acreedor ) ).

  ENDMETHOD.

  METHOD setStatusCancel.

   MODIFY ENTITIES OF zi_acreedores IN LOCAL MODE
   ENTITY acreedores
     UPDATE FROM VALUE #( FOR key IN keys
     ( Id = key-Id
     Status = 'C'
     %control-Status = if_abap_behv=>mk-on
     ) )
     FAILED failed
     REPORTED reported.

    READ ENTITIES OF zi_acreedores IN LOCAL MODE
    ENTITY acreedores
    FROM VALUE #( FOR key IN keys (  Id = key-Id ) )
    RESULT DATA(lt_acreedor).

    result = VALUE #( FOR lw_acreedor IN lt_acreedor
    ( Id = lw_acreedor-Id
    %param = lw_acreedor ) ).

  ENDMETHOD.

  METHOD valDeuda.

  READ ENTITIES OF  zi_acreedores IN LOCAL MODE
        ENTITY acreedores

   FROM VALUE #( FOR lw_key IN keys (
                  %key-Id = lw_key-Id
                  %control = VALUE #( MontoDeuda =  if_abap_behv=>mk-on )
                                        )
                                    )
    RESULT DATA(lt_acreedor).
    LOOP AT lt_acreedor ASSIGNING FIELD-SYMBOL(<fs_acreedor>).
      IF <fs_acreedor>-MontoDeuda < 0.

        APPEND VALUE #(               %key = <fs_acreedor>-%key
                                      %msg = new_message( id = 'ZMC447'
                                    number = '006'
                                  severity = if_abap_behv_message=>severity-error )
                        %element-MontoDeuda = if_abap_behv=>mk-on
)
                        TO reported-acreedores.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD valFecha.


    READ ENTITIES OF zi_acreedores IN LOCAL MODE
    ENTITY acreedores
    FROM VALUE #( FOR lw_key IN keys (
    %key-Id = lw_key-Id
    %control = VALUE #( FechaEmision = if_abap_behv=>mk-on
                        FechaVenc = if_abap_behv=>mk-on )
     ) )
    RESULT DATA(lt_acreedor).

    LOOP AT lt_acreedor ASSIGNING FIELD-SYMBOL(<fs_acreedor>).
      "no se valida que la fecha de inicio ingresada NO sea menor a la fecha de creacion del registro ya que esto puede suceder en la realidad

      IF <fs_acreedor>-FechaEmision GT <fs_acreedor>-FechaVenc.
        APPEND VALUE #( %key = <fs_acreedor>-%key
                        Id = <fs_acreedor>-Id
                        ) TO failed-acreedores.
        APPEND VALUE #( %key = <fs_acreedor>-%key
                       %msg = new_message( id       = 'ZMC447'
                                           number   = '007'
                                           v1       = |{ <fs_acreedor>-FechaEmision+6(2) }/{ <fs_acreedor>-FechaEmision+4(2) }/{ <fs_acreedor>-FechaEmision(4) }|
                                           v2       = |{ <fs_acreedor>-FechaVenc+6(2) }/{ <fs_acreedor>-FechaVenc+4(2) }/{ <fs_acreedor>-FechaVenc(4) }|
                                           severity = if_abap_behv_message=>severity-error )
                                           %element-FechaEmision = if_abap_behv=>mk-on
                                           %element-FechaVenc = if_abap_behv=>mk-on
       ) TO reported-acreedores.


      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
