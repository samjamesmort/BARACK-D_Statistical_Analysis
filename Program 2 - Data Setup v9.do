********************************************************************************
* PROJECT:      BARACK-D
* PROGRAM:      Program 2 - Data Setup
* WRITTEN BY:   Sam Mort
* DATE:         24 February 2023
* SOFTWARE:     Stata 16.1 (SE)
*
* NOTES:        Code for hard lock 23.02.2023
*               Changes from previous soft lock (01.12.2022) dataset:
*               - 305 additional variables - Variables with information about
*                 CRF version number and name, these were not downloaded 
*                 previously, does not affect the analysis.
********************************************************************************

clear all

global spssdata = "2023-02-23-144057750"
global sortition = "2023-03-28"


cd "K:\CV_R\BARACK-D\STATS\4. Analysis"

set maxvar 32767

global today = string(daily("$S_DATE", "DMY"), "%tdDmCY")


use "2.Data for Analysis (e.g. dta or sas)\BARACK-D SPSS_DAT$spssdata.dta", clear

/*
_E1			SCREENING
	_C1 	Screening Form v2.0
	_C2		Screening Form v1.0

_E2			eGFR 
	_C3		eGFR Monitoring v2.0
	_C4		eGFR Monitoring v1.0
	
_E3			BASELINE
	_C5		Baseline v2.0
	_C6		Baseline v1.0
	_C7		Concomitant Medications v1.0
	_C8		Medication Monitoring Diary v1.0
	_C9		EQ-5D-5L Questionnaire v1.0
	_C10	KDQoL Questionnaire v1.0
	_C11	ICECAP Questionnaire v1.0
	_C12	QoL VAS Questionnaire v1.0
	_C13	Additional Laboratory Test Results v1.0
	
_E4			VISIT 1
	_C14	Visit 1 v1.0
	_C15	Additional Laboratory Test Results v1.0
	
_E5			VISIT 2
	_C16	Visit 2 v1.0
	_C17	Additional Laboratory Test Results v1.0

_E6			VISIT 3
	_C18	Visit 3	v1.0
	_C19 	Additional Laboratory Test Results v1.0

_E7			VISIT 4
	_C20	Visit 4	v1.0
	_C21	Concomitant Medications v1.0
	_C22	Blood Pressure Monitoring Diary v1.0
	_C23	Medication Monitoring Diary v1.0
	_C24	Health Resource Use Diary v1.0
	_C25	Additional Laboratory Test Results v1.0

_E8			VISIT 5
	_C26	Visit 5 v1.0
	_C27	Concomitant Medications v1.0
	_C28	Medication Monitoring Diary v1.0
	_C29	Health Resource Use Diary v1.0
	_C30	EQ-5D-5L Questionnaire v1.0
	_C31	KDQoL Questionnaire v1.0
	_C32 	ICECAP Questionnaire v1.0
	_C33	QoL VAS Questionnaire v1.0
	_C34	Additional Laboratory Test Results v1.0
	

_E9			VISIT 6
	_C35	Visit 6 v1.0
	_C36	Health Resource Use Diary v1.0
	_C37	Additional Laboratory Test Results v1.0
	
_E10		VISIT 7
	_C38	Visit 7 v1.0
	_C39	Concomitant Medications v1.0
	_C40 	Blood Pressure Monitoring Diary v1.0
	_C41	Medication Monitoring Diary v1.0
	_C42 	Health Resource Use Diary v1.0
	_C43	EQ-5D-5L Questionnaire v1.0
	_C44	KDQoL Questionnaire v1.0
	_C45	ICECAP Questionnaire v1.0
	_C46	QoL VAS Questionnaire v1.0
	_C47	Additional Laboratory Test Results v1.0
	
_E11		VISIT 8
	_C48	Visit 8 v1.0
	_C49	Health Resource Use Diary v1.0
	_C50	Additional Laboratory Test Results v1.0

_E12		VISIT 9
	_C51	Visit 9 v1.0
	_C52	Concomitant Medications v1.0
	_C53	Blood Pressure Monitoring Diary v1.0
	_C54	Medication Monitoring Diary v1.0
	_C55	Health Resource Use Diary v1.0
	_C56	Additional Laboratory Test Results v1.0
	
_E13		VISIT 10
	_C57	Visit 10 v1.0
	_C58	Health Resource Use Diary v1.0
	_C59	Additional Laboratory Test Results v1.0

_E14		VISIT 11
	_C60	Visit 11 v1.0
	_C61	Concomitant Medications v1.0
	_C62	Blood Pressure Monitoring Diary v1.0
	_C63	Medication Monitoring Diary v1.0
	_C64	Health Resource Use Diary v1.0
	_C65	EQ-5D-5L Questionnaire v1.0
	_C66 	KDQoL Questionnaire v1.0
	_C67	ICECAP Questionnaire v1.0
	_C68	QoL VAS Questionnaire v1.0
	_C69 	Additional Laboratory Test Results v1.0

_E15		VISIT 12
	_C70	Visit 12 v1.0
	_C71	Health Resource Use Diary v1.0
	_C72	Additional Laboratory Test Results v1.0

_E16		VISIT 13
	_C73	Visit 13 v1.0
	_C74	Concomitant Medications v1.0
	_C75	Blood Pressure Monitoring Diary v1.0
	_C76	Medication Monitoring Diary v1.0
	_C77	Health Resource Use Diary v1.0
	_C78	Additional Laboratory Test Results v1.0
	
_E17		VISIT 14
	_C79	Visit 14 v1.0
	_C80	Health Resource Use Diary v1.0
	_C81	Additional Laboratory Test Results v1.0
	
_E18		VISIT 15
	_C82	Visit 15 v1.0
	_C83	Concomitant Medications v1.0
	_C84	Blood Pressure Monitoring Diary v1.0
	_C85	Medication Monitoring Diary v1.0
	_C86	Health Resource Use Diary v1.0
	_C87	EQ-5D-5L Questionnaire v1.0
	_C88	KDQoL Questionnaire v1.0
	_C89	ICECAP Questionnaire v1.0
	_C90	QoL VAS Questionnaire v1.0
	_C91	Additional Laboratory Test Results v1.0

_E19		ENDPOINT
	_C92	Endpoint Form v3.0
	_C93	Endpoint Form v2.0 (Removed - Merged with v3.0)

_E20		DISCONTINUATION
	_C94	Discontinuation Form v4.0 (Removed - Merged with v3.0)
	_C95	Discontinuation Form v3.0
	_C96	Discontinuation Form v2.0 (Removed - Merged with v1.0)
	_C97	Discontinuation Form v1.0
	
_E21		ADVERSE EVENTS
	_C98	Adverse Event Report Form v2.0
	_C99	Adverse Event Report Form v1.0 (Removed - Merged with v2.0)
	_C100 	Adverse Event MedDRA Coding Form v1.0
	
_E22		SERIOUS ADVERSE EVENTS
	_C101	Serious Adverse Event Report Form v2.0
	_C102	Serious Adverse Event Report Form v1.0
*/

des, short
/*
  obs:         1,985                          
 vars:         7,588 
*/

// Additionally downloaded variables - these were not downloaded previously
// Dropped because not needed for the analysis 
drop CRFVersionStatus*
drop VersionName*

des, short
/*
  obs:         1,985                          
 vars:         7,284  
      
*/

* Replace " " with missing ("") for every string variable
ds, has(type string)
foreach var of varlist `r(varlist)' {
	replace `var' = "" if `var' == " "
}

********************************************************************************
*********************************** SCREENING **********************************
******************************** _E1_C1 & _C1_C2 *******************************
********************************************************************************

egen VISDAT_SCR = rowmax(VISDAT_E1_C1 VISDAT_E1_C2)
format VISDAT_SCR %tdd_m_y
egen IEYN_SCR = rowmax(IEYN_E1_C1 IEYN_E1_C2)
label values IEYN_SCR IEYN_E1_C1
gen IETESTCD_SCR = IETESTCD_E1_C1 + IETESTCD_E1_C2
egen CONSENT_SCR = rowmax(CONSENT_E1_C1 CONSENT_E1_C2)
label values CONSENT_SCR CONSENT_E1_C1
egen VERSION_SCR = rowmax(VERSION_E1_C1)
label values VERSION_SCR VERSION_E1_C1

local varlist VISDAT IEYN IETESTCD CONSENT VERSION
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E1_C1'"
}
foreach s in `varlist' {
	foreach v of var `s'_SCR {
		label var `v' "`lbl`s''"
	}
}

drop VISDAT_E1_C1 IEYN_E1_C1 IETESTCD_E1_C1 CONSENT_E1_C1 VERSION_E1_C1 VISDAT_E1_C2 IEYN_E1_C2 IETESTCD_E1_C2 CONSENT_E1_C2

order VISDAT_SCR IEYN_SCR IETESTCD_SCR CONSENT_SCR VERSION_SCR, before(VISDAT_E2_1_C3)
    
********************************************************************************
******************************* SCREENING - EGFR *******************************
******************************** _E2_C3 & _E2_C4 *******************************
********************************************************************************

egen VISDAT_1_SCR = rowmax(VISDAT_E2_1_C3 VISDAT_E2_1_C4)
format VISDAT_1_SCR %tdd_m_y
egen SCRNUM_1_SCR = rowmax(SCRNUM_E2_1_C3 SCRNUM_E2_1_C4)
egen SYSBPR_1_SCR = rowmax(SYSBPR_E2_1_C3 SYSBPR_E2_1_C4)
egen DIABPR_1_SCR = rowmax(DIABPR_E2_1_C3 DIABPR_E2_1_C4)
egen SYSBPL_1_SCR = rowmax(SYSBPL_E2_1_C3 SYSBPL_E2_1_C4)
egen DIABPL_1_SCR = rowmax(DIABPL_E2_1_C3 DIABPL_E2_1_C4)
egen LBPERF_1_SCR = rowmax(LBPERF_E2_1_C3 LBPERF_E2_1_C4)
label values LBPERF_1_SCR LBPERF_E2_1_C3
gen GFR_1_SCR = GFR_E2_1_C3 + GFR_E2_1_C4
gen K_1_SCR = K_E2_1_C3 + K_E2_1_C4
gen CREAT_1_SCR = CREAT_E2_1_C3 + CREAT_E2_1_C4
egen SCRSTEP2_1_SCR = rowmax(SCRSTEP2_E2_1_C3 SCRSTEP_E2_1_C4)
label values SCRSTEP2_1_SCR SCRSTEP2_E2_1_C3

local varlist VISDAT SCRNUM SYSBPR DIABPR SYSBPL DIABPL LBPERF GFR K CREAT SCRSTEP2
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E2_1_C3'"
}
foreach s in `varlist' {
	foreach v of var `s'_1_SCR {
		label var `v' "`lbl`s''"
	}
}

drop VISDAT_E2_1_C3 SCRNUM_E2_1_C3 SYSBPR_E2_1_C3 DIABPR_E2_1_C3 SYSBPL_E2_1_C3 DIABPL_E2_1_C3 LBPERF_E2_1_C3 GFR_E2_1_C3 K_E2_1_C3 CREAT_E2_1_C3 SCRSTEP2_E2_1_C3 VISDAT_E2_1_C4 SCRNUM_E2_1_C4 SYSBPR_E2_1_C4 DIABPR_E2_1_C4 SYSBPL_E2_1_C4 DIABPL_E2_1_C4 LBPERF_E2_1_C4 GFR_E2_1_C4 K_E2_1_C4 CREAT_E2_1_C4 SCRSTEP_E2_1_C4

order VISDAT_1_SCR SCRNUM_1_SCR SYSBPR_1_SCR DIABPR_1_SCR SYSBPL_1_SCR DIABPL_1_SCR LBPERF_1_SCR GFR_1_SCR K_1_SCR CREAT_1_SCR SCRSTEP2_1_SCR, before(VISDAT_E2_2_C3)

rename VISDAT_E2_2_C3 VISDAT_2_SCR
rename SCRNUM_E2_2_C3 SCRNUM_2_SCR
rename SYSBPR_E2_2_C3 SYSBPR_2_SCR
rename DIABPR_E2_2_C3 DIABPR_2_SCR
rename SYSBPL_E2_2_C3 SYSBPL_2_SCR
rename DIABPL_E2_2_C3 DIABPL_2_SCR
rename LBPERF_E2_2_C3 LBPERF_2_SCR
rename GFR_E2_2_C3 GFR_2_SCR
rename K_E2_2_C3 K_2_SCR
rename CREAT_E2_2_C3 CREAT_2_SCR
rename SCRSTEP2_E2_2_C3 SCRSTEP2_2_SCR

********************************************************************************
*********************************** BASELINE ***********************************
******************************** _E3_C5 & _E3_C6 *******************************
********************************************************************************

egen VISDAT_BL = rowmax(VISDAT_E3_C5 VISDAT_E3_C6)
format VISDAT_BL %tdd_m_y
egen BRTHDAT_BL = rowmax(BRTHDAT_E3_C5 BRTHDAT_E3_C6)
format BRTHDAT_BL %tdd_m_y
gen SEX_BL = SEX_E3_C5 + SEX_E3_C6
egen ETHNIC_BL = rowmax(ETHNIC_E3_C5 ETHNIC_E3_C6)
label values ETHNIC_BL ETHNIC_E3_C5
gen ETHNICOT_BL = ETHNICOT_E3_C5
gen POSTCODE_BL = POSTCODE_E3_C5 + POSTCODE_E3_C6
egen WEIGHT_BL = rowmax(WEIGHT_E3_C5 WEIGHT_E3_C6)
egen HEIGHT_BL = rowmax(HEIGHT_E3_C5 HEIGHT_E3_C6)
egen WSTCIR_BL = rowmax(WSTCIR_E3_C5 WSTCIR_E3_C6)
egen HIPCIR_BL = rowmax(HIPCIR_E3_C5 HIPCIR_E3_C6)
egen SYSBPR_BL = rowmax(SYSBPR_E3_C5 SYSBPR_E3_C6)
egen DIABPR_BL = rowmax(DIABPR_E3_C5 DIABPR_E3_C6)
egen SYSBPL_BL = rowmax(SYSBPL_E3_C5 SYSBPL_E3_C6)
egen DIABPL_BL = rowmax(DIABPL_E3_C5 DIABPL_E3_C6)
egen SMOKSTAT_BL = rowmax(SMOKSTAT_E3_C5 SMOKSTAT_E3_C6)
label values SMOKSTAT_BL SMOKSTAT_E3_C5
egen HYPYN_BL = rowmax(HYPYN_E3_C5 HYPYN_E3_C6)
label values HYPYN_BL HYPYN_E3_C5
gen HYPSTDAT_BL = HYPSTDAT_E3_C5 + HYPSTDAT_E3_C6
egen DIAYN_BL = rowmax(DIAYN_E3_C5 DIAYN_E3_C6)
label values DIAYN_BL DIAYN_E3_C5
gen DIASTDAT_BL = DIASTDAT_E3_C5 + DIASTDAT_E3_C6
egen IMGYN_BL = rowmax(IMGYN_E3_C5 IMGYN_E3_C6)
label values IMGYN_BL IMGYN_E3_C5
gen IMGSTDAT_BL = IMGSTDAT_E3_C5 + IMGSTDAT_E3_C6
egen IHDYN_BL = rowmax(IHDYN_E3_C5 IHDYN_E3_C6)
label values IHDYN_BL IHDYN_E3_C5
egen HFYN_BL = rowmax(HFYN_E3_C5 HFYN_E3_C6)
label values HFYN_BL HFYN_E3_C5
gen HFTYPE_BL = HFTYPE_E3_C5 + HFTYPE_E3_C6
gen HFSTDAT_BL = HFSTDAT_E3_C5 + HFSTDAT_E3_C6
egen AFYN_BL = rowmax(AFYN_E3_C5 AFYN_E3_C6)
label values AFYN_BL AFYN_E3_C5
gen AFTYPE_BL = AFTYPE_E3_C5 + AFTYPE_E3_C6
gen AFSTDAT_BL = AFSTDAT_E3_C5 + AFSTDAT_E3_C6
egen CVDYN_BL = rowmax(CVDYN_E3_C5 CVDYN_E3_C6)
label values CVDYN_BL CVDYN_E3_C5
egen PVDYN_BL = rowmax(PVDYN_E3_C5 PVDYN_E3_C6)
label values PVDYN_BL PVDYN_E3_C5
egen RENYN_BL = rowmax(RENYN_E3_C5 RENYN_E3_C6)
label values RENYN_BL RENYN_E3_C5
egen CUTIYN_BL = rowmax(CUTIYN_E3_C5 CUTIYN_E3_C6)
label values CUTIYN_BL CUTIYN_E3_C5
egen AUTIYN_BL = rowmax(AUTIYN_E3_C5 AUTIYN_E3_C6)
label values AUTIYN_BL AUTIYN_E3_C5
egen THYYN_BL = rowmax(THYYN_E3_C5 THYYN_E3_C6)
label values THYYN_BL THYYN_E3_C5
gen THYSTDAT_BL = THYSTDAT_E3_C5 + THYSTDAT_E3_C6
egen ANAYN_BL = rowmax(ANAYN_E3_C5 ANAYN_E3_C6)
label values ANAYN_BL ANAYN_E3_C5
gen ANASTDAT_BL = ANASTDAT_E3_C5 + ANASTDAT_E3_C6
gen ANACAUS_BL = ANACAUS_E3_C5 + ANACAUS_E3_C6
egen OPEYN_BL = rowmax(OPEYN_E3_C5 OPEYN_E3_C6)
label values OPEYN_BL OPEYN_E3_C5
gen OPESTDAT_BL = OPESTDAT_E3_C5 + OPESTDAT_E3_C6
egen OPOYN_BL = rowmax(OPOYN_E3_C5 OPOYN_E3_C6)
label values OPOYN_BL OPOYN_E3_C5
gen OPOSTDAT_BL = OPOSTDAT_E3_C5 + OPOSTDAT_E3_C6
egen LBPERF_BL = rowmax(LBPERF_E3_C5 LBPERF_E3_C6)
label values LBPERF_BL LBPERF_E3_C5
egen FBCPERF_BL = rowmax(FBCPERF_E3_C5 FBCPERF_E3_C6)
label values FBCPERF_BL FBCPERF_E3_C5
egen HBAPERF_BL = rowmax(HBAPERF_E3_C5 HBAPERF_E3_C6)
label values HBAPERF_BL HBAPERF_E3_C5
egen FBSPERF_BL = rowmax(FBSPERF_E3_C5 FBSPERF_E3_C6)
label values FBSPERF_BL FBSPERF_E3_C5
egen BNPPERF_BL = rowmax(BNPPERF_E3_C5 BNPPERF_E3_C6)
label values BNPPERF_BL BNPPERF_E3_C5
egen ACRPERF_BL = rowmax(ACRPERF_E3_C5 ACRPERF_E3_C6)
label values ACRPERF_BL ACRPERF_E3_C5
egen EGPERF_BL = rowmax(EGPERF_E3_C5 EGPERF_E3_C6)
label values EGPERF_BL EGPERF_E3_C5
egen FBCCLSIG_BL = rowmax(FBCCLSIG_E3_C5 FBCCLSIG_E3_C6)
label values FBCCLSIG_BL FBCCLSIG_E3_C5
gen FBCDET_BL = FBCDET_E3_C5 + FBCDET_E3_C6
egen RENCLSIG_BL = rowmax(RENCLSIG_E3_C5 RENCLSIG_E3_C6)
label values RENCLSIG_BL RENCLSIG_E3_C5
gen RENDET_BL = RENDET_E3_C5 + RENDET_E3_C6
egen LIVCLSIG_BL = rowmax(LIVCLSIG_E3_C5 LIVCLSIG_E3_C6)
label values LIVCLSIG_BL LIVCLSIG_E3_C5
gen LIVDET_BL = LIVDET_E3_C5 + LIVDET_E3_C6
egen BONCLSIG_BL = rowmax(BONCLSIG_E3_C5 BONCLSIG_E3_C6)
label values BONCLSIG_BL BONCLSIG_E3_C5
gen BONDET_BL = BONDET_E3_C5 + BONDET_E3_C6
egen LIPCLSIG_BL = rowmax(LIPCLSIG_E3_C5 LIPCLSIG_E3_C6)
label values LIPCLSIG_BL LIPCLSIG_E3_C5
gen LIPDET_BL = LIPDET_E3_C5 + LIPDET_E3_C6
egen HBACLSIG_BL = rowmax(HBACLSIG_E3_C5 HBACLSIG_E3_C6)
label values HBACLSIG_BL HBACLSIG_E3_C5
gen HBADET_BL = HBADET_E3_C5 + HBADET_E3_C6
egen FBSCLSIG_BL = rowmax(FBSCLSIG_E3_C5 FBSCLSIG_E3_C6)
label values FBSCLSIG_BL FBSCLSIG_E3_C5
gen FBSDET_BL = FBSDET_E3_C5 + FBSDET_E3_C6
egen BNPCLSIG_BL = rowmax(BNPCLSIG_E3_C5 BNPCLSIG_E3_C6)
label values BNPCLSIG_BL BNPCLSIG_E3_C5
gen BNPDET_BL = BNPDET_E3_C5 + BNPDET_E3_C6
egen ECGCLSIG_BL = rowmax(ECGCLSIG_E3_C5 ECGCLSIG_E3_C6)
label values ECGCLSIG_BL ECGCLSIG_E3_C5
gen ECGDET_BL = ECGDET_E3_C5 + ECGDET_E3_C6
gen ALBCREAT_BL = ALBCREAT_E3_C5 + ALBCREAT_E3_C6
gen GFR_BL = GFR_E3_C5 + GFR_E3_C6
gen K_BL = K_E3_C5 + K_E3_C6
gen CREAT_BL = CREAT_E3_C5 + CREAT_E3_C6
egen RANDELIG_BL = rowmax(RANDELIG_E3_C5 RANDELIG_E3_C6)
label values RANDELIG_BL RANDELIG_E3_C5
egen RANDDAT_BL = rowmax(RANDDAT_E3_C5 RANDDAT_E3_C6)
format RANDDAT_BL %tdd_m_y

local varlist VISDAT BRTHDAT SEX ETHNIC ETHNICOT POSTCODE WEIGHT HEIGHT WSTCIR HIPCIR SYSBPR DIABPR SYSBPL DIABPL SMOKSTAT HYPYN HYPSTDAT DIAYN DIASTDAT IMGYN IMGSTDAT IHDYN HFYN HFTYPE HFSTDAT AFYN AFTYPE AFSTDAT CVDYN PVDYN RENYN CUTIYN AUTIYN THYYN THYSTDAT ANAYN ANASTDAT ANACAUS OPEYN OPESTDAT OPOYN OPOSTDAT LBPERF FBCPERF HBAPERF FBSPERF BNPPERF ACRPERF EGPERF FBCCLSIG FBCDET RENCLSIG RENDET LIVCLSIG LIVDET BONCLSIG BONDET LIPCLSIG LIPDET HBACLSIG HBADET FBSCLSIG FBSDET BNPCLSIG BNPDET ECGCLSIG ECGDET ALBCREAT GFR K CREAT RANDELIG RANDDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5'"
}
foreach s in `varlist' {
	foreach v of var `s'_BL {
		label var `v' "`lbl`s''"
	}
}

egen PHENOYN_BL = rowmax(PHENOYN_E3_C6)
label values PHENOYN_BL PHENOYN_E3_C6
egen PWVYN_BL = rowmax(PWVYN_E3_C6)
label values PWVYN_BL PWVYN_E3_C6
egen v_24HBPYN_BL = rowmax(v_24HBPYN_E3_C6)
label values v_24HBPYN_BL v_24HBPYN_E3_C6
gen v_24HBPID_BL = v_24HBPID_E3_C6

local varlist PHENOYN PWVYN v_24HBPYN v_24HBPID
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C6'"
}
foreach s in `varlist' {
	foreach v of var `s'_BL {
		label var `v' "`lbl`s''"
	}
}

gen IHDEVNT_1_BL = IHDEVNT_E3_C5_1 + IHDEVNT_E3_C6_1
gen IHDSTDAT_1_BL = IHDSTDAT_E3_C5_1 + IHDSTDAT_E3_C6_1
gen IHDEVNT_2_BL = IHDEVNT_E3_C5_2 + IHDEVNT_E3_C6_2
gen IHDSTDAT_2_BL = IHDSTDAT_E3_C5_2 + IHDSTDAT_E3_C6_2
gen IHDEVNT_3_BL = IHDEVNT_E3_C5_3 + IHDEVNT_E3_C6_3
gen IHDSTDAT_3_BL = IHDSTDAT_E3_C5_3 + IHDSTDAT_E3_C6_3
gen IHDEVNT_4_BL = IHDEVNT_E3_C5_4 + IHDEVNT_E3_C6_4
gen IHDSTDAT_4_BL = IHDSTDAT_E3_C5_4 + IHDSTDAT_E3_C6_4
gen IHDEVNT_5_BL = IHDEVNT_E3_C5_5 + IHDEVNT_E3_C6_5
gen IHDSTDAT_5_BL = IHDSTDAT_E3_C5_5 + IHDSTDAT_E3_C6_5
gen IHDEVNT_6_BL = IHDEVNT_E3_C5_6 + CVDEVNT_E3_C6_1
gen IHDSTDAT_6_BL = IHDSTDAT_E3_C5_6
gen CVDEVNT_1_BL = CVDEVNT_E3_C5_1
gen CVDSTDAT_1_BL = CVDSTDAT_E3_C5_1 + CVDSTDAT_E3_C6_1
gen CVDEVNT_2_BL = CVDEVNT_E3_C5_2 + CVDEVNT_E3_C6_2
gen CVDSTDAT_2_BL = CVDSTDAT_E3_C5_2 + CVDSTDAT_E3_C6_2
gen CVDEVNT_3_BL = CVDEVNT_E3_C5_3 + CVDEVNT_E3_C6_3
gen CVDSTDAT_3_BL = CVDSTDAT_E3_C5_3 + CVDSTDAT_E3_C6_3
gen CVDEVNT_4_BL = CVDEVNT_E3_C5_4 + CVDEVNT_E3_C6_4
gen CVDSTDAT_4_BL = CVDSTDAT_E3_C5_4 + CVDSTDAT_E3_C6_4
gen PVDTYPE_1_BL = PVDTYPE_E3_C5_1 + PVDTYPE_E3_C6_1
gen PVDSTDAT_1_BL = PVDSTDAT_E3_C5_1 + PVDSTDAT_E3_C6_1
gen PVDTYPE_2_BL = PVDTYPE_E3_C5_2 + PVDTYPE_E3_C6_2
gen PVDSTDAT_2_BL = PVDSTDAT_E3_C5_2 + PVDSTDAT_E3_C6_2
gen PVDTYPE_3_BL = PVDTYPE_E3_C5_3 + PVDTYPE_E3_C6_3
gen PVDSTDAT_3_BL = PVDSTDAT_E3_C5_3 + PVDSTDAT_E3_C6_3
gen PVDTYPE_4_BL = PVDTYPE_E3_C5_4 + PVDTYPE_E3_C6_4
gen PVDSTDAT_4_BL = PVDSTDAT_E3_C5_4 + PVDSTDAT_E3_C6_4
gen RENTYPE_1_BL = RENTYPE_E3_C5_1 + RENTYPE_E3_C6_1
gen RENSTDAT_1_BL = RENSTDAT_E3_C5_1 + RENSTDAT_E3_C6_1
gen RENTYPE_2_BL = RENTYPE_E3_C5_2 + RENTYPE_E3_C6_2 
gen RENSTDAT_2_BL = RENSTDAT_E3_C5_2 + RENSTDAT_E3_C6_2
gen RENTYPE_3_BL = RENTYPE_E3_C5_3 + RENTYPE_E3_C6_3
gen RENSTDAT_3_BL = RENSTDAT_E3_C5_3 + RENSTDAT_E3_C6_3
gen RENTYPE_4_BL = RENTYPE_E3_C5_4 + RENTYPE_E3_C6_4
gen RENSTDAT_4_BL = RENSTDAT_E3_C5_4 + RENSTDAT_E3_C6_4

local varlist IHDEVNT IHDSTDAT CVDEVNT CVDSTDAT PVDTYPE PVDSTDAT RENTYPE RENSTDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5_1'"
}
foreach s in `varlist' {
	foreach v of var `s'_1_BL {
		label var `v' "`lbl`s''"
	}
}

local varlist IHDEVNT IHDSTDAT CVDEVNT CVDSTDAT PVDTYPE PVDSTDAT RENTYPE RENSTDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5_2'"
}
foreach s in `varlist' {
	foreach v of var `s'_2_BL {
		label var `v' "`lbl`s''"
	}
}

local varlist IHDEVNT IHDSTDAT CVDEVNT CVDSTDAT PVDTYPE PVDSTDAT RENTYPE RENSTDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5_3'"
}
foreach s in `varlist' {
	foreach v of var `s'_3_BL {
		label var `v' "`lbl`s''"
	}
}

local varlist IHDEVNT IHDSTDAT CVDEVNT CVDSTDAT PVDTYPE PVDSTDAT RENTYPE RENSTDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5_4'"
}
foreach s in `varlist' {
	foreach v of var `s'_4_BL {
		label var `v' "`lbl`s''"
	}
}

local varlist IHDEVNT IHDSTDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5_5'"
}
foreach s in `varlist' {
	foreach v of var `s'_5_BL {
		label var `v' "`lbl`s''"
	}
}

local varlist IHDEVNT IHDSTDAT
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E3_C5_6'"
}
foreach s in `varlist' {
	foreach v of var `s'_6_BL {
		label var `v' "`lbl`s''"
	}
}

drop VISDAT_E3_C5 BRTHDAT_E3_C5 SEX_E3_C5 ETHNIC_E3_C5 ETHNICOT_E3_C5 POSTCODE_E3_C5 WEIGHT_E3_C5 HEIGHT_E3_C5 WSTCIR_E3_C5 HIPCIR_E3_C5 SYSBPR_E3_C5 DIABPR_E3_C5 SYSBPL_E3_C5 DIABPL_E3_C5 SMOKSTAT_E3_C5 HYPYN_E3_C5 HYPSTDAT_E3_C5 DIAYN_E3_C5 DIASTDAT_E3_C5 IMGYN_E3_C5 IMGSTDAT_E3_C5 IHDYN_E3_C5 HFYN_E3_C5 HFTYPE_E3_C5 HFSTDAT_E3_C5 AFYN_E3_C5 AFTYPE_E3_C5 AFSTDAT_E3_C5 CVDYN_E3_C5 PVDYN_E3_C5 RENYN_E3_C5 CUTIYN_E3_C5 AUTIYN_E3_C5 THYYN_E3_C5 THYSTDAT_E3_C5 ANAYN_E3_C5 ANASTDAT_E3_C5 ANACAUS_E3_C5 OPEYN_E3_C5 OPESTDAT_E3_C5 OPOYN_E3_C5 OPOSTDAT_E3_C5 LBPERF_E3_C5 FBCPERF_E3_C5 HBAPERF_E3_C5 FBSPERF_E3_C5 BNPPERF_E3_C5 ACRPERF_E3_C5 EGPERF_E3_C5 FBCCLSIG_E3_C5 FBCDET_E3_C5 RENCLSIG_E3_C5 RENDET_E3_C5 LIVCLSIG_E3_C5 LIVDET_E3_C5 BONCLSIG_E3_C5 BONDET_E3_C5 LIPCLSIG_E3_C5 LIPDET_E3_C5 HBACLSIG_E3_C5 HBADET_E3_C5 FBSCLSIG_E3_C5 FBSDET_E3_C5 BNPCLSIG_E3_C5 BNPDET_E3_C5 ECGCLSIG_E3_C5 ECGDET_E3_C5 ALBCREAT_E3_C5 GFR_E3_C5 K_E3_C5 CREAT_E3_C5 RANDELIG_E3_C5 RANDDAT_E3_C5 IHDEVNT_E3_C5_1 IHDSTDAT_E3_C5_1 IHDEVNT_E3_C5_2 IHDSTDAT_E3_C5_2 IHDEVNT_E3_C5_3 IHDSTDAT_E3_C5_3 IHDEVNT_E3_C5_4 IHDSTDAT_E3_C5_4 IHDEVNT_E3_C5_5 IHDSTDAT_E3_C5_5 IHDEVNT_E3_C5_6 IHDSTDAT_E3_C5_6 CVDEVNT_E3_C5_1 CVDSTDAT_E3_C5_1 CVDEVNT_E3_C5_2 CVDSTDAT_E3_C5_2 CVDEVNT_E3_C5_3 CVDSTDAT_E3_C5_3 CVDEVNT_E3_C5_4 CVDSTDAT_E3_C5_4 PVDTYPE_E3_C5_1 PVDSTDAT_E3_C5_1 PVDTYPE_E3_C5_2 PVDSTDAT_E3_C5_2 PVDTYPE_E3_C5_3 PVDSTDAT_E3_C5_3 PVDTYPE_E3_C5_4 PVDSTDAT_E3_C5_4 RENTYPE_E3_C5_1 RENSTDAT_E3_C5_1 RENTYPE_E3_C5_2 RENSTDAT_E3_C5_2 RENTYPE_E3_C5_3 RENSTDAT_E3_C5_3 RENTYPE_E3_C5_4 RENSTDAT_E3_C5_4 VISDAT_E3_C6 BRTHDAT_E3_C6 SEX_E3_C6 ETHNIC_E3_C6 POSTCODE_E3_C6 WEIGHT_E3_C6 HEIGHT_E3_C6 WSTCIR_E3_C6 HIPCIR_E3_C6 SYSBPR_E3_C6 DIABPR_E3_C6 SYSBPL_E3_C6 DIABPL_E3_C6 SMOKSTAT_E3_C6 HYPYN_E3_C6 HYPSTDAT_E3_C6 DIAYN_E3_C6 DIASTDAT_E3_C6 IMGYN_E3_C6 IMGSTDAT_E3_C6 IHDYN_E3_C6 HFYN_E3_C6 HFTYPE_E3_C6 HFSTDAT_E3_C6 AFYN_E3_C6 AFTYPE_E3_C6 AFSTDAT_E3_C6 CVDYN_E3_C6 PVDYN_E3_C6 RENYN_E3_C6 CUTIYN_E3_C6 AUTIYN_E3_C6 THYYN_E3_C6 THYSTDAT_E3_C6 ANAYN_E3_C6 ANASTDAT_E3_C6 ANACAUS_E3_C6 OPEYN_E3_C6 OPESTDAT_E3_C6 OPOYN_E3_C6 OPOSTDAT_E3_C6 LBPERF_E3_C6 FBCPERF_E3_C6 HBAPERF_E3_C6 FBSPERF_E3_C6 BNPPERF_E3_C6 ACRPERF_E3_C6 EGPERF_E3_C6 FBCCLSIG_E3_C6 FBCDET_E3_C6 RENCLSIG_E3_C6 RENDET_E3_C6 LIVCLSIG_E3_C6 LIVDET_E3_C6 BONCLSIG_E3_C6 BONDET_E3_C6 LIPCLSIG_E3_C6 LIPDET_E3_C6 HBACLSIG_E3_C6 HBADET_E3_C6 FBSCLSIG_E3_C6 FBSDET_E3_C6 BNPCLSIG_E3_C6 BNPDET_E3_C6 ECGCLSIG_E3_C6 ECGDET_E3_C6 ALBCREAT_E3_C6 GFR_E3_C6 K_E3_C6 CREAT_E3_C6 RANDELIG_E3_C6 RANDDAT_E3_C6 PHENOYN_E3_C6 PWVYN_E3_C6 v_24HBPYN_E3_C6 v_24HBPID_E3_C6 IHDEVNT_E3_C6_1 IHDSTDAT_E3_C6_1 IHDEVNT_E3_C6_2 IHDSTDAT_E3_C6_2 IHDEVNT_E3_C6_3 IHDSTDAT_E3_C6_3 IHDEVNT_E3_C6_4 IHDSTDAT_E3_C6_4 IHDEVNT_E3_C6_5 IHDSTDAT_E3_C6_5 CVDEVNT_E3_C6_1 CVDSTDAT_E3_C6_1 CVDEVNT_E3_C6_2 CVDSTDAT_E3_C6_2 CVDEVNT_E3_C6_3 CVDSTDAT_E3_C6_3 CVDEVNT_E3_C6_4 CVDSTDAT_E3_C6_4 PVDTYPE_E3_C6_1 PVDSTDAT_E3_C6_1 PVDTYPE_E3_C6_2 PVDSTDAT_E3_C6_2 PVDTYPE_E3_C6_3 PVDSTDAT_E3_C6_3 PVDTYPE_E3_C6_4 PVDSTDAT_E3_C6_4 RENTYPE_E3_C6_1 RENSTDAT_E3_C6_1 RENTYPE_E3_C6_2 RENSTDAT_E3_C6_2 RENTYPE_E3_C6_3 RENSTDAT_E3_C6_3 RENTYPE_E3_C6_4 RENSTDAT_E3_C6_4

order VISDAT_BL BRTHDAT_BL SEX_BL ETHNIC_BL ETHNICOT_BL POSTCODE_BL WEIGHT_BL HEIGHT_BL WSTCIR_BL HIPCIR_BL SYSBPR_BL DIABPR_BL SYSBPL_BL DIABPL_BL SMOKSTAT_BL HYPYN_BL HYPSTDAT_BL DIAYN_BL DIASTDAT_BL IMGYN_BL IMGSTDAT_BL IHDYN_BL HFYN_BL HFTYPE_BL HFSTDAT_BL AFYN_BL AFTYPE_BL AFSTDAT_BL CVDYN_BL PVDYN_BL RENYN_BL CUTIYN_BL AUTIYN_BL THYYN_BL THYSTDAT_BL ANAYN_BL ANASTDAT_BL ANACAUS_BL OPEYN_BL OPESTDAT_BL OPOYN_BL OPOSTDAT_BL LBPERF_BL FBCPERF_BL HBAPERF_BL FBSPERF_BL BNPPERF_BL ACRPERF_BL EGPERF_BL FBCCLSIG_BL FBCDET_BL RENCLSIG_BL RENDET_BL LIVCLSIG_BL LIVDET_BL BONCLSIG_BL BONDET_BL LIPCLSIG_BL LIPDET_BL HBACLSIG_BL HBADET_BL FBSCLSIG_BL FBSDET_BL BNPCLSIG_BL BNPDET_BL ECGCLSIG_BL ECGDET_BL ALBCREAT_BL GFR_BL K_BL CREAT_BL RANDELIG_BL RANDDAT_BL PHENOYN_BL PWVYN_BL v_24HBPYN_BL v_24HBPID_BL IHDEVNT_1_BL IHDSTDAT_1_BL IHDEVNT_2_BL IHDSTDAT_2_BL IHDEVNT_3_BL IHDSTDAT_3_BL IHDEVNT_4_BL IHDSTDAT_4_BL IHDEVNT_5_BL IHDSTDAT_5_BL IHDEVNT_6_BL IHDSTDAT_6_BL CVDEVNT_1_BL CVDSTDAT_1_BL CVDEVNT_2_BL CVDSTDAT_2_BL CVDEVNT_3_BL CVDSTDAT_3_BL CVDEVNT_4_BL CVDSTDAT_4_BL PVDTYPE_1_BL PVDSTDAT_1_BL PVDTYPE_2_BL PVDSTDAT_2_BL PVDTYPE_3_BL PVDSTDAT_3_BL PVDTYPE_4_BL PVDSTDAT_4_BL RENTYPE_1_BL RENSTDAT_1_BL RENTYPE_2_BL RENSTDAT_2_BL RENTYPE_3_BL RENSTDAT_3_BL RENTYPE_4_BL RENSTDAT_4_BL, before(VISITNUM_E3_C7)

********************************************************************************
********************** BASELINE - CONCOMITANT MEDICATIONS **********************
************************************ _E3_C7 ************************************
********************************************************************************

rename VISITNUM_E3_C7 VISITNUM_CON_BL
rename *_E3_C7 *_BL
rename *_E3_C7_1 *_1_BL
rename *_E3_C7_2 *_2_BL
rename *_E3_C7_3 *_3_BL
rename *_E3_C7_4 *_4_BL
rename *_E3_C7_5 *_5_BL
rename *_E3_C7_6 *_6_BL
rename *_E3_C7_7 *_7_BL
rename *_E3_C7_8 *_8_BL
rename *_E3_C7_9 *_9_BL
rename *_E3_C7_10 *_10_BL
rename *_E3_C7_11 *_11_BL
rename *_E3_C7_12 *_12_BL
rename *_E3_C7_13 *_13_BL
rename *_E3_C7_14 *_14_BL
rename *_E3_C7_15 *_15_BL
rename *_E3_C7_16 *_16_BL
rename *_E3_C7_17 *_17_BL
rename *_E3_C7_18 *_18_BL
rename *_E3_C7_19 *_19_BL
rename *_E3_C7_20 *_20_BL
rename *_E3_C7_21 *_21_BL
rename *_E3_C7_22 *_22_BL
rename *_E3_C7_23 *_23_BL
rename *_E3_C7_24 *_24_BL
rename *_E3_C7_25 *_25_BL
rename *_E3_C7_26 *_26_BL
rename *_E3_C7_27 *_27_BL
rename *_E3_C7_28 *_28_BL

********************************************************************************
******************** BASELINE - MEDICATION MONITORING DIARY ********************
************************************ _E3_C8 ************************************
********************************************************************************

rename VISITNUM_E3_C8 VISITNUM_MEDS_BL
rename *_E3_C8 *_MEDS_BL
rename *_E3_C8_1 *_1_MEDS_BL
rename *_E3_C8_2 *_2_MEDS_BL

********************************************************************************
*********************** BASELINE - EQ-5D-5L QUESTIONNAIRE **********************
************************************ _E3_C9 ************************************
********************************************************************************

rename VISITNUM_E3_C9 VISITNUM_EQ5D_BL
rename *_E3_C9 *_BL

********************************************************************************
************************ BASELINE - KDQOL QUESTIONNAIRE ************************
************************************ _E3_C10 ***********************************
********************************************************************************

rename VISITNUM_E3_C10 VISITNUM_KDQOL_BL
rename *_E3_C10 *_BL

********************************************************************************
*********************** BASELINE - ICECAP QUESTIONNAIRE ************************
************************************ _E3_C11 ***********************************
********************************************************************************

rename VISITNUM_E3_C11 VISITNUM_ICECAP_BL
rename *_E3_C11 *_BL

********************************************************************************
*********************** BASELINE - QOL VAS QUESTIONNAIRE ***********************
************************************ _E3_C12 ***********************************
********************************************************************************

rename VISITNUM_E3_C12 VISITNUM_QOLVAS_BL
rename *_E3_C12 *_BL

********************************************************************************
***************** BASELINE - ADDITIONAL LABORATORY TEST RESULTS ****************
************************************ _E3_C13 ***********************************
********************************************************************************

rename VISITNUM_E3_C13 VISITNUM_ADDLAB_BL
rename *_E3_C13 *_BL

********************************************************************************
************************************ VISIT 1 ***********************************
*********************************** _E4_C14 ************************************
********************************************************************************

rename *_E4_C14 *_V1

********************************************************************************
***************** VISIT 1 - ADDITIONAL LABORATORY TEST RESULTS *****************
*********************************** _E4_C15 ************************************
********************************************************************************

rename VISITNUM_E4_C15 VISITNUM_ADDLAB_V1
rename *_E4_C15 *_V1

********************************************************************************
************************************ VISIT 2 ***********************************
*********************************** _E5_C16 ************************************
********************************************************************************

rename *_E5_C16 *_V2

********************************************************************************
***************** VISIT 2 - ADDITIONAL LABORATORY TEST RESULTS *****************
*********************************** _E4_C17 ************************************
********************************************************************************

rename VISITNUM_E5_C17 VISITNUM_ADDLAB_V2
rename *_E5_C17 *_V2

********************************************************************************
************************************ VISIT 3 ***********************************
*********************************** _E6_C18 ************************************
********************************************************************************

rename *_E6_C18 *_V3

********************************************************************************
***************** VISIT 3 - ADDITIONAL LABORATORY TEST RESULTS *****************
*********************************** _E6_C19 ************************************
********************************************************************************

rename VISITNUM_E6_C19 VISITNUM_ADDLAB_V3
rename *_E6_C19 *_V3

********************************************************************************
************************************ VISIT 4 ***********************************
*********************************** _E7_C20 ************************************
********************************************************************************

rename *_E7_C20 *_V4

********************************************************************************
*********************** VISIT 4 - CONCOMITANT MEDICATIONS **********************
************************************ _E7_C21 ************************************
********************************************************************************

rename VISITNUM_E7_C21 VISITNUM_CON_V4
rename *_E7_C21 *_V4
rename *_E7_C21_1 *_1_V4
rename *_E7_C21_2 *_2_V4
rename *_E7_C21_3 *_3_V4
rename *_E7_C21_4 *_4_V4
rename *_E7_C21_5 *_5_V4
rename *_E7_C21_6 *_6_V4
rename *_E7_C21_7 *_7_V4
rename *_E7_C21_8 *_8_V4
rename *_E7_C21_9 *_9_V4
rename *_E7_C21_10 *_10_V4
rename *_E7_C21_11 *_11_V4
rename *_E7_C21_12 *_12_V4
rename *_E7_C21_13 *_13_V4
rename *_E7_C21_14 *_14_V4
rename *_E7_C21_15 *_15_V4
rename *_E7_C21_16 *_16_V4
rename *_E7_C21_17 *_17_V4
rename *_E7_C21_18 *_18_V4
rename *_E7_C21_19 *_19_V4
rename *_E7_C21_20 *_20_V4
rename *_E7_C21_21 *_21_V4
rename *_E7_C21_22 *_22_V4
rename *_E7_C21_23 *_23_V4
rename *_E7_C21_24 *_24_V4
rename *_E7_C21_25 *_25_V4

********************************************************************************
******************* VISIT 4 - BLOOD PRESSURE MONITORING DIARY ******************
*********************************** _E7_C22 ************************************
********************************************************************************

rename VISITNUM_E7_C22 VISITNUM_BP_V4
rename *_E7_C22 *_V4

********************************************************************************
********************* VISIT 4 - MEEICATION MONITORING DIARY ********************
*********************************** _E7_C23 ************************************
********************************************************************************

rename VISITNUM_E7_C23 VISITNUM_MEDS_V4
rename *_E7_C23 *_MEDS_V4
rename *_E7_C23_1 *_1_MEDS_V4
rename *_E7_C23_2 *_2_MEDS_V4
rename *_E7_C23_3 *_3_MEDS_V4
rename *_E7_C23_4 *_4_MEDS_V4
rename *_E7_C23_5 *_5_MEDS_V4
rename *_E7_C23_6 *_6_MEDS_V4
rename *_E7_C23_7 *_7_MEDS_V4
rename *_E7_C23_8 *_8_MEDS_V4
rename *_E7_C23_9 *_9_MEDS_V4
rename *_E7_C23_10 *_10_MEDS_V4
rename *_E7_C23_11 *_11_MEDS_V4
rename *_E7_C23_12 *_12_MEDS_V4
rename *_E7_C23_13 *_13_MEDS_V4
rename *_E7_C23_14 *_14_MEDS_V4
rename *_E7_C23_15 *_15_MEDS_V4
rename *_E7_C23_16 *_16_MEDS_V4
rename *_E7_C23_17 *_17_MEDS_V4
rename *_E7_C23_18 *_18_MEDS_V4

********************************************************************************
********************** VISIT 4 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E7_C24 ************************************
********************************************************************************

rename VISITNUM_E7_C24 VISITNUM_HRU_V4
rename *_E7_C24 *_HRU_V4
rename *_E7_C24_1 *_1_HRU_V4
rename *_E7_C24_2 *_2_HRU_V4
rename *_E7_C24_3 *_3_HRU_V4
rename *_E7_C24_4 *_4_HRU_V4
rename *_E7_C24_5 *_5_HRU_V4
rename *_E7_C24_6 *_6_HRU_V4
rename *_E7_C24_7 *_7_HRU_V4
rename *_E7_C24_8 *_8_HRU_V4
rename *_E7_C24_9 *_9_HRU_V4
rename *_E7_C24_10 *_10_HRU_V4
rename *_E7_C24_11 *_11_HRU_V4
rename *_E7_C24_12 *_12_HRU_V4
rename *_E7_C24_13 *_13_HRU_V4
rename *_E7_C24_14 *_14_HRU_V4
rename *_E7_C24_15 *_15_HRU_V4
rename *_E7_C24_16 *_16_HRU_V4
rename *_E7_C24_17 *_17_HRU_V4
rename *_E7_C24_18 *_18_HRU_V4
rename *_E7_C24_19 *_19_HRU_V4
rename *_E7_C24_20 *_20_HRU_V4
rename *_E7_C24_21 *_21_HRU_V4
rename *_E7_C24_22 *_22_HRU_V4
rename *_E7_C24_23 *_23_HRU_V4
rename *_E7_C24_24 *_24_HRU_V4
rename *_E7_C24_25 *_25_HRU_V4
rename *_E7_C24_26 *_26_HRU_V4
rename *_E7_C24_27 *_27_HRU_V4
rename *_E7_C24_28 *_28_HRU_V4
rename *_E7_C24_29 *_29_HRU_V4
rename *_E7_C24_30 *_30_HRU_V4
rename *_E7_C24_31 *_31_HRU_V4
rename *_E7_C24_32 *_32_HRU_V4

********************************************************************************
***************** VISIT 4 - ADDITIONAL LABORATORY TEST RESULTS *****************
************************************ _E7_C25 ***********************************
********************************************************************************

rename VISITNUM_E7_C25 VISITNUM_ADDLAB_V4
rename *_E7_C25 *_V4

********************************************************************************
************************************ VISIT 5 ***********************************
*********************************** _E8_C26 ************************************
********************************************************************************

rename *_E8_C26 *_V5

********************************************************************************
*********************** VISIT 5 - CONCOMITANT MEDICATIONS **********************
************************************ _E8_C27 ***********************************
********************************************************************************

rename VISITNUM_E8_C27 VISITNUM_CON_V5
rename *_E8_C27 *_V5
rename *_E8_C27_1 *_1_V5
rename *_E8_C27_2 *_2_V5
rename *_E8_C27_3 *_3_V5
rename *_E8_C27_4 *_4_V5
rename *_E8_C27_5 *_5_V5
rename *_E8_C27_6 *_6_V5
rename *_E8_C27_7 *_7_V5
rename *_E8_C27_8 *_8_V5
rename *_E8_C27_9 *_9_V5
rename *_E8_C27_10 *_10_V5
rename *_E8_C27_11 *_11_V5
rename *_E8_C27_12 *_12_V5
rename *_E8_C27_13 *_13_V5
rename *_E8_C27_14 *_14_V5
rename *_E8_C27_15 *_15_V5
rename *_E8_C27_16 *_16_V5
rename *_E8_C27_17 *_17_V5
rename *_E8_C27_18 *_18_V5
rename *_E8_C27_19 *_19_V5
rename *_E8_C27_20 *_20_V5
rename *_E8_C27_21 *_21_V5
rename *_E8_C27_22 *_22_V5
rename *_E8_C27_23 *_23_V5
rename *_E8_C27_24 *_24_V5
rename *_E8_C27_25 *_25_V5

********************************************************************************
********************* VISIT 5 - MEDICATION MONITORING DIARY ********************
*********************************** _E8_C28 ************************************
********************************************************************************

rename VISITNUM_E8_C28 VISITNUM_MEDS_V5
rename *_E8_C28 *_MEDS_V5
rename *_E8_C28_1 *_1_MEDS_V5
rename *_E8_C28_2 *_2_MEDS_V5
rename *_E8_C28_3 *_3_MEDS_V5
rename *_E8_C28_4 *_4_MEDS_V5
rename *_E8_C28_5 *_5_MEDS_V5
rename *_E8_C28_6 *_6_MEDS_V5
rename *_E8_C28_7 *_7_MEDS_V5
rename *_E8_C28_8 *_8_MEDS_V5
rename *_E8_C28_9 *_9_MEDS_V5
rename *_E8_C28_10 *_10_MEDS_V5
rename *_E8_C28_11 *_11_MEDS_V5

********************************************************************************
********************** VISIT 5 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E8_C29 ************************************
********************************************************************************

rename VISITNUM_E8_C29 VISITNUM_HRU_V5
rename *_E8_C29 *_HRU_V5
rename *_E8_C29_1 *_1_HRU_V5
rename *_E8_C29_2 *_2_HRU_V5
rename *_E8_C29_3 *_3_HRU_V5
rename *_E8_C29_4 *_4_HRU_V5
rename *_E8_C29_5 *_5_HRU_V5
rename *_E8_C29_6 *_6_HRU_V5
rename *_E8_C29_7 *_7_HRU_V5
rename *_E8_C29_8 *_8_HRU_V5
rename *_E8_C29_9 *_9_HRU_V5
rename *_E8_C29_10 *_10_HRU_V5
rename *_E8_C29_11 *_11_HRU_V5
rename *_E8_C29_12 *_12_HRU_V5
rename *_E8_C29_13 *_13_HRU_V5
rename *_E8_C29_14 *_14_HRU_V5
rename *_E8_C29_15 *_15_HRU_V5

********************************************************************************
*********************** VISIT 5 - EQ-5D-5L QUESTIONNAIRE ***********************
************************************ _E8_C30 ***********************************
********************************************************************************

rename VISITNUM_E8_C30 VISITNUM_EQ5D_V5
rename *_E8_C30 *_V5

********************************************************************************
************************* VISIT 5 - KDQOL QUESTIONNAIRE ************************
************************************ _E8_C31 ***********************************
********************************************************************************

rename VISITNUM_E8_C31 VISITNUM_KDQOL_V5
rename *_E8_C31 *_V5

********************************************************************************
************************ VISIT 5 - ICECAP QUESTIONNAIRE ************************
************************************ _E8_C32 ***********************************
********************************************************************************

rename VISITNUM_E8_C32 VISITNUM_ICECAP_V5
rename *_E8_C32 *_V5

********************************************************************************
************************ VISIT 5 - QOL VAS QUESTIONNAIRE ***********************
************************************ _E8_C33 ***********************************
********************************************************************************

rename VISITNUM_E8_C33 VISITNUM_QOLVAS_V5
rename *_E8_C33 *_V5

********************************************************************************
***************** VISIT 5 - ADDITIONAL LABORATORY TEST RESULTS *****************
************************************ _E8_C34 ***********************************
********************************************************************************

rename VISITNUM_E8_C34 VISITNUM_ADDLAB_V5
rename *_E8_C34 *_V5

********************************************************************************
************************************ VISIT 6 ***********************************
*********************************** _E9_C35 ************************************
********************************************************************************

rename *_E9_C35 *_V6

********************************************************************************
********************** VISIT 6 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E9_C36 ************************************
********************************************************************************

rename VISITNUM_E9_C36 VISITNUM_HRU_V6
rename *_E9_C36 *_HRU_V6
rename *_E9_C36_1 *_1_HRU_V6
rename *_E9_C36_2 *_2_HRU_V6
rename *_E9_C36_3 *_3_HRU_V6
rename *_E9_C36_4 *_4_HRU_V6
rename *_E9_C36_5 *_5_HRU_V6
rename *_E9_C36_6 *_6_HRU_V6
rename *_E9_C36_7 *_7_HRU_V6
rename *_E9_C36_8 *_8_HRU_V6
rename *_E9_C36_9 *_9_HRU_V6
rename *_E9_C36_10 *_10_HRU_V6
rename *_E9_C36_11 *_11_HRU_V6
rename *_E9_C36_12 *_12_HRU_V6
rename *_E9_C36_13 *_13_HRU_V6
rename *_E9_C36_14 *_14_HRU_V6
rename *_E9_C36_15 *_15_HRU_V6
rename *_E9_C36_16 *_16_HRU_V6
rename *_E9_C36_17 *_17_HRU_V6
rename *_E9_C36_18 *_18_HRU_V6
rename *_E9_C36_19 *_19_HRU_V6
rename *_E9_C36_20 *_20_HRU_V6
rename *_E9_C36_21 *_21_HRU_V6
rename *_E9_C36_22 *_22_HRU_V6
rename *_E9_C36_23 *_23_HRU_V6
rename *_E9_C36_24 *_24_HRU_V6
rename *_E9_C36_25 *_25_HRU_V6
rename *_E9_C36_26 *_26_HRU_V6
rename *_E9_C36_27 *_27_HRU_V6
rename *_E9_C36_28 *_28_HRU_V6
rename *_E9_C36_29 *_29_HRU_V6

********************************************************************************
***************** VISIT 6 - ADDITIONAL LABORATORY TEST RESULTS *****************
************************************ _E9_C37 ***********************************
********************************************************************************

rename VISITNUM_E9_C37 VISITNUM_ADDLAB_V6
rename *_E9_C37 *_V6

********************************************************************************
************************************ VISIT 7 ***********************************
*********************************** _E10_C38 ***********************************
********************************************************************************

rename *_E10_C38 *_V7

********************************************************************************
*********************** VISIT 7 - CONCOMITANT MEDICATIONS **********************
*********************************** _E10_C39 ***********************************
********************************************************************************

rename VISITNUM_E10_C39 VISITNUM_CON_V7
rename *_E10_C39 *_V7
rename *_E10_C39_1 *_1_V7
rename *_E10_C39_2 *_2_V7
rename *_E10_C39_3 *_3_V7
rename *_E10_C39_4 *_4_V7
rename *_E10_C39_5 *_5_V7
rename *_E10_C39_6 *_6_V7
rename *_E10_C39_7 *_7_V7
rename *_E10_C39_8 *_8_V7
rename *_E10_C39_9 *_9_V7
rename *_E10_C39_10 *_10_V7
rename *_E10_C39_11 *_11_V7
rename *_E10_C39_12 *_12_V7
rename *_E10_C39_13 *_13_V7
rename *_E10_C39_14 *_14_V7
rename *_E10_C39_15 *_15_V7
rename *_E10_C39_16 *_16_V7
rename *_E10_C39_17 *_17_V7
rename *_E10_C39_18 *_18_V7
rename *_E10_C39_19 *_19_V7
rename *_E10_C39_20 *_20_V7
rename *_E10_C39_21 *_21_V7
rename *_E10_C39_22 *_22_V7
rename *_E10_C39_23 *_23_V7
rename *_E10_C39_24 *_24_V7
rename *_E10_C39_25 *_25_V7
rename *_E10_C39_26 *_26_V7
rename *_E10_C39_27 *_27_V7
rename *_E10_C39_28 *_28_V7

********************************************************************************
******************* VISIT 7 - BLOOD PRESSURE MONITORING DIARY ******************
*********************************** _E10_C40 ***********************************
********************************************************************************

rename VISITNUM_E10_C40 VISITNUM_BP_V7
rename *_E10_C40 *_V7

********************************************************************************
********************* VISIT 7 - MEDICATION MONITORING DIARY ********************
*********************************** _E10_C41 ***********************************
********************************************************************************

rename VISITNUM_E10_C41 VISITNUM_MEDS_V7
rename *_E10_C41 *_MEDS_V7
rename *_E10_C41_1 *_1_MEDS_V7
rename *_E10_C41_2 *_2_MEDS_V7
rename *_E10_C41_3 *_3_MEDS_V7
rename *_E10_C41_4 *_4_MEDS_V7
rename *_E10_C41_5 *_5_MEDS_V7
rename *_E10_C41_6 *_6_MEDS_V7
rename *_E10_C41_7 *_7_MEDS_V7
rename *_E10_C41_8 *_8_MEDS_V7
rename *_E10_C41_9 *_9_MEDS_V7
rename *_E10_C41_10 *_10_MEDS_V7
rename *_E10_C41_11 *_11_MEDS_V7

********************************************************************************
********************** VISIT 7 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E10_C42 ***********************************
********************************************************************************

rename VISITNUM_E10_C42 VISITNUM_HRU_V7
rename *_E10_C42 *_HRU_V7
rename *_E10_C42_1 *_1_HRU_V7
rename *_E10_C42_2 *_2_HRU_V7
rename *_E10_C42_3 *_3_HRU_V7
rename *_E10_C42_4 *_4_HRU_V7
rename *_E10_C42_5 *_5_HRU_V7
rename *_E10_C42_6 *_6_HRU_V7
rename *_E10_C42_7 *_7_HRU_V7
rename *_E10_C42_8 *_8_HRU_V7
rename *_E10_C42_9 *_9_HRU_V7
rename *_E10_C42_10 *_10_HRU_V7
rename *_E10_C42_11 *_11_HRU_V7
rename *_E10_C42_12 *_12_HRU_V7
rename *_E10_C42_13 *_13_HRU_V7
rename *_E10_C42_14 *_14_HRU_V7
rename *_E10_C42_15 *_15_HRU_V7
rename *_E10_C42_16 *_16_HRU_V7
rename *_E10_C42_17 *_17_HRU_V7

********************************************************************************
*********************** VISIT 7 - EQ-5D-5L QUESTIONNAIRE ***********************
*********************************** _E10_C43 ***********************************
********************************************************************************

rename VISITNUM_E10_C43 VISITNUM_EQ5D_V7
rename *_E10_C43 *_V7

********************************************************************************
************************* VISIT 7 - KDQOL QUESTIONNAIRE ************************
*********************************** _E10_C44 ***********************************
********************************************************************************

rename VISITNUM_E10_C44 VISITNUM_KDQOL_V7
rename *_E10_C44 *_V7

********************************************************************************
************************ VISIT 7 - ICECAP QUESTIONNAIRE ************************
*********************************** _E10_C44 ***********************************
********************************************************************************

rename VISITNUM_E10_C45 VISITNUM_ICECAP_V7
rename *_E10_C45 *_V7

********************************************************************************
************************ VISIT 7 - QOL VAS QUESTIONNAIRE ***********************
*********************************** _E10_C46 ***********************************
********************************************************************************

rename VISITNUM_E10_C46 VISITNUM_QOLVAS_V7
rename *_E10_C46 *_V7

********************************************************************************
***************** VISIT 7 - ADDITIONAL LABORATORY TEST RESULTS *****************
*********************************** _E10_C47 ***********************************
********************************************************************************

rename VISITNUM_E10_C47 VISITNUM_ADDLAB_V7
rename *_E10_C47 *_V7

********************************************************************************
************************************ VISIT 8 ***********************************
*********************************** _E11_C48 ***********************************
********************************************************************************

rename *_E11_C48 *_V8

********************************************************************************
********************** VISIT 8 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E11_C49 ***********************************
********************************************************************************

rename VISITNUM_E11_C49 VISITNUM_HRU_V8
rename *_E11_C49 *_HRU_V8
rename *_E11_C49_1 *_1_HRU_V8
rename *_E11_C49_2 *_2_HRU_V8
rename *_E11_C49_3 *_3_HRU_V8
rename *_E11_C49_4 *_4_HRU_V8
rename *_E11_C49_5 *_5_HRU_V8
rename *_E11_C49_6 *_6_HRU_V8
rename *_E11_C49_7 *_7_HRU_V8
rename *_E11_C49_8 *_8_HRU_V8
rename *_E11_C49_9 *_9_HRU_V8
rename *_E11_C49_10 *_10_HRU_V8
rename *_E11_C49_11 *_11_HRU_V8
rename *_E11_C49_12 *_12_HRU_V8
rename *_E11_C49_13 *_13_HRU_V8
rename *_E11_C49_14 *_14_HRU_V8
rename *_E11_C49_15 *_15_HRU_V8
rename *_E11_C49_16 *_16_HRU_V8
rename *_E11_C49_17 *_17_HRU_V8
rename *_E11_C49_18 *_18_HRU_V8
rename *_E11_C49_19 *_19_HRU_V8
rename *_E11_C49_20 *_20_HRU_V8
rename *_E11_C49_21 *_21_HRU_V8

********************************************************************************
***************** VISIT 8 - ADDITIONAL LABORATORY TEST RESULTS *****************
*********************************** _E11_C50 ***********************************
********************************************************************************

rename VISITNUM_E11_C50 VISITNUM_ADDLAB_V8
rename *_E11_C50 *_V8

********************************************************************************
************************************ VISIT 9 ***********************************
*********************************** _E12_C51 ***********************************
********************************************************************************

rename *_E12_C51 *_V9

********************************************************************************
*********************** VISIT 9 - CONCOMITANT MEDICATIONS **********************
*********************************** _E12_C52 ***********************************
********************************************************************************

rename VISITNUM_E12_C52 VISITNUM_CON_V9
rename *_E12_C52 *_V9
rename *_E12_C52_1 *_1_V9
rename *_E12_C52_2 *_2_V9
rename *_E12_C52_3 *_3_V9
rename *_E12_C52_4 *_4_V9
rename *_E12_C52_5 *_5_V9
rename *_E12_C52_6 *_6_V9
rename *_E12_C52_7 *_7_V9
rename *_E12_C52_8 *_8_V9
rename *_E12_C52_9 *_9_V9
rename *_E12_C52_10 *_10_V9
rename *_E12_C52_11 *_11_V9
rename *_E12_C52_12 *_12_V9
rename *_E12_C52_13 *_13_V9
rename *_E12_C52_14 *_14_V9
rename *_E12_C52_15 *_15_V9
rename *_E12_C52_16 *_16_V9
rename *_E12_C52_17 *_17_V9
rename *_E12_C52_18 *_18_V9
rename *_E12_C52_19 *_19_V9
rename *_E12_C52_20 *_20_V9
rename *_E12_C52_21 *_21_V9
rename *_E12_C52_22 *_22_V9
rename *_E12_C52_23 *_23_V9
rename *_E12_C52_24 *_24_V9
rename *_E12_C52_25 *_25_V9
rename *_E12_C52_26 *_26_V9
rename *_E12_C52_27 *_27_V9
rename *_E12_C52_28 *_28_V9

********************************************************************************
******************* VISIT 9 - BLOOD PRESSURE MONITORING DIARY ******************
*********************************** _E12_C53 ***********************************
********************************************************************************

rename VISITNUM_E12_C53 VISITNUM_BP_V9
rename *_E12_C53 *_V9

********************************************************************************
********************* VISIT 9 - MEDICATION MONITORING DIARY ********************
*********************************** _E12_C54 ***********************************
********************************************************************************

rename VISITNUM_E12_C54 VISITNUM_MEDS_V9
rename *_E12_C54 *_MEDS_V9
rename *_E12_C54_1 *_1_MEDS_V9
rename *_E12_C54_2 *_2_MEDS_V9
rename *_E12_C54_3 *_3_MEDS_V9
rename *_E12_C54_4 *_4_MEDS_V9
rename *_E12_C54_5 *_5_MEDS_V9
rename *_E12_C54_6 *_6_MEDS_V9
rename *_E12_C54_7 *_7_MEDS_V9
rename *_E12_C54_8 *_8_MEDS_V9
rename *_E12_C54_9 *_9_MEDS_V9
rename *_E12_C54_10 *_10_MEDS_V9
rename *_E12_C54_11 *_11_MEDS_V9
rename *_E12_C54_12 *_12_MEDS_V9

********************************************************************************
********************** VISIT 9 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E12_C55 ***********************************
********************************************************************************

rename VISITNUM_E12_C55 VISITNUM_HRU_V9
rename *_E12_C55 *_HRU_V9
rename *_E12_C55_1 *_1_HRU_V9
rename *_E12_C55_2 *_2_HRU_V9
rename *_E12_C55_3 *_3_HRU_V9
rename *_E12_C55_4 *_4_HRU_V9
rename *_E12_C55_5 *_5_HRU_V9
rename *_E12_C55_6 *_6_HRU_V9
rename *_E12_C55_7 *_7_HRU_V9
rename *_E12_C55_8 *_8_HRU_V9
rename *_E12_C55_9 *_9_HRU_V9
rename *_E12_C55_10 *_10_HRU_V9
rename *_E12_C55_11 *_11_HRU_V9
rename *_E12_C55_12 *_12_HRU_V9
rename *_E12_C55_13 *_13_HRU_V9
rename *_E12_C55_14 *_14_HRU_V9
rename *_E12_C55_15 *_15_HRU_V9
rename *_E12_C55_16 *_16_HRU_V9
rename *_E12_C55_17 *_17_HRU_V9
rename *_E12_C55_18 *_18_HRU_V9

********************************************************************************
***************** VISIT 9 - ADDITIONAL LABORATORY TEST RESULTS *****************
*********************************** _E12_C56 ***********************************
********************************************************************************

rename VISITNUM_E12_C56 VISITNUM_ADDLAB_V9
rename *_E12_C56 *_V9

********************************************************************************
*********************************** VISIT 10 ***********************************
*********************************** _E13_C57 ***********************************
********************************************************************************

rename *_E13_C57 *_V10

********************************************************************************
********************* VISIT 10 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E13_C58 ***********************************
********************************************************************************

rename VISITNUM_E13_C58 VISITNUM_HRU_V10
rename *_E13_C58 *_HRU_V10
rename *_E13_C58_1 *_1_HRU_V10
rename *_E13_C58_2 *_2_HRU_V10
rename *_E13_C58_3 *_3_HRU_V10
rename *_E13_C58_4 *_4_HRU_V10
rename *_E13_C58_5 *_5_HRU_V10
rename *_E13_C58_6 *_6_HRU_V10
rename *_E13_C58_7 *_7_HRU_V10
rename *_E13_C58_8 *_8_HRU_V10
rename *_E13_C58_9 *_9_HRU_V10
rename *_E13_C58_10 *_10_HRU_V10
rename *_E13_C58_11 *_11_HRU_V10
rename *_E13_C58_12 *_12_HRU_V10
rename *_E13_C58_13 *_13_HRU_V10
rename *_E13_C58_14 *_14_HRU_V10
rename *_E13_C58_15 *_15_HRU_V10
rename *_E13_C58_16 *_16_HRU_V10
rename *_E13_C58_17 *_17_HRU_V10
rename *_E13_C58_18 *_18_HRU_V10

********************************************************************************
***************** VISIT 10 - ADDITIONAL LABORATORY TEST RESULTS ****************
*********************************** _E13_C59 ***********************************
********************************************************************************

rename VISITNUM_E13_C59 VISITNUM_ADDLAB_V10
rename *_E13_C59 *_V10

********************************************************************************
*********************************** VISIT 11 ***********************************
*********************************** _E14_C60 ***********************************
********************************************************************************

rename *_E14_C60 *_V11

********************************************************************************
********************** VISIT 11 - CONCOMITANT MEDICATIONS **********************
*********************************** _E14_C61 ***********************************
********************************************************************************

rename VISITNUM_E14_C61 VISITNUM_CON_V11
rename *_E14_C61 *_V11
rename *_E14_C61_1 *_1_V11
rename *_E14_C61_2 *_2_V11
rename *_E14_C61_3 *_3_V11
rename *_E14_C61_4 *_4_V11
rename *_E14_C61_5 *_5_V11
rename *_E14_C61_6 *_6_V11
rename *_E14_C61_7 *_7_V11
rename *_E14_C61_8 *_8_V11
rename *_E14_C61_9 *_9_V11
rename *_E14_C61_10 *_10_V11
rename *_E14_C61_11 *_11_V11
rename *_E14_C61_12 *_12_V11
rename *_E14_C61_13 *_13_V11
rename *_E14_C61_14 *_14_V11
rename *_E14_C61_15 *_15_V11
rename *_E14_C61_16 *_16_V11
rename *_E14_C61_17 *_17_V11
rename *_E14_C61_18 *_18_V11
rename *_E14_C61_19 *_19_V11
rename *_E14_C61_20 *_20_V11
rename *_E14_C61_21 *_21_V11
rename *_E14_C61_22 *_22_V11
rename *_E14_C61_23 *_23_V11
rename *_E14_C61_24 *_24_V11
rename *_E14_C61_25 *_25_V11
rename *_E14_C61_26 *_26_V11
rename *_E14_C61_27 *_27_V11
rename *_E14_C61_28 *_28_V11
rename *_E14_C61_29 *_29_V11
rename *_E14_C61_30 *_30_V11

********************************************************************************
****************** VISIT 11 - BLOOD PRESSURE MONITORING DIARY ******************
*********************************** _E14_C62 ***********************************
********************************************************************************

rename VISITNUM_E14_C62 VISITNUM_BP_V11
rename *_E14_C62 *_V11

********************************************************************************
******************** VISIT 11 - MEDICATION MONITORING DIARY ********************
*********************************** _E14_C63 ***********************************
********************************************************************************

rename VISITNUM_E14_C63 VISITNUM_MEDS_V11
rename *_E14_C63 *_MEDS_V11
rename *_E14_C63_1 *_1_MEDS_V11
rename *_E14_C63_2 *_2_MEDS_V11
rename *_E14_C63_3 *_3_MEDS_V11
rename *_E14_C63_4 *_4_MEDS_V11
rename *_E14_C63_5 *_5_MEDS_V11
rename *_E14_C63_6 *_6_MEDS_V11
rename *_E14_C63_7 *_7_MEDS_V11
rename *_E14_C63_8 *_8_MEDS_V11
rename *_E14_C63_9 *_9_MEDS_V11
rename *_E14_C63_10 *_10_MEDS_V11
rename *_E14_C63_11 *_11_MEDS_V11
rename *_E14_C63_12 *_12_MEDS_V11
rename *_E14_C63_13 *_13_MEDS_V11
rename *_E14_C63_14 *_14_MEDS_V11
rename *_E14_C63_15 *_15_MEDS_V11
rename *_E14_C63_16 *_16_MEDS_V11
rename *_E14_C63_17 *_17_MEDS_V11
rename *_E14_C63_18 *_18_MEDS_V11

********************************************************************************
********************* VISIT 11 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E14_C64 ***********************************
********************************************************************************

rename VISITNUM_E14_C64 VISITNUM_HRU_V11
rename *_E14_C64 *_HRU_V11
rename *_E14_C64_1 *_1_HRU_V11
rename *_E14_C64_2 *_2_HRU_V11
rename *_E14_C64_3 *_3_HRU_V11
rename *_E14_C64_4 *_4_HRU_V11
rename *_E14_C64_5 *_5_HRU_V11
rename *_E14_C64_6 *_6_HRU_V11
rename *_E14_C64_7 *_7_HRU_V11
rename *_E14_C64_8 *_8_HRU_V11
rename *_E14_C64_9 *_9_HRU_V11
rename *_E14_C64_10 *_10_HRU_V11
rename *_E14_C64_11 *_11_HRU_V11
rename *_E14_C64_12 *_12_HRU_V11
rename *_E14_C64_13 *_13_HRU_V11
rename *_E14_C64_14 *_14_HRU_V11
rename *_E14_C64_15 *_15_HRU_V11
rename *_E14_C64_16 *_16_HRU_V11
rename *_E14_C64_17 *_17_HRU_V11

********************************************************************************
*********************** VISIT 11 - EQ-5D-5L QUESTIONNAIRE **********************
*********************************** _E14_C65 ***********************************
********************************************************************************

rename VISITNUM_E14_C65 VISITNUM_EQ5D_V11
rename *_E14_C65 *_V11

********************************************************************************
************************ VISIT 11 - KDQOL QUESTIONNAIRE ************************
*********************************** _E14_C66 ***********************************
********************************************************************************

rename VISITNUM_E14_C66 VISITNUM_KDQOL_V11
rename *_E14_C66 *_V11

********************************************************************************
************************ VISIT 11 - ICECAP QUESTIONNAIRE ***********************
*********************************** _E14_C67 ***********************************
********************************************************************************

rename VISITNUM_E14_C67 VISITNUM_ICECAP_V11
rename *_E14_C67 *_V11

********************************************************************************
*********************** VISIT 11 - QOL VAS QUESTIONNAIRE ***********************
*********************************** _E14_C68 ***********************************
********************************************************************************

rename VISITNUM_E14_C68 VISITNUM_QOLVAS_V11
rename *_E14_C68 *_V11

********************************************************************************
***************** VISIT 11 - ADDITIONAL LABORATORY TEST RESULTS ****************
*********************************** _E14_C69 ***********************************
********************************************************************************

rename VISITNUM_E14_C69 VISITNUM_ADDLAB_V11
rename *_E14_C69 *_V11

********************************************************************************
*********************************** VISIT 12 ***********************************
*********************************** _E15_C70 ***********************************
********************************************************************************

rename *_E15_C70 *_V12

********************************************************************************
********************* VISIT 12 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E15_C71 ***********************************
********************************************************************************

rename VISITNUM_E15_C71 VISITNUM_HRU_V12
rename *_E15_C71 *_HRU_V12
rename *_E15_C71_1 *_1_HRU_V12
rename *_E15_C71_2 *_2_HRU_V12
rename *_E15_C71_3 *_3_HRU_V12
rename *_E15_C71_4 *_4_HRU_V12
rename *_E15_C71_5 *_5_HRU_V12
rename *_E15_C71_6 *_6_HRU_V12
rename *_E15_C71_7 *_7_HRU_V12
rename *_E15_C71_8 *_8_HRU_V12
rename *_E15_C71_9 *_9_HRU_V12
rename *_E15_C71_10 *_10_HRU_V12
rename *_E15_C71_11 *_11_HRU_V12
rename *_E15_C71_12 *_12_HRU_V12
rename *_E15_C71_13 *_13_HRU_V12
rename *_E15_C71_14 *_14_HRU_V12
rename *_E15_C71_15 *_15_HRU_V12
rename *_E15_C71_16 *_16_HRU_V12
rename *_E15_C71_17 *_17_HRU_V12
rename *_E15_C71_18 *_18_HRU_V12
rename *_E15_C71_19 *_19_HRU_V12
rename *_E15_C71_20 *_20_HRU_V12

********************************************************************************
***************** VISIT 12 - ADDITIONAL LABORATORY TEST RESULTS ****************
*********************************** _E15_C72 ***********************************
********************************************************************************

rename VISITNUM_E15_C72 VISITNUM_ADDLAB_V12
rename *_E15_C72 *_V12

********************************************************************************
*********************************** VISIT 13 ***********************************
*********************************** _E16_C73 ***********************************
********************************************************************************

rename *_E16_C73 *_V13

********************************************************************************
********************** VISIT 13 - CONCOMITANT MEDICATIONS **********************
*********************************** _E16_C74 ***********************************
********************************************************************************

rename VISITNUM_E16_C74 VISITNUM_CON_V13
rename *_E16_C74 *_V13
rename *_E16_C74_1 *_1_V13
rename *_E16_C74_2 *_2_V13
rename *_E16_C74_3 *_3_V13
rename *_E16_C74_4 *_4_V13
rename *_E16_C74_5 *_5_V13
rename *_E16_C74_6 *_6_V13
rename *_E16_C74_7 *_7_V13
rename *_E16_C74_8 *_8_V13
rename *_E16_C74_9 *_9_V13
rename *_E16_C74_10 *_10_V13
rename *_E16_C74_11 *_11_V13
rename *_E16_C74_12 *_12_V13
rename *_E16_C74_13 *_13_V13
rename *_E16_C74_14 *_14_V13
rename *_E16_C74_15 *_15_V13
rename *_E16_C74_16 *_16_V13
rename *_E16_C74_17 *_17_V13
rename *_E16_C74_18 *_18_V13
rename *_E16_C74_19 *_19_V13
rename *_E16_C74_20 *_20_V13
rename *_E16_C74_21 *_21_V13
rename *_E16_C74_22 *_22_V13
rename *_E16_C74_23 *_23_V13
rename *_E16_C74_24 *_24_V13
rename *_E16_C74_25 *_25_V13
rename *_E16_C74_26 *_26_V13

********************************************************************************
****************** VISIT 13 - BLOOD PRESSURE MONITORING DIARY ******************
*********************************** _E16_C75 ***********************************
********************************************************************************

rename VISITNUM_E16_C75 VISITNUM_BP_V13
rename *_E16_C75 *_V13

********************************************************************************
******************** VISIT 13 - MEDICATION MONITORING DIARY ********************
*********************************** _E16_C76 ***********************************
********************************************************************************

rename VISITNUM_E16_C76 VISITNUM_MEDS_V13
rename *_E16_C76 *_MEDS_V13
rename *_E16_C76_1 *_1_MEDS_V13
rename *_E16_C76_2 *_2_MEDS_V13
rename *_E16_C76_3 *_3_MEDS_V13
rename *_E16_C76_4 *_4_MEDS_V13
rename *_E16_C76_5 *_5_MEDS_V13
rename *_E16_C76_6 *_6_MEDS_V13
rename *_E16_C76_7 *_7_MEDS_V13
rename *_E16_C76_8 *_8_MEDS_V13
rename *_E16_C76_9 *_9_MEDS_V13
rename *_E16_C76_10 *_10_MEDS_V13
rename *_E16_C76_11 *_11_MEDS_V13
rename *_E16_C76_12 *_12_MEDS_V13
rename *_E16_C76_13 *_13_MEDS_V13
rename *_E16_C76_14 *_14_MEDS_V13
rename *_E16_C76_15 *_15_MEDS_V13
rename *_E16_C76_16 *_16_MEDS_V13
rename *_E16_C76_17 *_17_MEDS_V13

********************************************************************************
********************* VISIT 13 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E16_C77 ***********************************
********************************************************************************

rename VISITNUM_E16_C77 VISITNUM_HRU_V13
rename *_E16_C77 *_HRU_V13
rename *_E16_C77_1 *_1_HRU_V13
rename *_E16_C77_2 *_2_HRU_V13
rename *_E16_C77_3 *_3_HRU_V13
rename *_E16_C77_4 *_4_HRU_V13
rename *_E16_C77_5 *_5_HRU_V13
rename *_E16_C77_6 *_6_HRU_V13
rename *_E16_C77_7 *_7_HRU_V13
rename *_E16_C77_8 *_8_HRU_V13
rename *_E16_C77_9 *_9_HRU_V13
rename *_E16_C77_10 *_10_HRU_V13
rename *_E16_C77_11 *_11_HRU_V13
rename *_E16_C77_12 *_12_HRU_V13
rename *_E16_C77_13 *_13_HRU_V13
rename *_E16_C77_14 *_14_HRU_V13
rename *_E16_C77_15 *_15_HRU_V13
rename *_E16_C77_16 *_16_HRU_V13
rename *_E16_C77_17 *_17_HRU_V13
rename *_E16_C77_18 *_18_HRU_V13
rename *_E16_C77_19 *_19_HRU_V13
rename *_E16_C77_20 *_20_HRU_V13
rename *_E16_C77_21 *_21_HRU_V13
rename *_E16_C77_22 *_22_HRU_V13
rename *_E16_C77_23 *_23_HRU_V13
rename *_E16_C77_24 *_24_HRU_V13
rename *_E16_C77_25 *_25_HRU_V13

********************************************************************************
***************** VISIT 13 - ADDITIONAL LABORATORY TEST RESULTS ****************
*********************************** _E16_C78 ***********************************
********************************************************************************

rename VISITNUM_E16_C78 VISITNUM_ADDLAB_V13
rename *_E16_C78 *_V13

********************************************************************************
*********************************** VISIT 14 ***********************************
*********************************** _E17_C79 ***********************************
********************************************************************************

rename *_E17_C79 *_V14

********************************************************************************
********************* VISIT 14 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E17_C80 ***********************************
********************************************************************************

rename VISITNUM_E17_C80 VISITNUM_HRU_V14
rename *_E17_C80 *_HRU_V14
rename *_E17_C80_1 *_1_HRU_V14
rename *_E17_C80_2 *_2_HRU_V14
rename *_E17_C80_3 *_3_HRU_V14
rename *_E17_C80_4 *_4_HRU_V14
rename *_E17_C80_5 *_5_HRU_V14
rename *_E17_C80_6 *_6_HRU_V14
rename *_E17_C80_7 *_7_HRU_V14
rename *_E17_C80_8 *_8_HRU_V14
rename *_E17_C80_9 *_9_HRU_V14
rename *_E17_C80_10 *_10_HRU_V14
rename *_E17_C80_11 *_11_HRU_V14
rename *_E17_C80_12 *_12_HRU_V14
rename *_E17_C80_13 *_13_HRU_V14
rename *_E17_C80_14 *_14_HRU_V14
rename *_E17_C80_15 *_15_HRU_V14
rename *_E17_C80_16 *_16_HRU_V14
rename *_E17_C80_17 *_17_HRU_V14
rename *_E17_C80_18 *_18_HRU_V14

********************************************************************************
***************** VISIT 14 - ADDITIONAL LABORATORY TEST RESULTS ****************
*********************************** _E17_C81 ***********************************
********************************************************************************

rename VISITNUM_E17_C81 VISITNUM_ADDLAB_V14
rename *_E17_C81 *_V14

********************************************************************************
*********************************** VISIT 15 ***********************************
*********************************** _E18_C82 ***********************************
********************************************************************************

rename *_E18_C82 *_V15
rename *_E18_C82_1 *_1_V15
rename *_E18_C82_2 *_2_V15
rename *_E18_C82_3 *_3_V15
rename *_E18_C82_4 *_4_V15
rename *_E18_C82_5 *_5_V15

********************************************************************************
********************** VISIT 15 - CONCOMITANT MEDICATIONS **********************
*********************************** _E18_C83 ***********************************
********************************************************************************

rename VISITNUM_E18_C83 VISITNUM_CON_V15
rename *_E18_C83 *_V15
rename *_E18_C83_1 *_1_V15
rename *_E18_C83_2 *_2_V15
rename *_E18_C83_3 *_3_V15
rename *_E18_C83_4 *_4_V15
rename *_E18_C83_5 *_5_V15
rename *_E18_C83_6 *_6_V15
rename *_E18_C83_7 *_7_V15
rename *_E18_C83_8 *_8_V15
rename *_E18_C83_9 *_9_V15
rename *_E18_C83_10 *_10_V15
rename *_E18_C83_11 *_11_V15
rename *_E18_C83_12 *_12_V15
rename *_E18_C83_13 *_13_V15
rename *_E18_C83_14 *_14_V15
rename *_E18_C83_15 *_15_V15
rename *_E18_C83_16 *_16_V15
rename *_E18_C83_17 *_17_V15
rename *_E18_C83_18 *_18_V15
rename *_E18_C83_19 *_19_V15
rename *_E18_C83_20 *_20_V15
rename *_E18_C83_21 *_21_V15
rename *_E18_C83_22 *_22_V15
rename *_E18_C83_23 *_23_V15
rename *_E18_C83_24 *_24_V15
rename *_E18_C83_25 *_25_V15
rename *_E18_C83_26 *_26_V15
rename *_E18_C83_27 *_27_V15
rename *_E18_C83_28 *_28_V15
rename *_E18_C83_29 *_29_V15
rename *_E18_C83_30 *_30_V15
rename *_E18_C83_31 *_31_V15
rename *_E18_C83_32 *_32_V15
rename *_E18_C83_33 *_33_V15
rename *_E18_C83_34 *_34_V15
rename *_E18_C83_35 *_35_V15
rename *_E18_C83_36 *_36_V15
rename *_E18_C83_37 *_37_V15
rename *_E18_C83_38 *_38_V15
rename *_E18_C83_39 *_39_V15
rename *_E18_C83_40 *_40_V15

********************************************************************************
****************** VISIT 15 - BLOOD PRESSURE MONITORING DIARY ******************
*********************************** _E18_C84 ***********************************
********************************************************************************

rename VISITNUM_E18_C84 VISITNUM_BP_V15
rename *_E18_C84 *_V15

********************************************************************************
******************** VISIT 15 - MEDICATION MONITORING DIARY ********************
*********************************** _E18_C85 ***********************************
********************************************************************************

rename VISITNUM_E18_C85 VISITNUM_MEDS_V15
rename *_E18_C85 *_MEDS_V15
rename *_E18_C85_1 *_1_MEDS_V15
rename *_E18_C85_2 *_2_MEDS_V15
rename *_E18_C85_3 *_3_MEDS_V15
rename *_E18_C85_4 *_4_MEDS_V15
rename *_E18_C85_5 *_5_MEDS_V15
rename *_E18_C85_6 *_6_MEDS_V15
rename *_E18_C85_7 *_7_MEDS_V15
rename *_E18_C85_8 *_8_MEDS_V15
rename *_E18_C85_9 *_9_MEDS_V15
rename *_E18_C85_10 *_10_MEDS_V15
rename *_E18_C85_11 *_11_MEDS_V15
rename *_E18_C85_12 *_12_MEDS_V15

********************************************************************************
********************* VISIT 15 - HEALTH RESOURCE USE DIARY *********************
*********************************** _E18_C86 ***********************************
********************************************************************************

rename VISITNUM_E18_C86 VISITNUM_HRU_V15
rename *_E18_C86 *_HRU_V15
rename *_E18_C86_1 *_1_HRU_V15
rename *_E18_C86_2 *_2_HRU_V15
rename *_E18_C86_3 *_3_HRU_V15
rename *_E18_C86_4 *_4_HRU_V15
rename *_E18_C86_5 *_5_HRU_V15
rename *_E18_C86_6 *_6_HRU_V15
rename *_E18_C86_7 *_7_HRU_V15
rename *_E18_C86_8 *_8_HRU_V15
rename *_E18_C86_9 *_9_HRU_V15
rename *_E18_C86_10 *_10_HRU_V15
rename *_E18_C86_11 *_11_HRU_V15
rename *_E18_C86_12 *_12_HRU_V15
rename *_E18_C86_13 *_13_HRU_V15
rename *_E18_C86_14 *_14_HRU_V15
rename *_E18_C86_15 *_15_HRU_V15
rename *_E18_C86_16 *_16_HRU_V15

********************************************************************************
********************** VISIT 15 - EQ-5D-5L QUESTIONNAIRE  **********************
*********************************** _E18_C87 ***********************************
********************************************************************************

rename VISITNUM_E18_C87 VISITNUM_EQ5D_V15
rename *_E18_C87 *_V15

********************************************************************************
************************ VISIT 15 - KDQOL QUESTIONNAIRE ************************
*********************************** _E18_C88 ***********************************
********************************************************************************

rename VISITNUM_E18_C88 VISITNUM_KDQOL_V15
rename *_E18_C88 *_V15

********************************************************************************
************************ VISIT 15 - ICECAP QUESTIONNAIRE ***********************
*********************************** _E18_C89 ***********************************
********************************************************************************

rename VISITNUM_E18_C89 VISITNUM_ICECAP_V15
rename *_E18_C89 *_V15

********************************************************************************
*********************** VISIT 15 - QOL VAS QUESTIONNAIRE ***********************
*********************************** _E18_C90 ***********************************
********************************************************************************

rename VISITNUM_E18_C90 VISITNUM_QOLVAS_V15
rename *_E18_C90 *_V15

********************************************************************************
***************** VISIT 15 - ADDITIONAL LABORATORY TEST RESULTS ****************
*********************************** _E18_C91 ***********************************
********************************************************************************

rename VISITNUM_E18_C91 VISITNUM_ADDLAB_V15
rename *_E18_C91 *_V15

********************************************************************************
*********************************** ENDPOINT ***********************************
*********************************** _E19_C92 ***********************************
********************************************************************************

rename *_E19_1_C92 *_1_EP
rename *_E19_2_C92 *_2_EP
rename *_E19_3_C92 *_3_EP
rename *_E19_4_C92 *_4_EP
rename *_E19_5_C92 *_5_EP

foreach var in DEATHDAT {
    forvalues i = 1(1)5 {
		capture noisily: gen temp = date(`var'_`i'_EP, "YMD")
		capture noisily: format temp %tdd_m_y
		capture noisily: order temp, after(`var'_`i'_EP)
		capture noisily: drop `var'_`i'_EP
		capture noisily: rename temp `var'_`i'_EP
	}
}
label variable DEATHDAT_1_EP "Date"
label variable DEATHDAT_2_EP "Date"
label variable DEATHDAT_3_EP "Date"
label variable DEATHDAT_4_EP "Date"
label variable DEATHDAT_5_EP "Date"

********************************************************************************
******************************* DISCONTINUTATION *******************************
******************* _E20_C94 & _E20_C95 & _E20_C96 & _E20_C97 ******************
********************************************************************************

egen LVISDAT_1_WD = rowmax(LVISDAT_E20_1_C95 LVISDAT_E20_1_C97)
format LVISDAT_1_WD %tdd_m_y
egen EW_1_WD = rowmax(EW_E20_1_C95 EW_E20_1_C97)
label values EW_1_WD EW_E20_1_C95
gen EWREASON_1_WD = EWREASON_E20_1_C95 + EWREASON_E20_1_C97
gen EWDETAIL_1_WD = EWDETAIL_E20_1_C95 + EWDETAIL_E20_1_C97
egen FOLLOWUP_1_WD = rowmax(FOLLOWUP_E20_1_C95 FOLLOWUP_E20_1_C97)
label values FOLLOWUP_1_WD FOLLOWUP_E20_1_C95
gen LFU_1_WD = LFU_E20_1_C95
gen NEW_ASSESSRFW_1_WD = NEW_ASSESSRFW_E20_1_C95
gen ASSESSRFW_1_WD = ASSESSRFW_E20_1_C97

local varlist LVISDAT EW EWREASON EWDETAIL FOLLOWUP LFU NEW_ASSESSRFW
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E20_1_C95'"
}
foreach s in `varlist' {
	foreach v of var `s'_1_WD {
		label var `v' "`lbl`s''"
	}
}

local varlist ASSESSRFW
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E20_1_C97'"
}
foreach s in `varlist' {
	foreach v of var `s'_1_WD {
		label var `v' "`lbl`s''"
	}
}

egen LVISDAT_2_WD = rowmax(LVISDAT_E20_2_C95 LVISDAT_E20_2_C97)
format LVISDAT_2_WD %tdd_m_y
egen EW_2_WD = rowmax(EW_E20_2_C95 EW_E20_2_C97)
gen EWREASON_2_WD = EWREASON_E20_2_C95 + EWREASON_E20_2_C97
gen EWDETAIL_2_WD = EWDETAIL_E20_2_C95 + EWDETAIL_E20_2_C97
egen FOLLOWUP_2_WD = rowmax(FOLLOWUP_E20_2_C95 FOLLOWUP_E20_2_C97)
gen LFU_2_WD = LFU_E20_2_C95
gen NEW_ASSESSRFW_2_WD = NEW_ASSESSRFW_E20_2_C95
gen ASSESSRFW_2_WD = ASSESSRFW_E20_2_C97

local varlist LVISDAT EW EWREASON EWDETAIL FOLLOWUP LFU NEW_ASSESSRFW
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E20_2_C95'"
}
foreach s in `varlist' {
	foreach v of var `s'_2_WD {
		label var `v' "`lbl`s''"
	}
}

local varlist ASSESSRFW
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E20_2_C97'"
}
foreach s in `varlist' {
	foreach v of var `s'_2_WD {
		label var `v' "`lbl`s''"
	}
}

egen LVISDAT_3_WD = rowmax(LVISDAT_E20_3_C95)
format LVISDAT_3_WD %tdd_m_y
egen EW_3_WD = rowmax(EW_E20_3_C95)
gen EWREASON_3_WD = EWREASON_E20_3_C95
gen EWDETAIL_3_WD = EWDETAIL_E20_3_C95
egen FOLLOWUP_3_WD = rowmax(FOLLOWUP_E20_3_C95)
gen LFU_3_WD = LFU_E20_3_C95
gen NEW_ASSESSRFW_3_WD = NEW_ASSESSRFW_E20_3_C95

local varlist LVISDAT EW EWREASON EWDETAIL FOLLOWUP LFU NEW_ASSESSRFW
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E20_3_C95'"
}
foreach s in `varlist' {
	foreach v of var `s'_3_WD {
		label var `v' "`lbl`s''"
	}
}

egen LVISDAT_4_WD = rowmax(LVISDAT_E20_4_C95)
format LVISDAT_4_WD %tdd_m_y
egen EW_4_WD = rowmax(EW_E20_4_C95)
gen EWREASON_4_WD = EWREASON_E20_4_C95
gen EWDETAIL_4_WD = EWDETAIL_E20_4_C95
egen FOLLOWUP_4_WD = rowmax(FOLLOWUP_E20_4_C95)
gen NEW_ASSESSRFW_4_WD = NEW_ASSESSRFW_E20_4_C95

local varlist LVISDAT EW EWREASON EWDETAIL FOLLOWUP NEW_ASSESSRFW
foreach v of local varlist {
	local lbl`v' "`: var label `v'_E20_4_C95'"
}
foreach s in `varlist' {
	foreach v of var `s'_4_WD {
		label var `v' "`lbl`s''"
	}
}

forvalues i = 1(1)3 {
	capture noisily: destring LFU_`i'_WD, replace
}

drop LVISDAT_E20_1_C95 EW_E20_1_C95 EWREASON_E20_1_C95 EWDETAIL_E20_1_C95 FOLLOWUP_E20_1_C95 LFU_E20_1_C95 NEW_ASSESSRFW_E20_1_C95 LVISDAT_E20_1_C97 EW_E20_1_C97 EWREASON_E20_1_C97 EWDETAIL_E20_1_C97 FOLLOWUP_E20_1_C97 ASSESSRFW_E20_1_C97 LVISDAT_E20_2_C95 EW_E20_2_C95 EWREASON_E20_2_C95 EWDETAIL_E20_2_C95 FOLLOWUP_E20_2_C95 LFU_E20_2_C95 NEW_ASSESSRFW_E20_2_C95 LVISDAT_E20_2_C97 EW_E20_2_C97 EWREASON_E20_2_C97 EWDETAIL_E20_2_C97 FOLLOWUP_E20_2_C97 ASSESSRFW_E20_2_C97 LVISDAT_E20_3_C95 EW_E20_3_C95 EWREASON_E20_3_C95 EWDETAIL_E20_3_C95 FOLLOWUP_E20_3_C95 LFU_E20_3_C95 NEW_ASSESSRFW_E20_3_C95 LVISDAT_E20_4_C95 EW_E20_4_C95 EWREASON_E20_4_C95 EWDETAIL_E20_4_C95 FOLLOWUP_E20_4_C95 NEW_ASSESSRFW_E20_4_C95

order LVISDAT_1_WD EW_1_WD EWREASON_1_WD EWDETAIL_1_WD FOLLOWUP_1_WD LFU_1_WD NEW_ASSESSRFW_1_WD ASSESSRFW_1_WD LVISDAT_2_WD EW_2_WD EWREASON_2_WD EWDETAIL_2_WD FOLLOWUP_2_WD LFU_2_WD NEW_ASSESSRFW_2_WD ASSESSRFW_2_WD LVISDAT_3_WD EW_3_WD EWREASON_3_WD EWDETAIL_3_WD FOLLOWUP_3_WD LFU_3_WD NEW_ASSESSRFW_3_WD LVISDAT_4_WD EW_4_WD EWREASON_4_WD EWDETAIL_4_WD FOLLOWUP_4_WD NEW_ASSESSRFW_4_WD, before(AETERM_E21_1_C98)

********************************************************************************
******************************** ADVERSE EVENTS ********************************
****************************** _E21_C98 & _E21_C99 *****************************
********************************************************************************

rename *_E21_1_C98 *_1_AE
rename *_E21_2_C98 *_2_AE
rename *_E21_3_C98 *_3_AE
rename *_E21_4_C98 *_4_AE
rename *_E21_5_C98 *_5_AE
rename *_E21_6_C98 *_6_AE
rename *_E21_7_C98 *_7_AE
rename *_E21_8_C98 *_8_AE
rename *_E21_9_C98 *_9_AE
rename *_E21_10_C98 *_10_AE
rename *_E21_11_C98 *_11_AE
rename *_E21_12_C98 *_12_AE
rename *_E21_13_C98 *_13_AE
rename *_E21_14_C98 *_14_AE
rename *_E21_15_C98 *_15_AE
rename *_E21_16_C98 *_16_AE
rename *_E21_17_C98 *_17_AE
rename *_E21_18_C98 *_18_AE
//rename *_E21_19_C98 *_19_AE
//rename *_E21_20_C98 *_20_AE
//rename *_E21_21_C98 *_21_AE
//rename *_E21_22_C98 *_22_AE
rename *_E21_23_C98 *_23_AE

foreach var in AESTDAT_1_AE AEENDAT_1_AE AESTDAT_2_AE AEENDAT_2_AE AESTDAT_3_AE AEENDAT_3_AE AESTDAT_4_AE AEENDAT_4_AE AESTDAT_5_AE AEENDAT_5_AE AESTDAT_6_AE AEENDAT_6_AE AESTDAT_7_AE AEENDAT_7_AE AESTDAT_8_AE AEENDAT_8_AE AESTDAT_9_AE AEENDAT_9_AE AESTDAT_10_AE AEENDAT_10_AE AESTDAT_11_AE AEENDAT_11_AE AESTDAT_12_AE AEENDAT_12_AE AESTDAT_13_AE AEENDAT_13_AE AESTDAT_14_AE AEENDAT_14_AE AESTDAT_15_AE AEENDAT_15_AE AESTDAT_16_AE AEENDAT_16_AE AESTDAT_17_AE AEENDAT_17_AE AESTDAT_18_AE AEENDAT_18_AE AESTDAT_23_AE AEENDAT_23_AE {
		capture noisily: gen temp = date(`var', "YMD")
		capture noisily: format temp %tdd_m_y
		capture noisily: order temp, after(`var')
		capture noisily: drop `var'
		capture noisily: rename temp `var'
}

label define AEOUT 1 "Resolved, no residual side effects" 2 "Resolved, residual side effects" 3 "Continuing" 4 "Patient died"
label values AEOUT_1_AE AEOUT_2_AE AEOUT_3_AE AEOUT_4_AE AEOUT_5_AE AEOUT_6_AE AEOUT_7_AE AEOUT_8_AE AEOUT_9_AE AEOUT_10_AE AEOUT_11_AE AEOUT_12_AE AEOUT_13_AE AEOUT_14_AE AEOUT_15_AE AEOUT_16_AE AEOUT_17_AE AEOUT_18_AE AEOUT_23_AE AEOUT

label define AESEV 1 "Mild" 2 "Moderate" 3 "Severe"
label values AESEV_1_AE AESEV_2_AE AESEV_3_AE AESEV_4_AE AESEV_5_AE AESEV_6_AE AESEV_7_AE AESEV_8_AE AESEV_9_AE AESEV_10_AE AESEV_11_AE AESEV_12_AE AESEV_13_AE AESEV_14_AE AESEV_15_AE AESEV_16_AE AESEV_17_AE AESEV_18_AE AESEV_23_AE AESEV

label define AEREL 1 "Not related" 2 "Possibly related" 3 "Probably related" 4 "Definitely related"
label values AEREL_1_AE AEREL_2_AE AEREL_3_AE AEREL_4_AE AEREL_5_AE AEREL_6_AE AEREL_7_AE AEREL_8_AE AEREL_9_AE AEREL_10_AE AEREL_11_AE AEREL_12_AE AEREL_13_AE AEREL_14_AE AEREL_15_AE AEREL_16_AE AEREL_17_AE AEREL_18_AE AEREL_23_AE AEREL

label define AESER 1 "No" 2 "Requires hospitalisation" 3 "Disability" 4 "Life threatening" 5 "Death" 6 "Intervention required*"
label values AESER_1_AE AESER_2_AE AESER_3_AE AESER_4_AE AESER_5_AE AESER_6_AE AESER_7_AE AESER_8_AE AESER_9_AE AESER_10_AE AESER_11_AE AESER_12_AE AESER_13_AE AESER_14_AE AESER_15_AE AESER_16_AE AESER_17_AE AESER_18_AE AESER_23_AE AESER

label variable AESTDAT_1_AE "Date of Onset"
label variable AEENDAT_1_AE "Date of Resolution"
label variable AESTDAT_2_AE "Date of Onset"
label variable AEENDAT_2_AE "Date of Resolution"
label variable AESTDAT_3_AE "Date of Onset"
label variable AEENDAT_3_AE "Date of Resolution"
label variable AESTDAT_4_AE "Date of Onset"
label variable AEENDAT_4_AE "Date of Resolution"
label variable AESTDAT_5_AE "Date of Onset"
label variable AEENDAT_5_AE "Date of Resolution"
label variable AESTDAT_6_AE "Date of Onset"
label variable AEENDAT_6_AE "Date of Resolution"
label variable AESTDAT_7_AE "Date of Onset"
label variable AEENDAT_7_AE "Date of Resolution"
label variable AESTDAT_8_AE "Date of Onset"
label variable AEENDAT_8_AE "Date of Resolution"
label variable AESTDAT_9_AE "Date of Onset"
label variable AEENDAT_9_AE "Date of Resolution"
label variable AESTDAT_10_AE "Date of Onset"
label variable AEENDAT_10_AE "Date of Resolution"
label variable AESTDAT_11_AE "Date of Onset"
label variable AEENDAT_11_AE "Date of Resolution"
label variable AESTDAT_12_AE "Date of Onset"
label variable AEENDAT_12_AE "Date of Resolution"
label variable AESTDAT_13_AE "Date of Onset"
label variable AEENDAT_13_AE "Date of Resolution"
label variable AESTDAT_14_AE "Date of Onset"
label variable AEENDAT_14_AE "Date of Resolution"
label variable AESTDAT_15_AE "Date of Onset"
label variable AEENDAT_15_AE "Date of Resolution"
label variable AESTDAT_16_AE "Date of Onset"
label variable AEENDAT_16_AE "Date of Resolution"
label variable AESTDAT_17_AE "Date of Onset"
label variable AEENDAT_17_AE "Date of Resolution"
label variable AESTDAT_18_AE "Date of Onset"
label variable AEENDAT_18_AE "Date of Resolution"
label variable AESTDAT_23_AE "Date of Onset"
label variable AEENDAT_23_AE "Date of Resolution"

********************************************************************************
************************* ADVERSE EVENTS MEDDRA CODING *************************
*********************************** _E21_C100 **********************************
********************************************************************************

rename *_E21_1_C100 *_MEDDRA_1_AE
rename *_E21_1_C100_1 *_MEDDRA1_1_AE
rename *_E21_1_C100_2 *_MEDDRA2_1_AE
rename *_E21_1_C100_3 *_MEDDRA3_1_AE
rename *_E21_1_C100_4 *_MEDDRA4_1_AE
rename *_E21_1_C100_5 *_MEDDRA5_1_AE
rename *_E21_1_C100_6 *_MEDDRA6_1_AE
rename *_E21_1_C100_7 *_MEDDRA7_1_AE
rename *_E21_1_C100_8 *_MEDDRA8_1_AE

rename *_E21_2_C100 *_MEDDRA_2_AE
rename *_E21_2_C100_1 *_MEDDRA1_2_AE
rename *_E21_2_C100_2 *_MEDDRA2_2_AE
rename *_E21_2_C100_3 *_MEDDRA3_2_AE
rename *_E21_2_C100_4 *_MEDDRA4_2_AE
rename *_E21_2_C100_5 *_MEDDRA5_2_AE

rename *_E21_3_C100 *_MEDDRA_3_AE
rename *_E21_3_C100_1 *_MEDDRA1_3_AE
rename *_E21_3_C100_2 *_MEDDRA2_3_AE
rename *_E21_3_C100_3 *_MEDDRA3_3_AE
rename *_E21_3_C100_4 *_MEDDRA4_3_AE
rename *_E21_3_C100_5 *_MEDDRA5_3_AE

rename *_E21_4_C100 *_MEDDRA_4_AE
rename *_E21_4_C100_1 *_MEDDRA1_4_AE
rename *_E21_4_C100_2 *_MEDDRA2_4_AE
rename *_E21_4_C100_3 *_MEDDRA3_4_AE
rename *_E21_4_C100_4 *_MEDDRA4_4_AE

rename *_E21_5_C100 *_MEDDRA_5_AE
rename *_E21_5_C100_1 *_MEDDRA1_5_AE
rename *_E21_5_C100_2 *_MEDDRA2_5_AE
rename *_E21_5_C100_3 *_MEDDRA3_5_AE
rename *_E21_5_C100_4 *_MEDDRA4_5_AE

rename *_E21_6_C100 *_MEDDRA_6_AE
rename *_E21_6_C100_1 *_MEDDRA1_6_AE
rename *_E21_6_C100_2 *_MEDDRA2_6_AE
rename *_E21_6_C100_3 *_MEDDRA3_6_AE

rename *_E21_7_C100 *_MEDDRA_7_AE
rename *_E21_7_C100_1 *_MEDDRA1_7_AE
rename *_E21_7_C100_2 *_MEDDRA2_7_AE
rename *_E21_7_C100_3 *_MEDDRA3_7_AE
rename *_E21_7_C100_4 *_MEDDRA4_7_AE

rename *_E21_8_C100 *_MEDDRA_8_AE
rename *_E21_8_C100_1 *_MEDDRA1_8_AE
rename *_E21_8_C100_2 *_MEDDRA2_8_AE
rename *_E21_8_C100_3 *_MEDDRA3_8_AE
rename *_E21_8_C100_4 *_MEDDRA4_8_AE

rename *_E21_9_C100 *_MEDDRA_9_AE
rename *_E21_9_C100_1 *_MEDDRA1_9_AE
rename *_E21_9_C100_2 *_MEDDRA2_9_AE
rename *_E21_9_C100_3 *_MEDDRA3_9_AE

rename *_E21_10_C100 *_MEDDRA_10_AE
rename *_E21_10_C100_1 *_MEDDRA1_10_AE
rename *_E21_10_C100_2 *_MEDDRA2_10_AE
rename *_E21_10_C100_3 *_MEDDRA3_10_AE
rename *_E21_10_C100_4 *_MEDDRA4_10_AE

rename *_E21_11_C100 *_MEDDRA_11_AE
rename *_E21_11_C100_1 *_MEDDRA1_11_AE
rename *_E21_11_C100_2 *_MEDDRA2_11_AE
rename *_E21_11_C100_3 *_MEDDRA3_11_AE

rename *_E21_12_C100 *_MEDDRA_12_AE
rename *_E21_12_C100_1 *_MEDDRA1_12_AE
rename *_E21_12_C100_2 *_MEDDRA2_12_AE

rename *_E21_13_C100 *_MEDDRA_13_AE
rename *_E21_13_C100_1 *_MEDDRA1_13_AE

rename *_E21_14_C100 *_MEDDRA_14_AE
rename *_E21_14_C100_1 *_MEDDRA1_14_AE

rename *_E21_15_C100 *_MEDDRA_15_AE
rename *_E21_15_C100_1 *_MEDDRA1_15_AE
rename *_E21_15_C100_2 *_MEDDRA2_15_AE

rename *_E21_16_C100 *_MEDDRA_16_AE
rename *_E21_16_C100_1 *_MEDDRA1_16_AE
rename *_E21_16_C100_2 *_MEDDRA2_16_AE

rename *_E21_17_C100 *_MEDDRA_17_AE
rename *_E21_17_C100_1 *_MEDDRA1_17_AE

rename *_E21_18_C100 *_MEDDRA_18_AE
rename *_E21_18_C100_1 *_MEDDRA1_18_AE

rename *_E21_23_C100 *_MEDDRA_23_AE
rename *_E21_23_C100_1 *_MEDDRA1_23_AE

********************************************************************************
**************************** SERIOUS ADVERSE EVENTS ****************************
***************************** _E22_C101 & _E22_C102 ****************************
********************************************************************************

rename *_E22_1_C101 *_1_SAE
rename *_E22_1_C101_1 *_CM1_1_SAE
rename *_E22_1_C101_2 *_CM2_1_SAE
rename *_E22_1_C101_3 *_CM3_1_SAE
rename *_E22_1_C101_4 *_CM4_1_SAE
rename *_E22_1_C101_5 *_CM5_1_SAE
rename *_E22_1_C101_6 *_CM6_1_SAE
rename *_E22_1_C101_7 *_CM7_1_SAE
rename *_E22_1_C101_8 *_CM8_1_SAE
rename *_E22_1_C101_9 *_CM9_1_SAE
rename *_E22_1_C101_10 *_CM10_1_SAE
rename *_E22_1_C101_11 *_CM11_1_SAE
rename *_E22_1_C101_12 *_CM12_1_SAE
rename *_E22_1_C101_13 *_CM13_1_SAE
rename *_E22_1_C101_14 *_CM14_1_SAE

rename *_E22_2_C101 *_2_SAE
rename *_E22_2_C101_1 *_CM1_2_SAE
rename *_E22_2_C101_2 *_CM2_2_SAE
rename *_E22_2_C101_3 *_CM3_2_SAE
rename *_E22_2_C101_4 *_CM4_2_SAE
rename *_E22_2_C101_5 *_CM5_2_SAE
rename *_E22_2_C101_6 *_CM6_2_SAE
rename *_E22_2_C101_7 *_CM7_2_SAE
rename *_E22_2_C101_8 *_CM8_2_SAE
rename *_E22_2_C101_9 *_CM9_2_SAE
rename *_E22_2_C101_10 *_CM10_2_SAE
rename *_E22_2_C101_11 *_CM11_2_SAE
rename *_E22_2_C101_12 *_CM12_2_SAE
rename *_E22_2_C101_13 *_CM13_2_SAE
rename *_E22_2_C101_14 *_CM14_2_SAE
rename *_E22_2_C101_15 *_CM15_2_SAE
rename *_E22_2_C101_16 *_CM16_2_SAE
rename *_E22_2_C101_17 *_CM17_2_SAE
rename *_E22_2_C101_18 *_CM18_2_SAE
rename *_E22_2_C101_19 *_CM19_2_SAE
rename *_E22_2_C101_20 *_CM20_2_SAE
rename *_E22_2_C101_21 *_CM21_2_SAE
rename *_E22_2_C101_22 *_CM22_2_SAE

rename *_E22_3_C101 *_3_SAE
rename *_E22_3_C101_1 *_CM1_3_SAE
rename *_E22_3_C101_2 *_CM2_3_SAE
rename *_E22_3_C101_3 *_CM3_3_SAE
rename *_E22_3_C101_4 *_CM4_3_SAE
rename *_E22_3_C101_5 *_CM5_3_SAE
rename *_E22_3_C101_6 *_CM6_3_SAE
rename *_E22_3_C101_7 *_CM7_3_SAE
rename *_E22_3_C101_8 *_CM8_3_SAE
rename *_E22_3_C101_9 *_CM9_3_SAE
rename *_E22_3_C101_10 *_CM10_3_SAE
rename *_E22_3_C101_11 *_CM11_3_SAE
rename *_E22_3_C101_12 *_CM12_3_SAE
rename *_E22_3_C101_13 *_CM13_3_SAE

rename *_E22_4_C101 *_4_SAE
rename *_E22_4_C101_1 *_CM1_4_SAE
rename *_E22_4_C101_2 *_CM2_4_SAE
rename *_E22_4_C101_3 *_CM3_4_SAE
rename *_E22_4_C101_4 *_CM4_4_SAE
rename *_E22_4_C101_5 *_CM5_4_SAE
rename *_E22_4_C101_6 *_CM6_4_SAE
rename *_E22_4_C101_7 *_CM7_4_SAE
rename *_E22_4_C101_8 *_CM8_4_SAE
rename *_E22_4_C101_9 *_CM9_4_SAE
rename *_E22_4_C101_10 *_CM10_4_SAE
rename *_E22_4_C101_11 *_CM11_4_SAE

replace LOG_SAE_1_SAE = LOG_SAE_1_SAE + LOG_SAE_E22_1_C102
replace SAESPID_1_SAE = SAESPID_1_SAE + SAESPID_E22_1_C102
destring SAESHOSP_1_SAE, replace
egen temp = rowmax(SAESHOSP_1_SAE AESHOSP_E22_1_C102)
label values temp AESHOSP_E22_1_C102
order temp, after(SAESHOSP_1_SAE)
drop SAESHOSP_1_SAE 
rename temp SAESHOSP_1_SAE
rename AEDISAB_E22_1_C102 SAESDISAB_1_SAE
order SAESDISAB_1_SAE, after(SAESHOSP_1_SAE)
rename AESCONG_E22_1_C102 SAESCONG_1_SAE
order SAESCONG_1_SAE, after(SAESHOSP_1_SAE)
destring SAESLIFE_1_SAE, replace
egen temp = rowmax(SAESLIFE_1_SAE AESLIFE_E22_1_C102)
label values temp AESLIFE_E22_1_C102
order temp, after(SAESLIFE_1_SAE)
drop SAESLIFE_1_SAE
rename temp SAESLIFE_1_SAE
destring SAESDTH_1_SAE, replace
egen temp = rowmax(SAESDTH_1_SAE AESDTH_E22_1_C102)
label values temp AESDTH_E22_1_C102
order temp, after(SAESDTH_1_SAE)
drop SAESDTH_1_SAE
rename temp SAESDTH_1_SAE
destring SAESMIE_1_SAE, replace
egen temp = rowmax(SAESMIE_1_SAE AESMIE_E22_1_C102)
label values temp AESMIE_E22_1_C102
order temp, after(SAESMIE_1_SAE)
drop SAESMIE_1_SAE
rename temp SAESMIE_1_SAE
rename SAEREACT_E22_1_C102 SAEREACT_1_SAE
order SAEREACT_1_SAE, after(SAESMIE_1_SAE)
rename SAEEXP_E22_1_C102 SAEEXP_1_SAE
order SAEEXP_1_SAE, after(SAEREACT_1_SAE)
rename LOTNO_E22_1_C102 LOTNO_1_SAE
order LOTNO_1_SAE, after(SAEEXP_1_SAE)
rename SAECLASS_E22_1_C102 SAECLASS_1_SAE 
order SAECLASS_1_SAE, after(LOTNO_1_SAE)
replace SAETERM_1_SAE = SAETERM_1_SAE + SAEDETAIL_E22_1_C102
label variable SAESHOSP_1_SAE "Did the AE lead to admission or extention of admission to hospital?"
label variable SAESLIFE_1_SAE "Was the participant at risk of death because of the AE?"
label variable SAESDTH_1_SAE "Has the participant died?"
label variable SAESMIE_1_SAE "Was the AE an important medical event that jeopardised the participant (or an un"

replace LOG_SAE_2_SAE = LOG_SAE_2_SAE + LOG_SAE_E22_2_C102
replace SAESPID_2_SAE = SAESPID_2_SAE + SAESPID_E22_2_C102
destring SAESHOSP_2_SAE, replace
egen temp = rowmax(SAESHOSP_2_SAE AESHOSP_E22_2_C102)
order temp, after(SAESHOSP_2_SAE)
drop SAESHOSP_2_SAE
rename temp SAESHOSP_2_SAE
destring SAESDISAB_2_SAE, replace
egen temp = rowmax(SAESDISAB_2_SAE AEDISAB_E22_2_C102)
order temp, after(SAESDISAB_2_SAE)
drop SAESDISAB_2_SAE
rename temp SAESDISAB_2_SAE
rename AESCONG_E22_2_C102 SAESCONG_2_SAE
order SAESCONG_2_SAE, after(SAESDISAB_2_SAE)
destring SAESLIFE_2_SAE, replace
egen temp = rowmax(SAESLIFE_2_SAE AESLIFE_E22_2_C102)
order temp, after(SAESLIFE_2_SAE)
drop SAESLIFE_2_SAE
rename temp SAESLIFE_2_SAE
destring SAESDTH_2_SAE, replace
egen temp = rowmax(SAESDTH_2_SAE AESDTH_E22_2_C102)
order temp, after(SAESDTH_2_SAE)
drop SAESDTH_2_SAE
rename temp SAESDTH_2_SAE
destring SAESMIE_2_SAE, replace
egen temp = rowmax(SAESMIE_2_SAE AESMIE_E22_2_C102)
order temp, after(SAESMIE_2_SAE)
drop SAESMIE_2_SAE
rename temp SAESMIE_2_SAE
rename SAEREACT_E22_2_C102 SAEREACT_2_SAE
order SAEREACT_2_SAE, after(SAESMIE_2_SAE)
rename SAEEXP_E22_2_C102 SAEEXP_2_SAE
order SAEEXP_2_SAE, after(SAEREACT_2_SAE)
rename LOTNO_E22_2_C102 LOTNO_2_SAE
order LOTNO_2_SAE, after(SAEEXP_2_SAE)
rename SAECLASS_E22_2_C102 SAECLASS_2_SAE
order SAECLASS_2_SAE, after(LOTNO_2_SAE)
replace SAETERM_2_SAE = SAETERM_2_SAE + SAEDETAIL_E22_2_C102
label variable SAESHOSP_2_SAE "Did the AE lead to admission or extention of admission to hospital?"
label variable SAESDISAB_2_SAE "Has the AE resulted in persistent or significant disability/incapacity?"
label variable SAESLIFE_2_SAE "Was the participant at risk of death because of the AE?"
label variable SAESDTH_2_SAE "Has the participant died?"
label variable SAESMIE_2_SAE "Was the AE an important medical event that jeopardised the participant (or an un"

replace LOG_SAE_3_SAE = LOG_SAE_3_SAE + LOG_SAE_E22_3_C102
replace SAESPID_3_SAE = SAESPID_3_SAE + SAESPID_E22_3_C102
destring SAESHOSP_3_SAE, replace
egen temp = rowmax(SAESHOSP_3_SAE AESHOSP_E22_3_C102)
order temp, after(SAESHOSP_3_SAE)
drop SAESHOSP_3_SAE
rename temp SAESHOSP_3_SAE
rename AEDISAB_E22_3_C102 SAESDISAB_3_SAE
order SAESDISAB_3_SAE, after(SAESHOSP_3_SAE)
rename AESCONG_E22_3_C102 SAESCONG_3_SAE
order SAESCONG_3_SAE, after(SAESDISAB_3_SAE)
destring SAESLIFE_3_SAE, replace
egen temp = rowmax(SAESLIFE_3_SAE AESLIFE_E22_3_C102)
order temp, after(SAESLIFE_3_SAE)
drop SAESLIFE_3_SAE
rename temp SAESLIFE_3_SAE
rename AESDTH_E22_3_C102 SAESDTH_3_SAE
order SAESDTH_3_SAE, after(SAESLIFE_3_SAE)
rename AESMIE_E22_3_C102 SAESMIE_3_SAE
order SAESMIE_3_SAE, after(SAESDTH_3_SAE)
rename SAEREACT_E22_3_C102 SAEREACT_3_SAE
order SAEREACT_3_SAE, after(SAESMIE_3_SAE)
rename SAEEXP_E22_3_C102 SAEEXP_3_SAE
order SAEEXP_3_SAE, after(SAEREACT_3_SAE)
rename LOTNO_E22_3_C102 LOTNO_3_SAE
order LOTNO_3_SAE, after(SAEEXP_3_SAE)
rename SAECLASS_E22_3_C102 SAECLASS_3_SAE
order SAECLASS_3_SAE, after(LOTNO_3_SAE)
replace SAETERM_3_SAE = SAETERM_3_SAE + SAEDETAIL_E22_3_C102
label variable SAESHOSP_3_SAE "Did the AE lead to admission or extention of admission to hospital?"
label variable SAESLIFE_3_SAE "Was the participant at risk of death because of the AE?"

replace LOG_SAE_4_SAE = LOG_SAE_4_SAE + LOG_SAE_E22_4_C102
replace SAESPID_4_SAE = SAESPID_4_SAE + SAESPID_E22_4_C102
rename AESHOSP_E22_4_C102 SAESHOSP_4_SAE
order SAESHOSP_4_SAE, after(SAESPID_4_SAE)
rename AEDISAB_E22_4_C102 SAESDISAB_4_SAE
order SAESDISAB_4_SAE, after(SAESHOSP_4_SAE)
rename AESCONG_E22_4_C102 SAESCONG_4_SAE
order SAESCONG_4_SAE, after(SAESDISAB_4_SAE)
rename AESLIFE_E22_4_C102 SAESLIFE_4_SAE
order SAESLIFE_4_SAE, after(SAESCONG_4_SAE)
destring SAESDTH_4_SAE, replace
egen temp = rowmax(SAESDTH_4_SAE AESDTH_E22_4_C102)
order temp, after(SAESDTH_4_SAE)
drop SAESDTH_4_SAE
rename temp SAESDTH_4_SAE
rename AESMIE_E22_4_C102 SAESMIE_4_SAE
order SAESMIE_4_SAE, after(SAESDTH_4_SAE)
rename SAEREACT_E22_4_C102 SAEREACT_4_SAE
order SAEREACT_4_SAE, after(SAESMIE_4_SAE)
rename SAEEXP_E22_4_C102 SAEEXP_4_SAE
order SAEEXP_4_SAE, after(SAEREACT_4_SAE)
rename SAECLASS_E22_4_C102 SAECLASS_4_SAE
order SAECLASS_4_SAE, after(SAEEXP_4_SAE)
replace SAETERM_4_SAE = SAETERM_4_SAE + SAEDETAIL_E22_4_C102
label variable SAESDTH_4_SAE "Has the participant died?"

rename LOG_SAE_E22_5_C102 LOG_SAE_5_SAE
rename SAESPID_E22_5_C102 SAESPID_5_SAE
rename AESHOSP_E22_5_C102 SAESHOSP_5_SAE
rename AEDISAB_E22_5_C102 SAESDISAB_5_SAE
rename AESCONG_E22_5_C102 SAESCONG_5_SAE
rename AESLIFE_E22_5_C102 SAESLIFE_5_SAE
rename AESDTH_E22_5_C102 SAESDTH_5_SAE
rename AESMIE_E22_5_C102 SAESMIE_5_SAE
rename SAEREACT_E22_5_C102 SAEREACT_5_SAE
rename SAEEXP_E22_5_C102 SAEEXP_5_SAE
rename SAECLASS_E22_5_C102 SAECLASS_5_SAE
rename SAEDETAIL_E22_5_C102 SAETERM_5_SAE

rename LOG_SAE_E22_6_C102 LOG_SAE_6_SAE
rename SAESPID_E22_6_C102 SAESPID_6_SAE
rename AESHOSP_E22_6_C102 SAESHOSP_6_SAE
rename AEDISAB_E22_6_C102 SAESDISAB_6_SAE
rename AESCONG_E22_6_C102 SAESCONG_6_SAE
rename AESLIFE_E22_6_C102 SAESLIFE_6_SAE
rename AESDTH_E22_6_C102 SAESDTH_6_SAE
rename AESMIE_E22_6_C102 SAESMIE_6_SAE
rename SAEREACT_E22_6_C102 SAEREACT_6_SAE
rename SAEEXP_E22_6_C102 SAEEXP_6_SAE
rename SAECLASS_E22_6_C102 SAECLASS_6_SAE
rename SAEDETAIL_E22_6_C102 SAETERM_6_SAE 

rename LOG_SAE_E22_7_C102 LOG_SAE_7_SAE
rename SAESPID_E22_7_C102 SAESPID_7_SAE
rename AESHOSP_E22_7_C102 SAESHOSP_7_SAE
rename AEDISAB_E22_7_C102 SAESDISAB_7_SAE
rename AESCONG_E22_7_C102 SAESCONG_7_SAE
rename AESLIFE_E22_7_C102 SAESLIFE_7_SAE
rename AESDTH_E22_7_C102 SAESDTH_7_SAE
rename AESMIE_E22_7_C102 SAESMIE_7_SAE
rename SAEREACT_E22_7_C102 SAEREACT_7_SAE
rename SAEEXP_E22_7_C102 SAEEXP_7_SAE
rename SAECLASS_E22_7_C102 SAECLASS_7_SAE
rename SAEDETAIL_E22_7_C102 SAETERM_7_SAE      

drop LOG_SAE_E22_1_C102 SAESPID_E22_1_C102 AESHOSP_E22_1_C102 AESLIFE_E22_1_C102 AESDTH_E22_1_C102 AESMIE_E22_1_C102 SAEDETAIL_E22_1_C102 LOG_SAE_E22_2_C102 SAESPID_E22_2_C102 AESHOSP_E22_2_C102 AEDISAB_E22_2_C102 AESLIFE_E22_2_C102 AESDTH_E22_2_C102 AESMIE_E22_2_C102 SAEDETAIL_E22_2_C102 LOG_SAE_E22_3_C102 SAESPID_E22_3_C102 AESHOSP_E22_3_C102 AESLIFE_E22_3_C102 SAEDETAIL_E22_3_C102 LOG_SAE_E22_4_C102 SAESPID_E22_4_C102 AESDTH_E22_4_C102 SAEDETAIL_E22_4_C102

forvalues i = 1(1)7 {
	replace SAECLASS_`i'_SAE = "1" if SAECLASS_`i'_SAE == "SAE"
	replace SAECLASS_`i'_SAE = "2" if SAECLASS_`i'_SAE == "SSAR"
	replace SAECLASS_`i'_SAE = "3" if SAECLASS_`i'_SAE == "SUSAR"
	destring SAECLASS_`i'_SAE, replace
}
label define SAECLASS 1 "Serious Adverse Event (SAE)" 2 "Suspected Serious Adverse Reaction (SSAR)" 3 "Suspected Unexpected Serious Adverse Reaction (SUSAR)"
label values SAECLASS_1_SAE SAECLASS_2_SAE SAECLASS_3_SAE SAECLASS_4_SAE SAECLASS_5_SAE SAECLASS_6_SAE SAECLASS_7_SAE SAECLASS


********************************************************************************
************************************* SAVE *************************************
********************************************************************************

rename _all, lower

rename studysubjectid StudySubjectID
rename protocolid ProtocolID
rename subjectstatus SubjectStatus

save "2.Data for Analysis (e.g. dta or sas)\BARACK-D Master_$today.dta", replace


********************************************************************************
*********************************** SORTITION **********************************
********************************************************************************

clear
import delimited "1.Data Received (read only)\Sortition\BARACK-D.randomisations.$sortition.csv", clear 

rename studyid StudySubjectID

keep StudySubjectID site eligible allocation at

sort site
encode site, gen(SiteID)
order SiteID, after(site)
drop site

replace eligible = "1" if eligible == "Yes"
replace eligible = "0" if eligible == "No"
destring eligible, replace
label define eligible 1 "Yes" 0 "No"
label values eligible eligible

rename allocation randgrp
replace randgrp = "1" if randgrp == "Spironolactone (25mg once daily) + standard care"
replace randgrp = "2" if randgrp == "Standard care"
destring randgrp, replace
label define randgrp 1 "Spironolactone" 2 "Standard care"
label values randgrp randgrp

split at, p(".")
split at1, p(" ")
gen randdat = date(at11, "YMD")
format randdat %tdd_m_y
gen randtime = clock(at12, "hms")
format randtime %tcHH:MM:SS
drop at at1 at2 at11 at12

label variable SiteID "Site ID"
label variable StudySubjectID "Study Subject ID"
label variable eligible "Eligibility"
label variable randgrp "Randomised group"
label variable randdat "Date of randomisation"
label variable randtime "Time of randomisation"

merge 1:1 StudySubjectID using "2.Data for Analysis (e.g. dta or sas)\BARACK-D Master_$today.dta"
drop _merge

order StudySubjectID ProtocolID SiteID SubjectStatus eligible randgrp randdat randtime

sort StudySubjectID

save "2.Data for Analysis (e.g. dta or sas)\BARACK-D Master+Sortition_$today.dta", replace


********************************************************************************
************************ GENERATE VARIABLES FOR ANALYSIS ***********************
********************************************************************************

use "2.Data for Analysis (e.g. dta or sas)\BARACK-D Master+Sortition_$today.dta", clear

* Include in ITT analysis
gen ITT = 0 
replace ITT = 1 if !missing(randgrp) & eligible == 1 & missing(ietestcd_scr) & randelig_bl == 1 & strpos(ewreason_1_wd, "3") == 0 & strpos(ewreason_2_wd, "3") == 0 & strpos(ewreason_3_wd, "3") == 0 & strpos(ewreason_4_wd, "3") == 0
label define ITT 0 "Excluded (ineligibile)" 1 "Include in analysis population"
label values ITT ITT
label variable ITT "Include in analysis population?"

* Follow-up completion 
foreach i in scr bl v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 ep wd ae sae {
	egen miss = rownonmiss(*_`i'), strok
	gen complete_`i' = 0 if miss == 0
	replace complete_`i' = 1 if miss > 0
	drop miss
	label variable complete_`i' "Complete"
}
label define complete 0 "Missing" 1 "Completed" 
label values complete_scr complete_bl complete_v1 complete_v2 complete_v3 complete_v4 complete_v5 complete_v6 complete_v7 complete_v8 complete_v9 complete_v10 complete_v11 complete_v12 complete_v13 complete_v14 complete_v15 complete_ep complete_ae complete_sae complete_wd complete
order complete_scr, after(scrstep2_2_scr)
order complete_bl, after(cholhdlna_bl)
order complete_v1, after(cholhdlna_v1)
order complete_v2, after(cholhdlna_v2)
order complete_v3, after(cholhdlna_v3)
order complete_v4, after(cholhdlu_v4)
order complete_v5, after(cholhdlna_v5)
order complete_v6, after(cholhdlna_v6)
order complete_v7, after(cholhdlna_v7)
order complete_v8, after(cholhdlna_v8)
order complete_v9, after(cholhdlna_v9)
order complete_v10, after(cholhdlrg_v10)
order complete_v11, after(cholhdlna_v11)
order complete_v12, after(cholhdlna_v12)
order complete_v13, after(cholhdlna_v13)
order complete_v14, after(cholhdlna_v14)
order complete_v15, after(cholhdlna_v15)
order complete_ep, after(hosphdtype_5_ep)
order complete_wd, after(new_assessrfw_4_wd)
order complete_ae, after(aeser_23_ae)
order complete_sae, after(saeterm_7_sae)

* Adherenced
gen adherence = 0 
replace adherence = 1 if adherence_meds_bl == 1 | adherence_meds_v4 == 1 | adherence_meds_v5 == 1 |  adherence_meds_v7 == 1 | adherence_meds_v9 == 1 | adherence_meds_v11 == 1 | adherence_meds_v13 == 1 | adherence_meds_v15 == 1
label variable adherence "Adherence to study medication"
replace adherence = 0 if randgrp == 2

gen received = 1 if adherence == 1
replace received = 2 if adherence == 0
label define received 1 "Group C" 2 "Group D"
label values received received
label variable received "Intervention recieved"


* Age (computed from age at base line visit: VISDAT-BRTHDAT)
gen age_bl = (visdat_bl - brthdat_bl)/365.25
label variable age_bl "Age (years)"
order age_bl, after(brthdat_bl)

* The number of participants in each of the age groups according to EudraCT guidelines will be reported. These age groups are (adults (18-64 years), from 65-84 years, 85 years and over). Additionally we will report numbers by additional age groups: 18-54 years, 55-64 years, 65-74 years, 75 to 84 years and 85 years and over.
gen age_group1_bl = 1 if age_bl >= 18 & age_bl < 65
replace age_group1_bl = 2 if age_bl >= 65 & age_bl < 85
replace age_group1_bl = 3 if age_bl >= 85
replace age_group1_bl = . if missing(age_bl)
label define age_group1_bl 1 "18 to 64 years" 2 "65 to 84 years" 3 "85 years and over"
label values age_group1_bl age_group1_bl
label variable age_group1_bl "Age group (EudraCT guidelines)"

gen age_group2_bl = 1 if age_bl >= 18 & age_bl < 55
replace age_group2_bl = 2 if age_bl >= 55 & age_bl < 65
replace age_group2_bl = 3 if age_bl >= 65 & age_bl < 75
replace age_group2_bl = 4 if age_bl >= 75 & age_bl < 85
replace age_group2_bl = 5 if age_bl >= 85
replace age_group2_bl = . if missing(age_bl)
label define age_group2_bl 1 "18 to 54 years" 2 "55 to 64 years" 3 "65 to 74 years" 4 "75 to 84 years" 5 "85 years and over"
label values age_group2_bl age_group2_bl
label variable age_group2_bl "Additional age group"

order age_group1_bl age_group2_bl, after(age_bl)

* Gender (SEX)
replace sex_bl = "1" if sex_bl == "M"
replace sex_bl = "2" if sex_bl == "F"
destring sex_bl, replace
label define sex_bl 1 "Male" 2 "Female"
label values sex_bl sex_bl

* Ethnicity (ETHNIC)
gen ethnicnew_bl = 1 if ethnic_bl == 1 | ethnic_bl == 2 | ethnic_bl == 3 | ethnic_bl == 4
replace ethnicnew_bl = 2 if ethnic_bl == 5 | ethnic_bl == 6 | ethnic_bl == 7 | ethnic_bl == 8
replace ethnicnew_bl = 3 if ethnic_bl == 9 | ethnic_bl == 10 | ethnic_bl == 11 | ethnic_bl == 12 | ethnic_bl == 13
replace ethnicnew_bl = 4 if ethnic_bl == 14 | ethnic_bl == 15 | ethnic_bl == 16
replace ethnicnew_bl = 5 if ethnic_bl == 17 | ethnic_bl == 18
label define ethnicnew_bl 1 "White" 2 "Mixed/Multiple ethnic groups" 3 "Asian/Asian British" 4 "Black/African/Caribbean/Black British" 5 "Other ethnic group"
label values ethnicnew_bl ethnicnew_bl
label variable ethnicnew_bl "Ethnicity"
order ethnicnew_bl, after(ethnic_bl)

* Past medical history (including type II diabetes and coronary artery disease). Presence of: hypertension (HYPYN), diabetes (DIAYN), if no diabetes impaired fasting glucose and/or impaired glucose tolerance (IMGYN), Ischaemic heart disease (IHDYN), heart failure (HFYN), Atrial fibrillation (AFYN), Cerebrovascular disease (CVDYN), peripheral vascular disease (PVDYN), renal disease (RENYN), childhood urinary tract infection (CUTIYN), adulthood urinary tract infection (AUTIYN), Thyroid disease (THYYN), Anaemia (ANAYN), Osteopenia (OPEYN) and Osteoporosis (OPOYN).
tab hypyn_bl
tab diayn_bl
tab imgyn_bl
tab ihdyn_bl
tab hfyn_bl
tab afyn_bl
tab cvdyn_bl
tab pvdyn_bl
tab renyn_bl
tab cutiyn_bl
tab autiyn_bl
tab thyyn_bl
tab anayn_bl
tab opeyn_bl
tab opoyn_bl

* Smoking status (SMOKSTAT), categorised as never smoker, current smoker or former smoker.
label define smokstat_bl 0 "Never smoker" 1 "Current smoker" 2 "Former smoker"
label values smokstat_bl smokstat_bl

* Weight (WEIGHT)
tabstat weight_bl, stat(min max)

* Height (HEIGHT)
tabstat height_bl, stat(min max)

* Waist circumference (WSTCIR)
tabstat wstcir_bl, stat(min max)

* Hip circumference (HIPCIR)
tabstat hipcir_bl, stat(min max)

* Office measurement of diastolic BP right arm (DIABPR)
tabstat diabpr_bl, stat(min max)

* Office measurement of systolic BP right arm (SYSBPR)
tabstat sysbpr_bl, stat(min max)

* Office measurement  of diastolic BP left arm (DIABPL)
tabstat diabpl_bl, stat(min max)

* Office measurement of systolic BP left arm (SYSBPL)
tabstat sysbpl_bl, stat(min max)

** Laboratory and ECG (normal/abnormal(NCS)/abnormal(CS)) test results

* ACR (ALBCREAT)
tab albcreat_bl

* eGFR (GFR)
tab gfr_bl

* Potassium (K)
destring k_bl, replace
replace k_bl = . if k_bl == 666 | k_bl == 777 | k_bl == 888

* Creatinine (CREAT)
destring creat_bl, replace
replace creat_bl = . if creat_bl == 888

* Electrocardiogram (ECGCLSIG), categorised as normal, abnormal but not clinically significant or abnormal and clinically significant.
tab ecgclsig_bl


* BNP (BNP) recorded using pg/mL

* HbA1c (IFCC) [HBA1C] [HBA1C].  HBA1C can be recorded using mmol/mol and mmol/molHb. Units will be reported as mmol/mol. Where both IFCC and DCCT measures are recorded, the IFCC will be solely reported. Where only DCCT has been collected it will be converted to IFCC. IFCC can be calculated from DCCT using the following formula: IFCC= (DCCT-2.15)x10.929.       


* Lipid profile (serum total cholesterol, serum HDL cholesterol, serum LDL cholesterol, triglyceride and cholesterol to HDL cholesterol ration measurement) (CHOL, HDL, LDL, TRIG and CHOLHDL)
//CHOL_BL HDL_BL LDL_BL TRIG_BL CHOLHDL_BL

* Full blood count (coded as normal/abnormal but not clinically significant/abnormal and clinically significant FBCCLSIG). Where an abnormal result is recorded the actual value should be recorded as a free text field. The values recorded in the free text will be presented using summary statistics, either mean and standard deviations or median and interquartile range as appropriate.

* EQ5D
rename eq5d0101_bl eq5d1_bl
rename eq5d0102_bl eq5d2_bl
rename eq5d0103_bl eq5d3_bl
rename eq5d0104_bl eq5d4_bl
rename eq5d0105_bl eq5d5_bl
rename eq5d0106_bl eq5dvas_bl
rename eq5d0101_v5 eq5d1_v5
rename eq5d0102_v5 eq5d2_v5
rename eq5d0103_v5 eq5d3_v5
rename eq5d0104_v5 eq5d4_v5
rename eq5d0105_v5 eq5d5_v5
rename eq5d0106_v5 eq5dvas_v5
rename eq5d0101_v7 eq5d1_v7
rename eq5d0102_v7 eq5d2_v7
rename eq5d0103_v7 eq5d3_v7
rename eq5d0104_v7 eq5d4_v7
rename eq5d0105_v7 eq5d5_v7
rename eq5d0106_v7 eq5dvas_v7
rename eq5d0101_v11 eq5d1_v11
rename eq5d0102_v11 eq5d2_v11
rename eq5d0103_v11 eq5d3_v11
rename eq5d0104_v11 eq5d4_v11
rename eq5d0105_v11 eq5d5_v11
rename eq5d0106_v11 eq5dvas_v11
rename eq5d0101_v15 eq5d1_v15
rename eq5d0102_v15 eq5d2_v15
rename eq5d0103_v15 eq5d3_v15
rename eq5d0104_v15 eq5d4_v15
rename eq5d0105_v15 eq5d5_v15
rename eq5d0106_v15 eq5dvas_v15

foreach i in bl v5 v7 v11 v15 {
	gen EQ5D_PROFILE = string(eq5d1_`i', "%1.0f") + string(eq5d2_`i', "%1.0f") + string(eq5d3_`i', "%1.0f") + string(eq5d4_`i', "%1.0f") + string(eq5d5_`i', "%1.0f") if !missing(eq5d1_`i') & !missing(eq5d2_`i') & !missing(eq5d3_`i') & !missing(eq5d4_`i') & !missing(eq5d5_`i')
	
	destring EQ5D_PROFILE, replace
	
	merge m:1 EQ5D_PROFILE using "2.Data for Analysis (e.g. dta or sas)\EQ5D\EQ-5D-5L Value Sets.dta" 
	* _merge==1 : Subject has incomplete EQ5D - No index value
	* _merge==2 : Left over EQ5D
	* _merge==3 : Correctly merged
	drop if _merge == 2
	
	// All participants from UK - Keep UK
	drop EQ5D_PROFILE EQ5D_DENMARK EQ5D_FRANCE EQ5D_GERMANY EQ5D_JAPAN EQ5D_NETHERLANDS EQ5D_SPAIN EQ5D_THAILAND EQ5D_US EQ5D_ZIMBABWE _merge
	
	rename EQ5D_UK eq5dindex_`i'
	order eq5dindex_`i', after(eq5d5_`i')
	label variable eq5dindex_`i' "EQ5D index score"
}

foreach i in bl v5 v7 v11 v15 {
	replace eq5dvas_`i' = . if eq5dvas_`i' == 999
}

* Practice ID (from Sortition) will be presented by randomised group and overall.



/*
PRIMARY ENDPOINT

Time from randomisation until the first occurring of death, hospitalisation for heart disease (coronary heart disease, arrhythmia first recorded atrial fibrillation, sudden death, failed sudden death), stroke, or heart failure. Primary endpoint will be adjudicated by an independent endpoints committee blinded to treatment arm.

The following variables will be used to record the occurrence of an event HOSPYN (hospitalised), FSONSETCVD (first onset of cardiovascular disease) and DEATHYN (death). For a small minority of endpoints recorded before 3rd April 2019 an older version of the endpoint form has been used. For those cases the following variables will be used to record the occurrence of an event HDYN (hospitalised due to heart disease), STROKEYN (hospitalised due to stroke), PADYN (hospitalised due to arterial disease), HFYN (hospitalised due to heart failure) and DEATHYN (death). If any of the previously mentioned variables are coded “Yes” a primary outcome event will be recorded as having occurred. 

If more than one primary outcome event has occurred, time to event will be computed using the date of the earliest occurring event minus RANDDAT (date of randomisation). 

If a participant does not experience a primary outcome event they will be censored either at the date of last follow-up or at the date of withdrawal from the study. Based on the intention to treat (ITT) principle, participants who withdraw from treatment but consent to further follow-up will be censored at the date of last follow-up rather than the date of withdrawal from treatment.
*/

* Hospitalisation
gen EPhosp = 0
gen EPhospdate = .
gen EPfirsthosp = .
forvalues i = 1(1)5 {
	replace EPhosp = 1 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1)]
	replace EPhospdate = hospdat_`i'_ep if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & (hospdat_`i'_ep < EPhospdate | missing(EPhospdate)) & (hospdat_`i'_ep > randdat) & (!missing(hospdat_`i'_ep))]
	
	replace EPfirsthosp = 1 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "1") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 2 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "2") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 3 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "3") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 4 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "4") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 5 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "5") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 6 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "6") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 7 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hoscvdtype_`i'_ep, "7") > 0 & (strpos(hosphdtype_`i'_ep, "1") > 0 | strpos(hosphdtype_`i'_ep, "99") > 0 | missing(hosphdtype_`i'_ep)) & missing(EPfirsthosp)]
	replace EPfirsthosp = 8 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hosphdtype_`i'_ep, "2") > 0 & missing(EPfirsthosp)]
	replace EPfirsthosp = 9 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hosphdtype_`i'_ep, "3") > 0 & missing(EPfirsthosp)]
	replace EPfirsthosp = 10 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hosphdtype_`i'_ep, "4") > 0 & missing(EPfirsthosp)]
	replace EPfirsthosp = 11 if [(hospyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hosphdtype_`i'_ep, "5") > 0 & missing(EPfirsthosp)]
}
replace EPfirsthosp = 12 if EPhosp == 1 & missing(EPfirsthosp)
label define EPfirsthosp 1 "Heart disease - ACS" 2 "Heart disease - CHD" 3 "Heart disease - MI" 4 "Heart disease - Arrhythmia" 5 "Heart disease - AF" 6 "Heart disease - Cardiac arrest" 7 "Heart disease - Other" 8 "Heart failure" 9 "Stroke" 10 "Transient ischaemic attack" 11 "Peripheral arterial disease" 12 "Missing"
label values EPfirsthosp EPfirsthosp

* First onset of cardiovascular disease
gen EPcvd = 0
gen EPcvddate = .
gen EPfirstcvd = .
forvalues i = 1(1)4 {
	replace EPcvd = 1 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1)]
	replace EPcvddate = cvdstdat_`i'_ep if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & (cvdstdat_`i'_ep < EPcvddate | missing(EPcvddate)) & (cvdstdat_`i'_ep > randdat) & (!missing(cvdstdat_`i'_ep))]
	
	replace EPfirstcvd = 1 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "1") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 2 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "2") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 3 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "3") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 4 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "4") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 5 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "5") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 6 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "6") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 7 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(cvdtype_`i'_ep, "7") > 0 & (strpos(hdtype_`i'_ep, "1") > 0 | strpos(hdtype_`i'_ep, "99") > 0 | missing(hdtype_`i'_ep)) & missing(EPfirstcvd)]
	replace EPfirstcvd = 8 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hdtype_`i'_ep, "2") > 0 & missing(EPfirstcvd)]
	replace EPfirstcvd = 9 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hdtype_`i'_ep, "3") > 0 & missing(EPfirstcvd)]
	replace EPfirstcvd = 10 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hdtype_`i'_ep, "4") > 0 & missing(EPfirstcvd)]
	replace EPfirstcvd = 11 if [(fsonsetcvd_`i'_ep == 1) & (decision_new_`i'_ep == 1) & strpos(hdtype_`i'_ep, "5") > 0 & missing(EPfirstcvd)]
}
replace EPfirstcvd = 12 if EPcvd == 1 & missing(EPfirstcvd)
label define EPfirstcvd 1 "Heart disease - ACS" 2 "Heart disease - CHD" 3 "Heart disease - MI" 4 "Heart disease - Arrhythmia" 5 "Heart disease - AF" 6 "Heart disease - Cardiac arrest" 7 "Heart disease - Other" 8 "Heart failure" 9 "Stroke" 10 "Transient ischaemic attack" 11 "Peripheral arterial disease" 12 "Missing"
label values EPfirstcvd EPfirstcvd

* Death
gen EPdeath = 0
gen EPdeathdate = .
gen EPfirstdeath = .
forvalues i = 1(1)5 {
	replace EPdeath = 1 if [(deathyn_`i'_ep == 1) & (decision_new_`i'_ep == 1)]
	replace EPdeathdate = deathdat_`i'_ep if [(deathyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & (deathdat_`i'_ep < EPdeathdate | missing(EPdeathdate)) & (deathdat_`i'_ep > randdat) & (!missing(deathdat_`i'_ep))]
	
	replace EPfirstdeath = 1 if [(deathyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & deathtype_`i'_ep == 1]
	replace EPfirstdeath = 2 if [(deathyn_`i'_ep == 1) & (decision_new_`i'_ep == 1) & deathtype_`i'_ep == 0]
}
replace EPfirstdeath = 3 if EPdeath == 1 & missing(EPfirstdeath)
label define EPfirstdeath 1 "Cardiovascular" 2 "Not cardiovascular" 3 "Missing"
label values EPfirstdeath EPfirstdeath

* Primary endpoint
gen EPyn = 0
replace EPyn = 1 if [(EPhosp == 1) | (EPcvd == 1) | (EPdeath == 1)]
egen EPdate = rowmin(EPhospdate EPcvddate EPdeathdate) if EPyn == 1
gen EPfirstevent = .
replace EPfirstevent = 1 if EPfirstdeath == 1 & EPdeath == 1 & EPdeathdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 2 if EPfirstdeath == 2 & EPdeath == 1 & EPdeathdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 3 if EPfirstdeath == 3 & EPdeath == 1 & EPdeathdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 4 if EPfirstcvd == 1 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 5 if EPfirstcvd == 2 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 6 if EPfirstcvd == 3 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 7 if EPfirstcvd == 4 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 8 if EPfirstcvd == 5 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 9 if EPfirstcvd == 6 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 10 if EPfirstcvd == 7 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 11 if EPfirstcvd == 8 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 12 if EPfirstcvd == 9 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 13 if EPfirstcvd == 10 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 14 if EPfirstcvd == 11 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 15 if EPfirstcvd == 12 & EPcvd == 1 & EPcvddate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 16 if EPfirsthosp == 1 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 17 if EPfirsthosp == 2 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 18 if EPfirsthosp == 3 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 19 if EPfirsthosp == 4 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 20 if EPfirsthosp == 5 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 21 if EPfirsthosp == 6 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 22 if EPfirsthosp == 7 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 23 if EPfirsthosp == 8 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 24 if EPfirsthosp == 9 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 25 if EPfirsthosp == 10 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 26 if EPfirsthosp == 11 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
replace EPfirstevent = 27 if EPfirsthosp == 12 & EPhosp == 1 & EPhospdate == EPdate & missing(EPfirstevent)
label define EPfirstevent 1 "Death: Cardiovascular" 2 "Death: Not cardiovascular" 3 "Death: Missing" 4 "Cardiovascular disease: Heart disease - ACS" 5 "Cardiovascular disease: Heart disease - CHD" 6 "Cardiovascular disease: Heart disease - MI" 7 "Cardiovascular disease: Heart disease - Arrhythmia" 8 "Cardiovascular disease: Heart disease - AF" 9 "Cardiovascular disease: Heart disease - Cardiac arrest" 10 "Cardiovascular disease: Heart disease - Other" 11 "Cardiovascular disease: Heart failure" 12 "Cardiovascular disease: Stroke" 13 "Cardiovascular disease: Transient ischaemic attack" 14 "Cardiovascular disease: Peripheral arterial disease" 15 "Cardiovascular disease: Missing" 16 "Hospitalisation: Heart disease - ACS" 17 "Hospitalisation: Heart disease - CHD" 18 "Hospitalisation: Heart disease - MI" 19 "Hospitalisation: Heart disease - Arrhythmia" 20 "Hospitalisation: Heart disease - AF" 21 "Hospitalisation: Heart disease - Cardiac arrest" 22 "Hospitalisation: Heart disease - Other" 23 "Hospitalisation: Heart failure" 24 "Hospitalisation: Stroke" 25 "Hospitalisation: Transient ischaemic attack" 26 "Hospitalisation: Peripheral arterial disease" 27 "Hospitalisation: Missing"
label values EPfirstevent EPfirstevent

* Censoring participants who did not experience a primary endpoint
gen EPcensordate = .

// Date of last follow-up
replace EPcensordate = randdat if [(randdat > EPcensordate) | missing(EPcensordate) & !missing(randdat)]
replace EPcensordate = visdat_scr if [(visdat_scr > EPcensordate | missing(EPcensordate)) & (visdat_scr >= randdat) & (!missing(visdat_scr))]
forvalues i = 1(1)2 {
	replace EPcensordate = visdat_`i'_scr if [(visdat_`i'_scr > EPcensordate | missing(EPcensordate)) & (visdat_`i'_scr >= randdat) & (!missing(visdat_`i'_scr))]
}
replace EPcensordate = visdat_bl if [(visdat_bl > EPcensordate | missing(EPcensordate)) & (visdat_bl >= randdat) & (!missing(visdat_bl))]
forvalues i = 1(1)15 {
    replace EPcensordate = visdat_v`i' if [(visdat_v`i' > EPcensordate | missing(EPcensordate)) & (visdat_v`i' >= randdat) & (!missing(visdat_v`i'))]
}

/*
// Date of withdrawal from the study
forvalues i = 1(1)4 {
	replace EPcensordate = lvisdat_`i'_wd if [(lvisdat_`i'_wd > EPcensordate | missing(EPcensordate)) & (lvisdat_`i'_wd >= randdat) & (lfu_`i'_wd != 1) & (!missing(lvisdat_`i'_wd))]
}
*/

// Date of death
forvalues i = 1(1)5 {
	capture nosiley: replace EPcensordate = deathdat_`i'_ep if [(deathdat_`i'_ep > EPcensordate | missing(EPcensordate)) & (deathdat_`i'_ep >= randdat) & !missing(deathdat_`i'_ep)]
}

replace EPdate = EPcensordate if EPyn == 0 
replace EPhospdate = EPcensordate if EPhosp == 0
replace EPcvddate = EPcensordate if EPcvd == 0
replace EPdeathdate = EPcensordate if EPdeath == 0

replace EPdate = EPcensordate if EPyn == 1 & missing(EPdate)
replace EPhospdat = EPcensordate if EPhosp == 1 & missing(EPhospdate)
replace EPcvddate = EPcensordate if EPcvd == 1 & missing(EPcvddate)
replace EPdeathdate = EPcensordate if EPdeath == 1 & missing(EPdeathdate)

* Time from randomisation to event
gen EPtime = EPdate - randdat
gen EPhosptime = EPhospdate - randdat
gen EPcvdtime = EPcvddate - randdat
gen EPdeathtime = EPdeathdate - randdat

gen EPtime_months = (EPtime / 365.25) * 12
gen EPhosptime_months = (EPhosptime / 365.25) * 12
gen EPcvdtime_months = (EPcvdtime / 365.25) * 12
gen EPdeathtime_months = (EPdeathtime / 365.25) * 12

order EPyn EPdate EPtime EPtime_months EPhosp EPhospdate EPhosptime EPhosptime_months EPcvd EPcvddate EPcvdtime EPcvdtime_months EPdeath EPdeathdate EPdeathtime EPdeathtime_months EPcensordate, last

label define EPyn 0 "No" 1 "Yes"
label values EPyn EPyn
format EPdate %tdd_m_y
label variable EPyn "Primary endpoint (Yes/No)"
label variable EPdate "Date first reached primary endpoint"
label variable EPtime "Time from randomisation til primary endpoint (days)"
label variable EPtime_months "Time from randomisation til primary endpoint (months)"

label define EPhosp 0 "No" 1 "Yes"
label values EPhosp EPhosp
format EPhospdate %tdd_m_y
label variable EPhosp "Primary endpoint component: Hospitalisation (Yes/No)"
label variable EPhospdate "Date first onset of hospitalisation"
label variable EPhosptime "Time from randomisation til first onset of hospitalisation (days)"
label variable EPhosptime_months "Time from randomisation til first onset of hospitalisation (months)"

label define EPcvd 0 "No" 1 "Yes"
label values EPcvd EPcvd
format EPcvddate %tdd_m_y
label variable EPcvd "Primary endpoint component: Cardiovascular disease (Yes/No)"
label variable EPcvddate "Date first onset of cardiovascular disease"
label variable EPcvdtime "Time from randomisation til first onset of cardiovascular disease (days)"
label variable EPcvdtime_months "Time from randomisation til first onset of cardiovascular disease (months)"

label define EPdeath 0 "No" 1 "Yes"
label values EPdeath EPdeath
format EPdeathdate %tdd_m_y
label variable EPdeath "Primary endpoint component: Death (Yes/No)"
label variable EPdeathdate "Date of death"
label variable EPdeathtime "Time from randomisation til death (days)"
label variable EPdeathtime_months "Time from randomisation til death (months)"

format EPcensordate %tdd_m_y
label variable EPcensordate "Date of consoring"


/*
SECONDARY ENDPOINT - CHANGE IN SYSTOLIC BLOOD PRESSURE ANNUALLY

Change from baseline in office recorded systolic blood pressure annually (visit 7, 11) and at final visit. (variables SYSBPR and SYSBPL).  Change in systolic BP is collected for right arm and left arm separately. Means of all measurements of BP (in particular measurements taken from different arms) will be calculated at each time point in accordance with NICE guidelines and these mean BP measurements will be used in the analysis. These variables are collected at each visit (see schedule of assessments in appendix III). 
*/

foreach v in bl v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	egen sysbp_`v' = rowmean(sysbpr_`v' sysbpl_`v')
	egen diabp_`v' = rowmean(diabpr_`v' diabpl_`v')
}

foreach var in sysbp diabp {
	rename `var'_bl `var'_old_bl
	gen `var'_bl = `var'_old_bl
	sum `var'_old_bl
	replace `var'_bl = `r(mean)' if missing(`var'_bl)
	order `var'_bl, after(`var'_old_bl)
}

label variable sysbp_old_bl "Systolic BP at baseline"
label variable sysbp_bl "Systolic BP at baseline"
label variable sysbp_v1 "Systolic BP at week 1 ± 2 days"
label variable sysbp_v2 "Systolic BP at week 2 ± 2 days"
label variable sysbp_v3 "Systolic BP at week 4 ± 4 days"
label variable sysbp_v4 "Systolic BP at week 12 ± 4 days"
label variable sysbp_v5 "Systolic BP at week 26 ± 7 days (6 MONTHS)"
label variable sysbp_v6 "Systolic BP at week 39 ± 14 days"
label variable sysbp_v7 "Systolic BP at week 52 ± 14 days (1 YEAR)"
label variable sysbp_v8 "Systolic BP at week 65 ± 14 days"
label variable sysbp_v9 "Systolic BP at week 78 ± 14 days"
label variable sysbp_v10 "Systolic BP at week 91 ± 14 days"
label variable sysbp_v11 "Systolic BP at week 104 ± 14 days (2 YEARS)"
label variable sysbp_v12 "Systolic BP at week 117 ± 14 days"
label variable sysbp_v13 "Systolic BP at week 130 ± 14 days"
label variable sysbp_v14 "Systolic BP at week 143 ± 14 days"
label variable sysbp_v15 "Systolic BP at week 156 ± 14 days (3 YEARS)"

label variable diabp_old_bl "Diastolic BP at baseline"
label variable diabp_bl "Diastolic BP at baseline"
label variable diabp_v1 "Diastolic BP at week 1 ± 2 days"
label variable diabp_v2 "Diastolic BP at week 2 ± 2 days"
label variable diabp_v3 "Diastolic BP at week 4 ± 4 days"
label variable diabp_v4 "Diastolic BP at week 12 ± 4 days"
label variable diabp_v5 "Diastolic BP at week 26 ± 7 days (6 MONTHS)"
label variable diabp_v6 "Diastolic BP at week 39 ± 14 days"
label variable diabp_v7 "Diastolic BP at week 52 ± 14 days (1 YEAR)"
label variable diabp_v8 "Diastolic BP at week 65 ± 14 days"
label variable diabp_v9 "Diastolic BP at week 78 ± 14 days"
label variable diabp_v10 "Diastolic BP at week 91 ± 14 days"
label variable diabp_v11 "Diastolic BP at week 104 ± 14 days (2 YEARS)"
label variable diabp_v12 "Diastolic BP at week 117 ± 14 days"
label variable diabp_v13 "Diastolic BP at week 130 ± 14 days"
label variable diabp_v14 "Diastolic BP at week 143 ± 14 days"
label variable diabp_v15 "Diastolic BP at week 156 ± 14 days (3 YEARS)"


/* 
SECONDARY ENDPOINT - HYPOTENSION

Rates of hypotension (<100mmHg systolic recorded in both arms or postural hypotension recorded) at any point during the study. The rates of hypotension across the study period, defined as <100mmHg systolic or >20mmHg systolic drop on standing. The outcome will be hypotension (a binary coded variable defined as hypotension at any point during the study period, coded 1, or no hypotension, coded 0). 

This can be reported as two different outcomes:

i.	Hypotension (with or without symptoms) when systolic BP is <100mmHg. Specifically this variable is coded “yes” if systolic blood pressure in both arms drops below 100mmHg at any time point and “no” otherwise, i.e. {HYPO_BP=yes IF (SYSBPR AND SYSBPL)<100mmHg} {HYPO_BP=no IF (SYSBPR OR SYSBPL)≥100mmHg}. If this variable is coded yes at any follow up visit, then the outcome will be coded “yes”.

ii.	Postural / Orthostatic hypotension –postural or symptomatic hypotension leading to study discontinuation. If it is unclear whether the participant has symptoms it will be assumed that the participant has postural hypotension.  This information regarding postural drop is recorded in the discontinuation CRF under EWDETAIL as free text. If postural hypotension is recorded at any time point this outcome will be coded “yes”

The variable HYPOTENSION will be derived as follows:
HYPOTENSION=1 if {(SYSBPR AND SYSBPL) < 100mmHg at ANY Visit} OR {EWDETAIL=”postural/symptomatic hypotension” at study discontinuation}
HYPOTENSION=0 if {(SYSBPR OR SYSBPL)>100mmHg at ALL Visits} AND {EWDETAIL postural/symptomatic hypotension”}
*/

gen hypotension = 0

forvalues i = 1(1)15 {
	replace hypotension = 1 if [(sysbpr_v`i' < 100 & !missing(sysbpr_v`i')) & (sysbpl_v`i' < 100 & !missing(sysbpl_v`i'))]
}

forvalues i = 1(1)4 {
	gen ewdetail`i' = lower(ewdetail_`i'_wd)
}
forvalues i = 1(1)4 {
	replace hypotension = 1 if [(strpos(ewdetail`i', "postural hypotension") > 0) | (strpos(ewdetail`i', "symptomatic hypotension") > 0) | (strpos(ewdetail`i', "postural/symptomatic hypotension") > 0) | (strpos(ewdetail`i', "symptomatic/postural hypotension") > 0)]
}

replace hypotension = . if missing(sysbpr_v1) & missing(sysbpl_v1) & missing(sysbpr_v2) & missing(sysbpl_v2) & missing(sysbpr_v3) & missing(sysbpl_v3) & missing(sysbpr_v4) & missing(sysbpl_v4) & missing(sysbpr_v5) & missing(sysbpl_v5) & missing(sysbpr_v6) & missing(sysbpl_v6) & missing(sysbpr_v7) & missing(sysbpl_v7) & missing(sysbpr_v8) & missing(sysbpl_v8) & missing(sysbpr_v9) & missing(sysbpl_v9) & missing(sysbpr_v10) & missing(sysbpl_v10) & missing(sysbpr_v11) & missing(sysbpl_v11) & missing(sysbpr_v12) & missing(sysbpl_v12) & missing(sysbpr_v13) & missing(sysbpl_v13) & missing(sysbpr_v14) & missing(sysbpl_v14) & missing(sysbpr_v15) & missing(sysbpl_v15)

drop ewdetail1 ewdetail2 ewdetail3 ewdetail4

label define hypotension 0 "No" 1 "Yes"
label values hypotension hypotension

label variable hypotension "Hypotension at any point during the study"


/* 
SECONDARY ENDPOINT - B-TYPE NATRIRETIC PEPTIDE (BNP)

Change from baseline in B-type Natriuretic Peptide (BNP) at each of 12 weeks (visit 4), 1 year (visit 7), 2 years (visit 11) and 3 years (visit 15) . BNP testing is recorded in the main CRF at each visit (categorised as normal, abnormal (not clinically significant) and abnormal (clinically significant) [BNPCLSIG] and if abnormal the actual lab test result if reported in a text field [BNPDET] and also in additional laboratory test results CRF [BNP and BNPU].  To compute the change in BNP from baseline, the additional laboratory test results CRF data will only be used [BNP]. In some cases BNP is recorded only as being below a certain threshhold. For these measurements a value of half the threshold will be substituted, e.g. if the value is recorded as “<10pg/ml” it will be imputed as 5pg/ml. BNP can be measured using different units (pmol/L, pg/mL, ng/L): pg/mL is the same as ng/L as pg and mL are 1/1000th of ng and L. All results will be reported using pg/ml, using a conversion rate 1 pg/mL=0.118 pmol/L where required. Measurement of BNP is dependent on whether the local lab is able to perform this testing.   If no BNP results are available for a patient then the change from baseline will be regarded as missing. 
*/

gen BNP_bl = bnp_bl
replace BNP_bl = "1363" if BNP_bl == "1,363"
replace BNP_bl = "1661" if BNP_bl == "1,681"
replace BNP_bl = "5" if BNP_bl == "< 10"
replace BNP_bl = "1.45" if BNP_bl == "< 2.9"
replace BNP_bl = "25" if BNP_bl == "< 50"
replace BNP_bl = "21.5" if BNP_bl == "<43"
replace BNP_bl = "25" if BNP_bl == "<50"
destring BNP_bl, replace

gen BNP_v4 = bnp_v4
destring BNP_v4, replace

gen BNP_v5 = bnp_v5
replace BNP_v5 = "25" if BNP_v5 == "< 50"
replace BNP_v5 = "5" if BNP_v5 == "<10"
replace BNP_v5 = "25" if BNP_v5 == "<50"
replace BNP_v5 = "7.5" if BNP_v5 == "Lesser than 15"
replace BNP_v5 = "1.45" if BNP_v5 == "< 2.9"
destring BNP_v5, replace

gen BNP_v6 = bnp_v6
destring BNP_v6, replace

gen BNP_v7 = bnp_v7
replace BNP_v7 = "17.5" if BNP_v7 == "< 35"
replace BNP_v7 = "25" if BNP_v7 == "< 50"
replace BNP_v7 = "25" if BNP_v7 == "<50"
destring BNP_v7, replace

gen BNP_v9 = bnp_v9
destring BNP_v9, replace

gen BNP_v10 = bnp_v10
destring BNP_v10, replace

gen BNP_v11 = bnp_v11
replace BNP_v11 = "5" if BNP_v11 == "< 10"
replace BNP_v11 = "1.45" if BNP_v11 == "< 2.9"
replace BNP_v11 = "25" if BNP_v11 == "< 50"
replace BNP_v11 = "5" if BNP_v11 == "<10"
destring BNP_v11, replace

gen BNP_v12 = bnp_v12
destring BNP_v12, replace

gen BNP_v13 = bnp_v13
destring BNP_v13, replace

gen BNP_v14 = bnp_v14
destring BNP_v14, replace

gen BNP_v15 = bnp_v15
replace BNP_v15 = "2.5" if BNP_v15 == "< 5"
replace BNP_v15 = "25" if BNP_v15 == "< 50"
destring BNP_v15, replace

foreach v in bl v4 v5 v6 v7 v9 v10 v11 v12 v14 v15 {
	replace BNP_`v' = BNP_`v' / 1 if bnpu_`v' == "pg/mL"
	replace BNP_`v' = BNP_`v' / 0.118 if bnpu_`v' == "pmol/L"
	replace BNP_`v' = BNP_`v' / 1 if bnpu_`v' == "ng/L" // Same as pg/mL
	replace BNP_`v' = . if bnpu_`v' == "UNK" | missing(bnpu_`v')
}

mi set wide
mi register imputed BNP_bl
mi impute pmm BNP_bl, knn(10) add(10) rseed(10122021)

rename BNP_bl BNP_old_bl
egen BNP_bl = rowmean(_1_BNP_bl _2_BNP_bl _3_BNP_bl _4_BNP_bl _5_BNP_bl _6_BNP_bl _7_BNP_bl _8_BNP_bl _9_BNP_bl _10_BNP_bl)
order BNP_bl, after(BNP_old_bl)

mi unset
drop mi_miss BNP_bl_1_ BNP_bl_2_ BNP_bl_3_ BNP_bl_4_ BNP_bl_5_ BNP_bl_6_ BNP_bl_7_ BNP_bl_8_ BNP_bl_9_ BNP_bl_10_

label variable BNP_old_bl "B-type Natriuretic Peptide (pg/mL) at baseline"
label variable BNP_bl "B-type Natriuretic Peptide (pg/mL) at baseline"
label variable BNP_v4 "B-type Natriuretic Peptide (pg/mL) at week 12 ± 4 days"
label variable BNP_v5 "B-type Natriuretic Peptide (pg/mL) at week 26 ± 7 days (6 MONTHS)"
label variable BNP_v6 "B-type Natriuretic Peptide (pg/mL) at week 39 ± 14 days"
label variable BNP_v7 "B-type Natriuretic Peptide (pg/mL) at week 52 ± 14 days (1 YEAR)"
label variable BNP_v9 "B-type Natriuretic Peptide (pg/mL) at week 78 ± 14 days"
label variable BNP_v10 "B-type Natriuretic Peptide (pg/mL) at week 91 ± 14 days"
label variable BNP_v11 "B-type Natriuretic Peptide (pg/mL) at week 104 ± 14 days (2 YEARS)"
label variable BNP_v12 "B-type Natriuretic Peptide (pg/mL) at week 117 ± 14 days"
label variable BNP_v13 "B-type Natriuretic Peptide (pg/mL) at week 130 ± 14 days"
label variable BNP_v14 "B-type Natriuretic Peptide (pg/mL) at week 143 ± 14 days"
label variable BNP_v15 "B-type Natriuretic Peptide (pg/mL) at week 156 ± 14 days (3 YEARS)"


/*
SECONDARY ENDPOINT - ALBUMIN CREATININE RATIO (ACR)

Change in Albumin Creatinine Ratio (ACR) (variable ALBCREAT).  The percentage change in albumin creatinine ratio from baseline will be computed at 3 years. An increase in ACR level indicates worsening of renal disease. Numbers and percentages with a ≥30% increase in creatinine will be reported.
*/

* Creatinine
gen creatinine_bl = creat_bl

gen creatinine_v1 = creat_v1
replace creatinine_v1 = "154" if creatinine_v1 == "154."
destring creatinine_v1, replace

gen creatinine_v2 = creat_v2
replace creatinine_v2 = "106" if creatinine_v2 == "106."
destring creatinine_v2, replace

gen creatinine_v3 = creat_v3
destring creatinine_v3, replace

gen creatinine_v4 = creat_v4
destring creatinine_v4, replace

gen creatinine_v5 = creat_v5
replace creatinine_v5 = "166" if creatinine_v5 == "166."
destring creatinine_v5, replace

gen creatinine_v6 = creat_v6
destring creatinine_v6, replace

gen creatinine_v7 = creat_v7
destring creatinine_v7, replace

gen creatinine_v8 = creat_v8
destring creatinine_v8, replace

gen creatinine_v9 = creat_v9
destring creatinine_v9, replace

gen creatinine_v10 = creat_v10
destring creatinine_v10, replace

gen creatinine_v11 = creat_v11
destring creatinine_v11, replace

gen creatinine_v12 = creat_v12
destring creatinine_v12, replace

gen creatinine_v13 = creat_v13
destring creatinine_v13, replace

gen creatinine_v14 = creat_v14
destring creatinine_v14, replace

gen creatinine_v15 = creat_v15
replace creatinine_v15 = "144" if creatinine_v15 == "144 (high)"
destring creatinine_v15, replace

rename creatinine_bl creatinine_old_bl
gen creatinine_bl = creatinine_old_bl
sum creatinine_old_bl
replace creatinine_bl = `r(mean)' if missing(creatinine_bl)
order creatinine_bl, after(creatinine_old_bl)

label variable creatinine_old_bl "Creatinine (μmol/L) at baseline"
label variable creatinine_bl "Creatinine (μmol/L) at baseline"
label variable creatinine_v1 "Creatinine (μmol/L) at week 1 ± 2 days"
label variable creatinine_v2 "Creatinine (μmol/L) at week 2 ± 2 days"
label variable creatinine_v3 "Creatinine (μmol/L) at week 4 ± 4 days"
label variable creatinine_v4 "Creatinine (μmol/L) at week 12 ± 4 days"
label variable creatinine_v5 "Creatinine (μmol/L) at week 26 ± 7 days (6 MONTHS)"
label variable creatinine_v6 "Creatinine (μmol/L) at week 39 ± 14 days"
label variable creatinine_v7 "Creatinine (μmol/L) at week 52 ± 14 days (1 YEAR)"
label variable creatinine_v8 "Creatinine (μmol/L) at week 65 ± 14 days"
label variable creatinine_v9 "Creatinine (μmol/L) at week 78 ± 14 days"
label variable creatinine_v10 "Creatinine (μmol/L) at week 91 ± 14 days"
label variable creatinine_v11 "Creatinine (μmol/L) at week 104 ± 14 days (2 YEARS)"
label variable creatinine_v12 "Creatinine (μmol/L) at week 117 ± 14 days"
label variable creatinine_v13 "Creatinine (μmol/L) at week 130 ± 14 days"
label variable creatinine_v14 "Creatinine (μmol/L) at week 143 ± 14 days"
label variable creatinine_v15 "Creatinine (μmol/L) at week 156 ± 14 days (3 YEARS)"

// Increase in Creatinine ≥30% from Baseline
foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	gen change = ((creatinine_`v' - creatinine_bl) / creatinine_bl) * 100
	gen creat30_`v' = 0 
	replace creat30_`v' = 1 if change >= 30
	replace creat30_`v' = . if missing(change)
	drop change
}
label define creat30 0 "No" 1 "Yes"
label values creat30_v1 creat30_v2 creat30_v3 creat30_v4 creat30_v5 creat30_v6 creat30_v7 creat30_v8 creat30_v9 creat30_v10 creat30_v11 creat30_v12 creat30_v13 creat30_v14 creat30_v15 creat30

label variable creat30_v1 "Increase in Creatinine ≥30% from Baseline at week 1 ± 2 days"
label variable creat30_v2 "Increase in Creatinine ≥30% from Baseline at week 2 ± 2 days"
label variable creat30_v3 "Increase in Creatinine ≥30% from Baseline at week 4 ± 4 days" 
label variable creat30_v4 "Increase in Creatinine ≥30% from Baseline at week 12 ± 4 days"
label variable creat30_v5 "Increase in Creatinine ≥30% from Baseline at week 26 ± 7 days (6 MONTHS)"
label variable creat30_v6 "Increase in Creatinine ≥30% from Baseline at week 39 ± 14 days" 
label variable creat30_v7 "Increase in Creatinine ≥30% from Baseline at week 52 ± 14 days (1 YEAR)"
label variable creat30_v8 "Increase in Creatinine ≥30% from Baseline at week 65 ± 14 days"
label variable creat30_v9 "Increase in Creatinine ≥30% from Baseline at week 78 ± 14 days"
label variable creat30_v10 "Increase in Creatinine ≥30% from Baseline at week 91 ± 14 days"
label variable creat30_v11 "Increase in Creatinine ≥30% from Baseline at week 104 ± 14 days (2 YEARS)"
label variable creat30_v12 "Increase in Creatinine ≥30% from Baseline at week 117 ± 14 days"
label variable creat30_v13 "Increase in Creatinine ≥30% from Baseline at week 130 ± 14 days"
label variable creat30_v14 "Increase in Creatinine ≥30% from Baseline at week 143 ± 14 days"
label variable creat30_v15 "Increase in Creatinine ≥30% from Baseline at week 156 ± 14 days (3 YEARS)"

* Albumin Creatinine ratio (mg/mmol)
gen ACR_bl = albcreat_bl
replace ACR_bl = "" if ACR_bl == "No done"
replace ACR_bl = "" if ACR_bl == "pt passed away- no access to records as records are with health authority"
replace ACR_bl = "" if ACR_bl == "67 (protein /creatinine ratio)"
replace ACR_bl = "" if ACR_bl == "8 (Protein Creatinine Ratio)"
replace ACR_bl = "" if ACR_bl == "0"
replace ACR_bl = "0.0015" if ACR_bl == "<0.003"
replace ACR_bl = "0.0133" if ACR_bl == "<0.0266"
replace ACR_bl = "0.1" if ACR_bl == "< 0.2"
replace ACR_bl = "0.1" if ACR_bl == "<0.2"
replace ACR_bl = "0.15" if ACR_bl == "< 0.3"
replace ACR_bl = "0.15" if ACR_bl == "<0.3"
replace ACR_bl = "0.2" if ACR_bl == "< 0.4"
replace ACR_bl = "0.2" if ACR_bl == "<0.4"
replace ACR_bl = "0.24" if ACR_bl == "< 0.48"
replace ACR_bl = "0.25" if ACR_bl == "< 0.5"
replace ACR_bl = "0.25" if ACR_bl == "<0.5"
replace ACR_bl = "0.3" if ACR_bl == "< 0.6"
replace ACR_bl = "0.3" if ACR_bl == "<0.6"
replace ACR_bl = "0.32" if ACR_bl == "< 0.64"
replace ACR_bl = "0.35" if ACR_bl == "< 0.7"
replace ACR_bl = "0.35" if ACR_bl == "<0.7"
replace ACR_bl = "0.4" if ACR_bl == "< 0.8"
replace ACR_bl = "0.4" if ACR_bl == "<0.8"
replace ACR_bl = "0.45" if ACR_bl == "< 0.9"
replace ACR_bl = "0.45" if ACR_bl == "<0.9"
replace ACR_bl = "0.5" if ACR_bl == "< 1.0"
replace ACR_bl = "0.5" if ACR_bl == "< 1.00"
replace ACR_bl = "0.5" if ACR_bl == "<1"
replace ACR_bl = "0.5" if ACR_bl == "<1.0"
replace ACR_bl = "0.5" if ACR_bl == "<1.00"
replace ACR_bl = "0.55" if ACR_bl == "< 1.1"
replace ACR_bl = "0.55" if ACR_bl == "<1.1"
replace ACR_bl = "0.6" if ACR_bl == "< 1.2"
replace ACR_bl = "0.6" if ACR_bl == "<1.2"
replace ACR_bl = "0.65" if ACR_bl == "< 1.3"
replace ACR_bl = "0.65" if ACR_bl == "<1.3"
replace ACR_bl = "0.7" if ACR_bl == "< 1.4"
replace ACR_bl = "0.7" if ACR_bl == "<1.4"
replace ACR_bl = "0.75" if ACR_bl == "<1.5"
replace ACR_bl = "0.8" if ACR_bl == "<1.6"
replace ACR_bl = "0.85" if ACR_bl == "<1.7"
replace ACR_bl = "0.9" if ACR_bl == "<1.8"
replace ACR_bl = "0.95" if ACR_bl == "<1.9"
replace ACR_bl = "1.0" if ACR_bl == "< 2"
replace ACR_bl = "1.0" if ACR_bl == "<2"
replace ACR_bl = "1.0" if ACR_bl == "<2.0"
replace ACR_bl = "1.05" if ACR_bl == "<2.1"
replace ACR_bl = "1.1" if ACR_bl == "<2.2"
replace ACR_bl = "1.25" if ACR_bl == "<2.5"
replace ACR_bl = "1.3" if ACR_bl == "<2.6"
replace ACR_bl = "1.45" if ACR_bl == "<2.9"
replace ACR_bl = "1.15" if ACR_bl == "< 2.3"
replace ACR_bl = "1.25" if ACR_bl == "< 2.5"
replace ACR_bl = "1.4" if ACR_bl == "< 2.8"
replace ACR_bl = "1.5" if ACR_bl == "< 3"
replace ACR_bl = "1.5" if ACR_bl == "< 3.0"
replace ACR_bl = "1.5" if ACR_bl == "<3"
replace ACR_bl = "1.5" if ACR_bl == "<3 mg/L"
replace ACR_bl = "1.5" if ACR_bl == "<3.0"
replace ACR_bl = "1.75" if ACR_bl == "< 3.5"
replace ACR_bl = "1.75" if ACR_bl == "<3.5"
replace ACR_bl = "1.8" if ACR_bl == "<3.6"
replace ACR_bl = "2.0" if ACR_bl == "<4"
replace ACR_bl = "3.5" if ACR_bl == "< 7"
replace ACR_bl = "400" if ACR_bl == ">400"
destring ACR_bl, replace

gen ACR_v15 = albcreat_v15
replace ACR_v15 = "" if ACR_v15 == "10 (protein/creatinine ratio)"
replace ACR_v15 = "" if ACR_v15 == "12(protein/creatinine ratio)"
replace ACR_v15 = "" if ACR_v15 == "13 (PCR, not ACR)"
replace ACR_v15 = "" if ACR_v15 == "< 0.003 g/L - NA"
replace ACR_v15 = "" if ACR_v15 == "> 1 unable to calculate"
replace ACR_v15 = "" if ACR_v15 == "? not calculated"
replace ACR_v15 = "" if ACR_v15 == "Albumin not detected"
replace ACR_v15 = "" if ACR_v15 == "Arranged and then patient died within a couple of days of last visit hence no sample sent"
replace ACR_v15 = "" if ACR_v15 == "N/A"
replace ACR_v15 = "" if ACR_v15 == "N/D"
replace ACR_v15 = "" if ACR_v15 == "No result (NA)"
replace ACR_v15 = "" if ACR_v15 == "No sample"
replace ACR_v15 = "" if ACR_v15 == "No sample result documented- as per query response"
replace ACR_v15 = "" if ACR_v15 == "Not calculated"
replace ACR_v15 = "" if ACR_v15 == "Not done"
replace ACR_v15 = "" if ACR_v15 == "Not done (albumin too low)"
replace ACR_v15 = "" if ACR_v15 == "Not done as sample was not provided by the participant"
replace ACR_v15 = "" if ACR_v15 == "Not done- Unknown reason"
replace ACR_v15 = "" if ACR_v15 == "Not taken"
replace ACR_v15 = "" if ACR_v15 == "Not tested"
replace ACR_v15 = "" if ACR_v15 == "Nurse forgot to do the test"
replace ACR_v15 = "" if ACR_v15 == "PCR ratio 8"
replace ACR_v15 = "" if ACR_v15 == "Pt did not supply sample"
replace ACR_v15 = "" if ACR_v15 == "Pt didn't bring in sample despite several requests"
replace ACR_v15 = "" if ACR_v15 == "Sample not provided"
replace ACR_v15 = "" if ACR_v15 == "Sample rejected by lab"
replace ACR_v15 = "" if ACR_v15 == "Sample sent off but no result"
replace ACR_v15 = "" if ACR_v15 == "Too dilute to calculate"
replace ACR_v15 = "" if ACR_v15 == "Too low to calculate"
replace ACR_v15 = "" if ACR_v15 == "Too low to quantify"
replace ACR_v15 = "" if ACR_v15 == "Unable to calculate"
replace ACR_v15 = "" if ACR_v15 == "Undetectable"
replace ACR_v15 = "" if ACR_v15 == "tbc"
replace ACR_v15 = "0.0015" if ACR_v15 == "< 0.003"
replace ACR_v15 = "0.15" if ACR_v15 == "< 0.3"
replace ACR_v15 = "0.15" if ACR_v15 == "<0.3"
replace ACR_v15 = "0.2" if ACR_v15 == "< 0.4"
replace ACR_v15 = "0.2" if ACR_v15 == "<0.4"
replace ACR_v15 = "0.25" if ACR_v15 == "< 0.5"
replace ACR_v15 = "0.25" if ACR_v15 == "<0.5"
replace ACR_v15 = "0.3" if ACR_v15 == "< 0.6"
replace ACR_v15 = "0.35" if ACR_v15 == "< 0.7"
replace ACR_v15 = "0.4" if ACR_v15 == "< 0.8"
replace ACR_v15 = "0.4" if ACR_v15 == "<0.8"
replace ACR_v15 = "0.45" if ACR_v15 == "< 0.9"
replace ACR_v15 = "0.5" if ACR_v15 == "< 1"
replace ACR_v15 = "0.5" if ACR_v15 == "< 1.0"
replace ACR_v15 = "0.5" if ACR_v15 == "<1"
replace ACR_v15 = "0.55" if ACR_v15 == "<1.1"
replace ACR_v15 = "0.65" if ACR_v15 == "< 1.3"
replace ACR_v15 = "0.7" if ACR_v15 == "< 1.4"
replace ACR_v15 = "1.05" if ACR_v15 == "<2.1"
replace ACR_v15 = "0.7" if ACR_v15 == "0.7 mg"
replace ACR_v15 = "0.8" if ACR_v15 == "< 1.6"
replace ACR_v15 = "1.25" if ACR_v15 == "< 2.5"
replace ACR_v15 = "1.5" if ACR_v15 == "< 3"
replace ACR_v15 = "1.5" if ACR_v15 == "< 3.0"
replace ACR_v15 = "1.5" if ACR_v15 == "<3"
replace ACR_v15 = "1.5" if ACR_v15 == "<3.0"
replace ACR_v15 = "1.75" if ACR_v15 == "< 3.5"
replace ACR_v15 = "1.75" if ACR_v15 == "<3.5"
replace ACR_v15 = "2.5" if ACR_v15 == "< 5"
replace ACR_v15 = "2.5" if ACR_v15 == "< 5.0"
replace ACR_v15 = "2.5" if ACR_v15 == "<5.0"
replace ACR_v15 = "3" if ACR_v15 == "> 3"
replace ACR_v15 = "3.5" if ACR_v15 == "< 7"
replace ACR_v15 = "3.5" if ACR_v15 == "< 7.0"
replace ACR_v15 = "7.9" if ACR_v15 == "7.9 (high)"
destring ACR_v15, replace

foreach v in bl v15 {
	replace ACR_`v' = . if ACR_`v' == 777 | ACR_`v' == 888 | ACR_`v' == 999
}

rename ACR_bl ACR_old_bl
gen ACR_bl = ACR_old_bl
sum ACR_old_bl
replace ACR_bl = `r(mean)' if missing(ACR_bl)
order ACR_bl, after(ACR_old_bl)

foreach v in bl v15 {
	gen ACRcat_`v' = 1 if ACR_`v' < 3 & !missing(ACR_`v')
	replace ACRcat_`v' = 2 if ACR_`v' >= 3 & ACR_`v' <= 30 & !missing(ACR_`v')
	replace ACRcat_`v' = 3 if ACR_`v' > 30 & !missing(ACR_`v')
	order ACRcat_`v', after(ACR_`v')
}
label define ACRcat 1 "<3" 2 "3-30" 3 ">30"
label values ACRcat_bl ACRcat_v15 ACRcat

label variable ACR_old_bl "Albumin Creatinine Ratio at baseline"
label variable ACR_bl "Albumin Creatinine Ratio at baseline"
label variable ACRcat_bl "Albumin Creatinine Ratio category at baseline"
label variable ACR_v15 "Albumin Creatinine Ratio at week 156 ± 14 days (3 YEARS)"
label variable ACRcat_v15 "Albumin Creatinine Ratio category at week 156 ± 14 days (3 YEARS)"


/*
SECONDARY ENDPOINT - GLOMERULAR FILTRATION RATE (eGFR)

Change in Estimated Glomerular Filtration Rate (eGFR) (variable GFR).  The percentage change from baseline in eGFR from baseline will be computed at 6 months, 1, 2 and 3 years.  A reduction in eGFR indicates worsening of renal disease. Numbers and percentages with a drop of ≥35% in eGRF from baseline and ≥20% drop in eGRF from previously reported will also be presented.
*/

gen eGFR_bl = gfr_bl
replace eGFR_bl = "60" if eGFR_bl == "> 60"
replace eGFR_bl = "60" if eGFR_bl == ">60"
replace eGFR_bl = "60" if eGFR_bl == ">=60"
destring eGFR_bl, replace

gen eGFR_v1 = gfr_v1
destring eGFR_v1, replace

gen eGFR_v2 = gfr_v2
replace eGFR_v2 = "" if eGFR_v2 == "Not calculated"
destring eGFR_v2, replace 

gen eGFR_v3 = gfr_v3
replace eGFR_v3 = "60" if eGFR_v3 == ">60"
replace eGFR_v3 = "" if eGFR_v3 == "Not calculated"
destring eGFR_v3, replace

gen eGFR_v4 = gfr_v4
replace eGFR_v4 = "60" if eGFR_v4 == ">60"
destring eGFR_v4, replace

gen eGFR_v5 = gfr_v5
replace eGFR_v5 = "60" if eGFR_v5 == ">60"
destring eGFR_v5, replace

gen eGFR_v6 = gfr_v6
destring eGFR_v6, replace

gen eGFR_v7 = gfr_v7
destring eGFR_v7, replace

gen eGFR_v8 = gfr_v8
replace eGFR_v8 = "" if eGFR_v8 == "Not calculated"
destring eGFR_v8, replace

gen eGFR_v9 = gfr_v9
destring eGFR_v9, replace

gen eGFR_v10 = gfr_v10
destring eGFR_v10, replace

gen eGFR_v11 = gfr_v11
replace eGFR_v11 = "60" if eGFR_v11 == "> 60"
replace eGFR_v11 = "" if eGFR_v11 == "Test results not received from lab"
destring eGFR_v11, replace

gen eGFR_v12 = gfr_v12
replace eGFR_v12 = "" if eGFR_v12 == "Not calculated"
destring eGFR_v12, replace

gen eGFR_v13 = gfr_v13
destring eGFR_v13, replace 

gen eGFR_v14 = gfr_v14
replace eGFR_v14 = "60" if eGFR_v14 == "> 60"
destring eGFR_v14, replace

gen eGFR_v15 = gfr_v15
destring eGFR_v15, replace

foreach v in bl v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	replace eGFR_`v' = . if eGFR_`v' == 777 | eGFR_`v' == 888 | eGFR_`v' == 999
}

rename eGFR_bl eGFR_old_bl
gen eGFR_bl = eGFR_old_bl
sum eGFR_old_bl
replace eGFR_bl = `r(mean)' if missing(eGFR_bl)
order eGFR_bl, after(eGFR_old_bl)

label variable eGFR_old_bl "Glomerular Filtration Rate (ml/min/1.73m2) at baseline"
label variable eGFR_bl "Glomerular Filtration Rate (ml/min/1.73m2) at baseline"
label variable eGFR_v1 "Glomerular Filtration Rate (ml/min/1.73m2) at week 1 ± 2 days"
label variable eGFR_v2 "Glomerular Filtration Rate (ml/min/1.73m2) at week 2 ± 2 days"
label variable eGFR_v3 "Glomerular Filtration Rate (ml/min/1.73m2) at week 4 ± 4 days"
label variable eGFR_v4 "Glomerular Filtration Rate (ml/min/1.73m2) at week 12 ± 4 days"
label variable eGFR_v5 "Glomerular Filtration Rate (ml/min/1.73m2) at week 26 ± 7 days (6 MONTHS)"
label variable eGFR_v6 "Glomerular Filtration Rate (ml/min/1.73m2) at week 39 ± 14 days"
label variable eGFR_v7 "Glomerular Filtration Rate (ml/min/1.73m2) at week 52 ± 14 days (1 YEAR)"
label variable eGFR_v8 "Glomerular Filtration Rate (ml/min/1.73m2) at week 65 ± 14 days"
label variable eGFR_v9 "Glomerular Filtration Rate (ml/min/1.73m2) at week 78 ± 14 days"
label variable eGFR_v10 "Glomerular Filtration Rate (ml/min/1.73m2) at week 91 ± 14 days"
label variable eGFR_v11 "Glomerular Filtration Rate (ml/min/1.73m2) at week 104 ± 14 days (2 YEARS)"
label variable eGFR_v12 "Glomerular Filtration Rate (ml/min/1.73m2) at week 117 ± 14 days"
label variable eGFR_v13 "Glomerular Filtration Rate (ml/min/1.73m2) at week 130 ± 14 days"
label variable eGFR_v14 "Glomerular Filtration Rate (ml/min/1.73m2) at week 143 ± 14 days"
label variable eGFR_v15 "Glomerular Filtration Rate (ml/min/1.73m2) at week 156 ± 14 days (3 YEARS)"

// Decrease in eGFR ≥25% from Baseline
foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	gen change = ((eGFR_`v' - eGFR_bl) / eGFR_bl) * 100
	gen eGFR25_`v' = 0 
	replace eGFR25_`v' = 1 if change <= -25
	replace eGFR25_`v' = . if missing(change)
	drop change
}
label define eGFR25 0 "No" 1 "Yes"
label values eGFR25_v1 eGFR25_v2 eGFR25_v3 eGFR25_v4 eGFR25_v5 eGFR25_v6 eGFR25_v7 eGFR25_v8 eGFR25_v9 eGFR25_v10 eGFR25_v11 eGFR25_v12 eGFR25_v13 eGFR25_v14 eGFR25_v15 eGFR25

label variable eGFR25_v1 "Decrease in eGFR ≥35% from Baseline at week 1 ± 2 days"
label variable eGFR25_v2 "Decrease in eGFR ≥35% from Baseline at week 2 ± 2 days"
label variable eGFR25_v3 "Decrease in eGFR ≥35% from Baseline at week 4 ± 4 days" 
label variable eGFR25_v4 "Decrease in eGFR ≥35% from Baseline at week 12 ± 4 days"
label variable eGFR25_v5 "Decrease in eGFR ≥35% from Baseline at week 26 ± 7 days (6 MONTHS)"
label variable eGFR25_v6 "Decrease in eGFR ≥35% from Baseline at week 39 ± 14 days" 
label variable eGFR25_v7 "Decrease in eGFR ≥35% from Baseline at week 52 ± 14 days (1 YEAR)"
label variable eGFR25_v8 "Decrease in eGFR ≥35% from Baseline at week 65 ± 14 days"
label variable eGFR25_v9 "Decrease in eGFR ≥35% from Baseline at week 78 ± 14 days"
label variable eGFR25_v10 "Decrease in eGFR ≥35% from Baseline at week 91 ± 14 days"
label variable eGFR25_v11 "Decrease in eGFR ≥35% from Baseline at week 104 ± 14 days (2 YEARS)"
label variable eGFR25_v12 "Decrease in eGFR ≥35% from Baseline at week 117 ± 14 days"
label variable eGFR25_v13 "Decrease in eGFR ≥35% from Baseline at week 130 ± 14 days"
label variable eGFR25_v14 "Decrease in eGFR ≥35% from Baseline at week 143 ± 14 days"
label variable eGFR25_v15 "Decrease in eGFR ≥35% from Baseline at week 156 ± 14 days (3 YEARS)"

// Decrease in eGFR ≥20% from previously reported
gen previous_v1 = eGFR_bl

gen previous_v2 = eGFR_v1
replace previous_v2 = eGFR_bl if missing(previous_v2)

gen previous_v3 = eGFR_v2
replace previous_v3 = eGFR_v1 if missing(previous_v3)
replace previous_v3 = eGFR_bl if missing(previous_v3)

gen previous_v4 = eGFR_v3
replace previous_v4 = eGFR_v2 if missing(previous_v4)
replace previous_v4 = eGFR_v1 if missing(previous_v4)
replace previous_v4 = eGFR_bl if missing(previous_v4)

gen previous_v5 = eGFR_v4
replace previous_v5 = eGFR_v3 if missing(previous_v5)
replace previous_v5 = eGFR_v2 if missing(previous_v5)
replace previous_v5 = eGFR_v1 if missing(previous_v5)
replace previous_v5 = eGFR_bl if missing(previous_v5)

gen previous_v6 = eGFR_v5
replace previous_v6 = eGFR_v4 if missing(previous_v6)
replace previous_v6 = eGFR_v3 if missing(previous_v6)
replace previous_v6 = eGFR_v2 if missing(previous_v6)
replace previous_v6 = eGFR_v1 if missing(previous_v6)
replace previous_v6 = eGFR_bl if missing(previous_v6)

gen previous_v7 = eGFR_v6
replace previous_v7 = eGFR_v5 if missing(previous_v7)
replace previous_v7 = eGFR_v4 if missing(previous_v7)
replace previous_v7 = eGFR_v3 if missing(previous_v7)
replace previous_v7 = eGFR_v2 if missing(previous_v7)
replace previous_v7 = eGFR_v1 if missing(previous_v7)
replace previous_v7 = eGFR_bl if missing(previous_v7)

gen previous_v8 = eGFR_v7
replace previous_v8 = eGFR_v6 if missing(previous_v8)
replace previous_v8 = eGFR_v5 if missing(previous_v8)
replace previous_v8 = eGFR_v4 if missing(previous_v8)
replace previous_v8 = eGFR_v3 if missing(previous_v8)
replace previous_v8 = eGFR_v2 if missing(previous_v8)
replace previous_v8 = eGFR_v1 if missing(previous_v8)
replace previous_v8 = eGFR_bl if missing(previous_v8)

gen previous_v9 = eGFR_v8
replace previous_v9 = eGFR_v7 if missing(previous_v9)
replace previous_v9 = eGFR_v6 if missing(previous_v9)
replace previous_v9 = eGFR_v5 if missing(previous_v9)
replace previous_v9 = eGFR_v4 if missing(previous_v9)
replace previous_v9 = eGFR_v3 if missing(previous_v9)
replace previous_v9 = eGFR_v2 if missing(previous_v9)
replace previous_v9 = eGFR_v1 if missing(previous_v9)
replace previous_v9 = eGFR_bl if missing(previous_v9)

gen previous_v10 = eGFR_v9
replace previous_v10 = eGFR_v8 if missing(previous_v10)
replace previous_v10 = eGFR_v7 if missing(previous_v10)
replace previous_v10 = eGFR_v6 if missing(previous_v10)
replace previous_v10 = eGFR_v5 if missing(previous_v10)
replace previous_v10 = eGFR_v4 if missing(previous_v10)
replace previous_v10 = eGFR_v3 if missing(previous_v10)
replace previous_v10 = eGFR_v2 if missing(previous_v10)
replace previous_v10 = eGFR_v1 if missing(previous_v10)
replace previous_v10 = eGFR_bl if missing(previous_v10)

gen previous_v11 = eGFR_v10
replace previous_v11 = eGFR_v9 if missing(previous_v11)
replace previous_v11 = eGFR_v8 if missing(previous_v11)
replace previous_v11 = eGFR_v7 if missing(previous_v11)
replace previous_v11 = eGFR_v6 if missing(previous_v11)
replace previous_v11 = eGFR_v5 if missing(previous_v11)
replace previous_v11 = eGFR_v4 if missing(previous_v11)
replace previous_v11 = eGFR_v3 if missing(previous_v11)
replace previous_v11 = eGFR_v2 if missing(previous_v11)
replace previous_v11 = eGFR_v1 if missing(previous_v11)
replace previous_v11 = eGFR_bl if missing(previous_v11)

gen previous_v12 = eGFR_v11
replace previous_v12 = eGFR_v10 if missing(previous_v12)
replace previous_v12 = eGFR_v9 if missing(previous_v12)
replace previous_v12 = eGFR_v8 if missing(previous_v12)
replace previous_v12 = eGFR_v7 if missing(previous_v12)
replace previous_v12 = eGFR_v6 if missing(previous_v12)
replace previous_v12 = eGFR_v5 if missing(previous_v12)
replace previous_v12 = eGFR_v4 if missing(previous_v12)
replace previous_v12 = eGFR_v3 if missing(previous_v12)
replace previous_v12 = eGFR_v2 if missing(previous_v12)
replace previous_v12 = eGFR_v1 if missing(previous_v12)
replace previous_v12 = eGFR_bl if missing(previous_v12)

gen previous_v13 = eGFR_v12
replace previous_v13 = eGFR_v11 if missing(previous_v13)
replace previous_v13 = eGFR_v10 if missing(previous_v13)
replace previous_v13 = eGFR_v9 if missing(previous_v13)
replace previous_v13 = eGFR_v8 if missing(previous_v13)
replace previous_v13 = eGFR_v7 if missing(previous_v13)
replace previous_v13 = eGFR_v6 if missing(previous_v13)
replace previous_v13 = eGFR_v5 if missing(previous_v13)
replace previous_v13 = eGFR_v4 if missing(previous_v13)
replace previous_v13 = eGFR_v3 if missing(previous_v13)
replace previous_v13 = eGFR_v2 if missing(previous_v13)
replace previous_v13 = eGFR_v1 if missing(previous_v13)
replace previous_v13 = eGFR_bl if missing(previous_v13)

gen previous_v14 = eGFR_v13
replace previous_v14 = eGFR_v12 if missing(previous_v14)
replace previous_v14 = eGFR_v11 if missing(previous_v14)
replace previous_v14 = eGFR_v10 if missing(previous_v14)
replace previous_v14 = eGFR_v9 if missing(previous_v14)
replace previous_v14 = eGFR_v8 if missing(previous_v14)
replace previous_v14 = eGFR_v7 if missing(previous_v14)
replace previous_v14 = eGFR_v6 if missing(previous_v14)
replace previous_v14 = eGFR_v5 if missing(previous_v14)
replace previous_v14 = eGFR_v4 if missing(previous_v14)
replace previous_v14 = eGFR_v3 if missing(previous_v14)
replace previous_v14 = eGFR_v2 if missing(previous_v14)
replace previous_v14 = eGFR_v1 if missing(previous_v14)
replace previous_v14 = eGFR_bl if missing(previous_v14)

gen previous_v15 = eGFR_v14
replace previous_v15 = eGFR_v13 if missing(previous_v15)
replace previous_v15 = eGFR_v12 if missing(previous_v15)
replace previous_v15 = eGFR_v11 if missing(previous_v15)
replace previous_v15 = eGFR_v10 if missing(previous_v15)
replace previous_v15 = eGFR_v9 if missing(previous_v15)
replace previous_v15 = eGFR_v8 if missing(previous_v15)
replace previous_v15 = eGFR_v7 if missing(previous_v15)
replace previous_v15 = eGFR_v6 if missing(previous_v15)
replace previous_v15 = eGFR_v5 if missing(previous_v15)
replace previous_v15 = eGFR_v4 if missing(previous_v15)
replace previous_v15 = eGFR_v3 if missing(previous_v15)
replace previous_v15 = eGFR_v2 if missing(previous_v15)
replace previous_v15 = eGFR_v1 if missing(previous_v15)
replace previous_v15 = eGFR_bl if missing(previous_v15)

foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	gen change = ((eGFR_`v' - previous_`v') / previous_`v') * 100
	gen eGFR20_`v' = 0 
	replace eGFR20_`v' = 1 if change <= -20
	replace eGFR20_`v' = . if missing(change)
	drop change
}
drop previous_v1 previous_v2 previous_v3 previous_v4 previous_v5 previous_v6 previous_v7 previous_v8 previous_v9 previous_v10 previous_v11 previous_v12 previous_v13 previous_v14 previous_v15
label define eGFR20 0 "No" 1 "Yes"
label values eGFR20_v1 eGFR20_v2 eGFR20_v3 eGFR20_v4 eGFR20_v5 eGFR20_v6 eGFR20_v7 eGFR20_v8 eGFR20_v9 eGFR20_v10 eGFR20_v11 eGFR20_v12 eGFR20_v13 eGFR20_v14 eGFR20_v15 eGFR20

label variable eGFR20_v1 "Decrease in eGFR ≥20% from previous reported at week 1 ± 2 days"
label variable eGFR20_v2 "Decrease in eGFR ≥20% from previous reported at week 2 ± 2 days"
label variable eGFR20_v3 "Decrease in eGFR ≥20% from previous reported at week 4 ± 4 days" 
label variable eGFR20_v4 "Decrease in eGFR ≥20% from previous reported at week 12 ± 4 days"
label variable eGFR20_v5 "Decrease in eGFR ≥20% from previous reported at week 26 ± 7 days (6 MONTHS)"
label variable eGFR20_v6 "Decrease in eGFR ≥20% from previous reported at week 39 ± 14 days" 
label variable eGFR20_v7 "Decrease in eGFR ≥20% from previous reported at week 52 ± 14 days (1 YEAR)"
label variable eGFR20_v8 "Decrease in eGFR ≥20% from previous reported at week 65 ± 14 days"
label variable eGFR20_v9 "Decrease in eGFR ≥20% from previous reported at week 78 ± 14 days"
label variable eGFR20_v10 "Decrease in eGFR ≥20% from previous reported at week 91 ± 14 days"
label variable eGFR20_v11 "Decrease in eGFR ≥20% from previous reported at week 104 ± 14 days (2 YEARS)"
label variable eGFR20_v12 "Decrease in eGFR ≥20% from previous reported at week 117 ± 14 days"
label variable eGFR20_v13 "Decrease in eGFR ≥20% from previous reported at week 130 ± 14 days"
label variable eGFR20_v14 "Decrease in eGFR ≥20% from previous reported at week 143 ± 14 days"
label variable eGFR20_v15 "Decrease in eGFR ≥20% from previous reported at week 156 ± 14 days (3 YEARS)"


/*
SECONDARY ENDPOINT - TRANSIENT ISCHAEMIC ATTACK (TIA)

Incidence of Transient Ischaemic Attack (TIA) – as defined by the American Heart Association (2009).  TIA events and dates are collected in the endpoint CRF as the variable CVDTYPE.  The variable CVDTYPE is a field indicating the type of CVD event (coded as either heart failure, stroke, transient ischaemic attack or peripheral arterial disease).  Events recorded as ‘transient ischaemic attack’ will be used to compute the incidence of TIA. 
*/

gen TIA = 0
forvalues i = 1(1)4 {
	replace TIA = 1 if strpos(cvdtype_`i'_ep, "4") > 0
}

label define TIA 0 "No" 1 "Yes"
label values TIA TIA
label variable TIA "Transient Ischaemic Attack at any point during the study"


/*
SECONDARY ENDPOINT - RATE OF ADVERSE EVENTS

Rates of adverse events.  All adverse events are recorded in the AE report CRF. The number of participants experiencing at least one AE and the number of AEs per participant will be reported.  Number of SAEs will also be reported. 
*/

* AE
gen aeyn = 0 
replace aeyn = 1 if complete_ae == 1

gen aecount = 0
forvalues i = 1(1)23 {
	capture noisily: replace aecount = aecount + 1 if !missing(aeterm_`i'_ae)
}

label define aeyn 0 "No" 1 "Yes"
label values aeyn aeyn
label variable aeyn "Experiencing at least one AE during the study"
label variable aecount "Number of AEs during the study"


* SAE
gen saeyn = 0 
replace saeyn = 1 if complete_sae == 1

preserve

keep if saeyn == 1

forvalues i = 1(1)7 {
	gen log_sae_`i'_new = log_sae_`i'_sae
	gen saeterm_`i'_new = saeterm_`i'_sae
}

keep StudySubjectID log_sae_1_new saeterm_1_new log_sae_2_new saeterm_2_new log_sae_3_new saeterm_3_new log_sae_4_new saeterm_4_new log_sae_5_new saeterm_5_new log_sae_6_new saeterm_6_new log_sae_7_new saeterm_7_new

rename log_sae_*_new log_sae_*
rename saeterm_*_new saeterm_*

reshape long log_sae_ saeterm_, i(StudySubjectID) j(ID)

sort StudySubjectID ID log_sae_

gen flag = 1 if log_sae_ == log_sae_[_n+1] & !missing(log_sae_)
replace flag = 2 if log_sae_ == log_sae_[_n-1] & !missing(log_sae_)

replace saeterm_ = "Initial report: " + saeterm_ + " Follow-up report: " + saeterm_[_n+1] if flag == 1

drop if flag == 2
drop flag log_sae_

reshape wide saeterm_, i(StudySubjectID) j(ID)

rename saeterm_* saeterm_*_new
label variable saeterm_1_new "Serious Adverse Event Description"
label variable saeterm_2_new "Serious Adverse Event Description"
label variable saeterm_3_new "Serious Adverse Event Description"
label variable saeterm_4_new "Serious Adverse Event Description"
label variable saeterm_5_new "Serious Adverse Event Description"
label variable saeterm_6_new "Serious Adverse Event Description"
label variable saeterm_7_new "Serious Adverse Event Description"

save "temp_sae.dta", replace

restore

merge 1:1 StudySubjectID using "temp_sae.dta", nogen 

gen saecount = 0
forvalues i = 1(1)7 {
	replace saecount =  saecount + 1 if !missing(saeterm_`i'_new)
}

label define saeyn 0 "No" 1 "Yes"
label values saeyn saeyn
label variable saeyn "Experiencing at least one SAE during the study"
label variable saecount "Number of SAEs during the study"

erase "temp_sae.dta"


/*
SECONDARY ENDPOINT - RATE OF HYPERKALAEMIN

Hyperkaleamia is defined as a potassium level ≥5.5mmol/l.  Potassium [K] is recorded at each visit. A binary variable will be derived as experiencing hyperkalaemia at any time point. Hyperkalaemia will be recorded as “yes” if the participant has potassium levels ≥5.5mmol/l at any point during the study and “no” if at least one potassium measure is recorded and it does not meet the definition of hyperkalaemia.  If a participant has hyperkalaemia at any point during the study, the maximum value of Hyperkalaemia for that patients will be used to derive a second variable to indicate whether the maximum hyperkalaemia was mild (5.5-5.9mmol/l), moderate (6.0-6.4mmol/l) or severe (>6.5mmol/l).  
*/

gen potassium_bl = k_bl
destring potassium_bl, replace

gen potassium_v1 = k_v1
destring potassium_v1, replace

gen potassium_v2 = k_v2
destring potassium_v2, replace

gen potassium_v3 = k_v3
destring potassium_v3, replace

gen potassium_v4 = k_v4
destring potassium_v4, replace

gen potassium_v5 = k_v5
destring potassium_v5, replace

gen potassium_v6 = k_v6
destring potassium_v6, replace

gen potassium_v7 = k_v7
destring potassium_v7, replace

gen potassium_v8 = k_v8
replace potassium_v8 = "" if potassium_v8 == "Missing result"
destring potassium_v8, replace

gen potassium_v9 = k_v9
replace potassium_v9 = "" if potassium_v9 == "Not done"
destring potassium_v9, replace

gen potassium_v10 = k_v10
replace potassium_v10 = "" if potassium_v10 == "Not done"
destring potassium_v10, replace

gen potassium_v11 = k_v11
replace potassium_v11 = "" if potassium_v11 == "Not done"
destring potassium_v11, replace

gen potassium_v12 = k_v12
replace potassium_v12 = "" if potassium_v12 == "Not done"
destring potassium_v12, replace

gen potassium_v13 = k_v13
replace potassium_v13 = "" if potassium_v13 == "Not done"
destring potassium_v13, replace

gen potassium_v14 = k_v14
replace potassium_v14 = "" if potassium_v14 == "Not done"
destring potassium_v14, replace

gen potassium_v15 = k_v15
replace potassium_v15 = "" if potassium_v15 == "Not done"
destring potassium_v15, replace

foreach v in bl v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	replace potassium_`v' = . if potassium_`v' == 666 | potassium_`v' == 777 | potassium_`v' == 888 | potassium_`v' == 999
}

label variable potassium_bl "Potassium (mmol/L) at baseline"
label variable potassium_v1 "Potassium (mmol/L) at week 1 ± 2 days"
label variable potassium_v2 "Potassium (mmol/L) at week 2 ± 2 days"
label variable potassium_v3 "Potassium (mmol/L) at week 4 ± 4 days"
label variable potassium_v4 "Potassium (mmol/L) at week 12 ± 4 days"
label variable potassium_v5 "Potassium (mmol/L) at week 26 ± 7 days (6 MONTHS)"
label variable potassium_v6 "Potassium (mmol/L) at week 39 ± 14 days"
label variable potassium_v7 "Potassium (mmol/L) at week 52 ± 14 days (1 YEAR)"
label variable potassium_v8 "Potassium (mmol/L) at week 65 ± 14 days"
label variable potassium_v9 "Potassium (mmol/L) at week 78 ± 14 days"
label variable potassium_v10 "Potassium (mmol/L) at week 91 ± 14 days"
label variable potassium_v11 "Potassium (mmol/L) at week 104 ± 14 days (2 YEARS)"
label variable potassium_v12 "Potassium (mmol/L) at week 117 ± 14 days"
label variable potassium_v13 "Potassium (mmol/L) at week 130 ± 14 days"
label variable potassium_v14 "Potassium (mmol/L) at week 143 ± 14 days"
label variable potassium_v15 "Potassium (mmol/L) at week 156 ± 14 days (3 YEARS)"

gen hyperkalaemia = 0
foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	replace hyperkalaemia = 1 if potassium_`v' >= 5.5 & !missing(potassium_`v')
}
replace hyperkalaemia = . if [missing(potassium_v1) & missing(potassium_v2) & missing(potassium_v3) & missing(potassium_v4) & missing(potassium_v5) & missing(potassium_v6) & missing(potassium_v7) & missing(potassium_v8) & missing(potassium_v9) & missing(potassium_v10) & missing(potassium_v11) & missing(potassium_v12) & missing(potassium_v13) & missing(potassium_v14) & missing(potassium_v15)]

label define hyperkalaemia 0 "No" 1 "Yes"
label values hyperkalaemia hyperkalaemia
label variable hyperkalaemia "Hyperkalaemia at any point during the study"

gen hyperkalaemia_class = 0
// Mild (5.5 to 5.9 mmol/l)
foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	replace hyperkalaemia_class = 1 if potassium_`v' >= 5.5 & potassium_`v' < 6.0 & !missing(potassium_`v')
}
// Moderate (6.0 to 6.4 mmol/l)
foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	replace hyperkalaemia_class = 2 if potassium_`v' >= 6.0 & potassium_`v' < 6.5 & !missing(potassium_`v')
}
// Severe (> 6.5 mmol/l)
foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
	replace hyperkalaemia_class = 3 if potassium_`v' >= 6.5 & !missing(potassium_`v')
}
// No hyperkalaemia
replace hyperkalaemia_class = . if hyperkalaemia == 0 | missing(hyperkalaemia)

label define hyperkalaemia_class 1 "Mild (5.5 to 5.9 mmol/l)" 2 "Moderate (6.0 to 6.4 mmol/l)" 3 "Severe (> 6.5 mmol/l)"
label values hyperkalaemia_class hyperkalaemia_class
label variable hyperkalaemia_class "Hyperkalaemia classification"


/* 
SENSITIVITY ANALYSIS

To test the robustness of the result for the primary outcome, a sensitivity analysis will be carried out, using the cox proportional hazards model, adjusting the following pre-specified baseline prognostic factors:  diastolic (DIABPR/DIABPL) and/or systolic blood pressure (SYSBPR/SYSBPL) above or below NICE target, type II diabetes (DIAYN) and coronary artery disease (IHDYN) BP targets will be based on the following measures of clinical blood pressure: 
o	People aged under 80 years: lower than 140/90 mm Hg (systolic/diastolic) 
o	People aged 80 years or over: lower than 150/90 mm Hg (systolic/diastolic)
As blood pressure is recorded in both arms at each visit, we will consider the average of the two measures as meeting the criteria.
*/

gen bpNICE_bl = 0
replace bpNICE_bl = 1 if [(sysbp_bl < 140 & !missing(sysbp_bl)) | (diabp_bl < 90 & !missing(diabp_bl))] & (age_bl < 80 & !missing(age_bl))
replace bpNICE_bl = 1 if [(sysbp_bl < 150 & !missing(sysbp_bl)) | (diabp_bl < 90 & !missing(diabp_bl))] & (age_bl >= 80 & !missing(age_bl))

label define bpNICE_bl 0 "BP above NICE target" 1 "BP below NICE target"
label values bpNICE_bl bpNICE_bl
label variable bpNICE_bl "Baseline blood pressure below/above NICE target"




****************************** SAES & MEDDRA CODING ****************************

forvalues i = 1(1)8 {
	forvalues j = 1(1)18 {
		capture noisily: replace soc_meddra`i'_`j'_ae = "Cardiac disorders" if soc_meddra`i'_`j'_ae == "Cardiac disorder"
		capture noisily: replace soc_meddra`i'_`j'_ae = "Neoplasms benign, malignant and unspecified (incl cysts and polyps)" if soc_meddra`i'_`j'_ae == "Neoplasms benign, malignant and unspecified (incl cysts and polyps"
		capture noisily: replace soc_meddra`i'_`j'_ae = "Injury, poisoning and procedural complications" if soc_meddra`i'_`j'_ae == "njury, poisoning and procedural complications"
		capture noisily: replace pt_meddra`i'_`j'_ae = "Angina pectoris" if pt_meddra`i'_`j'_ae == "Angina pectrois"
		capture noisily: replace pt_meddra`i'_`j'_ae = "Vomiting" if pt_meddra`i'_`j'_ae == "vomiting"
		capture noisily: replace pt_meddra`i'_`j'_ae = "Pouchitis" if pt_meddra`i'_`j'_ae == " Pouchitis"
		capture noisily: replace pt_meddra`i'_`j'_ae = "Brain natriuretic peptide increased" if pt_meddra`i'_`j'_ae == "brain natriuretic peptide increased"		
		capture noisily: replace pt_meddra`i'_`j'_ae = "Muscle spasms" if pt_meddra`i'_`j'_ae == "Muscle spasm"
	}
}

save "2.Data for Analysis (e.g. dta or sas)\BARACK-D for Analysis_$today.dta", replace



********************************** MEDICATION **********************************

use "2.Data for Analysis (e.g. dta or sas)\BARACK-D for Analysis_$today.dta", clear

* Current medication baseline (CMTRT) 

keep StudySubjectID cmtrt_*_bl cmstdat_*_bl cmendat_*_bl

rename cmtrt_*_bl cmtrt*
rename cmstdat_*_bl cmstdat*
rename cmendat_*_bl cmendat*

reshape long cmtrt cmstdat cmendat, i(StudySubjectID) j(mednum)

replace cmtrt = lower(cmtrt)

save "2.Data for Analysis (e.g. dta or sas)\temp_med.dta", replace

import excel "1.Data Received (read only)\Copy of Medname_MP.xlsx", sheet("Sheet1") firstrow clear

rename _all, lower
replace cmtrt = lower(cmtrt)

sort cmtrt
gen dup = 1 if cmtrt == cmtrt[_n-1]
drop if dup == 1
drop dup

merge 1:m cmtrt using "2.Data for Analysis (e.g. dta or sas)\temp_med.dta"
drop _merge

erase "2.Data for Analysis (e.g. dta or sas)\temp_med.dta"

drop if missing(StudySubjectID)

foreach var in betablocker aceinhibitors arb statin antihypensive {
	replace `var' = "1" if `var' == "y"
	replace `var' = "1" if `var' == "Y"
	destring `var', replace
}

keep StudySubjectID betablocker aceinhibitors arb statin antihypensive mednum
order StudySubjectID betablocker aceinhibitors arb statin antihypensive mednum

reshape wide betablocker aceinhibitors arb statin antihypensive, i(StudySubjectID) j(mednum)

foreach var in betablocker aceinhibitors arb statin antihypensive {
	egen `var' = rowmax(`var'*)
	replace `var' = 0 if missing(`var')
	rename `var' `var'_bl
}

keep StudySubjectID betablocker_bl aceinhibitors_bl arb_bl statin_bl antihypensive_bl

label define medyn 0 "No" 1 "Yes"
label values betablocker_bl aceinhibitors_bl arb_bl statin_bl antihypensive_bl medyn

label variable betablocker_bl "Beta blocker"
label variable aceinhibitors_bl "ACE inhibitors"
label variable arb_bl "ARB"
label variable statin_bl "Statin"
label variable antihypensive_bl "Antihypensive"

merge 1:1 StudySubjectID using "2.Data for Analysis (e.g. dta or sas)\BARACK-D for Analysis_$today.dta"
drop _merge

order betablocker_bl aceinhibitors_bl arb_bl statin_bl antihypensive_bl, after(cmongo_28_bl)





gen lastvisit = 0
forvalue i = 1(1)15 {
	replace lastvisit = `i' if complete_v`i' == 1
}
label define lastvisit 0 "Baseline" 1 "Week 1 (Visit 1)" 2 "Week 2 (Visit 2)" 3 "Week 4 (Visit 3)" 4 "Week 12 (Visit 4)" 5 "Month 6 (Visit 5)" 6 "Week 39 (Visit 6)" 7 "Year 1 (Visit 7)" 8 "Week 65 (Visit 8)" 9 "Week 78 (Visit 9)" 10 "Week 91 (Visit 10)" 11 "Year 2 (Visit 11)" 12 "Week 117 (Visit 12)" 13 "Week 130 (Visit 13)" 14 "Week 143 (Visit 14)" 15 "Year 3 (Visit 15)"
label values lastvisit lastvisit
label variable lastvisit "Last visit"

gen ewreason = .
foreach i in 4 3 2 1 {
	foreach j in 1 2 3 4 5 6 {
		replace ewreason = `j' if strpos(ewreason_`i'_wd, "`j'") > 0 & missing(ewreason)
	}
}
foreach i in 1 2 3 {
	replace ewreason = 7 if lfu_`i'_wd == 1 
}

replace ewreason = 7 if missing(ewreason) & lastvisit != 15
replace ewreason = 8 if EPdeath == 1
replace ewreason = 3 if missing(randgrp) | eligible != 1 | !missing(ietestcd_scr) | randelig_bl != 1 | strpos(ewreason_1_, "3") != 0 | strpos(ewreason_2_wd, "3") != 0 | strpos(ewreason_3_wd, "3") | strpos(ewreason_4_wd, "3") != 0
replace ewreason = . if lastvisit == 15 & ewreason != 3 & ewreason != 8 

label define ewreason3 1 "Non adherence to study procedures" 2 "Due to safety concerns" 3 "Ineligibility" 4 "Non-compliance with study/treatment" 5 "Due to disease progression" 6 "Other" 7 "Lost to follow-up" 8 "Died"
label values ewreason ewreason3
label variable ewreason "Reason for withdrawal/discontinuation/lost to follow-up"

order lastvisit ewreason, after(ITT)


merge 1:1 StudySubjectID using "2.Data for Analysis (e.g. dta or sas)\BARACK-D IMD_quintile.dta"
drop _merge
rename IMDquintile_new IMDquintile_bl
order IMDquintile_bl, after(postcode_bl)
label variable IMDquintile_bl "Indices of multiple deprivation (IMD) quintile"



********************************************************************************
************************************* SAVE *************************************
********************************************************************************

save "2.Data for Analysis (e.g. dta or sas)\BARACK-D for Analysis_$today.dta", replace
