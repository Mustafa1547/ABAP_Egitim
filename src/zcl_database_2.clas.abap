CLASS zcl_database_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_database_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " 1. Nesneleri saklayacağımız tabloyu tanımlıyoruz
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    " 2. Veritabanından tüm verileri çekmek için geçici bir yapı
    SELECT FROM /dmo/connection
      FIELDS carrier_id, connection_id, airport_from_id, airport_to_id
      WHERE airport_from_id = 'SFO'
      INTO TABLE @DATA(lt_db_data).

    " 3. Döngü kurarak her satır için nesne oluşturuyoruz
    LOOP AT lt_db_data INTO DATA(ls_data).
      " Her satır için yeni bir nesne (instance) yaratıyoruz
      DATA(lo_conn) = NEW lcl_connection(
                            i_carrier_id    = ls_data-carrier_id
                            i_connection_id = ls_data-connection_id
                            i_from_id       = ls_data-airport_from_id
                            i_to_id         = ls_data-airport_to_id
                          ).

      " Bu nesneyi nesne tablosuna ekliyoruz
      APPEND lo_conn TO connections.

    ENDLOOP.

    " 4. Sonuçları yazdırmak için nesne tablosunda dönüyoruz
    out->write( |Tablodaki Toplam Kayıt Sayısı: { lines( connections ) }| ).
    out->write( `--------------------------------------------------` ).

    LOOP AT connections INTO DATA(lo_item).
       out->write( lo_item->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
