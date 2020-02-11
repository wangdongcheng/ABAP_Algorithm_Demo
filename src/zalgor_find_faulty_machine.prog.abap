*&---------------------------------------------------------------------*
*& Report ZALGOR_FIND_FAULTY_MACHINE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalgor_find_faulty_machine.

*-- Machine
CLASS lcl_machine DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_guid TYPE guid_16 OPTIONAL,

      get_guid
        RETURNING VALUE(rv_guid) TYPE guid_16.

  PRIVATE SECTION.
    DATA:
      machine_id_guid TYPE guid_16.

ENDCLASS.

CLASS lcl_machine IMPLEMENTATION.
  METHOD constructor.
    IF iv_guid IS SUPPLIED.
      machine_id_guid = iv_guid.
    ELSE.
      TRY .
          machine_id_guid = cl_system_uuid=>if_system_uuid_static~create_uuid_x16( ).
        CATCH cx_uuid_error.
          RETURN.
      ENDTRY.
    ENDIF.
  ENDMETHOD.

  METHOD get_guid.
    rv_guid = machine_id_guid.
  ENDMETHOD.
ENDCLASS.

TYPES:
  gtt_machines TYPE STANDARD TABLE OF REF TO lcl_machine.

*-- Machines
CLASS lcl_machines DEFINITION.
  PUBLIC SECTION.
    METHODS:
      add_machine
        IMPORTING
          iv_guid TYPE guid_16 OPTIONAL,

      get_machines
        EXPORTING et_machines TYPE gtt_machines,

      get_machine
        IMPORTING
                  iv_index          TYPE i
        RETURNING VALUE(ro_machine) TYPE REF TO lcl_machine,

      check_machines
        RETURNING VALUE(rv_guid) TYPE guid_16.

  PRIVATE SECTION.
    DATA:
          lt_machines TYPE gtt_machines.
ENDCLASS.

CLASS lcl_machines IMPLEMENTATION.
  METHOD add_machine.
    IF iv_guid IS SUPPLIED.
      DATA(lo_machine) = NEW lcl_machine( iv_guid ).
    ELSE.
      lo_machine = NEW lcl_machine( ).
    ENDIF.

    APPEND lo_machine TO me->lt_machines.

  ENDMETHOD.

  METHOD get_machines.
    CLEAR et_machines.
    et_machines = lt_machines.
  ENDMETHOD.

  METHOD get_machine.
    CHECK iv_index GE 1 AND
          iv_index LE lines( me->lt_machines ).
    TRY.
        ro_machine = me->lt_machines[ iv_index ].
      CATCH cx_sy_itab_line_not_found .

    ENDTRY.

  ENDMETHOD.

  METHOD check_machines.
    CHECK lines( lt_machines ) GE 2.

    LOOP AT lt_machines ASSIGNING FIELD-SYMBOL(<lo_machine>).
      rv_guid = rv_guid BIT-XOR <lo_machine>->get_guid( ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

INCLUDE zalgor_find_faulty_machine_ut.
