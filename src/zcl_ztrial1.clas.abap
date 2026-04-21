CLASS zcl_ztrial1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ztrial1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  out->write( 'Hello World' ).
  ENDMETHOD.
ENDCLASS.
