CLASS ycl_ide_action_tr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_aia_action .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_ide_action_tr IMPLEMENTATION.
  METHOD if_aia_action~run.
    TRY.
        DATA input TYPE ycl_ide_action_tr_input=>ty_input.
        context->get_input_config_content( )->get_as_structure( IMPORTING result = input ).
      CATCH cx_sd_invalid_data INTO DATA(exception). " TODO: variable is assigned but never used (ABAP cleaner)
        CLEAR input.
    ENDTRY.
    IF input-display_text IS INITIAL.
      RAISE EXCEPTION NEW cx_aia_static( textid = VALUE #( msgid = 'IDE_ACTIONS_DEMO'
                                                           msgno = '001'
                                                           attr1 = input-display_text ) ).
    ENDIF.

    " Create Transport using the XCO Library
*xco_cp_cts=>transports->workbench( iv_target = '')->create_request(
*  EXPORTING
*    iv_short_description = ''
**  RECEIVING
**    ro_request           =
*)..
    " Once TR is created, add the user as task owner.

    " Pass the created Transport number and Description to the user
    DATA(text_result) = cl_aia_result_factory=>create_text_popup_result( ).
    text_result->set_content( |Transport created| ).

    result = text_result.
  ENDMETHOD.
ENDCLASS.
