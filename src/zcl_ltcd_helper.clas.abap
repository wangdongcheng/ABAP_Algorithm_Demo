class ZCL_LTCD_HELPER definition
  public
  final
  create public .

public section.

  class-methods STRING_TO_INT_ARRAY
    importing
      !IV_STR type STRING
    returning
      value(RT_NUMS) type ZALGOR_INT4_T .
  class-methods STRING_TO_INT_2D_ARRAY
    importing
      !IV_STR type STRING
    returning
      value(RT_NUMS_2D) type ZALGOR_INT4_T_T .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LTCD_HELPER IMPLEMENTATION.


  METHOD string_to_int_2d_array.
    CHECK iv_str IS NOT INITIAL.
    SPLIT iv_str AT ';' INTO TABLE DATA(lt_arr_str).

    LOOP AT lt_arr_str ASSIGNING FIELD-SYMBOL(<lv_arr_str>).
      SPLIT <lv_arr_str> AT ',' INTO TABLE DATA(lt_arr).
      APPEND lt_arr TO rt_nums_2d.
    ENDLOOP.
  ENDMETHOD.


  METHOD string_to_int_array.
    CHECK iv_str IS NOT INITIAL.
    SPLIT iv_str AT ',' INTO TABLE DATA(lt_nums).
    rt_nums = lt_nums.
  ENDMETHOD.
ENDCLASS.
