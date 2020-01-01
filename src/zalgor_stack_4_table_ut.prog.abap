*&---------------------------------------------------------------------*
*& Include          ZALGOR_STACK_4_TABLE_UT
*&---------------------------------------------------------------------*

CLASS lcl_ut DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PUBLIC SECTION.
    METHODS:
      ut_01 FOR TESTING,
      ut_02 FOR TESTING,
      ut_03 FOR TESTING.

  PRIVATE SECTION.
    DATA:
          lt_i TYPE STANDARD TABLE OF i.

ENDCLASS.


CLASS lcl_ut IMPLEMENTATION.
  METHOD ut_01.
*    lt_i = VALUE #( ( 8 ) ( 4 ) ).
    DATA(lo_stack) = NEW lcl_stack( lt_i ).

    lo_stack->push( 9 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lo_stack->is_empty( )    " Data object with current value
        exp = abap_false    " Data object with expected type
    ).

  ENDMETHOD.

  METHOD ut_02.
    DATA(lo_stack) = NEW lcl_stack( lt_i ).

    lo_stack->push( 11 ).
    lo_stack->push( 28 ).
    lo_stack->push( 23 ).
    lo_stack->push( 91 ).

    lo_stack->pop( ).

    DATA lv_act TYPE i.
    lo_stack->pop(
      IMPORTING
        e_pop_entry = lv_act
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  lv_act   " Data object with current value
        exp                  =  23  " Data object with expected type
    ).
  ENDMETHOD.

  METHOD ut_03.
    DATA:
      BEGIN OF ls_test,
        aa TYPE char1,
        bb TYPE char4,
      END OF ls_test,
      lt_test LIKE STANDARD TABLE OF ls_test.

    lt_test = VALUE #( ( aa = |y|
                         bb = |cccc| ) ).

    DATA(lo_stack) = NEW lcl_stack( lt_test ).

    lo_stack->push( |12345| ).

    lo_stack->pop(
      IMPORTING
        e_pop_entry = ls_test
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  ls_test-bb   " Data object with current value
        exp                  =  |2345|  " Data object with expected type
    ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  lo_stack->get_counter( )   " Data object with current value
        exp                  =  1  " Data object with expected type
    ).
    lo_stack->pop(
      IMPORTING
        e_pop_entry = ls_test
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  =  ls_test   " Data object with current value
        exp                  =  |ycccc|  " Data object with expected type
).

  ENDMETHOD.
ENDCLASS.
