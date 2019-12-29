*&---------------------------------------------------------------------*
*& Include          ZALGOR_PIE_FLIP_SORT_UT
*&---------------------------------------------------------------------*

*-- UNIT TEST CLASS
CLASS lcl_ut DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PUBLIC SECTION.
    CLASS-METHODS:
      get_random_pies
        IMPORTING
          iv_qty         TYPE i DEFAULT 10
          iv_max_size    TYPE i DEFAULT 100
          iv_min_size    TYPE i DEFAULT 1
            PREFERRED PARAMETER iv_qty
        RETURNING
          VALUE(rt_pies) TYPE zalgor_int1_t.

    METHODS:
      flip_ut FOR TESTING,
      get_max_pos_ut FOR TESTING.

ENDCLASS.

CLASS lcl_ut IMPLEMENTATION.
  METHOD get_random_pies.
    CLEAR rt_pies.

    IF NOT iv_max_size GT iv_min_size.
      " Raise Exception
    ENDIF.

    DATA:
      lv_pie TYPE i.

    DO.
      lv_pie = NEW cl_random_number( )->if_random_number~get_random_int( i_limit = iv_max_size ).
      IF lv_pie GE iv_min_size.
        APPEND lv_pie TO rt_pies.
        IF lines( rt_pies ) EQ iv_qty.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.

  ENDMETHOD.

  METHOD flip_ut.
    DATA(lt_pies) = lcl_ut=>get_random_pies( ).

    DATA lv_index TYPE i VALUE 3.
    DATA(lv_exp) = lt_pies[ lv_index ].

    lcl_flip_pies=>set_pies( lt_pies ).
    READ TABLE lcl_flip_pies=>flip( lv_index ) INTO DATA(lv_act) INDEX 1.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act =  lv_act   " Data object with current value
        exp =  lv_exp   " Data object with expected type
    ).
  ENDMETHOD.

  METHOD get_max_pos_ut.
    DATA(lt_pies) = VALUE zalgor_int1_t( ).
    APPEND 1 TO lt_pies.
    APPEND 33 TO lt_pies.
    APPEND 24 TO lt_pies.
    APPEND 92 TO lt_pies.
    APPEND 26 TO lt_pies.

    lcl_flip_pies=>set_pies( lt_pies ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act =  lcl_flip_pies=>get_max_pie_position( 5 )
        exp =  4
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act =  lcl_flip_pies=>get_max_pie_position( 3 )
        exp =  2
    ).

        cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act =  lcl_flip_pies=>get_max_pie_position( 6 )
        exp =  0
    ).

  ENDMETHOD.

ENDCLASS.
