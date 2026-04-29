*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE /dmo/carrier_name,
      END OF st_details.

    TYPES:
      BEGIN OF st_airport,
        AirportId TYPE /dmo/airport_id,
        Name      TYPE /dmo/airport_name,
      END OF st_airport.

    TYPES tt_airports TYPE STANDARD TABLE OF st_airport
                        WITH NON-UNIQUE DEFAULT KEY.

    CLASS-DATA airports TYPE tt_airports.

    METHODS constructor
      IMPORTING
        i_departure   TYPE /dmo/airport_from_id
        i_destination TYPE /dmo/airport_to_id.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

  PRIVATE SECTION.
    DATA details TYPE st_details.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

METHOD constructor.
  SELECT
  FROM /DMO/I_Airport
  FIELDS AirportID, Name
  INTO TABLE @airports.

  details-departureairport   = i_departure.
  details-destinationairport = i_destination.
ENDMETHOD.

  METHOD get_output.

    DATA(departure)   = airports[ airportID = details-departureairport   ].
    DATA(destination) = airports[ airportID = details-destinationairport ].

    APPEND |Departure:   { details-departureairport   } { departure-name   }| TO r_output.
    APPEND |Destination: { details-destinationairport } { destination-name }| TO r_output.

  ENDMETHOD.
ENDCLASS.
