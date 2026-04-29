CLASS zcl_structured_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_structured_3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

     DATA lo_connection TYPE REF TO lcl_connection.

     TRY.
          lo_connection = NEW lcl_connection(
             i_carrier_id = 'LH'
             i_connection_id = '0400'
           ).

           out->write( lo_connection->get_output(  ) ).


        CATCH cx_abap_invalid_value.
           out->write( 'Hata' ).

     ENDTRY.
  ENDMETHOD.
ENDCLASS.
