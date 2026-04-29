CLASS zcl_cds DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA lo_connection TYPE REF TO lcl_connection.

    TRY.
        lo_connection = NEW lcl_connection(
            i_carrier_id      = 'LH'
            i_connection_id   = '0400'
            i_airport_from_id = 'FRA'
            i_airport_to_id   = 'JFK'
        ).

        out->write( lo_connection->get_output( ) ).

      CATCH cx_abap_invalid_value.
        out->write( 'Uçuş bulunamadı!' ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
