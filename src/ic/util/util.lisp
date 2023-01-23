;;;; ./src/ic/util/util.lisp

(defpackage #:mnas-ansys/ic/util
  (:use #:cl)
  (:nicknames "IC/UTIL" "UTIL")
  (:export mess
           print-error-log
           write-file
           quit
           dialog
           question
           confirm
           yes-or-no
           multiple-choice
           multiple-choice-default
           pause
           batch-mode
           run-application-command
           run-application-batch
           run-application-exec
           exec
           run-application-direct
           remove-duplicate
           undo
           redo
           undo-group-begin
           undo-group-end
           undo-suspend
           undo-suspended
           undo-resume
           undo-start
           undo-stop
           undo-clear
           archive-dir
           unarchive-file
           stopwatch-start
           stopwatch-get-elapsed
           stopwatch-end
           list-uniquify
           list-remove-duplicated
           list-get-duplicated
           list-remove-from-grouped
           list-median
           chdir
           check-licensing-aienv
           reinit-geom-objects
           ic-error)
  (:documentation
   " Пакет предназначен для создания геометрии через API системы ANSYS ICEM CFD."
   ))

(in-package #:mnas-ansys/ic/util)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mess (message color)
  "Prints the given message to the message window or the standard
output if MED is being run in batch mode. There may be 1 or 2
arguments. The first is the string and the second if given is the
color to print the message in.
"
  (format
   t
   "ic_mess ~A ~A~%"
   message color))

(defun print-error-log (res)
  "Prints the error log res to the screen in red. If there are more
than 64 lines, they will all be saved to a temporary file such as the
default /tmp/ERROR_LOG0.tmp
"
  (format t
          "ic_print_error_log ~A~%" res))
  
(defun write-file (name text)
  "Creates a file with some stuff in it."
  (format t "ic_write_file ~A ~A~%" name text))

(defun quit ()
  "Quits (MED and save the current project settings.)"
  (format t "ic_quit"))
  

(defun dialog (args)
  "Calls the tk_dialog utility function."
  (format t "ic_dialog ~A~%" args))

(defun question (args)
  "Queries the user to input a string value."
  (format t "ic_question ~A~%" args))

(defun confirm (mess)
  "Presents a dialog with a message and one button that says OK that
just dismisses the dialog."
  (format t "ic_confirm ~A~%" mess))

(defun yes-or-no (mess)
  "Presents a dialog with a message and 2 buttons, which say Yes or
No. Returns 1 or 0 depending on which is pressed."
  (format t "ic_yes_or_no ~A~%" mess))


(defun multiple-choice (mess args)
  "Presents a dialog with a message and multiple buttons with the given
labels. Returns the ordinal of the one that is pressed."
  (format t "ic_multiple_choice ~A ~A~%" mess args))

(defun multiple-choice-default (default mess args)
  "Same as ic_multiple_choice but default gives the index of the
button that is to be the default button for the dialog. If less than
zero then there will not be any default button."
  (format t "ic_multiple_choice_default ~A ~A ~A~%" default mess args))


(defun pause (ms)
  "Waits for ms milliseconds, process regular Tk events, and then
returns."
  (format t "ic_pause ~A~%" ms))

(defun batch-mode ()
  "Checks (for batch mode.)"
  (format t "ic_batch_mode"))
 

(defun run-application-command (dir progdir progname arguments)
  "Runs some external application."
  (format t "ic_run_application_command ~A ~A ~A ~A~%" dir progdir progname arguments))

(defun run-application-batch (dir progdir progname envname arguments &key (logfile ""))
  "Runs some external application in batch mode"
  (format t "ic_run_application_batch ~A ~A ~A ~A ~A ~A~%" dir progdir progname envname arguments logfile))

(defun run-application-exec (dir progdir progname arguments)
  "Runs some external application, given the full path."
  (format t "ic_run_application_exec ~A ~A ~A ~A~%" dir progdir progname arguments))

(defun exec (args)
  "A simplified version of this."
  (format t "ic_exec ~A~%" args))

(defun run-application-direct (dir progdir progname envname arguments)
  "Runs an application."
  (format t "ic_run_application_direct ~A ~A ~A ~A ~A~%" dir progdir progname envname arguments))

(defun remove-duplicate (names)
  "Removes duplicates from list of names."
  (format t "ic_remove_duplicate ~A~%" names))

(defun undo ()
  " Undoes (the previous action.)"
  (format t "ic_undo~%"))

(defun redo ()
  " Redoes the previous undone action."
  (format t "ic_redo~%"))

(defun undo-group-begin (&optional (text "") (undo_group ""))
  "Sets undo group begin."
  (format t "ic_undo_group_begin ~A ~A~%" text undo_group))

(defun undo-group-end (&optional (text "") (undo_group ""))
  "Sets undo group end."
  (format t "ic_undo_group_end ~A ~A~2%" text undo_group))

(defun undo-suspend ()
  " Suspends undo logging."
  (format t "ic_undo_suspend~%"))

(defun undo-suspended ()
  " State of undo manager."
  (format t "ic_undo_suspended~%"))

(defun undo-resume ()
  "Resumes undo logging."
  (format t "ic_undo_resume~%"))

(defun undo-start ()
  "Starts undo handler; started by default."
  (format t "ic_undo_start~%"))

(defun undo-stop ()
  "Stops undo handler; removes undo log."
  (format t "ic_undo_stop~%"))

(defun undo-clear ()
  "Clears undo events and restarts undo log."
  (format t "ic_undo_clear~%"))

(defun archive-dir (dir archive)
  "Allows you to tar and gzip the directory dir as archive."
  (format t "ic_archive_dir ~A ~A~%" dir archive))

(defun unarchive-file (file dest)
  "Allows you to untar and gunzip the archive file in directory dest."
  (format t "ic_unarchive_file ~A ~A~%" file dest))

(defun stopwatch-start ()
  "Starts a stopwatch, in milliseconds."
  (format t "ic_stopwatch_start~%"))

(defun stopwatch-get-elapsed (&optional (stop_the_watch 0))
  "Gets the elapsed time, in milliseconds, since start of the
stopwatch. Optional argument stop_the_watch will also stop the watch."
  (format t "ic_stopwatch_get_elapsed ~A~%" stop_the_watch))

(defun stopwatch-end ()
  "Stops the current stopwatch."
  (format t "ic_stopwatch_end~%"))

(defun list-uniquify (list)
  "Uniquifies given TCL list list. Note that this function returns the
list sorted."
  (format t "ic_list_uniquify list ~A~%" list))

(defun list-remove-duplicated (list)
  "For every non-unique element in given TCL list list, remove all
instances. Note that this function returns the list sorted."
  (format t "ic_list_remove_duplicated ~A~%" list))

(defun list-get-duplicated (list)
  "This returns the duplicated items in a list"
  (format t "ic_list_get_duplicated ~A~%" list))

(defun list-remove-from-grouped (groups orig)
  "Takes a list of groups and an original list and returns items in orig
that are not in groups "
  (format t "ic_list_remove_from_grouped ~A ~A~%" groups orig))

(defun list-median (list)
  "Gets the median in the list."
  (format t "ic_list_median ~A~%" list))

(defun chdir (dir)
  "Changes working directory."
  (format t "ic_chdir ~A~%" dir))

(defun check-licensing-aienv ()
  "Checks to see if ai*env licensing is enabled."
  (format t "ic_check_licensing_aienv~%"))

(defun reinit-geom-objects (&optional (all ""))
  "Redefines graphics for geometry."
  (format t "ic_reinit_geom_objects ~A~%" all))

(defun ic-error ()
  "For testing."
  (format t "ic_error"))
