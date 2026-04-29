*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

" Tip tanımlarını en üstte yapıyoruz
TYPES: BEGIN OF ty_flight_info,
         carrier_id      TYPE /dmo/carrier_id,
         connection_id   TYPE /dmo/connection_id,
         airport_from_id TYPE /dmo/airport_from_id,
         airport_to_id   TYPE /dmo/airport_to_id,
         distance        TYPE /dmo/flight_distance,
       END OF ty_flight_info.

TYPES ty_flight_table TYPE TABLE OF ty_flight_info WITH EMPTY KEY.

CLASS lcl_flight_analyzer DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING it_flights TYPE ty_flight_table.

    METHODS get_count
      RETURNING VALUE(rv_count) TYPE i.

    METHODS get_longest
      RETURNING VALUE(rs_flight) TYPE ty_flight_info.

  PRIVATE SECTION.
    DATA mt_flights TYPE ty_flight_table.
ENDCLASS.

CLASS lcl_flight_analyzer IMPLEMENTATION.
  METHOD constructor.
    me->mt_flights = it_flights.
  ENDMETHOD.

  METHOD get_count.
    rv_count = lines( mt_flights ).
  ENDMETHOD.

  METHOD get_longest.
    LOOP AT mt_flights INTO DATA(ls_flight).
      IF ls_flight-distance > rs_flight-distance.
        rs_flight = ls_flight.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
