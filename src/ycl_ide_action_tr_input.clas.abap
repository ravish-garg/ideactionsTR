CLASS ycl_ide_action_tr_input DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_aia_sd_action_input .
    TYPES  module_id TYPE c LENGTH 3.
    "Enum values for Module ID
    CONSTANTS: BEGIN OF modules,
                 "! <p class="shorttext">Sales & Dist</p>
                 sales      TYPE module_id VALUE 'SD',
                 "! <p class="shorttext">Human Resources</p>
                 hr         TYPE module_id VALUE 'HR',
                 "! <p class="shorttext">Material Management</p>
                 purchasing TYPE module_id VALUE 'MM',
                 "! <p class="shorttext">Basis</p>
                 basis      TYPE module_id VALUE 'X',
               END OF modules.
    "Max Length catering to sxco_ar_short_description

    "! <p class="shorttext">Transport Attributes</p>
    TYPES :BEGIN OF ty_input,
             "! <p class="shorttext">Change Request</p>
             "!  "! $required
             "! $maxLength 10
             change_request TYPE c LENGTH 10,
             "! $values { @link ycl_ide_action_tr_input.data:modules }
             "! $default { @link ycl_ide_action_tr_input.data:modules.sales }
             "!  "! $required
             "! $maxLength 3
             module         TYPE c LENGTH 3,
             "! $required
             "! $minLength 5
             "! $maxLength 47
             text           TYPE c LENGTH 47,
             display_text   TYPE sxco_ar_short_description,
           END OF ty_input.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_ide_action_tr_input IMPLEMENTATION.
  METHOD if_aia_sd_action_input~create_input_config.
    DATA input TYPE ty_input.

    " Create configuration for the UI
    DATA(configuration) = ui_information_factory->get_configuration_factory( )->create_for_data( input ).

    " Get Elements and set UI Attributes

    " Set the Title
*    configuration->get_structure( 'input' )->set_title( 'Transport Attributes' ).

    " Get element reference for Transport Display Text
    DATA(lo_element) = configuration->get_element( 'display_text' ).
    " Set the generated Transport description to read-only
    lo_element->set_read_only( ).
    " Set Title
    lo_element->set_title( 'Transport Description' ).

    " Get element reference for CHange Request
    lo_element = configuration->get_element( 'change_request' ).
    " Set Value Help for Change Request Field to custom value help provider
    lo_element->set_values( if_sd_config_element=>values_kind-domain_specific_named_items ).
    " Title is set via the in-line annotation on data declaration
    "lo_element->set_title( 'Change Request' ).
    " Set side effect on the Field to trigger update generated description
    lo_element->set_sideeffect( after_update = abap_true ).

    " Get element reference for Module ID
    lo_element = configuration->get_element( 'module' ).
    " Set Title for Module Reference
    lo_element->set_title( 'Module ID' ).
    " Set Value Help for Module field

    " Set side effect on the Field to trigger update generated description
    lo_element->set_sideeffect( after_update = abap_true ).

    " Get element reference for User Text
    lo_element = configuration->get_element( 'text' ).
    " Set title
    lo_element->set_title( 'Description' ).
    " Set side effect on the Field to trigger update generated description
    lo_element->set_sideeffect( after_update = abap_true ).

    result = ui_information_factory->for_abap_type( abap_type     = input
                                                    configuration = configuration ).
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_action_provider.
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_side_effect_provider.
    " Return a reference to  side effect handlers via the side effect provider
    result = cl_sd_sideeffect_provider=>create( feature_control = NEW ycl_ide_action_tr_side_effects( )
                                                determination   = NEW ycl_ide_action_tr_side_effects( ) ).
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_value_help_provider.
    " Return a reference to value help handler via the value help provider
    result = cl_sd_value_help_provider=>create( value_help_handler_dsni = NEW ycl_ide_action_tr_valuehelp( ) ).
  ENDMETHOD.
ENDCLASS.
