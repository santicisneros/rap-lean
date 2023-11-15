CLASS zcl_447_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_447_HELLO_WORLD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    out->write( 'Hello World' ).


* Data Objects with Built-in Types
**********************************************************************

*    " comment/uncomment the following declarations and check the output
**    DATA variable TYPE string.
**   DATA variable TYPE i.
**    DATA variable TYPE d.
**    DATA variable TYPE c LENGTH 10.
*    DATA variable TYPE n LENGTH 10.
**    DATA variable TYPE p LENGTH 8 DECIMALS 2.
*
** Output
***********************************************************************
*    out->write( cl_abap_char_utilities=>newline ).
*    out->write(  'Result with Initial Value)' ).
*    out->write(   variable  ).
*    out->write(  '---------' ).
*    out->write( cl_abap_char_utilities=>newline ).
*
*    variable = '19891109'.
*
*    out->write(  'Result with Value 19891109' ).
*    out->write(   variable ).
*    out->write(  '---------' ).



**********************************************************************


* Example 1: Local Types
**********************************************************************

* Comment/Uncomment the following lines to change the type of my_var
    TYPES my_type TYPE p LENGTH 3 DECIMALS 2.
*    TYPES my_type TYPE i .
*    TYPES my_type TYPE string.
*    TYPES my_type TYPE n length 10.

* Variable based on local type
    DATA my_variable TYPE my_type.

    out->write(  `my_variable (TYPE MY_TYPE)` ).
    out->write(   my_variable ).

* Example 2: Global Types
**********************************************************************

* Variable based on global type .
    " Place cursor on variable and press F2 or F3
    DATA airport TYPE /dmo/airport_id VALUE 'FRA'.

    out->write(  `airport (TYPE /DMO/AIRPORT_ID )` ).
    out->write(   airport ).

* Example 3: Constants
**********************************************************************

    CONSTANTS c_text   TYPE string VALUE `Hello World`.
    CONSTANTS c_number TYPE i      VALUE 12345.

    "Uncomment this line to see syntax error ( VALUE is mandatory)
*  constants c_text2   type string.

    out->write(  `c_text (TYPE STRING)` ).
    out->write(   c_text ).
    out->write(  '---------' ).

    out->write(  `c_number (TYPE I )` ).
    out->write(   c_number ).
    out->write(  `---------` ).

* Example 4: Literals
**********************************************************************

    out->write(  '12345               ' ).    "Text Literal   (Type C)
    out->write(  `12345               ` ).    "String Literal (Type STRING)
    "String Literal (Type STRING)
    out->write(  12345                  ).    "Number Literal (Type I)

    "uncomment this line to see syntax error (no number literal with digits)
*    out->write(  12345.67                  ).



* Declarations
**********************************************************************

    " comment/uncomment these line for different result types
    TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
*    TYPES t_result TYPE p LENGTH 8 DECIMALS 0.
*    TYPES t_result TYPE i.

    DATA result TYPE t_result.

* Calculations
**********************************************************************
    " comment/uncomment these lines for different calculations

    result = 2 + 3.
*    result = 2 - 3.
*    result = 2 * 3.
*    result = 2 / 3.
*
*    result = sqrt( 2 ).
*    result = ipow( base = 2 exp = 3 ).
*
*    result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
*   result = 8 * 7 - 6 / 5 + 4.

* Output
**********************************************************************

    out->write( result ).




* Declarations
**********************************************************************
    TYPES t_amount TYPE  p LENGTH 8 DECIMALS 2.

    DATA amount   TYPE t_amount VALUE '3.30'.
    DATA amount1  TYPE t_amount VALUE '1.20'.
    DATA amount2  TYPE t_amount VALUE '2.10'.

    DATA the_date  TYPE d                     VALUE '19891109'.
    DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.

    DATA part1 TYPE string VALUE `Hello`.
    DATA part2 TYPE string VALUE `World`.

* String Templates
**********************************************************************

    " comment/uncomment the following lines for different examples
*    DATA(text) = |Hello World|.
    DATA(text) = |Total: { amount } EUR|.
*   DATA(text) = |Total: { amount1 + amount2 } EUR|.

* Format Options
**********************************************************************

    "Date
*    DATA(text) = |Raw Date: { the_date             }|.
*    DATA(text) = |ISO Date: { the_date Date = ISO  }|.
*    DATA(text) = |USER Date:{ the_date Date = USER }|.

    "Number
*    DATA(text) = |Raw Number { my_numer                    }|.
*    DATA(text) = |User Format{ my_numer NUMBER = USER      }|.
*    DATA(text) = |Sign Right { my_number SIGN = RIGHT      }|.
*    DATA(text) = |Scientific { my_number STYLE = SCIENTIFIC }|.

* String expression (concatenation Operator)
**********************************************************************

*    DATA(text) = part1 && part2.
*    DATA(text) = part1 && | | && part2.
*    DATA(text) = |{ amount1 } + { amount2 }| &&
*                 | = | &&
*                 |{ amount1 + amount2 }|.


* Output
**********************************************************************

    out->write( text ).

* Solution Code:

    DATA ls_airport TYPE /dmo/airport.

    SELECT SINGLE FROM /dmo/airport
       FIELDS airport_id, name, city, country
        WHERE airport_id = 'FRA'
        INTO CORRESPONDING FIELDS OF @ls_airport.

    IF sy-subrc = 0. "Data returned
      out->write( ls_airport ).
    ELSE.
      out->write( |No data found!| ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
