CLASS lhc_soh DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR soh RESULT result.

ENDCLASS.

CLASS lhc_soh IMPLEMENTATION.

  METHOD get_global_authorizations.

  ENDMETHOD.

ENDCLASS.
