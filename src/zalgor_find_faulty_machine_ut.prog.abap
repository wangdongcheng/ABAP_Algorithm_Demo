*&---------------------------------------------------------------------*
*& Include          ZALGOR_FIND_FAULTY_MACHINE_UT
*&---------------------------------------------------------------------*

CLASS lcl_ut DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      setup,
      ut_01 FOR TESTING.
    CLASS-DATA:
      obj_machines TYPE REF TO lcl_machines,
      missing_idx  TYPE i.

ENDCLASS.

CLASS lcl_ut IMPLEMENTATION.
  METHOD setup.
    DATA:
      lv_timestp     TYPE timestamp.

* use timestamp to randomly miss one machine
    GET TIME STAMP FIELD lv_timestp.
    missing_idx = substring( val = |{ lv_timestp }|
                             off = 12
                             len = 2 ).

    obj_machines = NEW lcl_machines( ).

    DO 100 TIMES.
      lcl_ut=>obj_machines->add_machine( ).
    ENDDO.

    obj_machines->get_machines(
      IMPORTING
        et_machines = DATA(lt_machines)
    ).

*-- Deliberately miss one machine here
    DELETE lt_machines INDEX missing_idx.

    LOOP AT lt_machines ASSIGNING FIELD-SYMBOL(<lo_machine>).
      lcl_ut=>obj_machines->add_machine( <lo_machine>->get_guid( ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD ut_01.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lcl_ut=>obj_machines->check_machines( )                       " Data object with current value
        exp = lcl_ut=>obj_machines->get_machine( missing_idx )->get_guid( ) " Data object with expected type
    ).
  ENDMETHOD.

ENDCLASS.
