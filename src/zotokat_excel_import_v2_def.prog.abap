*&---------------------------------------------------------------------*
*& Include          ZOTOKAT_EXCEL_IMPORT_V2_DEF
*&---------------------------------------------------------------------*

DATA: gt_kisi like alsmex_tabline occurs 0 WITH HEADER LINE.

TYPES: BEGIN OF gty_kisi,
       name LIKE gt_kisi-value,
       surname LIKE gt_kisi-value,
       phone_num LIKE gt_kisi-value,
       mail LIKE gt_kisi-value,
       END OF gty_kisi
       .

DATA: gt_kayit TYPE TABLE OF gty_kisi,
      gs_kayit TYPE gty_kisi.

DATA: gd_crow TYPE i.

PARAMETERS: p_file like rlgrap-filename.

DATA: go_grid TYPE REF TO cl_gui_alv_grid.
DATA: go_container TYPE REF TO cl_gui_custom_container.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.
