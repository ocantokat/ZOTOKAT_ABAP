*&---------------------------------------------------------------------*
*& Include          ZOTOKAT_EXCEL_IMPORT_V2_FRM
*&---------------------------------------------------------------------*

FORM get_data .

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename    = p_file
      i_begin_col = '1'
      i_begin_row = '2'
      i_end_col   = '4'
      i_end_row   = '6'
    TABLES
      intern      = gt_kisi
*   EXCEPTIONS
*     INCONSISTENT_PARAMETERS       = 1
*     UPLOAD_OLE  = 2
*     OTHERS      = 3
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

*INTERNAL TABLE'I SÜTUNA VE SATIRA GÖRE SIRALAMA İŞLEMİ
  SORT gt_kisi BY row col.

*İLK SATIRIN İNDEXİNİ GETİRME
  READ TABLE gt_kisi INDEX 1.

*İlk çekilen kaydın indexini kaybetmemek için değişkene atalım.
  gd_crow = gt_kisi-row.

*Sonradan eklenen kayıtlar için öncesinde değerleri sıfırlayalım
  LOOP AT gt_kisi.

    IF gt_kisi-row <> gd_crow.
      APPEND gs_kayıt TO gt_kayit.
      CLEAR: gs_kayit.
      gd_crow = gt_kisi-row.
    ENDIF.

    IF gt_kisi-col EQ '0001'.
      gs_kayit-name = gt_kisi-value.
    ELSEIF gt_kisi-col EQ '0002'.
      gs_kayit-surname = gt_kisi-value.
    ELSEIF gt_kisi-col EQ '0003'.
      gs_kayit-phone_num = gt_kisi-value.
    ELSEIF gt_kisi-col EQ '0004'.
      gs_kayit-mail = gt_kisi-value.
    ENDIF.

  ENDLOOP.

  APPEND gs_kayit TO gt_kayit.








ENDFORM.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.



ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .



  CREATE OBJECT go_grid
    EXPORTING
      i_parent = cl_gui_container=>screen0 .

  CALL METHOD go_grid->set_table_for_first_display
  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
*    i_structure_name              = 'ZOTOKATT_EXCEL1'
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
      is_layout                     = gs_layout
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
    CHANGING
      it_outtab                     = gt_kayit
      it_fieldcatalog               = gt_fcat
*    it_sort                       =
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4
    .
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat .

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'NAME'.
  gs_fcat-coltext = 'İsim'.
  APPEND gs_fcat TO gt_fcat.
*
  CLEAR gs_fcat.
  gs_fcat-fieldname = 'SURNAME'.
  gs_fcat-coltext = 'Soy isim'.
  APPEND gs_fcat TO gt_fcat.


  CLEAR gs_fcat.
  gs_fcat-fieldname = 'PHONE_NUM'.
  gs_fcat-coltext = 'Tel. No'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR gs_fcat.
  gs_fcat-fieldname = 'MAIL'.
  gs_fcat-coltext = 'E-Mail'.
  APPEND gs_fcat TO gt_fcat.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .

  CLEAR: gs_layout.
  gs_layout-zebra = abap_true.

ENDFORM.
