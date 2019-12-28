*&---------------------------------------------------------------------*
*& Include          ZALGOR_CHINESE_CHESS_UT
*&---------------------------------------------------------------------*

*-- UNIT TEST CLASS
CLASS lcl_ut DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
    CLASS-DATA gt_relative_pos_exp TYPE tt_relative_pos.

    CLASS-METHODS:
      get_relative_pos_expect.
    METHODS:
      get_relative_pos_01_ut FOR TESTING,
      get_relative_pos_02_ut FOR TESTING.
ENDCLASS.

CLASS lcl_ut IMPLEMENTATION.
  METHOD  get_relative_pos_expect.
    IF gt_relative_pos_exp IS INITIAL.
      gt_relative_pos_exp = VALUE #( a = 1
                                        ( b = 2 ) ( b = 3 )
                                        ( b = 5 ) ( b = 6 )
                                        ( b = 8 ) ( b = 9 )
                                     a = 2
                                        ( b = 1 ) ( b = 3 )
                                        ( b = 4 ) ( b = 6 )
                                        ( b = 7 ) ( b = 9 )
                                     a = 3
                                        ( b = 1 ) ( b = 2 )
                                        ( b = 4 ) ( b = 5 )
                                        ( b = 7 ) ( b = 8 )
                                     a = 4
                                        ( b = 2 ) ( b = 3 )
                                        ( b = 5 ) ( b = 6 )
                                        ( b = 8 ) ( b = 9 )
                                     a = 5
                                        ( b = 1 ) ( b = 3 )
                                        ( b = 4 ) ( b = 6 )
                                        ( b = 7 ) ( b = 9 )
                                     a = 6
                                        ( b = 1 ) ( b = 2 )
                                        ( b = 4 ) ( b = 5 )
                                        ( b = 7 ) ( b = 8 )
                                     a = 7
                                        ( b = 2 ) ( b = 3 )
                                        ( b = 5 ) ( b = 6 )
                                        ( b = 8 ) ( b = 9 )
                                     a = 8
                                        ( b = 1 ) ( b = 3 )
                                        ( b = 4 ) ( b = 6 )
                                        ( b = 7 ) ( b = 9 )
                                     a = 9
                                        ( b = 1 ) ( b = 2 )
                                        ( b = 4 ) ( b = 5 )
                                        ( b = 7 ) ( b = 8 )
                                   ).
    ENDIF.
  ENDMETHOD.

  METHOD get_relative_pos_01_ut.
    lcl_ut=>get_relative_pos_expect( ).
    lcl_chinese_chess=>get_relative_pos_01(
      IMPORTING
        et_relative_pos = DATA(lt_relative_pos_act)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_relative_pos_act     " Data object with current value
        exp                  = gt_relative_pos_exp     " Data object with expected type
    ).

  ENDMETHOD.

  METHOD get_relative_pos_02_ut.
    lcl_ut=>get_relative_pos_expect( ).
    lcl_chinese_chess=>get_relative_pos_02(
      IMPORTING
        et_relative_pos = DATA(lt_relative_pos_act)
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_relative_pos_act     " Data object with current value
        exp                  = gt_relative_pos_exp     " Data object with expected type
    ).

  ENDMETHOD.
ENDCLASS.
