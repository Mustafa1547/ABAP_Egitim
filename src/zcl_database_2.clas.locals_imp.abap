*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    " Constructor artık veritabanına gitmez, sadece gelen veriyi nesneye yükler
    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_from_id       TYPE /dmo/airport_from_id
        i_to_id         TYPE /dmo/airport_to_id.

    METHODS get_output
        RETURNING VALUE(r_output) TYPE string.

  PRIVATE SECTION.
    DATA: carrier_id      TYPE /dmo/carrier_id,
          connection_id   TYPE /dmo/connection_id,
          airport_from_id TYPE /dmo/airport_from_id,
          airport_to_id   TYPE /dmo/airport_to_id.
ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.
  METHOD constructor.
    me->carrier_id      = i_carrier_id.
    me->connection_id   = i_connection_id.
    me->airport_from_id = i_from_id.
    me->airport_to_id   = i_to_id.
  ENDMETHOD.

  METHOD get_output.
   r_output = |Carrier: { me->carrier_id } Connection: { me->connection_id }:   { me->airport_from_id } -> { me->airport_to_id }|.
  ENDMETHOD.
ENDCLASS.
