*"* use this source file for the definition and implementation of

*"* local helper classes, interface definitions and type

*"* declarations



class lcl_connection definition create private.


PUBLIC SECTION.

METHODS constructor

IMPORTING

i_carrier_id TYPE /dmo/carrier_id

i_connection_id TYPE /dmo/connection_id

i_airport_from_id TYPE /dmo/airport_from_id

i_airport_to_id TYPE /dmo/airport_to_id.

METHODS get_output

RETURNING VALUE(r_output) TYPE string_table.

PROTECTED SECTION.

PRIVATE SECTION.



DATA carrier_id TYPE /dmo/carrier_id.

DATA connection_id TYPE /dmo/connection_id.

DATA airport_from_id TYPE /dmo/airport_from_id.

DATA airport_to_id TYPE /dmo/airport_to_id.

endclass.

class lcl_connection implementation.

method constructor.

IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.

RAISE EXCEPTION TYPE cx_abap_invalid_value.

ENDIF.


SELECT SINGLE

FROM /dmo/connection

FIELDS airport_from_id, airport_to_id

WHERE carrier_id = @i_carrier_id

AND connection_id = @i_connection_id

INTO ( @airport_from_id, @airport_to_id ).

IF sy-subrc <> 0.

RAISE EXCEPTION TYPE cx_abap_invalid_value.

ENDIF.

endmethod.

method get_output.


APPEND |--------------------------------| TO r_output.

APPEND |Carrier: { carrier_id }| TO r_output.

APPEND |Connection: { connection_id }| TO r_output.

APPEND |Departure: { airport_from_id }| TO r_output.

APPEND |Destination: { airport_to_id }| TO r_output.

endmethod.

endclass.
