CLASS lhc_project447 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR project447 RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR project447 RESULT result.

    METHODS setstatusapprove FOR MODIFY
      IMPORTING keys FOR ACTION project447~setStatusApprove RESULT result. "estas son mi variables, resultado es lo que devuelvo y keys es lo que traigo para cambiar

    METHODS detprojectid FOR DETERMINE ON MODIFY
      IMPORTING keys FOR project447~detprojectid. "estas son mi variables, resultado es lo que devuelvo y keys es lo que traigo para cambiar

    METHODS valdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR project447~valdate.

    METHODS setstatusdisapprove FOR MODIFY
      IMPORTING keys FOR ACTION project447~setstatusdisapprove RESULT result.
    METHODS valissensitive FOR VALIDATE ON SAVE
      IMPORTING keys FOR project447~valissensitive.  "estas son mi variables, resultado es lo que devuelvo y keys es lo que traigo para cambiar

ENDCLASS.
*aca uso logica normal de abap 7.4
CLASS lhc_project447 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zi_projt447 IN LOCAL MODE
    ENTITY project447
          FIELDS (  status )
            WITH CORRESPONDING #( keys )
              RESULT DATA(lt_proj_447)
              FAILED failed.

    LOOP AT lt_proj_447 INTO DATA(ls_proj).

      result = VALUE #( FOR lw_proj IN lt_proj_447
               ( %key = lw_proj-%key
                 %features-%update = COND #(
                                     WHEN lw_proj-Status = 'A'
                                     THEN if_abap_behv=>fc-o-disabled
                                     ELSE if_abap_behv=>fc-o-enabled
                                     ) ) ).


    ENDLOOP.
  ENDMETHOD.

  METHOD setstatusapprove.

    MODIFY ENTITIES OF zi_projt447 IN LOCAL MODE "este es el cambio
    ENTITY project447
    UPDATE FROM VALUE #( FOR key IN keys
    ( Id = key-Id "si tiene mas de una key, igualo todas las key que tiene la tabla
    Status = 'A'
*    IsSensitive = 'Y'  "cambiaria el campo issensitive tb
    %control-Status = if_abap_behv=>mk-on "realizo un metodo interno que cambia la flag 0 por 1, y lo igualo con mi declaracion de variable A
*    %control-IsSensitive = if_abap_behv=>mk-on
    )
     )
     FAILED failed
     REPORTED reported.

    "IF failed IS INITIAL. "para chequear si hay un error, y manejarlo, dar un msj o lo que se necesite

    READ ENTITIES OF zi_projt447 IN LOCAL MODE "aca leo el cambio que recien realizamos
    ENTITY project447
    FROM VALUE #( FOR key IN keys ( Id = key-Id ) )
    RESULT DATA(lt_project_447).

    result = VALUE #( FOR lw_project_447 IN lt_project_447
    ( Id = lw_project_447-Id
    %param = lw_project_447 ) ). "param me trae todos los parametros para no tener que escribir todos

    "ENDIF.
  ENDMETHOD.

  METHOD detProjectId.

    READ ENTITIES OF zi_projt447 IN LOCAL MODE
    ENTITY project447
    FIELDS ( ProjectId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_project_447).

    MODIFY ENTITIES OF zi_projt447 IN LOCAL MODE
    ENTITY project447
    UPDATE FIELDS ( ProjectId )
    WITH VALUE #( FOR lw_proj IN lt_project_447 (
    %key = lw_proj-%key
    ProjectId = COND #(
    WHEN lw_proj-IsSensitive EQ 'Y'
    THEN |Y-{ cl_abap_context_info=>get_system_time(  ) }|
    ELSE |N-{ cl_abap_context_info=>get_system_time( ) }|
    )
    ) )
    REPORTED DATA(lt_reported).

  ENDMETHOD.

  METHOD valDate.

*   READ entity in local mode zi_projt447
    READ ENTITIES OF zi_projt447 IN LOCAL MODE
    ENTITY project447
    FROM VALUE #( FOR lw_key IN keys (
    %key-Id = lw_key-Id
    %control = VALUE #( BeginDate = if_abap_behv=>mk-on
                        EndDate = if_abap_behv=>mk-on )
     ) )
    RESULT DATA(lt_project).

    LOOP AT lt_project ASSIGNING FIELD-SYMBOL(<fs_proj>).
      "se validad que la fecha de inicio ingresada NO sea menor a la fecha de creacion del registro
      IF <fs_proj>-BeginDate LT cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %key = <fs_proj>-%key
                        id   = <fs_proj>-Id
        ) TO failed-project447.
        APPEND VALUE #( %key = <fs_proj>-%key
                        %msg = new_message( id   = 'ZMC447'  "esta es la clase de mensaje que creamos, con que codigo y que severidad
                                        number   = '002'
                                        v1       = |{ <fs_proj>-BeginDate+6(2) }/{ <fs_proj>-BeginDate+4(2) }/{ <fs_proj>-BeginDate(4) }|
                                        severity =  if_abap_behv_message=>severity-error )
                                        %element-BeginDate = if_abap_behv=>mk-on "para marcar el campo en color el cual esta en error
        ) TO reported-project447.

      ELSEIF <fs_proj>-BeginDate GT <fs_proj>-EndDate.
        APPEND VALUE #( %key = <fs_proj>-%key
                        id = <fs_proj>-Id
                        ) TO failed-project447.
        APPEND VALUE #( %key = <fs_proj>-%key
                       %msg = new_message( id       = 'ZMC447'
                                           number   = '001'
                                           v1       = |{ <fs_proj>-BeginDate+6(2) }/{ <fs_proj>-BeginDate+4(2) }/{ <fs_proj>-BeginDate(4) }|
                                           v2       = |{ <fs_proj>-EndDate+6(2) }/{ <fs_proj>-EndDate+4(2) }/{ <fs_proj>-EndDate(4) }|
                                           v3       = <fs_proj>-ProjectId
                                           severity = if_abap_behv_message=>severity-error )
                                           %element-BeginDate = if_abap_behv=>mk-on "para marcar el campo en color el cual esta en error
                                           %element-EndDate = if_abap_behv=>mk-on "para marcar el campo en color el cual esta en error
       ) TO reported-project447.


      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD setStatusDisapprove.

    MODIFY ENTITIES OF zi_projt447 IN LOCAL MODE
      ENTITY project447
      UPDATE FROM VALUE #( FOR key IN keys
      ( Id = key-Id
      Status = 'D'
      %control-Status = if_abap_behv=>mk-on
      )
       )
       FAILED failed
       REPORTED reported.

    READ ENTITIES OF zi_projt447 IN LOCAL MODE
    ENTITY project447
    FROM VALUE #( FOR key IN keys ( Id = key-Id ) )
    RESULT DATA(lt_project_447).

    result = VALUE #( FOR lw_project_447 IN lt_project_447
    ( Id = lw_project_447-Id
    %param = lw_project_447 ) ).


  ENDMETHOD.
*************************** VALIDATE IS SENSITIVE **************************
  METHOD valIsSensitive.

      READ ENTITIES OF  zi_projt447 IN LOCAL MODE
        ENTITY project447
*  CAMPOS A VALIDAR
   FROM VALUE #( FOR lw_key IN keys (
                  %key-Id = lw_key-Id
                  %control = VALUE #( IsSensitive =  if_abap_behv=>mk-on )
                                        )
                                    )
    RESULT DATA(lt_project).
    LOOP AT lt_project ASSIGNING FIELD-SYMBOL(<fs_proj>).
      IF <fs_proj>-IsSensitive EQ 'N'.
*        APPEND VALUE #( %key = <fs_proj>-%key
*                          id = <fs_proj>-Id )
*                        TO failed-project447.
        APPEND VALUE #(               %key = <fs_proj>-%key
                                      %msg = new_message( id = 'ZMC_331'
                                    number = '004'
                                  severity = if_abap_behv_message=>severity-information )
                        %element-IsSensitive = if_abap_behv=>mk-on
)
                        TO reported-project447.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
