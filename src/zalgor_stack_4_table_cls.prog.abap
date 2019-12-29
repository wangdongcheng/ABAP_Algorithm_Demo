*&---------------------------------------------------------------------*
*& Include          ZALGOR_STACK_4_TABLE_CLS
*&---------------------------------------------------------------------*

*-- Local Class of CL_WF_STACK_4_DDIC

CLASS lcl_stack DEFINITION.
  PUBLIC SECTION.
    METHODS:
      construction
        IMPORTING
          it_tab TYPE ANY TABLE,

      push
        IMPORTING
          i_push_entry TYPE any,

      pop
        EXPORTING
          e_pop_entry TYPE any,

      get_counter
        RETURNING
          VALUE(rv_counter) TYPE i,

      is_empty
        RETURNING
          VALUE(rv_bool) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
      stack   TYPE REF TO data,
      top     TYPE REF TO data,
      counter TYPE i.

ENDCLASS.

CLASS lcl_stack IMPLEMENTATION.
  METHOD construction.
*        IMPORTING
*          it_tab TYPE ANY TABLE

    CHECK it_tab IS NOT INITIAL.

    CREATE DATA me->stack LIKE it_tab.
    CREATE DATA me->top LIKE LINE OF it_tab.

    me->counter = lines( it_tab ).
  ENDMETHOD.

  METHOD push.
*        IMPORTING
*          i_push_entry TYPE any

    FIELD-SYMBOLS:
      <lt_stack> TYPE table,
      <l_top>    TYPE any.

    CHECK i_push_entry IS NOT INITIAL.

    ASSIGN me->stack->* TO <lt_stack>.
    IF sy-subrc NE 0.
      " Error message
      RETURN.
    ENDIF.

    ASSIGN me->top->* TO <l_top>.
    IF sy-subrc NE 0.
      " Error message
      RETURN.
    ENDIF.

    <l_top> = i_push_entry.

    INSERT <l_top> INTO <lt_stack> INDEX 1.
    IF sy-subrc NE 0.
      " error message
    ENDIF.

    me->counter = me->counter + 1.

  ENDMETHOD.

  METHOD pop.
  ENDMETHOD.

  METHOD get_counter.
  ENDMETHOD.

  METHOD is_empty.
  ENDMETHOD.
ENDCLASS.
