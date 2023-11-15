CLASS zcl_test_447 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_447 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA: lt_selection TYPE TABLE FOR READ IMPORT zi_soh_447,
          lt_creation  TYPE TABLE FOR CREATE zi_soh_447,
          lt_update    TYPE TABLE FOR UPDATE zi_soh_447.

***** READ A OTRA TABLA POR FUERA DEL POOL BEHAVIOR, DOS FORMAS DISTINTAS

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).

    SELECT FROM zi_soh_447 FIELDS SoId
    WHERE Div EQ '55'
    INTO TABLE @lt_selection.

*    SELECT FROM zi_soh_447 FIELDS SoId
*    WHERE CreatedDt EQ @lv_date
*    INTO TABLE @lt_selection.

*********************************************************
******* OTRO READ

*    lt_selection = value #( ( SoId = '1150' )
*                            ( SoId  = '25' )
*    ).

    READ ENTITIES OF zi_soh_447
    ENTITY soh
    ALL FIELDS WITH lt_selection
    RESULT DATA(lt_result)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    out->write( lt_result ).

**********************************************************************
********* CREATE

*    lt_creation =   VALUE #( (  %cid = 'Key1'
*                                SoId = '910'
*                                SalesOrg = '60'
*                                Div = '40'
*                                DistCh = '45'
*                                CreatedBy = cl_abap_context_info=>get_user_technical_name( )
*                                CreatedDt = cl_abap_context_info=>get_system_date( )
*                                %control-SoId       = if_abap_behv=>mk-on
*                                %control-SalesOrg   = if_abap_behv=>mk-on
*                                %control-Div        = if_abap_behv=>mk-on
*                                %control-DistCh     = if_abap_behv=>mk-on
*                                %control-CreatedBy   = if_abap_behv=>mk-on
*                                %control-CreatedDt   = if_abap_behv=>mk-on
*                              )
*                            ).
*
*    MODIFY ENTITIES OF zi_soh_447
*    ENTITY soh
*    CREATE FROM lt_creation
*    FAILED DATA(ls_failed)
**    MAPPED DATA(ls_mapped)
*    REPORTED DATA(ls_reported).
*
*    TRY.
**        out->write( ls_mapped-soh[ 1 ]-SoId ).
*        COMMIT ENTITIES.
*
*      CATCH cx_sy_itab_line_not_found.
*        out->write( ls_failed-soh[ 1 ]-%cid ).
*        ROLLBACK ENTITIES.
*
*    ENDTRY.

**********************************************************************
    " UPDATE

    lt_update = VALUE #( (   SoId      = '1150'
                             SalesOrg  = '65'
                             Div       = '45'
                             DistCh    = '99'
                             %control-SalesOrg   = if_abap_behv=>mk-on
                             %control-Div        = if_abap_behv=>mk-on
                             %control-DistCh     = if_abap_behv=>mk-on ) ).

    MODIFY ENTITIES OF zi_soh_447
    ENTITY soh
    UPDATE FROM lt_update
    FAILED DATA(ls_failed)
    MAPPED DATA(ls_mapped)
    REPORTED DATA(ls_reported).

    out->write( 'Updated' ).
    COMMIT ENTITIES.



  ENDMETHOD.
ENDCLASS.
