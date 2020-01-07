CLASS zalgor_cl_stack_4_table DEFINITION
PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.

CLASS zalgor_cl_stack_4_table IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lt_i TYPE STANDARD TABLE OF i.
    DATA(lo_stack) = NEW lcl_stack( lt_i ).
    lo_stack->push( 9 ).

    out->write(
      EXPORTING
        data   = lo_stack->get_counter(  )
    ).
  ENDMETHOD.

ENDCLASS.
