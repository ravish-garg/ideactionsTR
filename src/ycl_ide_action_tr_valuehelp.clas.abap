CLASS ycl_ide_action_tr_valuehelp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sd_value_help_dsni.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_ide_action_tr_valuehelp IMPLEMENTATION.
  METHOD if_sd_value_help_dsni~get_value_help_items.
    DATA items TYPE STANDARD TABLE OF if_sd_value_help_dsni=>ty_named_item.

    CASE value_help_id.
      WHEN 'change_request'.
        " Define the available value help items
        items = VALUE #( ( name = 'Charles'   description = 'The King'  ) ##NO_TEXT
                         ( name = 'Elizabeth' description = 'Mother of Charles' ) ##NO_TEXT
                         ( name = 'Philip'    description = 'Father of Charles'  ) ##NO_TEXT
                         ( name = 'Camilla'   description = 'Wife of Charles'  ) ##NO_TEXT
                         ( name = 'William'   description = 'Son of Charles' ) ##NO_TEXT
                         ( name = 'Harry'     description = 'Son of Charles'  ) ) ##NO_TEXT.
      WHEN OTHERS.
    ENDCASE.
    " Delete items that doesn't match the search_pattern_range.
    DELETE items WHERE name NOT IN search_pattern_range.

    " Return the value help items
    result = VALUE #( items            = items
                      total_item_count = lines( items ) ).
  ENDMETHOD.

ENDCLASS.
