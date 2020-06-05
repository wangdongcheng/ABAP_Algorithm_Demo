*&---------------------------------------------------------------------*
*& Report ZALGOR_MATRIX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalgor_matrix.

TYPES:
  tt_i_2d TYPE STANDARD TABLE OF abadr_tab_int4 .

DATA lt_2d TYPE tt_i_2d.

APPEND VALUE abadr_tab_int4( ( 1 ) ( 2 ) ( 3 ) ) TO lt_2d.
APPEND VALUE abadr_tab_int4( ( 4 ) ( 5 ) ( 6 ) ) TO lt_2d.
APPEND VALUE abadr_tab_int4( ( 7 ) ( 8 ) ( 9 ) ) TO lt_2d.

DATA(i) = VALUE i( ).
i = 1.
DATA(j) = VALUE i( ).
j = 1.

WHILE i LE 3.
  j = 1.
  WHILE j LE 3.
    cl_demo_output=>write( lt_2d[  i  ][ j ] ).
    j = j + 1.
  ENDWHILE.
  i = i + 1.
ENDWHILE.

cl_demo_output=>display(  ).
