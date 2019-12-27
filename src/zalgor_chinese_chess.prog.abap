*&---------------------------------------------------------------------*
*& Report ZALGOR_CHINESE_CHESS
*&---------------------------------------------------------------------*
*& 《编程之美》 1.2 中国象棋将帅问题
*&
*& A: 1 - 2 - 3
*&    |   |   |
*&    4 - 5 - 6
*&    |   |   |
*&    7 - 8 - 9
*&
*& B: 1 - 2 - 3
*&    |   |   |
*&    4 - 5 - 6
*&    |   |   |
*&    7 - 8 - 9
*&---------------------------------------------------------------------*
REPORT zalgor_chinese_chess.

TYPES:
  BEGIN OF ts_relative_pos,
    a TYPE i,
    b TYPE i,
  END OF ts_relative_pos,
  tt_relative_pos TYPE STANDARD TABLE OF ts_relative_pos,

  ty_p            TYPE p DECIMALS 3.

CLASS lcl_chinese_chess DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
      get_relative_pos_01
        EXPORTING et_relative_pos TYPE tt_relative_pos,

      get_relative_pos_02
        EXPORTING et_relative_pos TYPE tt_relative_pos,

      main.

ENDCLASS.

CLASS lcl_chinese_chess IMPLEMENTATION.
  METHOD get_relative_pos_01.
    CLEAR et_relative_pos.

*-- This additional variable ET_RELATIVE_POS is involved here only for test
*-- The variable LS_RELATIVE_POS is the only one we actually need, we can write it in loop
*-- to meet the interview task requirement.

    DATA ls_relative_pos TYPE ts_relative_pos.
    ls_relative_pos-a = 1.
    ls_relative_pos-b = 1.

    DO 9 TIMES.
      DO 9 TIMES.
        IF ls_relative_pos-a MOD 3 NE ls_relative_pos-b MOD 3.
          APPEND ls_relative_pos TO et_relative_pos.
        ENDIF.
        ls_relative_pos-b = ls_relative_pos-b + 1.
      ENDDO.
      ls_relative_pos-b = 1.
      ls_relative_pos-a = ls_relative_pos-a + 1.
    ENDDO.

    SORT et_relative_pos BY a
                            b.
  ENDMETHOD.

  METHOD get_relative_pos_02.
    CLEAR et_relative_pos.

*-- The variable LV_COUNT is the only one we actually need
    DATA:
      lv_count        TYPE i VALUE 81,
      ls_relative_pos TYPE ts_relative_pos.

    WHILE lv_count GE 0.
      lv_count = lv_count - 1.
      IF floor( CONV ty_p( lv_count / 9 ) ) MOD 3 EQ lv_count MOD 9 MOD 3.
        CONTINUE.
      ENDIF.
      ls_relative_pos-a = floor( CONV ty_p( lv_count / 9 ) ) + 1.
      ls_relative_pos-b = lv_count MOD 9 + 1.
      APPEND ls_relative_pos TO et_relative_pos.

    ENDWHILE.

    SORT et_relative_pos BY a
                            b.
  ENDMETHOD.

  METHOD main.
    DATA: lt_relative_pos TYPE tt_relative_pos.

    lcl_chinese_chess=>get_relative_pos_01(
      IMPORTING
        et_relative_pos = lt_relative_pos ).

    LOOP AT lt_relative_pos ASSIGNING FIELD-SYMBOL(<ls_relative_pos>).
      cl_demo_output=>write( |A: { <ls_relative_pos>-a }, B: { <ls_relative_pos>-b }| ).
    ENDLOOP.

    cl_demo_output=>display( ).

  ENDMETHOD.
ENDCLASS.

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

START-OF-SELECTION.
  lcl_chinese_chess=>main( ).
