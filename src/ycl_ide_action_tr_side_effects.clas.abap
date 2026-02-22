CLASS ycl_ide_action_tr_side_effects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_sd_determination,
      if_sd_feature_control.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_ide_action_tr_side_effects IMPLEMENTATION.
  METHOD if_sd_determination~run.
    "Optional: read additional parameters via the context.
    IF context IS INSTANCE OF cl_aia_sd_context.
      FINAL(action_context) = CAST cl_aia_sd_context( context )->get_ide_action_context(  ).
    ENDIF.

    " Retrieve the model with data
    DATA(input_data) = VALUE ycl_ide_action_tr_input=>ty_input( ).
    model->get_as_structure( IMPORTING result = input_data ).

    "Update the User generated description in the following format
    "<Change_Request>:<Module_ID>:<User Text>
    input_data-display_text = |{ to_uppeR( input_data-change_request ) }:{ to_upper( input_data-module )  }:{ input_data-text }|.

    " Return the changed model
    result = input_data.
  ENDMETHOD.

  METHOD if_sd_feature_control~run.
    " Retrieve the model
    DATA(input) = VALUE ycl_ide_action_tr_input=>ty_input( ).
    model->get_as_structure( IMPORTING result = input ).

    " Create the initial feature control
    DATA(feature_control) = feature_control_factory->create_for_data( input ).
    "Do nothing here as no dynamic feature control is required

    RETURN feature_control.
  ENDMETHOD.

ENDCLASS.
