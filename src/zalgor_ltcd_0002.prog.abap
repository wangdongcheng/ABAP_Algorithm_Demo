*&---------------------------------------------------------------------*
*& Report ZALGOR_LC0002
*&---------------------------------------------------------------------*
*& 2. Add Two Numbers
*& You are given two non-empty linked lists representing two non-negative integers.
*& The digits are stored in reverse order and each of their nodes contain a single digit.
*& Add the two numbers and return it as a linked list.
*&
*& You may assume the two numbers do not contain any leading zero, except the number 0 itself.
*&
*& Example:
*&
*& Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
*& Output: 7 -> 0 -> 8
*& Explanation: 342 + 465 = 807.
*&---------------------------------------------------------------------*
REPORT zalgor_ltcd_0002.

CLASS lcl_listnode DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_val TYPE i.
    DATA:
      mv_val  TYPE i,
      mo_next TYPE REF TO lcl_listnode.
ENDCLASS.

CLASS lcl_listnode IMPLEMENTATION.
  METHOD constructor.
    mv_val = iv_val.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_ut DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.
  PUBLIC SECTION.
    METHODS:
      ut_listnode_create FOR TESTING.
  PRIVATE SECTION.
    DATA: mo_ln TYPE REF TO lcl_listnode.
ENDCLASS.

CLASS lcl_ut IMPLEMENTATION.
  METHOD ut_listnode_create.
    DATA(lo_ln) = NEW lcl_listnode( 0 ).

    mo_ln = lo_ln.
    WHILE sy-index LE 10.
      lo_ln->mo_next = NEW lcl_listnode( sy-index ).
      lo_ln = lo_ln->mo_next.
    ENDWHILE.

    DATA(lv_str) = |{ mo_ln->mv_val }|.
    WHILE mo_ln->mo_next IS BOUND.
      lv_str = |{ lv_str }->{ mo_ln->mo_next->mv_val }|.
      mo_ln = mo_ln->mo_next.
    ENDWHILE.
    cl_demo_output=>display( lv_str ).
  ENDMETHOD.
ENDCLASS.
