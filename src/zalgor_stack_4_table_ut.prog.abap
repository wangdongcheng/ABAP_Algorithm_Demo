*&---------------------------------------------------------------------*
*& Include          ZALGOR_STACK_4_TABLE_UT
*&---------------------------------------------------------------------*

CLASS lcl_ut DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    METHODS:
      setup,
      ut_01 FOR TESTING,
      ut_02 FOR TESTING,
      ut_03 FOR TESTING.

    DATA:
      mt_i     TYPE STANDARD TABLE OF i,
      mo_stack TYPE REF TO lcl_stack.

ENDCLASS.


CLASS lcl_ut IMPLEMENTATION.
  METHOD setup.
    mo_stack = NEW lcl_stack( mt_i ).
  ENDMETHOD.

  METHOD ut_01.
    mo_stack->push( 9 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = mo_stack->is_empty( )    " Data object with current value
        exp = abap_false    " Data object with expected type
    ).

  ENDMETHOD.

  METHOD ut_02.

    mo_stack->push( 11 ).
    mo_stack->push( 28 ).
    mo_stack->push( 23 ).
    mo_stack->push( 91 ).

    mo_stack->pop( ).

    DATA lv_act TYPE i.
    mo_stack->pop(
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

    mo_stack = NEW lcl_stack( lt_test ).
    mo_stack->push( |12345| ).

    mo_stack->pop(
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
        act                  =  mo_stack->get_counter( )   " Data object with current value
        exp                  =  1  " Data object with expected type
    ).

    mo_stack->pop(
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
