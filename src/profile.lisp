(progn
  (sb-profile:profile open-tetin-file
                      read-file-as-lines
                      make-instance
                      read-object
                      )
  (open-tetin-file "~/quicklisp/local-projects/ANSYS/mnas-ansys/tin/a32_GU.tin")
  (sb-profile:report)
  (sb-profile:reset)
  (sb-profile:unprofile))

;;;;  seconds  |     gc     |    consed   |  calls |  sec/call  |  name  
;;;;----------------------------------------------------------
;;;;     2.763 |      0.325 | 453,593,632 | 21,578 |   0.000128 | READ-OBJECT
;;;;     0.265 |      0.047 |  34,127,968 |      1 |   0.264999 | READ-FILE-AS-LINES
;;;;     0.000 |      0.000 |           0 |      1 |   0.000000 | OPEN-TETIN-FILE
;;;;----------------------------------------------------------
;;;;     3.028 |      0.372 | 487,721,600 | 21,580 |            | Total
;;;;
;;;;estimated total profiling overhead: 0.05 seconds
;;;;overhead estimation parameters:
;;;;  0.0s/call, 2.09e-6s total profiling, 8.4600003e-7s internal profiling
;;;;
;;;;These functions were not called:
;;;; MAKE-INSTANCE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  seconds  |     gc     |    consed   |  calls |  sec/call  |  name  
;;;;----------------------------------------------------------
;;;;    42.418 |      0.408 | 453,492,784 | 21,578 |   0.001966 | READ-OBJECT
;;;;     0.250 |      0.047 |  33,239,440 |      1 |   0.249999 | READ-FILE-AS-LINES
;;;;     0.000 |      0.000 |           0 |      1 |   0.000000 | OPEN-TETIN-FILE
;;;;----------------------------------------------------------
;;;;    42.668 |      0.455 | 486,732,224 | 21,580 |            | Total
;;;;
;;;;estimated total profiling overhead: 0.05 seconds
;;;;overhead estimation parameters:
;;;;  0.0s/call, 2.09e-6s total profiling, 8.4600003e-7s internal profiling
;;;;
;;;;These functions were not called:
;;;; MAKE-INSTANCE
