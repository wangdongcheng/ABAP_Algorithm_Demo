INTERFACE zalgor_if_tops
  PUBLIC .

  TYPES:
    tt_int    TYPE STANDARD TABLE OF i WITH EMPTY KEY,
    tt_int_2d TYPE STANDARD TABLE OF tt_int WITH EMPTY KEY.
ENDINTERFACE.
