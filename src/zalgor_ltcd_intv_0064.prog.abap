*&---------------------------------------------------------------------*
*& Report ZALGOR_LTCD_INTV_0064
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

* 面试题64. 求1+2+…+n
* 求 1+2+...+n ，要求不能使用乘除法、for、while、if、else、switch、case等关键字及条件判断语句（A?B:C）。
*
* 示例 1：
*
* 输入: n = 3
* 输出: 6
* 示例 2：
*
* 输入: n = 9
* 输出: 45
*
*
* 限制：
*
* 1 <= n <= 10000

REPORT zalgor_ltcd_intv_0064.

CLASS lcl_add DEFINITION.
  PUBLIC SECTION.
    METHODS:
      get_sum_nums
        IMPORTING
          iv_n          TYPE i
        RETURNING
          VALUE(rv_ans) TYPE i.
ENDCLASS.

CLASS lcl_add IMPLEMENTATION.
  METHOD get_sum_nums.
*    rv_ans = SWITCH i( iv_n
*                       WHEN 0 THEN 0
*                       ELSE iv_n + me->get_sum_nums( iv_n - 1 ) ).
    TRY.
        DATA(lv_dummy) = 1 / iv_n.
        rv_ans = iv_n + me->get_sum_nums( iv_n - 1 ).
      CATCH cx_sy_zerodivide.
        rv_ans = 0.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_ut DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    METHODS:
      ut FOR TESTING.
ENDCLASS.

CLASS lcl_ut IMPLEMENTATION.
  METHOD ut.
    DATA(lo_add) = NEW lcl_add( ).
    cl_abap_unit_assert=>assert_equals(
      act = lo_add->get_sum_nums( 0 )
      exp = 0
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lo_add->get_sum_nums( 1 )
      exp = 1
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lo_add->get_sum_nums( 9 )
      exp = 45
    ).
    cl_abap_unit_assert=>assert_equals(
      act = lo_add->get_sum_nums( 3 )
      exp = 6
    ).
  ENDMETHOD.
ENDCLASS.
