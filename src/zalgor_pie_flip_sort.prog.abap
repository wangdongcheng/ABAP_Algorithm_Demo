*&---------------------------------------------------------------------*
*& Report ZALGOR_PIE_FLIP_SORT
*&---------------------------------------------------------------------*
*& 《编程之美》 1.3 一摞烙饼的排序
*&---------------------------------------------------------------------*
REPORT zalgor_pie_flip_sort.

CLASS lcl_flip_pies DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      is_sorted
        RETURNING
          VALUE(rv_bool) TYPE abap_bool,

      set_pies
        IMPORTING
          it_pies TYPE zalgor_int1_t, " Standard Type for INT1

      get_pies
        RETURNING
          VALUE(rt_pies) TYPE zalgor_int1_t,

      get_max_pie_position
        IMPORTING
          iv_from_index   TYPE i DEFAULT 1
          iv_to_index     TYPE i
        RETURNING
          VALUE(rv_index) TYPE i,

      flip
        IMPORTING
          iv_index       TYPE i
        RETURNING
          VALUE(rt_pies) TYPE zalgor_int1_t.

  PRIVATE SECTION.
    CLASS-DATA:
      pies TYPE STANDARD TABLE OF i.
ENDCLASS.

CLASS lcl_flip_pies IMPLEMENTATION.
  METHOD is_sorted.
    rv_bool = abap_false.
    DATA(lt_pies_copy) = pies.
    SORT lt_pies_copy.
    IF lt_pies_copy EQ pies.
      rv_bool = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD set_pies.
    pies = it_pies.
  ENDMETHOD.

  METHOD get_pies.
    CLEAR rt_pies.
    rt_pies = pies.
  ENDMETHOD.

  METHOD get_max_pie_position.
    CHECK iv_to_index LE lines( pies ).

    DATA max_pie TYPE i VALUE 0.
    LOOP AT pies ASSIGNING FIELD-SYMBOL(<lv_pie>) FROM iv_from_index TO iv_to_index.
      IF <lv_pie> GE max_pie.
        max_pie = <lv_pie>.
        rv_index = sy-tabix.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD flip.
    CHECK iv_index GT 0 AND
          iv_index LE lines( pies ) AND
          lines( pies ) GE 1.

    IF pies[ 1 ] NE pies[ iv_index ].
      DATA(lv_pie_tmp) = pies[ 1 ].
      pies[ 1 ] = pies[ iv_index ].
      pies[ iv_index ] = lv_pie_tmp.
    ENDIF.
    rt_pies = get_pies( ).

  ENDMETHOD.
ENDCLASS.

INCLUDE zalgor_pie_flip_sort_ut.
