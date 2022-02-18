;;;; ./src/icem/translation.lisp

(defpackage #:mnas-ansys/icem/translation
  (:use #:cl)
  (:export ic_trans_ddn_tetin
           ic_trans_ug_tetin
           ic_trans_gems_tetin
           ic_trans_tetin_ddn
           ic_trans_tetin_brepxml
           ic_trans_iges_ddn
           ic_trans_iges_tetin
           ic_trans_ddn_iges
           ic_trans_ddn_tvda
           ic_trans_tvda_ddn
           ic_trans_ddn_dxf
           ic_trans_dxf_ddn
           ic_trans_idi_tetin
           ic_trans_proe_tetin_protcl
           ic_trans_read_esf_file
           ic_trans_acis_tetin
           ic_trans_dwg_tetin
           ic_trans_anf_tetin
           ic_trans_step_tetin
           ic_trans_tetin_step
           ic_trans_ps_tetin
           ic_trans_tetin_ps
           ic_wb_brep_read
           ic_wb_brep_load
           ic_wb_brep_attach
           ic_trans_cos_ccl
           )
  (:documentation
   " Пакет содержит функции преобразования (перевода, экспорта-импорта)."
   ))

(in-package #:mnas-ansys/icem/translation)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_trans_ddn_tetin (ddn tetin)
  " 
Transfers the given DDN part file into the named tetin file.
"
  (format t
          "ic_trans_ddn_tetin ~S ~S~%" ddn tetin))

(defun ic_trans_ug_tetin (prt tetin &optional (mode "ug_default") (usr_script "")  (usr_opts ""))
  "
Transfers the given Unigraphics part file into the named tetin file. 

prt path to UG part 
tetin path to new Tetin name 
mode translation mode
ug_default -- same output as interactive interface

named -- output only named entities

levels -- output all entities; levels mapped to families

user -- run user supplied script
 
usr_script custom script supplied by user 
usr_opts options supplied for user script  

For example usage, refer to ic_trans_ug_tetin.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t
          "ic_trans_ug_tetin ~S ~S ~S ~S ~S~%" prt tetin mode usr_script usr_opts))

(defun ic_trans_gems_tetin (prt &optional (tetin "") (tol 0.0001) (isRel 1))
  "
Transfers the given GEMS surface file into the named tetin file.

prt the GEMS file 
tetin the output file, defaults to a filename derived from the gems filename, prt. 
tol specifies the tetin triangulation tolerance. defaults to 0.0001 
isRel when set, the triangulation tolerance is scaled by the part radius, defaults to 1. 

For example usage, refer to ic_trans_gems_tetin.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t
          "ic_trans_gems_tetin ~S ~S ~S ~S~%" prt tetin tol isRel))

(defun ic_trans_tetin_ddn (tetin iparta &optional (pname "") (units "-mm"))
  "
Transfers the given tetin file into the named DDN part file. 

tetin tetin file 
iparta DDN IPARTA file  
pname DDN Part Name 
units units flag 

Notes: 

If the pname argument is given, that is used for the part name. Otherwise the name of the tetin file is used.

The units flag may take on the following values: 

-mm (default) millimeters  
-inches  inches 
-feet inches/feet 

DDN likes IPARTA files to reside in a directory called parts.

For example usage, refer to ic_trans_tetin_ddn.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"

  (format t
          "ic_trans_tetin_ddn ~S ~S ~S ~S~%" tetin iparta pname units))

(defun ic_trans_tetin_brepxml (tetin brepxmlfile &optional  (light_export ""))
  " Transfers the given tetin file into the named DesignSpace BrepXML
file. If the brepxmlfile argument is given that is used for the part
name. Else the name of the tetin file is used. If light_export is
specified, then the graphics only BrepXML file is written.
"

  (format t
          "ic_trans_tetin_brepxml ~S ~S ~S~%" tetin brepxmlfile light_export))

(defun ic_trans_iges_ddn (igesfile ddnpart ddnfile &optional (dir_file "default") (dir_file_user "") (data_red 0) (listing_file "") (run_icempt 0) (trans_dos 0))
  " Transfers the given IGES file igesfile into the DDN file
ddnpart. The type of directive file dir_file may be one of none,
default, catia or user, among which default is the default; it if is
user then must be specified. You may also specify data reduction
data_red, a listing file listing_file, the option to run icempt
run_icempt after the translation, and the option to translate DOS text
trans_dos.
"
  (format t
          "ic_trans_iges_ddn ~S ~S ~S ~S ~S ~S ~S ~S ~S~%"
          igesfile ddnpart ddnfile dir_file dir_file_user data_red listing_file run_icempt trans_dos ))

(defun ic_trans_iges_tetin (igesfile tetinfile &optional (dir_file "default") (dir_file_user "") (data_red 0) (list_file "") (run_icempt 0) (trans_dos 0))
  " Transfers the given IGES file igesfile into the tetin file
tetinfile. The type of directive file dir_file may be one of none,
default, catia or user, among which default is the default; it if is
user then must be specified. You may also specify data reduction
data_red, a listing file listing_file, the option to run icempt
run_icempt after the translation, and the option to translate DOS text
trans_dos.
"
  (format t
          "ic_trans_iges_tetin ~S ~S ~S ~S ~S ~S ~S ~S~%"
          igesfile tetinfile dir_file dir_file_user data_red list_file run_icempt trans_dos))
  
(defun ic_trans_ddn_iges (ddn_file iges_name &optional (listing_file "") (dir_file ""))
  " 
Trasnfers the given DDN part file ddn_file to the IGES file
iges_name. The listing file listing_file will be saved if specified,
and the directive file dir_file if specified.
"
  (format t
          "ic_trans_ddn_iges ~S ~S ~S ~S~%" ddn_file iges_name listing_file dir_file))


(defun ic_trans_ddn_tvda (infile outfile selected &optional (tvda_dir "") (tvda_list ""))
  " Transfers the given DDN part infile to the TVDA file outfile. The
DDN selected partname selected is specified for the directive file
created. The directive file tvda_dir is optional, as is the output
list file tvda_list.
"

  (format t
          "ic_trans_ddn_tvda ~S ~S ~S ~S ~S~%" infile outfile selected tvda_dir tvda_list))


(defun ic_trans_tvda_ddn (infile outfile &optional ( tvda_dir "") (tvda_list ""))
  "
Transfers the given TVDA file infile to the DDN part file outfile. The
directive file tvda_dir is optional, as is the output list file
tvda_list.
"

  (format t
          "ic_trans_tvda_ddn ~S ~S ~S ~S~%" infile outfile tvda_dir tvda_list))

(defun ic_trans_ddn_dxf (file outfile &optional (dxf_list "" ) (directive_file ""))
  " 
Transfers the DDN part file file to the DXF file outfile. The DXF
listing file dxf_list may be specified and the directive file
directive_file may also be specified.
"
  (format t
          "ic_trans_ddn_dxf ~S ~S ~A ~A~% " file outfile dxf_list directive_file))


(defun ic_trans_dxf_ddn (infile file &optional (dxf_list "")(directive_file ""))
  " Transfer the DXF file infile to the DDN part file file. The DXF
listing file dxf_list may be specified and the directive file
directive_file may also be specified."

  (format t
          "ic_trans_dxf_ddn ~S ~S ~S ~S~$" infile file dxf_list directive_file))

(defun ic_trans_idi_tetin (prt &optional (tetin "") (tol 0.0001) (isRel 1) (idi_options ""))
  "
Transfers the given IDI surface file into the named tetin file.

prt the IDI file 
tetin the output file, defaults to a filename derived from the idi filename, prt. 

For example usage, refer to ic_trans_idi_tetin.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t
          "ic_trans_idi_tetin (prt &optional (tetin "") (tol 0.0001) (isRel 1) (idi_options ""))"))


(defun ic_trans_proe_tetin_protcl (prt &optional (tetin ""))
  "
Transfers the given Creo Parametric part file into the named tetin file.

prt the Creo Parametric file 
tetin the output file, defaults to a filename derived from the Creo Parametric filename, prt. 

For example usage, refer to ic_trans_proe_tetin.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.

Automatically uses the part file to generate the tetin file.
"
  (format t
          "ic_trans_proe_tetin_protcl ~S ~S~%" prt tetin))

(defun ic_trans_read_esf_file (prt &optional (do_tri 0) (fam ""))
  "
Imports an External Scan File.

prt ESF file to read 
fam name of family containing created surfaces 
return list of created surfaces 

Notes: 

If the fam parameter is omitted, a family will be created for each surface.

For example usage, refer to ic_trans_read_esf_file.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t
          "ic_trans_read_esf_file ~S ~S ~S~%" prt do_tri fam))


(defun ic_trans_acis_tetin (acisfile outfile)
  "
Imports an ACIS SAT File.

acisfile the SAT file 
outfile the tetin output file 

--------------------------------------------------------------------------------
Note:   For example usage, refer to ic_trans_acis_tetin.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
--------------------------------------------------------------------------------
"
  (format t
          "ic_trans_acis_tetin ~S ~S~%" acisfile outfile))


(defun ic_trans_dwg_tetin (dwgfile outfile)
  "
Imports a DWG file.

dwgfile the DWG file 
outfile the tetin output file 

--------------------------------------------------------------------------------
Note:   For example usage, refer to ic_trans_dwg_tetin.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
--------------------------------------------------------------------------------
"

  (format t
          "ic_trans_dwg_tetin ~S ~S~%" dwgfile outfile))


(defun ic_trans_anf_tetin (anffile outfile)
  "
Imports an ANF file.

anffile the ANF file  
outfile the tetin output file 

--------------------------------------------------------------------------------
Note: For example usage, refer to ic_trans_anf_tetin.tcl in the ANSYS
installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
--------------------------------------------------------------------------------
"
  (format t
          "ic_trans_anf_tetin ~S ~S~% " anffile outfile))

(defun ic_trans_step_tetin (infile outfile &optional (facet 0) (tolarg "") (stepver 0) (args ""))
  "
Import STEP or IGES file.

infile a STEP or IGES file 
outfile the TETIN output file 
facet == 1 - Import as faceted geometry == 0 - Import as spline geometry 

--------------------------------------------------------------------------------
Note: For example usage, refer to ic_trans_step_tetin.tcl in the ANSYS
installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
--------------------------------------------------------------------------------
"
  (format t
          "ic_trans_step_tetin ~S ~S ~S ~S ~S ~S~%" infile outfile facet tolarg stepver args))

  
  
(defun ic_trans_tetin_step (infile outfile &optional (tolarg ""))
  "
Exports STEP or IGES file.

infile the tetin file 
outfile the STEP or IGES file 

Notes:

The type of output (i.e. step or iges) is determined by the extension (i.e. .stp or .igs) of the output file
"
  (format t
          "ic_trans_tetin_step ~S ~S ~A~%" infile outfile tolarg))

(defun ic_trans_ps_tetin (infile outfile &optional (units "meter"))
  "
Imports a Parasolid file.

infile a Parasolid file 
outfile the tetin output file 

--------------------------------------------------------------------------------
Note: For example usage, refer to ic_trans_ps_tetin.tcl in the ANSYS
installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
--------------------------------------------------------------------------------
"
  (format t
          "ic_trans_ps_tetin ~S ~S ~S~%" infile outfile units))

(defun ic_trans_tetin_ps (infile outfile)
  "
Exports a Parasolid file. 

infile the tetin file 
outfile the Parasolid file 

--------------------------------------------------------------------------------
Note: For example usage, refer to ic_trans_tetin_ps.tcl in the ANSYS
installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
--------------------------------------------------------------------------------
"
  (format t
          "ic_trans_tetin_ps ~S ~S~%" infile outfile))


(defun ic_wb_brep_read (prt &optional (make_absolute_paths 1) (merge 0) (mesh 0) (subset 0) (geom 1) (executable 0))
  "
Imports an ANSYS Workbench model.
"
  (format t
          "ic_wb_brep_read ~S ~S ~S ~S ~S ~S ~S~%"
          prt make_absolute_paths merge mesh subset geom executable))


(defun ic_wb_brep_load (&optional (load_file "") (module_name "") (doUpdate 0) (assemId "0xFFFFFFFF"))
  "
Imports a ANSYS Workbench model Returns 1 if build topology is required as a postprocessing step. Returns 0 otherwise.
"
  (format t
          "ic_wb_brep_load ~S ~S ~S ~S~%" load_file module_name doUpdate assemId))


(defun ic_wb_brep_attach (&optional (load_file ""))
  "
Attach to an ANSYS Workbench model.
"
  (format t
          "ic_wb_brep_attach ~S~%" load_file))

(defun ic_trans_cos_ccl (file)
  "
Saves the coordinate system to a CFX Command Language (CCL) file.
"
  (format t
          "ic_trans_cos_ccl ~S~%" file))

