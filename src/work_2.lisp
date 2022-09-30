(in-package #:mnas-ansys/utils)
"Z:/_namatv/CFX/n70/cfx/cfx_N70_prj_01_Ne_10_Tair_0.cfx"

(defparameter *C* '("B AIR_RL_OUT N2 D_10.000" "B AIR_SL_OUR D_09.500" "C C_1_2 X_049.5 D_00.850" "C C_1_2 X_049.5 D_00.850 2" "C C_1_2 X_071.5 D_01.250" "C C_1_2 X_071.5 D_01.250 2" "C C_1_2 X_085.0 L D_01.250" "C C_1_2 X_085.0 L D_01.250 2" "C C_1_2 X_085.0 R D_01.250" "C C_1_2 X_085.0 R D_01.250 2" "C C_1_2 X_093.5 D_01.250" "C C_1_2 X_093.5 D_01.250 2" "C C_1_2 X_115.5 D_01.250" "C C_1_2 X_115.5 D_01.250 2" "C C_1_2 X_137.5 D_01.250" "C C_1_2 X_137.5 D_01.250 2" "C C_1_2 X_159.5 D_01.250" "C C_1_2 X_159.5 D_01.250 2" "C C_1_2 X_181.5 D_00.850" "C C_1_2 X_181.5 D_00.850 2" "C C_1_2 X_203.5 D_00.850" "C C_1_2 X_203.5 D_00.850 2" "C C_1_2 X_227.5 D_00.850" "C C_1_2 X_227.5 D_00.850 2" "C C_1_2 X_251.5 D_00.850" "C C_1_2 X_251.5 D_00.850 2" "C C_1_2 X_275.5 D_00.800" "C C_1_2 X_275.5 D_00.800 2" "C C_1_2 X_376.5 D_08.500" "C C_1_2 X_376.5 D_08.500 2" "C C_1_2 X_416.5 D_01.05" "C C_1_2 X_416.5 D_01.05 2" "C C_1_2 X_451.5 D_01.250" "C C_1_2 X_451.5 D_01.250 2" "C C_1_2 X_481.5 D_01.500" "C C_1_2 X_481.5 D_01.500 2" "C C_1_3 C_1_3_2 D_06.000" "C C_1_4 C_1_4_1 D_06.000" "C C_1_5 C_1_5_1 D_04.000" "C C_1_5 C_1_5_1 D_04.000 2" "C C_6_6 C_6_6_L D_08.000 2" "C C_6_6 C_6_6_R D_08.000 2" "GAS_O GAS_OUT" "GT HOLES X_049.5 D_00.850" "GT HOLES X_071.5 D_01.250" "GT HOLES X_083.8 D_01.250" "GT HOLES X_093.5 D_01.250" "GT HOLES X_115.5 D_01.250" "GT HOLES X_137.5 D_01.050" "GT HOLES X_159.5 D_01.050" "GT HOLES X_181.5 D_00.850" "GT HOLES X_203.5 D_00.800" "GT HOLES X_227.5 D_00.850" "GT HOLES X_251.5 D_00.850" "GT HOLES X_275.5 D_00.800" "GT HOLES X_376.5 D_08.500" "GT HOLES X_416.5 D_01.050" "GT HOLES X_451.5 D_01.250" "GT HOLES X_481.5 D_01.500" "GT IN OUTER D_02.00" "GT IN OUTER D_04.000" "GT IN PP_L D_01.000" "GT IN PP_L D_02.000" "GT IN PP_L D_04.000" "GT IN PP_R D_01.000" "GT IN PP_R D_04.000" "GT IN WALL D_04.000" "GT IN WALL D_08.000" "GT OUT FIX D_02.000" "GT OUT FIX D_04.000" "GT OUT FIX D_08.000" "GT OUT FIX D_16.000" "GT OUT PP_L WALL D_04.000" "GT OUT TUBE WALL D_02.000" "GT OUT TUBE WALL D_04.000" "GT OUT TUBE WALL D_08.000" "GT OUT TUBE WALL D_16.000" "GT TOR D_02.000" "GU COOL_1 HOLES D_01.200" "GU COOL_1 HOLES D_01.500" "GU COOL_1 HOLES D_06.000" "GU COOL_1 WALL IN D_04.000" "GU COOL_1 WALL OUT D_04.000" "GU COOL_2 IN WALL D_04.000" "GU COOL_2 IN WALL D_16.000" "GU COOL_2 OUT HOLES D_01.500" "GU COOL_2 OUT HOLES D_04.000" "GU COOL_2 OUT WALL D_02.000" "GU COOL_2 OUT WALL D_04.000" "GU COOL_2 OUT WALL D_16.000" "GU G1 HOLES D_00.520" "GU G1 HOLES D_01.600" "GU G2 HOLES D_00.600" "GU G2 HOLES D_02.000" "GU G2 HOLES D_07.500" "GU G2 WALL D_02.000" "GU G2 WALL D_08.000" "GU GU_GT D_04.000" "GU GU_GT D_08.000" "GU GU_KMP WALL D_00.500" "GU GU_KMP WALL D_02.000" "GU GU_KMP WALL D_04.000" "GU GU_KMP WALL D_08.000" "GU GU_KMP WALL D_16.000" "GU ZAV_1 LOP PRES D_04.000" "GU ZAV_1 LOP R_IN D_04.00" "GU ZAV_1 LOP SUCT D_04.000" "GU ZAV_1 OUT WALL D_01.000" "GU ZAV_1 OUT WALL D_16.000" "GU ZAV_1 T D_01.000" "GU ZAV_2 IN WALL D_08.000" "GU ZAV_2 LOP PRES D_08.000" "GU ZAV_2 LOP R D_04.000" "GU ZAV_2 LOP SUCT D_08.000" "GU ZAV_2 LOP T D_04.000" "KRP KMP OUT D_08.000" "KRP KMP OUT D_16.000" "KRP KS IN D_04.000" "KRP KS IN D_08.000" "KRP KS IN D_16.000" "KRP KS OUT D_02.000" "KRP SA_DN HOLES D_09.500" "KRP SA_DN HOLES D_10.000" "KRP SA_DN WALL D_01.000 2" "KRP SA_DN WALL D_08.000" "KRP SA_UP WALL D_04.000" "KRP SA_UP WALL D_08.000" "KRP SA_UP WALL D_16.000" "KRP SA_UP WALL D_16.000 2" "SA IN WALL D_04.000" "SA LOP D_02.000" "SA LOP D_04.000" "SA LOP D_08.000" "SA OUT WALL D_04.000 2" "B AIR_IN D_16.000" "B GAS_1 D_04.000" "B GAS_2 D_08.000" "B GAS_OUT D_16.000" "C C_1_1 C_1_1_1 L" "C C_1_1 C_1_1_1 R" "C C_1_2 X_067.8 D_01.000" "C C_1_2 X_067.8 D_01.000 2" "C C_1_2 X_288.0 D_17.500" "C C_1_2 X_288.0 X_288.0" "C C_1_3 C_1_3_1 D_04.000" "C C_1_3 C_1_3_1 D_04.000 2" "C C_1_4 C_1_4_1 D_16.000" "C C_1_4 C_1_4_2 D_16.000" "C C_2_2 C_2_2_1 L D_00.000" "C C_2_2 C_2_2_1 R D_00.000" "C C_2_2 C_2_2_2 L D_01.000" "C C_2_2 C_2_2_2 R D_01.000" "C C_2_3 C_2_3_1 D_16.000" "C C_2_3 C_2_3_1 D_16.000 2" "C C_2_4 C_2_4_1 D_16.000" "C C_2_4 C_2_4_1 D_16.000 2" "C C_2_5 C_2_5_1 D_04.000" "C C_2_5 C_2_5_1 D_04.000 2" "C C_2_6 D_08.000" "C C_2_6 D_08.000 2" "C C_6_6 C_6_6_L D_08.000" "C C_6_6 C_6_6_R D_08.000" "C C_6_7 D_08.000" "C C_6_7 D_08.000 2" "C C_7_7 L D_00.000" "C C_7_7 R D_00.000" "GT HOLES X_288.0 D_17.500" "GT IN PP_R D_02.000" "GT IN WALL D_02.000" "GT OUT PP_R WALL D_04.000" "GT OUT TUBE WALL D_01.000" "GU COOL_1 WALL IN D_02.000" "GU COOL_1 WALL OUT D_02.000" "GU COOL_2 IN WALL D_02.000" "GU G1 HOLES D_07.000" "GU G1 WALL D_02.000" "GU G1 WALL D_04.000" "GU G1 WALL D_08.000" "GU G1 WALL D_16.000" "GU G2 HOLES D_15.000" "GU G2 WALL D_01.000" "GU G2 WALL D_16.000" "GU GU_GT D_02.000" "GU GU_KMP WALL D_01.000" "GU ZAV_1 IN WALL D_04.000" "GU ZAV_1 IN WALL D_08.000" "GU ZAV_1 OUT WALL D_02.000" "GU ZAV_1 OUT WALL D_04.000" "GU ZAV_2 IN WALL D_04.000" "GU ZAV_2 IN WALL D_16.000" "GU ZAV_2 LOP T D_00.500" "GU ZAV_2 OUT WALL D_02.000" "GU ZAV_2 OUT WALL D_04.000" "GU ZAV_2 OUT WALL D_08.000" "GU ZAV_2 OUT WALL D_16.000" "KRP KMP IN D_08.000" "KRP KMP IN D_16.000" "KRP KMP OUT D_02.000" "KRP KS IN D_02.000" "KRP KS OUT D_08.000" "KRP KS OUT D_16.000" "KRP SA_DN WALL D_01.000" "KRP SA_DN WALL D_04.000" "KRP SA_DN WALL D_04.000 2" "KRP SA_DN WALL D_16.000" "KRP SA_UP WALL D_01.000" "KRP SA_UP WALL D_02.000" "KRP SA_UP WALL D_08.000 2" "SA IN WALL D_02.000" "SA IN WALL D_08.000" "SA IN WALL D_08.000 2" "SA OUT WALL D_04.000" "SA OUT WALL D_08.000" "SA OUT WALL D_08.000 2" "Primitive 2D" "Primitive 2D 2" "Primitive 2D 3" "Primitive 2D 4" "Primitive 2D 5" "Primitive 2D 6" "Primitive 2D 7" "Primitive 2D A" "Primitive 2D A 2" "Primitive 2D A 3" "Primitive 2D A 4" "Primitive 2D A 5" "Primitive 2D A 6" "Primitive 2D A 7" "Primitive 2D AA" "Primitive 2D AA 2" "Primitive 2D AA 3" "Primitive 2D AA 4" "Primitive 2D AA 5" "Primitive 2D AA 6" "Primitive 2D AAA" "Primitive 2D AAA 2" "Primitive 2D AAB" "Primitive 2D AAB 2" "Primitive 2D AAC" "Primitive 2D AAC 2" "Primitive 2D AAD" "Primitive 2D AAD 2" "Primitive 2D AAE" "Primitive 2D AAE 2" "Primitive 2D AAF" "Primitive 2D AAF 2" "Primitive 2D AAG" "Primitive 2D AAG 2" "Primitive 2D AAH" "Primitive 2D AAH 2" "Primitive 2D AAI" "Primitive 2D AAI 2" "Primitive 2D AAJ" "Primitive 2D AAJ 2" "Primitive 2D AAK" "Primitive 2D AAK 2" "Primitive 2D AAL" "Primitive 2D AAL 2" "Primitive 2D AAM" "Primitive 2D AAM 2" "Primitive 2D AAN" "Primitive 2D AAN 2" "Primitive 2D AAO" "Primitive 2D AAO 2" "Primitive 2D AAP" "Primitive 2D AAP 2" "Primitive 2D AAQ" "Primitive 2D AAQ 2" "Primitive 2D AAR" "Primitive 2D AAR 2" "Primitive 2D AAS" "Primitive 2D AAS 2" "Primitive 2D AAT" "Primitive 2D AAT 2" "Primitive 2D AAU" "Primitive 2D AAU 2" "Primitive 2D AAV" "Primitive 2D AAV 2" "Primitive 2D AAW" "Primitive 2D AAW 2" "Primitive 2D AAX" "Primitive 2D AAX 2" "Primitive 2D AAY" "Primitive 2D AAY 2" "Primitive 2D AAZ" "Primitive 2D AAZ 2" "Primitive 2D AB" "Primitive 2D AB 2" "Primitive 2D AB 3" "Primitive 2D AB 4" "Primitive 2D AB 5" "Primitive 2D AB 6" "Primitive 2D ABA" "Primitive 2D ABA 2" "Primitive 2D ABB" "Primitive 2D ABB 2" "Primitive 2D ABC" "Primitive 2D ABC 2" "Primitive 2D ABD" "Primitive 2D ABD 2" "Primitive 2D ABE" "Primitive 2D ABE 2" "Primitive 2D ABF" "Primitive 2D ABF 2" "Primitive 2D ABG" "Primitive 2D ABG 2" "Primitive 2D ABH" "Primitive 2D ABH 2" "Primitive 2D ABI" "Primitive 2D ABI 2" "Primitive 2D ABJ" "Primitive 2D ABJ 2" "Primitive 2D ABK" "Primitive 2D ABK 2" "Primitive 2D ABL" "Primitive 2D ABL 2" "Primitive 2D ABM" "Primitive 2D ABM 2" "Primitive 2D ABN" "Primitive 2D ABN 2" "Primitive 2D ABO" "Primitive 2D ABO 2" "Primitive 2D ABP" "Primitive 2D ABP 2" "Primitive 2D ABQ" "Primitive 2D ABQ 2" "Primitive 2D ABR" "Primitive 2D ABR 2" "Primitive 2D ABS" "Primitive 2D ABS 2" "Primitive 2D ABT" "Primitive 2D ABT 2" "Primitive 2D ABU" "Primitive 2D ABU 2" "Primitive 2D ABV" "Primitive 2D ABV 2" "Primitive 2D ABW" "Primitive 2D ABW 2" "Primitive 2D ABX" "Primitive 2D ABX 2" "Primitive 2D ABY" "Primitive 2D ABY 2" "Primitive 2D ABZ" "Primitive 2D ABZ 2" "Primitive 2D AC" "Primitive 2D AC 2" "Primitive 2D AC 3" "Primitive 2D AC 4" "Primitive 2D AC 5" "Primitive 2D AC 6" "Primitive 2D ACA" "Primitive 2D ACA 2" "Primitive 2D ACB" "Primitive 2D ACB 2" "Primitive 2D ACC" "Primitive 2D ACC 2" "Primitive 2D ACD" "Primitive 2D ACD 2" "Primitive 2D ACE" "Primitive 2D ACE 2" "Primitive 2D ACF" "Primitive 2D ACF 2" "Primitive 2D ACG" "Primitive 2D ACG 2" "Primitive 2D ACH" "Primitive 2D ACH 2" "Primitive 2D ACI" "Primitive 2D ACI 2" "Primitive 2D ACJ" "Primitive 2D ACJ 2" "Primitive 2D ACK" "Primitive 2D ACK 2" "Primitive 2D ACL" "Primitive 2D ACL 2" "Primitive 2D ACM" "Primitive 2D ACM 2" "Primitive 2D ACN" "Primitive 2D ACN 2" "Primitive 2D ACO" "Primitive 2D ACO 2" "Primitive 2D ACP" "Primitive 2D ACP 2" "Primitive 2D ACQ" "Primitive 2D ACQ 2" "Primitive 2D ACR" "Primitive 2D ACR 2" "Primitive 2D ACS" "Primitive 2D ACS 2" "Primitive 2D ACT" "Primitive 2D ACT 2" "Primitive 2D ACU" "Primitive 2D ACU 2" "Primitive 2D ACV" "Primitive 2D ACV 2" "Primitive 2D ACW" "Primitive 2D ACW 2" "Primitive 2D ACX" "Primitive 2D ACX 2" "Primitive 2D ACY" "Primitive 2D ACY 2" "Primitive 2D ACZ" "Primitive 2D ACZ 2" "Primitive 2D AD" "Primitive 2D AD 2" "Primitive 2D AD 3" "Primitive 2D AD 4" "Primitive 2D AD 5" "Primitive 2D AD 6" "Primitive 2D ADA" "Primitive 2D ADA 2" "Primitive 2D ADB" "Primitive 2D ADB 2" "Primitive 2D ADC" "Primitive 2D ADC 2" "Primitive 2D ADD" "Primitive 2D ADD 2" "Primitive 2D ADE" "Primitive 2D ADE 2" "Primitive 2D ADF" "Primitive 2D ADF 2" "Primitive 2D ADG" "Primitive 2D ADG 2" "Primitive 2D ADH" "Primitive 2D ADH 2" "Primitive 2D ADI" "Primitive 2D ADI 2" "Primitive 2D ADJ" "Primitive 2D ADJ 2" "Primitive 2D ADK" "Primitive 2D ADK 2" "Primitive 2D ADL" "Primitive 2D ADL 2" "Primitive 2D ADM" "Primitive 2D ADM 2" "Primitive 2D ADN" "Primitive 2D ADN 2" "Primitive 2D ADO" "Primitive 2D ADO 2" "Primitive 2D ADP" "Primitive 2D ADP 2" "Primitive 2D ADQ" "Primitive 2D ADQ 2" "Primitive 2D ADR" "Primitive 2D ADR 2" "Primitive 2D ADS" "Primitive 2D ADS 2" "Primitive 2D ADT" "Primitive 2D ADT 2" "Primitive 2D ADU" "Primitive 2D ADU 2" "Primitive 2D ADV" "Primitive 2D ADV 2" "Primitive 2D ADW" "Primitive 2D ADW 2" "Primitive 2D ADX" "Primitive 2D ADX 2" "Primitive 2D ADY" "Primitive 2D ADY 2" "Primitive 2D ADZ" "Primitive 2D ADZ 2" "Primitive 2D AE" "Primitive 2D AE 2" "Primitive 2D AE 3" "Primitive 2D AE 4" "Primitive 2D AE 5" "Primitive 2D AE 6" "Primitive 2D AEA" "Primitive 2D AEA 2" "Primitive 2D AEB" "Primitive 2D AEB 2" "Primitive 2D AEC" "Primitive 2D AEC 2" "Primitive 2D AED" "Primitive 2D AED 2" "Primitive 2D AEE" "Primitive 2D AEE 2" "Primitive 2D AEF" "Primitive 2D AEF 2" "Primitive 2D AEG" "Primitive 2D AEG 2" "Primitive 2D AEH" "Primitive 2D AEH 2" "Primitive 2D AEI" "Primitive 2D AEI 2" "Primitive 2D AEJ" "Primitive 2D AEJ 2" "Primitive 2D AEK" "Primitive 2D AEK 2" "Primitive 2D AEL" "Primitive 2D AEL 2" "Primitive 2D AEM" "Primitive 2D AEM 2" "Primitive 2D AEN" "Primitive 2D AEN 2" "Primitive 2D AEO" "Primitive 2D AEO 2" "Primitive 2D AEP" "Primitive 2D AEP 2" "Primitive 2D AEQ" "Primitive 2D AEQ 2" "Primitive 2D AER" "Primitive 2D AER 2" "Primitive 2D AES" "Primitive 2D AES 2" "Primitive 2D AET" "Primitive 2D AET 2" "Primitive 2D AEU" "Primitive 2D AEU 2" "Primitive 2D AEV" "Primitive 2D AEV 2" "Primitive 2D AEW" "Primitive 2D AEW 2" "Primitive 2D AEX" "Primitive 2D AEX 2" "Primitive 2D AEY" "Primitive 2D AEY 2" "Primitive 2D AEZ" "Primitive 2D AEZ 2" "Primitive 2D AF" "Primitive 2D AF 2" "Primitive 2D AF 3" "Primitive 2D AF 4" "Primitive 2D AF 5" "Primitive 2D AFA" "Primitive 2D AFA 2" "Primitive 2D AFB" "Primitive 2D AFB 2" "Primitive 2D AFC" "Primitive 2D AFC 2" "Primitive 2D AFD" "Primitive 2D AFD 2" "Primitive 2D AFE" "Primitive 2D AFE 2" "Primitive 2D AFF" "Primitive 2D AFF 2" "Primitive 2D AFG" "Primitive 2D AFG 2" "Primitive 2D AFH" "Primitive 2D AFH 2" "Primitive 2D AFI" "Primitive 2D AFI 2" "Primitive 2D AFJ" "Primitive 2D AFJ 2" "Primitive 2D AFK" "Primitive 2D AFK 2" "Primitive 2D AFL" "Primitive 2D AFL 2" "Primitive 2D AFM" "Primitive 2D AFM 2" "Primitive 2D AFN" "Primitive 2D AFN 2" "Primitive 2D AFO" "Primitive 2D AFO 2" "Primitive 2D AFP" "Primitive 2D AFP 2" "Primitive 2D AFQ" "Primitive 2D AFQ 2" "Primitive 2D AFR" "Primitive 2D AFR 2" "Primitive 2D AFS" "Primitive 2D AFS 2" "Primitive 2D AFT" "Primitive 2D AFT 2" "Primitive 2D AFU" "Primitive 2D AFU 2" "Primitive 2D AFV" "Primitive 2D AFV 2" "Primitive 2D AFW" "Primitive 2D AFW 2" "Primitive 2D AFX" "Primitive 2D AFX 2" "Primitive 2D AFY" "Primitive 2D AFY 2" "Primitive 2D AFZ" "Primitive 2D AFZ 2" "Primitive 2D AG" "Primitive 2D AG 2" "Primitive 2D AG 3" "Primitive 2D AG 4" "Primitive 2D AG 5" "Primitive 2D AGA" "Primitive 2D AGA 2" "Primitive 2D AGB" "Primitive 2D AGB 2" "Primitive 2D AGC" "Primitive 2D AGC 2" "Primitive 2D AGD" "Primitive 2D AGD 2" "Primitive 2D AGE" "Primitive 2D AGE 2" "Primitive 2D AGF" "Primitive 2D AGF 2" "Primitive 2D AGG" "Primitive 2D AGG 2" "Primitive 2D AGH" "Primitive 2D AGH 2" "Primitive 2D AGI" "Primitive 2D AGI 2" "Primitive 2D AGJ" "Primitive 2D AGJ 2" "Primitive 2D AGK" "Primitive 2D AGK 2" "Primitive 2D AGL" "Primitive 2D AGL 2" "Primitive 2D AGM" "Primitive 2D AGM 2" "Primitive 2D AGN" "Primitive 2D AGN 2" "Primitive 2D AGO" "Primitive 2D AGO 2" "Primitive 2D AGP" "Primitive 2D AGP 2" "Primitive 2D AGQ" "Primitive 2D AGQ 2" "Primitive 2D AGR" "Primitive 2D AGR 2" "Primitive 2D AGS" "Primitive 2D AGS 2" "Primitive 2D AGT" "Primitive 2D AGT 2" "Primitive 2D AGU" "Primitive 2D AGU 2" "Primitive 2D AGV" "Primitive 2D AGV 2" "Primitive 2D AGW" "Primitive 2D AGW 2" "Primitive 2D AGX" "Primitive 2D AGX 2" "Primitive 2D AGY" "Primitive 2D AGY 2" "Primitive 2D AGZ" "Primitive 2D AGZ 2" "Primitive 2D AH" "Primitive 2D AH 2" "Primitive 2D AH 3" "Primitive 2D AH 4" "Primitive 2D AH 5" "Primitive 2D AHA" "Primitive 2D AHA 2" "Primitive 2D AHB" "Primitive 2D AHB 2" "Primitive 2D AHC" "Primitive 2D AHC 2" "Primitive 2D AHD" "Primitive 2D AHD 2" "Primitive 2D AHE" "Primitive 2D AHE 2" "Primitive 2D AHF" "Primitive 2D AHF 2" "Primitive 2D AHG" "Primitive 2D AHG 2" "Primitive 2D AHH" "Primitive 2D AHH 2" "Primitive 2D AHI" "Primitive 2D AHI 2" "Primitive 2D AHJ" "Primitive 2D AHJ 2" "Primitive 2D AHK" "Primitive 2D AHK 2" "Primitive 2D AHL" "Primitive 2D AHL 2" "Primitive 2D AHM" "Primitive 2D AHM 2" "Primitive 2D AHN" "Primitive 2D AHN 2" "Primitive 2D AHO" "Primitive 2D AHO 2" "Primitive 2D AHP" "Primitive 2D AHP 2" "Primitive 2D AHQ" "Primitive 2D AHQ 2" "Primitive 2D AHR" "Primitive 2D AHR 2" "Primitive 2D AHS" "Primitive 2D AHS 2" "Primitive 2D AHT" "Primitive 2D AHT 2" "Primitive 2D AHU" "Primitive 2D AHU 2" "Primitive 2D AHV" "Primitive 2D AHV 2" "Primitive 2D AHW" "Primitive 2D AHW 2" "Primitive 2D AHX" "Primitive 2D AHX 2" "Primitive 2D AHY" "Primitive 2D AHY 2" "Primitive 2D AHZ" "Primitive 2D AHZ 2" "Primitive 2D AI" "Primitive 2D AI 2" "Primitive 2D AI 3" "Primitive 2D AI 4" "Primitive 2D AI 5" "Primitive 2D AIA" "Primitive 2D AIA 2" "Primitive 2D AIB" "Primitive 2D AIB 2" "Primitive 2D AIC" "Primitive 2D AIC 2" "Primitive 2D AID" "Primitive 2D AID 2" "Primitive 2D AIE" "Primitive 2D AIE 2" "Primitive 2D AIF" "Primitive 2D AIF 2" "Primitive 2D AIG" "Primitive 2D AIG 2" "Primitive 2D AIH" "Primitive 2D AIH 2" "Primitive 2D AII" "Primitive 2D AII 2" "Primitive 2D AIJ" "Primitive 2D AIJ 2" "Primitive 2D AIK" "Primitive 2D AIK 2" "Primitive 2D AIL" "Primitive 2D AIL 2" "Primitive 2D AIM" "Primitive 2D AIM 2" "Primitive 2D AIN" "Primitive 2D AIN 2" "Primitive 2D AIO" "Primitive 2D AIO 2" "Primitive 2D AIP" "Primitive 2D AIP 2" "Primitive 2D AIQ" "Primitive 2D AIQ 2" "Primitive 2D AIR" "Primitive 2D AIR 2" "Primitive 2D AIS" "Primitive 2D AIS 2" "Primitive 2D AIT" "Primitive 2D AIT 2" "Primitive 2D AIU" "Primitive 2D AIU 2" "Primitive 2D AIV" "Primitive 2D AIV 2" "Primitive 2D AIW" "Primitive 2D AIW 2" "Primitive 2D AIX" "Primitive 2D AIX 2" "Primitive 2D AIY" "Primitive 2D AIY 2" "Primitive 2D AIZ" "Primitive 2D AIZ 2" "Primitive 2D AJ" "Primitive 2D AJ 2" "Primitive 2D AJ 3" "Primitive 2D AJ 4" "Primitive 2D AJ 5" "Primitive 2D AJA" "Primitive 2D AJA 2" "Primitive 2D AJB" "Primitive 2D AJB 2" "Primitive 2D AJC" "Primitive 2D AJC 2" "Primitive 2D AJD" "Primitive 2D AJD 2" "Primitive 2D AJE" "Primitive 2D AJE 2" "Primitive 2D AJF" "Primitive 2D AJF 2" "Primitive 2D AJG" "Primitive 2D AJG 2" "Primitive 2D AJH" "Primitive 2D AJH 2" "Primitive 2D AJI" "Primitive 2D AJI 2" "Primitive 2D AJJ" "Primitive 2D AJJ 2" "Primitive 2D AJK" "Primitive 2D AJK 2" "Primitive 2D AJL" "Primitive 2D AJL 2" "Primitive 2D AJM" "Primitive 2D AJM 2" "Primitive 2D AJN" "Primitive 2D AJN 2" "Primitive 2D AJO" "Primitive 2D AJO 2" "Primitive 2D AJP" "Primitive 2D AJP 2" "Primitive 2D AJQ" "Primitive 2D AJQ 2" "Primitive 2D AJR" "Primitive 2D AJR 2" "Primitive 2D AJS" "Primitive 2D AJS 2" "Primitive 2D AJT" "Primitive 2D AJT 2" "Primitive 2D AJU" "Primitive 2D AJU 2" "Primitive 2D AJV" "Primitive 2D AJV 2" "Primitive 2D AJW" "Primitive 2D AJW 2" "Primitive 2D AJX" "Primitive 2D AJX 2" "Primitive 2D AJY" "Primitive 2D AJY 2" "Primitive 2D AJZ" "Primitive 2D AJZ 2" "Primitive 2D AK" "Primitive 2D AK 2" "Primitive 2D AK 3" "Primitive 2D AK 4" "Primitive 2D AK 5" "Primitive 2D AKA" "Primitive 2D AKA 2" "Primitive 2D AKB" "Primitive 2D AKB 2" "Primitive 2D AKC" "Primitive 2D AKC 2" "Primitive 2D AKD" "Primitive 2D AKD 2" "Primitive 2D AKE" "Primitive 2D AKE 2" "Primitive 2D AKF" "Primitive 2D AKF 2" "Primitive 2D AKG" "Primitive 2D AKG 2" "Primitive 2D AKH" "Primitive 2D AKH 2" "Primitive 2D AKI" "Primitive 2D AKI 2" "Primitive 2D AKJ" "Primitive 2D AKJ 2" "Primitive 2D AKK" "Primitive 2D AKK 2" "Primitive 2D AKL" "Primitive 2D AKL 2" "Primitive 2D AKM" "Primitive 2D AKM 2" "Primitive 2D AKN" "Primitive 2D AKN 2" "Primitive 2D AKO" "Primitive 2D AKO 2" "Primitive 2D AKP" "Primitive 2D AKP 2" "Primitive 2D AKQ" "Primitive 2D AKQ 2" "Primitive 2D AKR" "Primitive 2D AKR 2" "Primitive 2D AKS" "Primitive 2D AKS 2" "Primitive 2D AKT" "Primitive 2D AKT 2" "Primitive 2D AKU" "Primitive 2D AKU 2" "Primitive 2D AKV" "Primitive 2D AKV 2" "Primitive 2D AKW" "Primitive 2D AKW 2" "Primitive 2D AKX" "Primitive 2D AKX 2" "Primitive 2D AKY" "Primitive 2D AKY 2" "Primitive 2D AKZ" "Primitive 2D AKZ 2" "Primitive 2D AL" "Primitive 2D AL 2" "Primitive 2D AL 3" "Primitive 2D AL 4" "Primitive 2D AL 5" "Primitive 2D ALA" "Primitive 2D ALA 2" "Primitive 2D ALB" "Primitive 2D ALB 2" "Primitive 2D ALC" "Primitive 2D ALC 2" "Primitive 2D ALD" "Primitive 2D ALD 2" "Primitive 2D ALE" "Primitive 2D ALE 2" "Primitive 2D ALF" "Primitive 2D ALF 2" "Primitive 2D ALG" "Primitive 2D ALG 2" "Primitive 2D ALH" "Primitive 2D ALH 2" "Primitive 2D ALI" "Primitive 2D ALI 2" "Primitive 2D ALJ" "Primitive 2D ALJ 2" "Primitive 2D ALK" "Primitive 2D ALK 2" "Primitive 2D ALL" "Primitive 2D ALL 2" "Primitive 2D ALM" "Primitive 2D ALM 2" "Primitive 2D ALN" "Primitive 2D ALN 2" "Primitive 2D ALO" "Primitive 2D ALO 2" "Primitive 2D ALP" "Primitive 2D ALP 2" "Primitive 2D ALQ" "Primitive 2D ALQ 2" "Primitive 2D ALR" "Primitive 2D ALR 2" "Primitive 2D ALS" "Primitive 2D ALS 2" "Primitive 2D ALT" "Primitive 2D ALT 2" "Primitive 2D ALU" "Primitive 2D ALU 2" "Primitive 2D ALV" "Primitive 2D ALV 2" "Primitive 2D ALW" "Primitive 2D ALW 2" "Primitive 2D ALX" "Primitive 2D ALX 2" "Primitive 2D ALY" "Primitive 2D ALY 2" "Primitive 2D ALZ" "Primitive 2D ALZ 2" "Primitive 2D AM" "Primitive 2D AM 2" "Primitive 2D AM 3" "Primitive 2D AM 4" "Primitive 2D AM 5" "Primitive 2D AMA" "Primitive 2D AMA 2" "Primitive 2D AMB" "Primitive 2D AMB 2" "Primitive 2D AMC" "Primitive 2D AMC 2" "Primitive 2D AMD" "Primitive 2D AMD 2" "Primitive 2D AME" "Primitive 2D AME 2" "Primitive 2D AMF" "Primitive 2D AMF 2" "Primitive 2D AMG" "Primitive 2D AMG 2" "Primitive 2D AMH" "Primitive 2D AMH 2" "Primitive 2D AMI" "Primitive 2D AMI 2" "Primitive 2D AMJ" "Primitive 2D AMJ 2" "Primitive 2D AMK" "Primitive 2D AMK 2" "Primitive 2D AML" "Primitive 2D AML 2" "Primitive 2D AMM" "Primitive 2D AMM 2" "Primitive 2D AMN" "Primitive 2D AMN 2" "Primitive 2D AMO" "Primitive 2D AMO 2" "Primitive 2D AMP" "Primitive 2D AMP 2" "Primitive 2D AMQ" "Primitive 2D AMQ 2" "Primitive 2D AMR" "Primitive 2D AMR 2" "Primitive 2D AMS" "Primitive 2D AMS 2" "Primitive 2D AMT" "Primitive 2D AMT 2" "Primitive 2D AMU" "Primitive 2D AMU 2" "Primitive 2D AMV" "Primitive 2D AMV 2" "Primitive 2D AMW" "Primitive 2D AMW 2" "Primitive 2D AMX" "Primitive 2D AMX 2" "Primitive 2D AMY" "Primitive 2D AMY 2" "Primitive 2D AMZ" "Primitive 2D AMZ 2" "Primitive 2D AN" "Primitive 2D AN 2" "Primitive 2D AN 3" "Primitive 2D AN 4" "Primitive 2D AN 5" "Primitive 2D ANA" "Primitive 2D ANA 2" "Primitive 2D ANB" "Primitive 2D ANB 2" "Primitive 2D ANC" "Primitive 2D ANC 2" "Primitive 2D AND" "Primitive 2D AND 2" "Primitive 2D ANE" "Primitive 2D ANE 2" "Primitive 2D ANF" "Primitive 2D ANF 2" "Primitive 2D ANG" "Primitive 2D ANG 2" "Primitive 2D ANH" "Primitive 2D ANH 2" "Primitive 2D ANI" "Primitive 2D ANI 2" "Primitive 2D ANJ" "Primitive 2D ANJ 2" "Primitive 2D ANK" "Primitive 2D ANK 2" "Primitive 2D ANL" "Primitive 2D ANL 2" "Primitive 2D ANM" "Primitive 2D ANM 2" "Primitive 2D ANN" "Primitive 2D ANN 2" "Primitive 2D ANO" "Primitive 2D ANO 2" "Primitive 2D ANP" "Primitive 2D ANP 2" "Primitive 2D ANQ" "Primitive 2D ANQ 2" "Primitive 2D ANR" "Primitive 2D ANR 2" "Primitive 2D ANS" "Primitive 2D ANS 2" "Primitive 2D ANT" "Primitive 2D ANT 2" "Primitive 2D ANU" "Primitive 2D ANU 2" "Primitive 2D ANV" "Primitive 2D ANV 2" "Primitive 2D ANW" "Primitive 2D ANW 2" "Primitive 2D ANX" "Primitive 2D ANX 2" "Primitive 2D ANY" "Primitive 2D ANY 2" "Primitive 2D ANZ" "Primitive 2D ANZ 2" "Primitive 2D AO" "Primitive 2D AO 2" "Primitive 2D AO 3" "Primitive 2D AO 4" "Primitive 2D AO 5" "Primitive 2D AOA" "Primitive 2D AOA 2" "Primitive 2D AOB" "Primitive 2D AOB 2" "Primitive 2D AOC" "Primitive 2D AOC 2" "Primitive 2D AOD" "Primitive 2D AOD 2" "Primitive 2D AOE" "Primitive 2D AOE 2" "Primitive 2D AOF" "Primitive 2D AOF 2" "Primitive 2D AOG" "Primitive 2D AOG 2" "Primitive 2D AOH" "Primitive 2D AOH 2" "Primitive 2D AOI" "Primitive 2D AOI 2" "Primitive 2D AOJ" "Primitive 2D AOJ 2" "Primitive 2D AOK" "Primitive 2D AOK 2" "Primitive 2D AOL" "Primitive 2D AOL 2" "Primitive 2D AOM" "Primitive 2D AOM 2" "Primitive 2D AON" "Primitive 2D AON 2" "Primitive 2D AOO" "Primitive 2D AOO 2" "Primitive 2D AOP" "Primitive 2D AOP 2" "Primitive 2D AOQ" "Primitive 2D AOQ 2" "Primitive 2D AOR" "Primitive 2D AOR 2" "Primitive 2D AOS" "Primitive 2D AOS 2" "Primitive 2D AOT" "Primitive 2D AOT 2" "Primitive 2D AOU" "Primitive 2D AOU 2" "Primitive 2D AOV" "Primitive 2D AOV 2" "Primitive 2D AOW" "Primitive 2D AOW 2" "Primitive 2D AOX" "Primitive 2D AOX 2" "Primitive 2D AOY" "Primitive 2D AOY 2" "Primitive 2D AOZ" "Primitive 2D AOZ 2" "Primitive 2D AP" "Primitive 2D AP 2" "Primitive 2D AP 3" "Primitive 2D AP 4" "Primitive 2D AP 5" "Primitive 2D APA" "Primitive 2D APA 2" "Primitive 2D APB" "Primitive 2D APB 2" "Primitive 2D APC" "Primitive 2D APC 2" "Primitive 2D APD" "Primitive 2D APD 2" "Primitive 2D APE" "Primitive 2D APE 2" "Primitive 2D APF" "Primitive 2D APF 2" "Primitive 2D APG" "Primitive 2D APG 2" "Primitive 2D APH" "Primitive 2D APH 2" "Primitive 2D API" "Primitive 2D API 2" "Primitive 2D APJ" "Primitive 2D APJ 2" "Primitive 2D APK" "Primitive 2D APK 2" "Primitive 2D APL" "Primitive 2D APL 2" "Primitive 2D APM" "Primitive 2D APM 2" "Primitive 2D APN" "Primitive 2D APN 2" "Primitive 2D APO" "Primitive 2D APO 2" "Primitive 2D APP" "Primitive 2D APP 2" "Primitive 2D APQ" "Primitive 2D APQ 2" "Primitive 2D APR" "Primitive 2D APR 2" "Primitive 2D APS" "Primitive 2D APS 2" "Primitive 2D APT" "Primitive 2D APT 2" "Primitive 2D APU" "Primitive 2D APU 2" "Primitive 2D APV" "Primitive 2D APV 2" "Primitive 2D APW" "Primitive 2D APW 2" "Primitive 2D APX" "Primitive 2D APX 2" "Primitive 2D APY" "Primitive 2D APY 2" "Primitive 2D APZ" "Primitive 2D APZ 2" "Primitive 2D AQ" "Primitive 2D AQ 2" "Primitive 2D AQ 3" "Primitive 2D AQ 4" "Primitive 2D AQ 5" "Primitive 2D AQA" "Primitive 2D AQA 2" "Primitive 2D AQB" "Primitive 2D AQB 2" "Primitive 2D AQC" "Primitive 2D AQC 2" "Primitive 2D AQD" "Primitive 2D AQD 2" "Primitive 2D AQE" "Primitive 2D AQE 2" "Primitive 2D AQF" "Primitive 2D AQF 2" "Primitive 2D AQG" "Primitive 2D AQG 2" "Primitive 2D AQH" "Primitive 2D AQH 2" "Primitive 2D AQI" "Primitive 2D AQI 2" "Primitive 2D AQJ" "Primitive 2D AQJ 2" "Primitive 2D AQK" "Primitive 2D AQK 2" "Primitive 2D AQL" "Primitive 2D AQL 2" "Primitive 2D AQM" "Primitive 2D AQM 2" "Primitive 2D AQN" "Primitive 2D AQN 2" "Primitive 2D AQO" "Primitive 2D AQO 2" "Primitive 2D AQP" "Primitive 2D AQP 2" "Primitive 2D AQQ" "Primitive 2D AQQ 2" "Primitive 2D AQR" "Primitive 2D AQR 2" "Primitive 2D AQS" "Primitive 2D AQS 2" "Primitive 2D AQT" "Primitive 2D AQT 2" "Primitive 2D AQU" "Primitive 2D AQU 2" "Primitive 2D AQV" "Primitive 2D AQV 2" "Primitive 2D AQW" "Primitive 2D AQW 2" "Primitive 2D AQX" "Primitive 2D AQX 2" "Primitive 2D AQY" "Primitive 2D AQY 2" "Primitive 2D AQZ" "Primitive 2D AQZ 2" "Primitive 2D AR" "Primitive 2D AR 2" "Primitive 2D AR 3" "Primitive 2D AR 4" "Primitive 2D AR 5" "Primitive 2D ARA" "Primitive 2D ARA 2" "Primitive 2D ARB" "Primitive 2D ARB 2" "Primitive 2D ARC" "Primitive 2D ARC 2" "Primitive 2D ARD" "Primitive 2D ARD 2" "Primitive 2D ARE" "Primitive 2D ARE 2" "Primitive 2D ARF" "Primitive 2D ARF 2" "Primitive 2D ARG" "Primitive 2D ARG 2" "Primitive 2D ARH" "Primitive 2D ARH 2" "Primitive 2D ARI" "Primitive 2D ARI 2" "Primitive 2D ARJ" "Primitive 2D ARJ 2" "Primitive 2D ARK" "Primitive 2D ARK 2" "Primitive 2D ARL" "Primitive 2D ARL 2" "Primitive 2D ARM" "Primitive 2D ARM 2" "Primitive 2D ARN" "Primitive 2D ARN 2" "Primitive 2D ARO" "Primitive 2D ARO 2" "Primitive 2D ARP" "Primitive 2D ARP 2" "Primitive 2D ARQ" "Primitive 2D ARQ 2" "Primitive 2D ARR" "Primitive 2D ARR 2" "Primitive 2D ARS" "Primitive 2D ARS 2" "Primitive 2D ART" "Primitive 2D ART 2" "Primitive 2D ARU" "Primitive 2D ARU 2" "Primitive 2D ARV" "Primitive 2D ARV 2" "Primitive 2D ARW" "Primitive 2D ARW 2" "Primitive 2D ARX" "Primitive 2D ARX 2" "Primitive 2D ARY" "Primitive 2D ARY 2" "Primitive 2D ARZ" "Primitive 2D ARZ 2" "Primitive 2D AS" "Primitive 2D AS 2" "Primitive 2D AS 3" "Primitive 2D AS 4" "Primitive 2D AS 5" "Primitive 2D ASA" "Primitive 2D ASA 2" "Primitive 2D ASB" "Primitive 2D ASB 2" "Primitive 2D ASC" "Primitive 2D ASC 2" "Primitive 2D ASD" "Primitive 2D ASD 2" "Primitive 2D ASE" "Primitive 2D ASE 2" "Primitive 2D ASF" "Primitive 2D ASF 2" "Primitive 2D ASG" "Primitive 2D ASG 2" "Primitive 2D ASH" "Primitive 2D ASH 2" "Primitive 2D ASI" "Primitive 2D ASI 2" "Primitive 2D ASJ" "Primitive 2D ASJ 2" "Primitive 2D ASK" "Primitive 2D ASK 2" "Primitive 2D ASL" "Primitive 2D ASL 2" "Primitive 2D ASM" "Primitive 2D ASM 2" "Primitive 2D ASN" "Primitive 2D ASN 2" "Primitive 2D ASO" "Primitive 2D ASO 2" "Primitive 2D ASP" "Primitive 2D ASP 2" "Primitive 2D ASQ" "Primitive 2D ASQ 2" "Primitive 2D ASR" "Primitive 2D ASR 2" "Primitive 2D ASS" "Primitive 2D ASS 2" "Primitive 2D AST" "Primitive 2D AST 2" "Primitive 2D ASU" "Primitive 2D ASU 2" "Primitive 2D ASV" "Primitive 2D ASV 2" "Primitive 2D ASW" "Primitive 2D ASW 2" "Primitive 2D ASX" "Primitive 2D ASX 2" "Primitive 2D ASY" "Primitive 2D ASY 2" "Primitive 2D ASZ" "Primitive 2D ASZ 2" "Primitive 2D AT" "Primitive 2D AT 2" "Primitive 2D AT 3" "Primitive 2D AT 4" "Primitive 2D AT 5" "Primitive 2D ATA" "Primitive 2D ATA 2" "Primitive 2D ATB" "Primitive 2D ATB 2" "Primitive 2D ATC" "Primitive 2D ATC 2" "Primitive 2D ATD" "Primitive 2D ATD 2" "Primitive 2D ATE" "Primitive 2D ATE 2" "Primitive 2D ATF" "Primitive 2D ATF 2" "Primitive 2D ATG" "Primitive 2D ATG 2" "Primitive 2D ATH" "Primitive 2D ATH 2" "Primitive 2D ATI" "Primitive 2D ATI 2" "Primitive 2D ATJ" "Primitive 2D ATJ 2" "Primitive 2D ATK" "Primitive 2D ATK 2" "Primitive 2D ATL" "Primitive 2D ATL 2" "Primitive 2D ATM" "Primitive 2D ATM 2" "Primitive 2D ATN" "Primitive 2D ATN 2" "Primitive 2D ATO" "Primitive 2D ATO 2" "Primitive 2D ATP" "Primitive 2D ATP 2" "Primitive 2D ATQ" "Primitive 2D ATQ 2" "Primitive 2D ATR" "Primitive 2D ATR 2" "Primitive 2D ATS" "Primitive 2D ATS 2" "Primitive 2D ATT" "Primitive 2D ATT 2" "Primitive 2D ATU" "Primitive 2D ATU 2" "Primitive 2D ATV" "Primitive 2D ATV 2" "Primitive 2D ATW" "Primitive 2D ATW 2" "Primitive 2D ATX" "Primitive 2D ATX 2" "Primitive 2D ATY" "Primitive 2D ATY 2" "Primitive 2D ATZ" "Primitive 2D ATZ 2" "Primitive 2D AU" "Primitive 2D AU 2" "Primitive 2D AU 3" "Primitive 2D AU 4" "Primitive 2D AU 5" "Primitive 2D AUA" "Primitive 2D AUA 2" "Primitive 2D AUB" "Primitive 2D AUB 2" "Primitive 2D AUC" "Primitive 2D AUC 2" "Primitive 2D AUD" "Primitive 2D AUD 2" "Primitive 2D AUE" "Primitive 2D AUE 2" "Primitive 2D AUF" "Primitive 2D AUF 2" "Primitive 2D AUG" "Primitive 2D AUG 2" "Primitive 2D AUH" "Primitive 2D AUH 2" "Primitive 2D AUI" "Primitive 2D AUI 2" "Primitive 2D AUJ" "Primitive 2D AUJ 2" "Primitive 2D AUK" "Primitive 2D AUK 2" "Primitive 2D AUL" "Primitive 2D AUL 2" "Primitive 2D AUM" "Primitive 2D AUM 2" "Primitive 2D AUN" "Primitive 2D AUN 2" "Primitive 2D AUO" "Primitive 2D AUO 2" "Primitive 2D AUP" "Primitive 2D AUP 2" "Primitive 2D AUQ" "Primitive 2D AUQ 2" "Primitive 2D AUR" "Primitive 2D AUR 2" "Primitive 2D AUS" "Primitive 2D AUS 2" "Primitive 2D AUT" "Primitive 2D AUT 2" "Primitive 2D AUU" "Primitive 2D AUU 2" "Primitive 2D AUV" "Primitive 2D AUV 2" "Primitive 2D AUW" "Primitive 2D AUW 2" "Primitive 2D AUX" "Primitive 2D AUX 2" "Primitive 2D AUY" "Primitive 2D AUY 2" "Primitive 2D AUZ" "Primitive 2D AUZ 2" "Primitive 2D AV" "Primitive 2D AV 2" "Primitive 2D AV 3" "Primitive 2D AV 4" "Primitive 2D AV 5" "Primitive 2D AVA" "Primitive 2D AVA 2" "Primitive 2D AVB" "Primitive 2D AVB 2" "Primitive 2D AVC" "Primitive 2D AVC 2" "Primitive 2D AVD" "Primitive 2D AVD 2" "Primitive 2D AVE" "Primitive 2D AVE 2" "Primitive 2D AVF" "Primitive 2D AVF 2" "Primitive 2D AVG" "Primitive 2D AVG 2" "Primitive 2D AVH" "Primitive 2D AVH 2" "Primitive 2D AVI" "Primitive 2D AVI 2" "Primitive 2D AVJ" "Primitive 2D AVJ 2" "Primitive 2D AVK" "Primitive 2D AVK 2" "Primitive 2D AVL" "Primitive 2D AVM" "Primitive 2D AVN" "Primitive 2D AVO" "Primitive 2D AVP" "Primitive 2D AVQ" "Primitive 2D AVR" "Primitive 2D AVS" "Primitive 2D AVT" "Primitive 2D AVU" "Primitive 2D AVV" "Primitive 2D AVW" "Primitive 2D AVX" "Primitive 2D AVY" "Primitive 2D AVZ" "Primitive 2D AW" "Primitive 2D AW 2" "Primitive 2D AW 3" "Primitive 2D AW 4" "Primitive 2D AW 5" "Primitive 2D AWA" "Primitive 2D AWB" "Primitive 2D AWC" "Primitive 2D AWD" "Primitive 2D AWE" "Primitive 2D AWF" "Primitive 2D AWG" "Primitive 2D AWH" "Primitive 2D AWI" "Primitive 2D AWJ" "Primitive 2D AWK" "Primitive 2D AWL" "Primitive 2D AWM" "Primitive 2D AWN" "Primitive 2D AWO" "Primitive 2D AWP" "Primitive 2D AWQ" "Primitive 2D AWR" "Primitive 2D AWS" "Primitive 2D AWT" "Primitive 2D AWU" "Primitive 2D AWV" "Primitive 2D AWW" "Primitive 2D AWX" "Primitive 2D AWY" "Primitive 2D AWZ" "Primitive 2D AX" "Primitive 2D AX 2" "Primitive 2D AX 3" "Primitive 2D AX 4" "Primitive 2D AX 5" "Primitive 2D AXA" "Primitive 2D AXB" "Primitive 2D AXC" "Primitive 2D AXD" "Primitive 2D AXE" "Primitive 2D AXF" "Primitive 2D AXG" "Primitive 2D AXH" "Primitive 2D AXI" "Primitive 2D AXJ" "Primitive 2D AXK" "Primitive 2D AXL" "Primitive 2D AXM" "Primitive 2D AXN" "Primitive 2D AXO" "Primitive 2D AXP" "Primitive 2D AXQ" "Primitive 2D AXR" "Primitive 2D AXS" "Primitive 2D AXT" "Primitive 2D AXU" "Primitive 2D AXV" "Primitive 2D AXW" "Primitive 2D AXX" "Primitive 2D AXY" "Primitive 2D AXZ" "Primitive 2D AY" "Primitive 2D AY 2" "Primitive 2D AY 3" "Primitive 2D AY 4" "Primitive 2D AY 5" "Primitive 2D AYA" "Primitive 2D AYB" "Primitive 2D AYC" "Primitive 2D AYD" "Primitive 2D AYE" "Primitive 2D AYF" "Primitive 2D AYG" "Primitive 2D AYH" "Primitive 2D AYI" "Primitive 2D AYJ" "Primitive 2D AYK" "Primitive 2D AYL" "Primitive 2D AYM" "Primitive 2D AYN" "Primitive 2D AYO" "Primitive 2D AYP" "Primitive 2D AYQ" "Primitive 2D AYR" "Primitive 2D AYS" "Primitive 2D AYT" "Primitive 2D AYU" "Primitive 2D AYV" "Primitive 2D AYW" "Primitive 2D AYX" "Primitive 2D AYY" "Primitive 2D AYZ" "Primitive 2D AZ" "Primitive 2D AZ 2" "Primitive 2D AZ 3" "Primitive 2D AZ 4" "Primitive 2D AZ 5" "Primitive 2D AZA" "Primitive 2D AZB" "Primitive 2D AZC" "Primitive 2D AZD" "Primitive 2D AZE" "Primitive 2D AZF" "Primitive 2D AZG" "Primitive 2D AZH" "Primitive 2D AZI" "Primitive 2D AZJ" "Primitive 2D AZK" "Primitive 2D AZL" "Primitive 2D AZM" "Primitive 2D AZN" "Primitive 2D AZO" "Primitive 2D AZP" "Primitive 2D AZQ" "Primitive 2D AZR" "Primitive 2D AZS" "Primitive 2D AZT" "Primitive 2D AZU" "Primitive 2D AZV" "Primitive 2D AZW" "Primitive 2D AZX" "Primitive 2D AZY" "Primitive 2D AZZ" "Primitive 2D B" "Primitive 2D B 2" "Primitive 2D B 3" "Primitive 2D B 4" "Primitive 2D B 5" "Primitive 2D B 6" "Primitive 2D BA" "Primitive 2D BA 2" "Primitive 2D BA 3" "Primitive 2D BA 4" "Primitive 2D BA 5" "Primitive 2D BAA" "Primitive 2D BAB" "Primitive 2D BAC" "Primitive 2D BAD" "Primitive 2D BAE" "Primitive 2D BAF" "Primitive 2D BAG" "Primitive 2D BAH" "Primitive 2D BAI" "Primitive 2D BAJ" "Primitive 2D BAK" "Primitive 2D BAL" "Primitive 2D BAM" "Primitive 2D BAN" "Primitive 2D BAO" "Primitive 2D BAP" "Primitive 2D BAQ" "Primitive 2D BAR" "Primitive 2D BAS" "Primitive 2D BAT" "Primitive 2D BAU" "Primitive 2D BAV" "Primitive 2D BAW" "Primitive 2D BAX" "Primitive 2D BAY" "Primitive 2D BAZ" "Primitive 2D BB" "Primitive 2D BB 2" "Primitive 2D BB 3" "Primitive 2D BB 4" "Primitive 2D BB 5" "Primitive 2D BBA" "Primitive 2D BBB" "Primitive 2D BBC" "Primitive 2D BBD" "Primitive 2D BBE" "Primitive 2D BBF" "Primitive 2D BBG" "Primitive 2D BBH" "Primitive 2D BBI" "Primitive 2D BBJ" "Primitive 2D BBK" "Primitive 2D BBL" "Primitive 2D BBM" "Primitive 2D BBN" "Primitive 2D BBO" "Primitive 2D BBP" "Primitive 2D BBQ" "Primitive 2D BBR" "Primitive 2D BBS" "Primitive 2D BBT" "Primitive 2D BBU" "Primitive 2D BBV" "Primitive 2D BBW" "Primitive 2D BBX" "Primitive 2D BBY" "Primitive 2D BBZ" "Primitive 2D BC" "Primitive 2D BC 2" "Primitive 2D BC 3" "Primitive 2D BC 4" "Primitive 2D BC 5" "Primitive 2D BCA" "Primitive 2D BCB" "Primitive 2D BCC" "Primitive 2D BCD" "Primitive 2D BCE" "Primitive 2D BCF" "Primitive 2D BCG" "Primitive 2D BCH" "Primitive 2D BCI" "Primitive 2D BCJ" "Primitive 2D BCK" "Primitive 2D BCL" "Primitive 2D BCM" "Primitive 2D BCN" "Primitive 2D BCO" "Primitive 2D BCP" "Primitive 2D BCQ" "Primitive 2D BCR" "Primitive 2D BCS" "Primitive 2D BCT" "Primitive 2D BCU" "Primitive 2D BCV" "Primitive 2D BCW" "Primitive 2D BCX" "Primitive 2D BCY" "Primitive 2D BCZ" "Primitive 2D BD" "Primitive 2D BD 2" "Primitive 2D BD 3" "Primitive 2D BD 4" "Primitive 2D BD 5" "Primitive 2D BDA" "Primitive 2D BDB" "Primitive 2D BDC" "Primitive 2D BDD" "Primitive 2D BDE" "Primitive 2D BDF" "Primitive 2D BDG" "Primitive 2D BDH" "Primitive 2D BDI" "Primitive 2D BDJ" "Primitive 2D BDK" "Primitive 2D BDL" "Primitive 2D BDM" "Primitive 2D BDN" "Primitive 2D BDO" "Primitive 2D BDP" "Primitive 2D BDQ" "Primitive 2D BDR" "Primitive 2D BDS" "Primitive 2D BDT" "Primitive 2D BDU" "Primitive 2D BDV" "Primitive 2D BDW" "Primitive 2D BDX" "Primitive 2D BDY" "Primitive 2D BDZ" "Primitive 2D BE" "Primitive 2D BE 2" "Primitive 2D BE 3" "Primitive 2D BE 4" "Primitive 2D BE 5" "Primitive 2D BEA" "Primitive 2D BEB" "Primitive 2D BEC" "Primitive 2D BED" "Primitive 2D BEE" "Primitive 2D BEF" "Primitive 2D BEG" "Primitive 2D BEH" "Primitive 2D BEI" "Primitive 2D BEJ" "Primitive 2D BEK" "Primitive 2D BEL" "Primitive 2D BEM" "Primitive 2D BEN" "Primitive 2D BEO" "Primitive 2D BEP" "Primitive 2D BEQ" "Primitive 2D BER" "Primitive 2D BES" "Primitive 2D BET" "Primitive 2D BEU" "Primitive 2D BEV" "Primitive 2D BEW" "Primitive 2D BEX" "Primitive 2D BEY" "Primitive 2D BEZ" "Primitive 2D BF" "Primitive 2D BF 2" "Primitive 2D BF 3" "Primitive 2D BF 4" "Primitive 2D BF 5" "Primitive 2D BFA" "Primitive 2D BFB" "Primitive 2D BFC" "Primitive 2D BFD" "Primitive 2D BFE" "Primitive 2D BFF" "Primitive 2D BFG" "Primitive 2D BFH" "Primitive 2D BFI" "Primitive"))

(length *c*)

(format t "~{~S~%~}"
        (sort *c* #'string<))

(defun make-domain-interface-rotational-periodicity (domain-interface i-reg-lst-1 i-reg-lst-2)
  (let ((d-i domain-interface
             #+nil(mnas-string/translit:translit domain-interface :ht mnas-string/translit:*cfx->en*)))
    (format t
            "
FLOW: Flow Analysis 1
  &replace DOMAIN INTERFACE: ~A
    Boundary List1 = ~A Side 1
    Boundary List2 = ~A Side 2
    Filter Domain List1 = D1
    Filter Domain List2 = D1
    Interface Region List1 = ~A
    Interface Region List2 = ~A
    Interface Type = Fluid Fluid
    INTERFACE MODELS: 
      Option = Rotational Periodicity
      AXIS DEFINITION: 
        Option = Coordinate Axis
        Rotation Axis = Coord 0.1
      END
    END
    MESH CONNECTION: 
      Option = Automatic
    END
  END
END
~2%
"
            d-i d-i d-i i-reg-lst-1 i-reg-lst-2)))

(defun make-domain-interface-general-connection (domain-interface i-reg-lst-1 i-reg-lst-2)
  (let ((d-i domain-interface
             #+nil(mnas-string/translit:translit domain-interface :ht mnas-string/translit:*cfx->en*)))
    (format t
            "
FLOW: Flow Analysis 1
  &replace DOMAIN INTERFACE: ~A
    Boundary List1 = ~A Side 1
    Boundary List2 = ~A Side 2
    Filter Domain List1 = D1
    Filter Domain List2 = D1
    Interface Region List1 = ~A
    Interface Region List2 = ~A
    Interface Type = Fluid Fluid
    INTERFACE MODELS: 
      Option = General Connection
      FRAME CHANGE: 
        Option = None
      END
      MASS AND MOMENTUM: 
        Option = Conservative Interface Flux
        MOMENTUM INTERFACE MODEL: 
          Option = None
        END
      END
      PITCH CHANGE: 
        Option = None
      END
    END
    MESH CONNECTION: 
      Option = Automatic
    END
  END
END
~2%
"
            d-i d-i d-i i-reg-lst-1 i-reg-lst-2)))


(progn
  (make-domain-interface-rotational-periodicity "C_1_1_1" "C C_1_1 C_1_1_1 L"          "C C_1_1 C_1_1_1 R")
  (make-domain-interface-rotational-periodicity "C_2_2_1" "C C_2_2 C_2_2_1 L D_00.000" "C C_2_2 C_2_2_1 R D_00.000")
  (make-domain-interface-rotational-periodicity "C_2_2_2" "C C_2_2 C_2_2_2 L D_01.000" "C C_2_2 C_2_2_2 R D_01.000")
  (make-domain-interface-rotational-periodicity "C_6_6_1" "C C_6_6 C_6_6_L D_08.000"   "C C_6_6 C_6_6_R D_08.000")
  (make-domain-interface-rotational-periodicity "C_6_6_2" "C C_6_6 C_6_6_L D_08.000 2" "C C_6_6 C_6_6_R D_08.000 2")
  (make-domain-interface-rotational-periodicity "C_7_7_1" "C C_7_7 L D_00.000"         "C C_7_7 R D_00.000")
;;;;
  (make-domain-interface-general-connection "C_1_2 X_049.5" "C C_1_2 X_049.5 D_00.850" "C C_1_2 X_049.5 D_00.850 2")
  (make-domain-interface-general-connection "C_1_2 X_067.8" "C C_1_2 X_067.8 D_01.000" "C C_1_2 X_067.8 D_01.000 2")
  (make-domain-interface-general-connection "C_1_2 X_071.5" "C C_1_2 X_071.5 D_01.250" "C C_1_2 X_071.5 D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_085.0 L" "C C_1_2 X_085.0 L D_01.250" "C C_1_2 X_085.0 L D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_085.0 R" "C C_1_2 X_085.0 R D_01.250" "C C_1_2 X_085.0 R D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_093.5" "C C_1_2 X_093.5 D_01.250" "C C_1_2 X_093.5 D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_115.5" "C C_1_2 X_115.5 D_01.250" "C C_1_2 X_115.5 D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_137.5" "C C_1_2 X_137.5 D_01.250" "C C_1_2 X_137.5 D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_159.5" "C C_1_2 X_159.5 D_01.250" "C C_1_2 X_159.5 D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_181.5" "C C_1_2 X_181.5 D_00.850" "C C_1_2 X_181.5 D_00.850 2")
  (make-domain-interface-general-connection "C_1_2 X_203.5" "C C_1_2 X_203.5 D_00.850" "C C_1_2 X_203.5 D_00.850 2")
  (make-domain-interface-general-connection "C_1_2 X_227.5" "C C_1_2 X_227.5 D_00.850" "C C_1_2 X_227.5 D_00.850 2")
  (make-domain-interface-general-connection "C_1_2 X_251.5" "C C_1_2 X_251.5 D_00.850" "C C_1_2 X_251.5 D_00.850 2")
  (make-domain-interface-general-connection "C_1_2 X_275.5" "C C_1_2 X_275.5 D_00.800" "C C_1_2 X_275.5 D_00.800 2")
  (make-domain-interface-general-connection "C_1_2 X_288.0" "C C_1_2 X_288.0 D_17.500" "C C_1_2 X_288.0 X_288.0")
  (make-domain-interface-general-connection "C_1_2 X_376.5" "C C_1_2 X_376.5 D_08.500" "C C_1_2 X_376.5 D_08.500 2")
  (make-domain-interface-general-connection "C_1_2 X_416.5" "C C_1_2 X_416.5 D_01.05" "C C_1_2 X_416.5 D_01.05 2")
  (make-domain-interface-general-connection "C_1_2 X_451.5" "C C_1_2 X_451.5 D_01.250" "C C_1_2 X_451.5 D_01.250 2")
  (make-domain-interface-general-connection "C_1_2 X_481.5" "C C_1_2 X_481.5 D_01.500" "C C_1_2 X_481.5 D_01.500 2")
  (make-domain-interface-general-connection "C_1_3_1" "C C_1_3 C_1_3_1 D_04.000" "C C_1_3 C_1_3_1 D_04.000 2")
  (make-domain-interface-general-connection "C_1_3_2" "C C_1_3 C_1_3_2 D_06.000" "C C_1_4 C_1_4_1 D_06.000")
  (make-domain-interface-general-connection "C_1_4_1" "C C_1_4 C_1_4_1 D_16.000" "C C_1_4 C_1_4_2 D_16.000")
  (make-domain-interface-general-connection "C_1_5_1" "C C_1_5 C_1_5_1 D_04.000" "C C_1_5 C_1_5_1 D_04.000 2")
  (make-domain-interface-general-connection "C_2_3_1" "C C_2_3 C_2_3_1 D_16.000" "C C_2_3 C_2_3_1 D_16.000 2")
  (make-domain-interface-general-connection "C_2_4_1" "C C_2_4 C_2_4_1 D_16.000" "C C_2_4 C_2_4_1 D_16.000 2")
  (make-domain-interface-general-connection "C_2_5_1" "C C_2_5 C_2_5_1 D_04.000" "C C_2_5 C_2_5_1 D_04.000 2")
  (make-domain-interface-general-connection "C_2_6_1" "C C_2_6 D_08.000" "C C_2_6 D_08.000 2")
  (make-domain-interface-general-connection "C_6_7_1" "C C_6_7 D_08.000" "C C_6_7 D_08.000 2"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; MATERIAL
"
LIBRARY: 
  &replace MATERIAL: CH4
    Material Description = Methane CH4
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 11.1E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 16.04 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.07787415E+01 []
          NASA a2 = 0.01747668E+00 [K^-1]
          NASA a3 = -0.02783409E-03 [K^-2]
          NASA a4 = 0.03049708E-06 [K^-3]
          NASA a5 = -0.01223931E-09 [K^-4]
          NASA a6 = -0.09825229E+05 [K]
          NASA a7 = 0.01372219E+03 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.01683479E+02 []
          NASA a2 = 0.01023724E+00 [K^-1]
          NASA a3 = -0.03875129E-04 [K^-2]
          NASA a4 = 0.06785585E-08 [K^-3]
          NASA a5 = -0.04503423E-12 [K^-4]
          NASA a6 = -0.01008079E+06 [K]
          NASA a7 = 0.09623395E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 343E-04 [W m^-1 K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: CO
    Material Description = Carbon Monoxide CO
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 16.6E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 28.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03262452E+02 []
          NASA a2 = 0.01511941E-01 [K^-1]
          NASA a3 = -0.03881755E-04 [K^-2]
          NASA a4 = 0.05581944E-07 [K^-3]
          NASA a5 = -0.02474951E-10 [K^-4]
          NASA a6 = -0.01431054E+06 [K]
          NASA a7 = 0.04848897E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03025078E+02 []
          NASA a2 = 0.01442689E-01 [K^-1]
          NASA a3 = -0.05630828E-05 [K^-2]
          NASA a4 = 0.01018581E-08 [K^-3]
          NASA a5 = -0.06910952E-13 [K^-4]
          NASA a6 = -0.01426835E+06 [K]
          NASA a7 = 0.06108218E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 251E-04 [W m^-1 K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: CO2
    Material Description = Carbon Dioxide CO2
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 14.9E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 44.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.02275725E+02 []
          NASA a2 = 0.09922072E-01 [K^-1]
          NASA a3 = -0.01040911E-03 [K^-2]
          NASA a4 = 0.06866687E-07 [K^-3]
          NASA a5 = -0.02117280E-10 [K^-4]
          NASA a6 = -0.04837314E+06 [K]
          NASA a7 = 0.01018849E+03 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.04453623E+02 []
          NASA a2 = 0.03140169E-01 [K^-1]
          NASA a3 = -0.01278411E-04 [K^-2]
          NASA a4 = 0.02393997E-08 [K^-3]
          NASA a5 = -0.01669033E-12 [K^-4]
          NASA a6 = -0.04896696E+06 [K]
          NASA a7 = -0.09553959E+01 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 145E-04 [W m^-1 K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: GAS
    Material Group = User
    Object Origin = User
    Option = Reacting Mixture
    Reactions List = Methane Air WD2 NO PDF
  END
END

LIBRARY: 
  &replace MATERIAL: H2O
    Material Description = Water Vapour
    Material Group = Gas Phase Combustion, Interphase Mass Transfer, Water Data
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 9.4E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 18.02 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03386842E+02 []
          NASA a2 = 0.03474982E-01 [K^-1]
          NASA a3 = -0.06354696E-04 [K^-2]
          NASA a4 = 0.06968581E-07 [K^-3]
          NASA a5 = -0.02506588E-10 [K^-4]
          NASA a6 = -0.03020811E+06 [K]
          NASA a7 = 0.02590233E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.02672146E+02 []
          NASA a2 = 0.03056293E-01 [K^-1]
          NASA a3 = -0.08730260E-05 [K^-2]
          NASA a4 = 0.01200996E-08 [K^-3]
          NASA a5 = -0.06391618E-13 [K^-4]
          NASA a6 = -0.02989921E+06 [K]
          NASA a7 = 0.06862817E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 193E-04 [W m^-1 K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: N2
    Material Description = Nitrogen N2
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 17.7E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 28.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03298677E+02 []
          NASA a2 = 0.01408240E-01 [K^-1]
          NASA a3 = -0.03963222E-04 [K^-2]
          NASA a4 = 0.05641515E-07 [K^-3]
          NASA a5 = -0.02444855E-10 [K^-4]
          NASA a6 = -0.01020900E+05 [K]
          NASA a7 = 0.03950372E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.02926640E+02 []
          NASA a2 = 0.01487977E-01 [K^-1]
          NASA a3 = -0.05684761E-05 [K^-2]
          NASA a4 = 0.01009704E-08 [K^-3]
          NASA a5 = -0.06753351E-13 [K^-4]
          NASA a6 = -0.09227977E+04 [K]
          NASA a7 = 0.05980528E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 259E-04 [W m^-1 K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: NO
    Material Description = Nitric Oxide NO
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 17.8E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 30.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03376542E+02 []
          NASA a2 = 0.01253063E-01 [K^-1]
          NASA a3 = -0.03302751E-04 [K^-2]
          NASA a4 = 0.05217810E-07 [K^-3]
          NASA a5 = -0.02446263E-10 [K^-4]
          NASA a6 = 0.09817961E+05 [K]
          NASA a7 = 0.05829590E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03245435E+02 []
          NASA a2 = 0.01269138E-01 [K^-1]
          NASA a3 = -0.05015890E-05 [K^-2]
          NASA a4 = 0.09169283E-09 [K^-3]
          NASA a5 = -0.06275419E-13 [K^-4]
          NASA a6 = 0.09800840E+05 [K]
          NASA a7 = 0.06417294E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 238E-04 [W m^-1 K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: O2
    Material Description = Oxygen O2
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 19.2E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 31.99 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03212936E+02 []
          NASA a2 = 0.01127486E-01 [K^-1]
          NASA a3 = -0.05756150E-05 [K^-2]
          NASA a4 = 0.01313877E-07 [K^-3]
          NASA a5 = -0.08768554E-11 [K^-4]
          NASA a6 = -0.01005249E+05 [K]
          NASA a7 = 0.06034738E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03697578E+02 []
          NASA a2 = 0.06135197E-02 [K^-1]
          NASA a3 = -0.01258842E-05 [K^-2]
          NASA a4 = 0.01775281E-09 [K^-3]
          NASA a5 = -0.01136435E-13 [K^-4]
          NASA a6 = -0.01233930E+05 [K]
          NASA a7 = 0.03189166E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 266E-04 [W m^-1 K^-1]
      END
    END
  END
END
"
