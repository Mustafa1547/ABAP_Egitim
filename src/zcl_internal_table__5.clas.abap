CLASS zcl_internal_table__5 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_internal_table__5 IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
  " Nesneyi yaratırken istediğimiz kodları gönderiyoruz
  DATA(lo_connection) = NEW lcl_connection( i_departure   = 'FRA'
                                            i_destination = 'SFO' ).

  DATA(lt_output) = lo_connection->get_output( ).
  out->write( lt_output ).

ENDMETHOD.
ENDCLASS.
