CLASS zcl_flight_info DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    METHODS run
      IMPORTING iv_carrier TYPE /dmo/carrier_id
                out        TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.

CLASS zcl_flight_info IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    run( iv_carrier = 'LH'
         out        = out ).
  ENDMETHOD.

  METHOD run.
    " Local types sekmesindeki ty_flight_table'ı kullanır
    DATA lt_flights TYPE ty_flight_table.

    " SELECT ifadesinin doğru ve modern yazımı:
    SELECT FROM /dmo/connection
      FIELDS carrier_id,
             connection_id,
             airport_from_id,
             airport_to_id,
             distance
      WHERE carrier_id = @iv_carrier
      INTO TABLE @lt_flights.

    IF lt_flights IS INITIAL.
      out->write( |Veri bulunamadı: { iv_carrier }| ).
      RETURN.
    ENDIF.

    " Analyzer nesnesini oluştur
    DATA(lo_analyzer) = NEW lcl_flight_analyzer( lt_flights ).

    " Sonuçları Yazdır
    out->write( '================================' ).
    out->write( |Havayolu: { iv_carrier }| ).
    out->write( |Toplam Uçuş: { lo_analyzer->get_count( ) }| ).

    " En uzun uçuş
    DATA(ls_longest) = lo_analyzer->get_longest( ).
    out->write( '--- En Uzun Uçuş ---' ).
    out->write( |Kalkış:  { ls_longest-airport_from_id }| ).
    out->write( |Varış:   { ls_longest-airport_to_id }| ).
    out->write( |Mesafe:  { ls_longest-distance } KM| ).

    " Tüm uçuşlar listesi
    out->write( '--- Tüm Uçuşlar ---' ).
    LOOP AT lt_flights INTO DATA(ls_flight).
      out->write( |{ ls_flight-connection_id }: { ls_flight-airport_from_id } -> { ls_flight-airport_to_id } ({ ls_flight-distance } KM)| ).
    ENDLOOP.

    out->write( '================================' ).

  ENDMETHOD.

ENDCLASS.
