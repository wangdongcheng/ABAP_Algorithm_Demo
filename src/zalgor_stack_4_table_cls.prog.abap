*&---------------------------------------------------------------------*
*& Include          ZALGOR_STACK_4_TABLE_CLS
*&---------------------------------------------------------------------*

*-- Local Class of CL_WF_STACK_4_DDIC

CLASS lcl_stack DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
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
          VALUE(rv_is_empty) TYPE abap_bool.

  PRIVATE SECTION.
    DATA:
      stack   TYPE REF TO data,
      top     TYPE REF TO data,
      counter TYPE i.

ENDCLASS.

CLASS lcl_stack IMPLEMENTATION.
  METHOD constructor .
*        IMPORTING
*          it_tab TYPE ANY TABLE

    CREATE DATA me->stack LIKE it_tab.
    CREATE DATA me->top LIKE LINE OF it_tab.

    LOOP AT it_tab ASSIGNING FIELD-SYMBOL(<l_tab>).
      me->push( <l_tab> ).
    ENDLOOP.

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
    ELSE.
      me->counter = me->counter + 1.
    ENDIF.

  ENDMETHOD.

  METHOD pop.
*        EXPORTING
*          e_pop_entry TYPE any

    FIELD-SYMBOLS:
      <lt_stack> TYPE table,
      <l_top>    TYPE any.

    CLEAR e_pop_entry.

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

    TRY .
        <l_top> = <lt_stack>[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        RETURN.
    ENDTRY.

    DELETE TABLE <lt_stack> FROM <l_top>.
    IF sy-subrc NE 0.
      " error message
    ELSE.
      e_pop_entry = <l_top>.
      me->counter = me->counter - 1.
    ENDIF.
  ENDMETHOD.

  METHOD get_counter.
    rv_counter = me->counter.
  ENDMETHOD.

  METHOD is_empty.
    IF me->counter EQ 0.
      rv_is_empty = abap_true.
    ELSE.
      rv_is_empty = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
