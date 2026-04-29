*"* use this source file for the definition and implementation of

*"* local helper classes, interface definitions and type

*"* declarations



CLASS lcl_connection DEFINITION.


  PUBLIC SECTION.

    METHODS constructor

      IMPORTING

        i_carrier_id      TYPE /dmo/carrier_id

        i_connection_id   TYPE /dmo/connection_id

        i_airport_from_id TYPE /dmo/airport_from_id

        i_airport_to_id   TYPE /dmo/airport_to_id.

    METHODS get_output

      RETURNING VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA carrier_id      TYPE /dmo/carrier_id.
    DATA connection_id   TYPE /dmo/connection_id.

    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id   TYPE /dmo/airport_to_id.

    DATA carrier_name    TYPE /dmo/carrier_name.
    DATA currency_code   TYPE /dmo/currency_code.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

METHOD constructor.

  IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.

    RAISE EXCEPTION TYPE cx_abap_invalid_value.

  ENDIF.

    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name, \_Airline-CurrencyCode
     WHERE AirlineID    = @i_carrier_id
       AND ConnectionID = @i_connection_id
      INTO ( @airport_from_id, @airport_to_id, @carrier_name, @currency_code ).


    IF sy-subrc <> 0.

      RAISE EXCEPTION TYPE cx_abap_invalid_value.

    ENDIF.

  ENDMETHOD.

  METHOD get_output.

    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
    APPEND |Currency: { currency_code } | TO r_output .

  ENDMETHOD.

ENDCLASS.
