*&---------------------------------------------------------------------*
*& Report ZALGOR_LC0001
*&---------------------------------------------------------------------*
*& 1. Two Sum
*& Given an array of integers, return indices of the two numbers such that they add up to a specific target.
*&
*& You may assume that each input would have exactly one solution, and you may not use the same element twice.
*&
*& Example:
*&
*& Given nums = [2, 7, 11, 15], target = 9,
*&
*& Because nums[0] + nums[1] = 2 + 7 = 9,
*& return [0, 1].
*&---------------------------------------------------------------------*
REPORT zalgor_ltcd_0001.

TYPES:
  tt_nums TYPE STANDARD TABLE OF i,
  BEGIN OF ts_ret,
    a TYPE i,
    b TYPE i,
  END OF ts_ret,
  BEGIN OF ts_map,
    key TYPE i,
    val TYPE i,
  END OF ts_map,
  tt_map_st TYPE SORTED TABLE OF ts_map WITH UNIQUE KEY key.

CLASS lcl_sol DEFINITION.
  PUBLIC SECTION.
    METHODS:
      two_sum
        IMPORTING
          it_nums       TYPE tt_nums
          iv_target     TYPE i
        RETURNING
          VALUE(rs_ret) TYPE ts_ret.
ENDCLASS.

CLASS lcl_sol IMPLEMENTATION.
  METHOD two_sum.
    DATA lt_map TYPE tt_map_st.
    LOOP AT it_nums ASSIGNING FIELD-SYMBOL(<ls_nums>).
      DATA(lv_idx) = sy-tabix.
      TRY.
          rs_ret = VALUE #( a = lt_map[ key = iv_target - <ls_nums> ]-val
                            b = lv_idx ).
          RETURN.
        CATCH cx_sy_itab_line_not_found.
          INSERT VALUE #( key = <ls_nums>
                          val = lv_idx ) INTO TABLE lt_map.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_ut DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    METHODS:
      ut_two_sum FOR TESTING.
ENDCLASS.

CLASS lcl_ut IMPLEMENTATION.
  METHOD ut_two_sum.
    DATA(lt_nums) = zalgor_cl_ltcd_helper=>string_to_int_array( |2,7,11,15,18| ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = NEW lcl_sol( )->two_sum( it_nums = lt_nums
                                                        iv_target = 18 )  " Data object with current value
        exp                  = VALUE ts_ret( a = 2 b = 3 )   " Data object with expected type
    ).

    lt_nums = zalgor_cl_ltcd_helper=>string_to_int_array( |3,22,6,15,34,56,66| ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = NEW lcl_sol( )->two_sum( it_nums = lt_nums
                                                        iv_target = 40 )  " Data object with current value
        exp                  = VALUE ts_ret( a = 3 b = 5 )   " Data object with expected type
    ).

    lt_nums = zalgor_cl_ltcd_helper=>string_to_int_array( |1,3,0,6,-1,34,56,66| ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = NEW lcl_sol( )->two_sum( it_nums = lt_nums
                                                        iv_target = 65 )  " Data object with current value
        exp                  = VALUE ts_ret( a = 5 b = 8 )   " Data object with expected type
    ).
  ENDMETHOD.
ENDCLASS.
