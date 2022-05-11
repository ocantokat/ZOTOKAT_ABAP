*&---------------------------------------------------------------------*
*& Report ZOTOKATR_EXCEL_IMPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOTOKATR_EXCEL_IMPORT.

INCLUDE ZOTOKAT_EXCEL_IMPORT_V2_DEF.
INCLUDE ZOTOKAT_EXCEL_IMPORT_V2_FRM.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'
 EXPORTING
   FIELD_NAME          = 'P_FILE'
 IMPORTING
   FILE_NAME           = P_FILE
          .

START-OF-SELECTION.


PERFORM get_data.

*loop at gt_kayıt into gs_kayıt.
*write:/     sy-vline,
*(10) gs_kayıt-name, sy-vline,
*(10) gs_kayıt-surname, sy-vline,
*(10) gs_kayıt-phone_num, sy-vline,
*(10) gs_kayıt-mail, sy-vline.
*endloop.

PERFORM set_fcat.
PERFORM set_layout.
PERFORM display_alv.

CALL SCREEN 0100.
