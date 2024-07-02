global today = string(daily("$S_DATE", "DMY"), "%tdDmCY")

log using "K:\CV_R\BARACK-D\STATS\4. Analysis\4.Output\Analysis log_$today.log", replace

********************************************************************************
* PROJECT:      BARACK-D
* PROGRAM:      Program 3 - Analysis
* WRITTEN BY:   Sam Mort
* DATE:         December 2022 (Updated February 2023)
* SOFTWARE:     Stata 16.1 (SE) 
*
* NOTES:		
********************************************************************************

clear
clear matrix
clear mata
putdocx clear
putexcel clear

global data = "31Mar2023"

version 16.1
cd "K:\CV_R\BARACK-D\STATS\4. Analysis"

set maxvar 32767
use "2.Data for Analysis (e.g. dta or sas)\BARACK-D for Analysis_$data.dta", clear

/*
SCR - SCREENING
BL  - BASELINE
V1  - WEEK 1   ± 2 DAYS
V2  - WEEK 2   ± 2 DAYS
V3  - WEEK 4   ± 4 DAYS
V4  - WEEK 12  ± 4 DAYS
V5  - WEEK 26  ± 7 DAYS  (6 MONTHS)
V6  - WEEK 39  ± 14 DAYS
V7  - WEEK 52  ± 14 DAYS (1 YEAR)
V8  - WEEK 65  ± 14 DAYS
V9  - WEEK 78  ± 14 DAYS
V10 - WEEK 91  ± 14 DAYS
V11 - WEEK 104 ± 14 DAYS (2 YEARS)
V12 - WEEK 117 ± 14 DAYS
V13 - WEEK 130 ± 14 DAYS
V14 - WEEK 143 ± 14 DAYS
V15 - WEEK 156 ± 14 DAYS (3 YEARS)
EP  - ENDPOINT
WD  - DISCONTINUATION
AE  - ADVERSE EVENTS
SAE - SERIOUS ADVERSE EVENTS
*/

* Remove all ineligible from analysis
drop if missing(randgrp)
keep if eligible == 1
keep if ieyn_scr == 1 | randelig_bl == 1
keep if missing(ietestcd_scr)
forvalues i = 1(1)4 {
	drop if strpos(ewreason_`i'_wd, "3") > 0 // Withdrawn due to ineligiblity
}


* Begin putdocx
putdocx begin, font("Calibri", 10, 0 0 0)

* Document title
putdocx paragraph, font("Calibri", 14, 0 0 0) halign(center)
putdocx text ("BARACK-D Final Analysis"), bold

* Document author
putdocx paragraph, font("Calibri", 12, 0  0 0)
putdocx text ("AUTHOR: Sam Mort"), bold

* Date and time document created
putdocx paragraph, font(, 12)
putdocx text ("DATE: $S_DATE $S_TIME"), bold

* Software used
putdocx paragraph, font("Calibri", 12, 0 0 0)
putdocx text ("SOFTWARE: Stata Version 16.1 (SE)"), bold

* Set putexcel
putexcel set "4.Output\Results_$today.xlsx", replace


* Number of participants in each group 
tab randgrp, matcell(M)
global N1 = M[1,1]
global N2 = M[2,1]
global N = M[1,1] + M[2,1]
global groups = r(r) // Number of groups



********************************************************************************
******************* BASELINE CHARACTERISTICS OF PARTICIPANTS *******************
********************************************************************************

putdocx sectionbreak
putdocx paragraph
putdocx text ("BASELINE CHARACTERISTICS OF PARTICIPANTS"), bold


/* TABLE 1 BASELINE CHARACTERISTICS */

putdocx paragraph
putdocx text ("Table 1 Baseline characteristics"), bold

putdocx table table = (104,4), note("NB Percentages have been computed with the number of participants with the response available as the denominator")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Overall"), halign(center) bold
putdocx table table(2,4) = ("(N=$N)"), halign(center) bold

putdocx table table(3,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(4,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(5,1) = ("     18 to 64 years")
putdocx table table(6,1) = ("     65 to 84 years")
putdocx table table(7,1) = ("     85 years and older")
putdocx table table(8,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(9,1) = ("     18 to 54 years")
putdocx table table(10,1) = ("     55 to 64 years")
putdocx table table(11,1) = ("     65 to 74 years")
putdocx table table(12,1) = ("     75 to 84 years")
putdocx table table(13,1) = ("     85 years and older")
putdocx table table(14,1) = ("Sex, n/N (%)"), bold
putdocx table table(15,1) = ("     Male")
putdocx table table(16,1) = ("     Female")
putdocx table table(17,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(18,1) = ("     White")
putdocx table table(19,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(20,1) = ("     Asian/Asian British")
putdocx table table(21,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(22,1) = ("     Other ethnic group")
putdocx table table(23,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(24,1) = ("     Hypertension")
putdocx table table(25,1) = ("     Diabetes")
putdocx table table(26,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(27,1) = ("     Ischaemic heart disease")
putdocx table table(28,1) = ("     Heart failure")
putdocx table table(29,1) = ("     Atrial fibrillation")
putdocx table table(30,1) = ("     Cerebrovascular disease")
putdocx table table(31,1) = ("     Peripheral vascular disease")
putdocx table table(32,1) = ("     Renal disease")
putdocx table table(33,1) = ("     Childhood urinary tract infection")
putdocx table table(34,1) = ("     Adulthood urinary tract infection")
putdocx table table(35,1) = ("     Thyroid disease")
putdocx table table(36,1) = ("     Anaemia")
putdocx table table(37,1) = ("     Osteopenia")
putdocx table table(38,1) = ("     Osteoporosis")
putdocx table table(39,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(40,1) = ("     1 (Most deprived)")
putdocx table table(41,1) = ("     2")
putdocx table table(42,1) = ("     3")
putdocx table table(43,1) = ("     4")
putdocx table table(44,1) = ("     5 (Least deprived)")
putdocx table table(45,1) = ("Current medication, n/N (%)"), bold
putdocx table table(46,1) = ("     Beta blockers")
putdocx table table(47,1) = ("     ACE inhibitors")
putdocx table table(48,1) = ("     ARBs")
putdocx table table(49,1) = ("     Statins")
putdocx table table(50,1) = ("     Antihypensives")
putdocx table table(51,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(52,1) = ("     Never smoker")
putdocx table table(53,1) = ("     Current smoker")
putdocx table table(54,1) = ("     Former smoker")
putdocx table table(55,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(56,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(57,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(58,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(60,1) = ("     Systolic BP left arm")
putdocx table table(61,1) = ("     Systolic BP right arm")
putdocx table table(62,1) = ("     Diastolic BP left arm")
putdocx table table(63,1) = ("     Diastolic BP right arm"),
putdocx table table(64,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(65,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(66,1) = ("     Normal")
putdocx table table(67,1) = ("     Abnormal (not clinically significant)")
putdocx table table(68,1) = ("     Abnormal (clinically significant)")
putdocx table table(69,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(70,1) = ("     Normal")
putdocx table table(71,1) = ("     Abnormal (not clinically significant)")
putdocx table table(72,1) = ("     Abnormal (clinically significant)")
putdocx table table(73,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(74,1) = ("     Normal")
putdocx table table(75,1) = ("     Abnormal (not clinically significant)")
putdocx table table(76,1) = ("     Abnormal (clinically significant)")
putdocx table table(77,1) = ("Lipids, n/N (%)"), bold
putdocx table table(78,1) = ("     Normal")
putdocx table table(79,1) = ("     Abnormal (not clinically significant)")
putdocx table table(80,1) = ("     Abnormal (clinically significant)")
putdocx table table(81,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(82,1) = ("     Normal")
putdocx table table(83,1) = ("     Abnormal (not clinically significant)")
putdocx table table(84,1) = ("     Abnormal (clinically significant)")
putdocx table table(85,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(86,1) = ("     Normal")
putdocx table table(87,1) = ("     Abnormal (not clinically significant)")
putdocx table table(88,1) = ("     Abnormal (clinically significant)")
putdocx table table(89,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(90,1) = ("     Normal")
putdocx table table(91,1) = ("     Abnormal (not clinically significant)")
putdocx table table(92,1) = ("     Abnormal (clinically significant)")
putdocx table table(93,1) = ("B-type natriuretic peptide"), bold
putdocx table table(94,1) = ("     Normal")
putdocx table table(95,1) = ("     Abnormal (not clinically significant)")
putdocx table table(96,1) = ("     Abnormal (clinically significant)")
putdocx table table(97,1) = ("Electrocardiogram"), bold
putdocx table table(98,1) = ("     Normal")
putdocx table table(99,1) = ("     Abnormal (not clinically significant)")
putdocx table table(100,1) = ("     Abnormal (clinically significant)")
putdocx table table(101,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(102,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(103,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(104,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(64,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(65,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(7,.), border(bottom, single)
putdocx table table(13,.), border(bottom, single)
putdocx table table(16,.), border(bottom, single)
putdocx table table(22,.), border(bottom, single)
putdocx table table(38,.), border(bottom, single)
putdocx table table(44,.), border(bottom, single)
putdocx table table(50,.), border(bottom, single)
putdocx table table(54,.), border(bottom, single)
putdocx table table(55,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(63,.), border(bottom, single)
putdocx table table(64,.), border(bottom, single)
putdocx table table(68,.), border(bottom, single)
putdocx table table(72,.), border(bottom, single)
putdocx table table(76,.), border(bottom, single)
putdocx table table(80,.), border(bottom, single)
putdocx table table(84,.), border(bottom, single)
putdocx table table(88,.), border(bottom, single)
putdocx table table(92,.), border(bottom, single)
putdocx table table(96,.), border(bottom, single)
putdocx table table(100,.), border(bottom, single)
putdocx table table(101,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, double)

* Age
local row = 3

tabstat age_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Age groups (EudraCT guidelines)
local row = 4

tabcount age_group1_bl randgrp, v1(1 2 3) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Additional age groups
local row = 8

tabcount age_group2_bl randgrp, v1(1 2 3 4 5) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Sex
local row = 14

tabcount sex_bl randgrp, v1(1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Ethnicity
local row = 17

tabcount ethnicnew_bl randgrp, v1(1 2 3 4 5) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Past medical history
local row = 23

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	tabcount `var'_bl randgrp, c1(1 0) v2(1 2) zero matrix(MG)
	local row = `row' + 1
	
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	matrix MTA = J(1,rowsof(MT),1) * MT
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Indices of multiple deprivation (IMD)
local row = 39

tabcount IMDquintile_bl randgrp, v1(1 2 3 4 5) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Current medication
local row = 45

foreach var in betablocker aceinhibitors arb statin antihypensive {
	tabcount `var'_bl randgrp, c1(1 0) v2(1 2) zero matrix(MG)
	local row = `row' + 1
	
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	matrix MTA = J(1,rowsof(MT),1) * MT
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Smoking status
local row = 51

tabcount smokstat_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Weight (kg)
local row = 55

tabstat weight_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Height (cm)
local row = 56

tabstat height_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)


* Waise circumference (cm)
local row = 57

tabstat wstcir_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Hip circumference (cm)
local row = 58

tabstat hipcir_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Office BP measurement (mmHG)
local row = 59

foreach var in sysbpl sysbpr diabpl diabpr {
	tabstat `var'_bl, by(randgrp) stat(mean sd min max n) save
	local row = `row' + 1
	
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = `g' + 1
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
	matrix define MT = r(StatTotal)
	local col = `col' + 1
	local mean = string(MT[1,1], "%5.1f")
	local sd = string(MT[2,1], "%5.1f")
	local n = string(MT[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 65

tabcount renclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Liver function tests
local row = 69

tabcount livclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Bone profile
local row = 73

tabcount bonclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Lipids
local row = 77

tabcount lipclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Full blood count
local row = 81

tabcount fbcclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* HbA1C
local row = 85

tabcount hbaclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Fasting blood sugar
local row = 89

tabcount fbsclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* B-type natriuretic peptide
local row = 93

tabcount bnpclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Electrocardiogram
local row = 97

tabcount ecgclsig_bl randgrp, v1(0 1 2) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Albumin creatinine ratio (mg/mmol)
local row = 101

tabstat ACR_old_bl, by(randgrp) stat(p50 p25 p75 n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local p50 = string(M`g'[1,1], "%5.1f")
	local p25 = string(M`g'[2,1], "%5.1f")
	local p75 = string(M`g'[3,1], "%5.1f")
	local n = string(M`g'[4,1], "%5.0f")
	putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local p50 = string(MT[1,1], "%5.1f")
local p25 = string(MT[2,1], "%5.1f")
local p75 = string(MT[3,1], "%5.1f")
local n = string(MT[4,1], "%5.0f")
putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)

* eGFR (ml/min/1.73m2)
local row = 102

tabstat eGFR_old_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Potassium (mmol/L)
local row = 103

tabstat potassium_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Creatinine (μmol/L)
local row = 104

tabstat creatinine_bl, by(randgrp) stat(mean sd min max n) save

forvalues g = 1(1)$groups {
	matrix define M`g' = r(Stat`g')
	local col = `g' + 1
	local mean = string(M`g'[1,1], "%5.1f")
	local sd = string(M`g'[2,1], "%5.1f")
	local n = string(M`g'[5,1], "%5.0f")
	putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
}
matrix define MT = r(StatTotal)
local col = `col' + 1
local mean = string(MT[1,1], "%5.1f")
local sd = string(MT[2,1], "%5.1f")
local n = string(MT[5,1], "%5.0f")
putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)

* Practice ID
local row = 105


********************************************************************************
******************************** NUMBER ANALYSED *******************************
********************************************************************************

putdocx sectionbreak
putdocx paragraph
putdocx text ("NUMBER ANALYSED"), bold


/* TABLE 2 COMPLETION OF FOLLOW-UP ASSESSMENTS, WITHDRAWALS, AND LOSS TO FOLLOW-UP OVER THE STUDY PERIOD */

putdocx paragraph
putdocx text ("Table 2 Completion of follow-up assessments, withdrawals, and loss to follow-up over the study period"), bold

putdocx table table = (32,4), note("NB Percentages have been computed with the number of participants remaining in the study at each time point/the number of participants in the randomised arm that withdrew, discontinued, or were lost to follow-up after randomisation. *Excluded from analysis population") 

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(1,4) = ("Overall"), halign(center) bold

putdocx table table(2,1) = ("Screened"), bold
putdocx table table(3,1) = ("Excluded (not randomised)"), bold
putdocx table table(4,1) = ("Randomised"), bold
putdocx table table(5,1) = ("Study visit available, n/N (%)"), bold
putdocx table table(6,1) = ("     Baseline"), bold
putdocx table table(7,1) = ("     Visit 1 - Week 1 follow-up")
putdocx table table(8,1) = ("     Visit 2 - Week 2 follow-up")
putdocx table table(9,1) = ("     Visit 3 - Week 4 follow-up")
putdocx table table(10,1) = ("     Visit 4 - Week 12 follow-up")
putdocx table table(11,1) = ("     Visit 5 - Month 6 follow-up"), bold
putdocx table table(12,1) = ("     Visit 6 - Week 39 follow-up")
putdocx table table(13,1) = ("     Visit 7 - Year 1 follow-up"), bold
putdocx table table(14,1) = ("     Visit 8 - Week 65 follow-up")
putdocx table table(15,1) = ("     Visit 9 - Week 78 follow-up")
putdocx table table(16,1) = ("     Visit 10 - Week 91 follow-up")
putdocx table table(17,1) = ("     Visit 11 - Year 2 follow-up"), bold
putdocx table table(18,1) = ("     Visit 12 - Week 117 follow-up")
putdocx table table(19,1) = ("     Visit 13 - Week 130 follow-up")
putdocx table table(20,1) = ("     Visit 14 - Week 143 follow-up")
putdocx table table(21,1) = ("     Visit 15 - Year 3 follow-up"), bold
putdocx table table(22,1) = ("Withdrew/Discontinued/Lost to follow-up after randomisation/Died, n/N (%)"), bold
putdocx table table(23,1) = ("     Non adherence to study procedures")
putdocx table table(24,1) = ("     Due to safety concerns")
putdocx table table(25,1) = ("     Ineligibility*")
putdocx table table(26,1) = ("     Non-compliance with study/treatment")
putdocx table table(27,1) = ("     Due to disease progression")
putdocx table table(28,1) = ("     Other reason")
putdocx table table(29,1) = ("     Lost to follow-up")
putdocx table table(30,1) = ("     Died")
putdocx table table(31,1) = ("Endpoint form available"), bold
putdocx table table(32,1) = ("Included in analysis population"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(1,.), border(bottom, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(4,.), border(bottom, single)
putdocx table table(21,.), border(bottom, single)
putdocx table table(30,.), border(bottom, single)
putdocx table table(31,.), border(bottom, single)
putdocx table table(32,.), border(bottom, double)

preserve

use "2.Data for Analysis (e.g. dta or sas)\BARACK-D for Analysis_$data", clear

local row = 2

* Screened
count
local n = string(r(N), "%5.0f")

putdocx table table(`row',2) = ("-"), halign(center) bold
putdocx table table(`row',3) = ("-"), halign(center) bold
putdocx table table(`row',4) = ("`n'"), halign(center) bold

* Excluded (not randomised)
local row = `row' + 1

count if missing(randgrp)
local n = string(r(N), "%5.0f")

putdocx table table(`row',2) = ("-"), halign(center) bold
putdocx table table(`row',3) = ("-"), halign(center) bold
putdocx table table(`row',4) = ("`n'"), halign(center) bold

* Randomised
local row = `row' + 1

keep if !missing(randgrp)

tabcount ITT randgrp, c1(<=1) v2(1 2) zero matrix(MG)

forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
putdocx table table(`row',`col') = ("`freq'"), halign(center)

* Withdrew/discontinued/lost to follow-up after randomisation
local row = 22

tabcount ewreason randgrp if (lastvisit < 15 | (lastvisit == 15 & ewreason == 3)), v1(1 2 3 4 5 6 7 8) v2(1 2) missing zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local row2 = `row'
local col = `col' + 1
forvalues l = 1(1)`levels' {
	local row2 = `row2' + 1
	local freq = string(MT[`l',1], "%5.0f")
	local perc = string((MT[`l',1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

* Endpoint form available
local row = 31

tabcount complete_ep randgrp, c1(1 0) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
local perc = string((MT[1,1]/MTA[1,1])*100, "%5.1f")
local n = string(MTA[1,1], "%5.0f")
putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)

* Included in ITT analysis (excluded inelgiible)
local row = 32

tabcount ITT randgrp, c1(1 0) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
matrix MTA = J(1,rowsof(MT),1) * MT
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
local perc = string((MT[1,1]/MTA[1,1])*100, "%5.1f")
local n = string(MTA[1,1], "%5.0f")
putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)

* Follow-up time point available
local row = 5

rename complete_bl complete_0
rename complete_v* complete_*

foreach v in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 {
	tabcount complete_`v' randgrp, c1(1 0) v2(1 2) zero matrix(MG)
	
	local row = `row' + 1
	
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	matrix MTA = J(1,rowsof(MT),1) * MT
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/MTA[1,1])*100, "%5.1f")
	local n = string(MTA[1,1], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	
	drop if lastvisit == `v'
}

putdocx table table(6,.), bold
putdocx table table(11,.), bold
putdocx table table(13,.), bold
putdocx table table(17,.), bold
putdocx table table(21,.), bold

restore


/* TABLE 3 AVAILABILITY OF OUTCOME DATA AT EACH TIME POINT */

putdocx sectionbreak
putdocx paragraph
putdocx text ("Table 3 Availability of outcome data at each time point"), bold

putdocx table table = (34,4)

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Overall"), halign(center) bold
putdocx table table(2,4) = ("(N=$N)"), halign(center) bold

putdocx table table(3,1) = ("PRIMARY ENDPOINT"), bold colspan(3)
putdocx table table(4,1) = ("Primary endpoint"), bold
putdocx table table(5,1) = ("Primary endpoint components"), bold
putdocx table table(6,1) = ("     Hospitalisation")
putdocx table table(7,1) = ("     Cardiovascular disease")
putdocx table table(8,1) = ("     Death")
putdocx table table(9,1) = ("SECONDARY ENDPOINTS"), bold colspan(3)
putdocx table table(10,1) = ("Office measurements of systolic blood pressure"), bold
putdocx table table(11,1) = ("     Baseline")
putdocx table table(12,1) = ("     6 months")
putdocx table table(13,1) = ("     1 year")
putdocx table table(14,1) = ("     2 years")
putdocx table table(15,1) = ("     3 years")
putdocx table table(16,1) = ("Rate of hypotension"), bold
putdocx table table(17,1) = ("B-type natriuretic peptide [BNP]"), bold
putdocx table table(18,1) = ("     Baseline")
putdocx table table(19,1) = ("     6 months")
putdocx table table(20,1) = ("     1 year")
putdocx table table(21,1) = ("     2 years")
putdocx table table(22,1) = ("     3 years")
putdocx table table(23,1) = ("Albumin creatinine ratio [ACR]"), bold
putdocx table table(24,1) = ("     Baseline")
putdocx table table(25,1) = ("     3 years")
putdocx table table(26,1) = ("Estimated glomerular filtration rate [eGFR]"), bold
putdocx table table(27,1) = ("     Baseline")
putdocx table table(28,1) = ("     6 months")
putdocx table table(29,1) = ("     1 year")
putdocx table table(30,1) = ("     2 years")
putdocx table table(31,1) = ("     3 years")
putdocx table table(32,1) = ("Transient ischemic attack [TIA]"), bold
putdocx table table(33,1) = ("SAFETY ENDPOINT"), bold colspan(3)
putdocx table table(34,1) = ("Hyperkaliemia"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)
putdocx table table(9,.), font(, , 255 255 255) shading(50 77 122)
putdocx table table(33,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(4,.), border(bottom, single)
putdocx table table(8,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(16,.), border(bottom, single)
putdocx table table(22,.), border(bottom, single)
putdocx table table(25,.), border(bottom, single)
putdocx table table(31,.), border(bottom, single)
putdocx table table(32,.), border(bottom, single)
putdocx table table(33,.), border(bottom, single)
putdocx table table(34,.), border(bottom, double)

* Primary endpoint
local row = 4

gen missing = 0 
replace missing = 1 if missing(EPtime)

tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
local perc = string((MT[1,1]/$N)*100, "%5.1f")
putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)

drop missing

* Primary endpoint components
local row = 5

foreach var in EPhosptime EPcvdtime EPdeathtime {
	local row = `row' + 1
	gen missing = 0 
	replace missing = 1 if missing(`var')
	
	tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
		putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/$N)*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	
	drop missing
}

* Office measurements of systolic blood pressure
local row = 10

foreach var in sysbp_old_bl sysbp_v5 sysbp_v7 sysbp_v11 sysbp_v15 {
	local row = `row' + 1
	gen missing = 0 
	replace missing = 1 if missing(`var')
	
	tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
		putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/$N)*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	
	drop missing
}

* Rate of hypotension
local row = 16

gen missing = 0 
replace missing = 1 if missing(hypotension)

tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
local perc = string((MT[1,1]/$N)*100, "%5.1f")
putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)

drop missing

* B-tpye natriuretic peptide 
local row = 17

foreach var in BNP_old_bl BNP_v5 BNP_v7 BNP_v11 BNP_v15 {
	local row = `row' + 1
	gen missing = 0 
	replace missing = 1 if missing(`var')
	
	tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
		putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/$N)*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	
	drop missing
}

* Albumin creatinine ratio
local row = 23

foreach var in ACR_old_bl ACR_v15 {
	local row = `row' + 1
	gen missing = 0 
	replace missing = 1 if missing(`var')
	
	tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
		putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/$N)*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	
	drop missing
}

* Estimated glomerular filtration rate
local row = 26

foreach var in eGFR_old_bl eGFR_v5 eGFR_v7 eGFR_v11 eGFR_v15 {
	local row = `row' + 1
	gen missing = 0 
	replace missing = 1 if missing(`var')
	
	tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
		putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	}
	matrix MT = MG * J(colsof(MG),1,1)
	local col = `col' + 1
	local freq = string(MT[1,1], "%5.0f")
	local perc = string((MT[1,1]/$N)*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
	
	drop missing
}

* Transient ischemic attack 
local row = 32

gen missing = 0 
replace missing = 1 if missing(TIA)

tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
local perc = string((MT[1,1]/$N)*100, "%5.1f")
putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)

drop missing

* Hyperkalaemia
local row = 34

gen missing = 0 
replace missing = 1 if missing(hyperkalaemia)

tabcount missing randgrp, v1(0) v2(1 2) zero matrix(MG)
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/${N`g'})*100, "%5.1f")
	putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)
}
matrix MT = MG * J(colsof(MG),1,1)
local col = `col' + 1
local freq = string(MT[1,1], "%5.0f")
local perc = string((MT[1,1]/$N)*100, "%5.1f")
putdocx table table(`row',`col') = ("`freq' (`perc')"), halign(center)

drop missing


/* TABLE 4 ASSOICATION BETWEEN RANDOMISED ARM AND WITHDRAWING, DISCONTINUING, OR BEING LOST TO FOLLOW-UP */

putdocx sectionbreak
putdocx paragraph
putdocx text ("Table 4 Association between randomised arm and withdrawing, discontinuing, or being lost to follow-up"), bold

putdocx table table = (5,5), note("Spironolactone versus standard care. Logistic regression of the availability of the completion of follow-up modelled against randomised intervention arm. ‡Level of significance = 0.05 ")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Odds ratio [95% CI]†"), halign(center) bold
putdocx table table(1,5) = ("P-value‡"), halign(center) bold

putdocx table table(3,1) = ("Completion of follow-up, n/N (%)"), bold colspan(3)
putdocx table table(4,1) = ("     Completed")
putdocx table table(5,1) = ("     Withdrawn")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)

putdocx table table(5,.), border(bottom, double)

local row = 3

gen withdrawn = 0
replace withdrawn = 1 if (lastvisit < 15 | (lastvisit == 15 & ewreason == 3))

local row2 = `row' + 1
tabcount withdrawn randgrp, c1(0 1) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}
logit withdrawn i.randgrp, or
contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)
local or = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f") 
putdocx table table(`row',2) = ("`or' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row',3) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',3) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',3) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',3), shading(255 255 0)
}

drop withdrawn


/* TABLE 5 BASELINE COVARIATES OF THOSE PARTICIPANTS WHO COMPLETED FOLLOW-UP OR WERE WITHDRAWN, DISCONTINUED, OR WERE LOST TO FOLLOW-UP, AND THE PROBABILITY OF EACH COVARIATE PREDICTING WITHDRAWAL */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5 Baseline covariates of those participants who completed follow-up or were withdrawn, discontinued, or were lost to follow-up, and the probability of each covariate predicting withdrawal from the study"), bold

gen withdrawn = 0
replace withdrawn = 1 if (lastvisit < 15 | (lastvisit == 15 & ewreason == 3))
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if withdrawn == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

count if withdrawn == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of completion of the availability of the completion of follow-up modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,2) = ("Predicting withdrawal from the study (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Completed"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Withdrawn"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Completed"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Withdrawn"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit withdrawn c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat age_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit withdrawn i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if withdrawn == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit withdrawn i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if withdrawn == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit withdrawn i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if withdrawn == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit withdrawn i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if withdrawn == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit withdrawn i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if withdrawn == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit withdrawn i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if withdrawn == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit withdrawn i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if withdrawn == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit withdrawn i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit withdrawn c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat weight_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit withdrawn c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat height_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit withdrawn c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit withdrawn c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit withdrawn c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 67

logit withdrawn i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit withdrawn i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit withdrawn i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit withdrawn i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit withdrawn i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit withdrawn i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit withdrawn i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit withdrawn i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit withdrawn i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if withdrawn == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit withdrawn c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if withdrawn == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit withdrawn c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit withdrawn c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit withdrawn c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if withdrawn == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("No withdrawals")
}

drop withdrawn


/* TABLE 5A BASELINE COVARIATES OF THOSE PARTICIPANTS WHO HAVE THE SECONDARY ENDPOINT OF OFFICE MEASUREMENTS OF SYSTOLIC BLOOD PRESSURE AT 3 YEARS AVAILABLE OR MISSING, AND THE PROBABILITY OF EACH COVARIATE PREDICTING MISSINGNESS OF THE PRIMARY ENDPOINT */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5A Baseline covariates of those participants who have the secondary endpoint of office measurements of systolic blood pressure at 3 years available or missing, and the probability of each covariate predicting missingness of the primary endpoint"), bold

gen missing = 0 if !missing(sysbp_v15)
replace missing = 1 if missing(sysbp_v15)
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if missing == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

local varlist1 = ""

count if missing == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of the availability of systolic blood pressure at 3 years modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,1) = ("Secondary Endpoint: Systolic blood pressure at 3 years"), bold
putdocx table table(1,2) = ("Predicting missingness (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Available"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Missing"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Available"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Missing"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit missing c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat age_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit missing i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if missing == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit missing i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit missing i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.sex_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if missing == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit missing i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.ethnicnew_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist1 = "`varlist1' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit missing i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.IMDquintile_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist1 = "`varlist1' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit missing i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.smokstat_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit missing c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.weight_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat weight_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit missing c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.height_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat height_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit missing c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.wstcir_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit missing c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.hipcir_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit missing c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist1 = "`varlist1' " + "c.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 67

logit missing i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.renclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit missing i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.livclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit missing i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.bonclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit missing i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.lipclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit missing i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.fbcclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit missing i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.hbaclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit missing i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.fbsclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit missing i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.bnpclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit missing i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "i.ecgclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit missing c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.ACR_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if missing == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit missing c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.eGFR_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit missing c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.potassium_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit missing c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist1 = "`varlist1' " + "c.creatinine_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("None missing systolic blood pressure at 3 years")
}

drop missing


/* TABLE 5B BASELINE COVARIATES OF THOSE PARTICIPANTS WHO HAVE THE SECONDARY ENDPOINT OF RATE OF HYPOTENSION AVAILABLE OR MISSING, AND THE PROBABILITY OF EACH COVARIATE PREDICTING MISSINGNESS OF THE PRIMARY ENDPOINT */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5B Baseline covariates of those participants who have the secondary endpoint of rate of hypotension available or missing, and the probability of each covariate predicting missingness of the primary endpoint"), bold

gen missing = 0 if !missing(hypotension)
replace missing = 1 if missing(hypotension)
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if missing == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

local varlist2 = ""

count if missing == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of the availability of rate of hypotension across the study period modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,1) = ("Secondary Endpoint: Rate of hypotension during study"), bold
putdocx table table(1,2) = ("Predicting missingness (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Available"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Missing"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Available"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Missing"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit missing c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat age_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit missing i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if missing == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit missing i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit missing i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.sex_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if missing == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit missing i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.ethnicnew_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist2 = "`varlist2' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit missing i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.IMDquintile_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist2 = "`varlist2' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit missing i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.smokstat_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit missing c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.weight_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat weight_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit missing c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.height_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat height_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit missing c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.wstcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit missing c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.hipcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit missing c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist2 = "`varlist2' " + "c.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 67

logit missing i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.renclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit missing i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.livclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit missing i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.bonclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit missing i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.lipclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit missing i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.fbcclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit missing i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.hbaclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit missing i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.fbsclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit missing i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.bnpclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit missing i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "i.ecgclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit missing c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.ACR_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if missing == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit missing c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.eGFR_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit missing c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.potassium_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit missing c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist2 = "`varlist2' " + "c.creatinine_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("None missing rate of hypotension during study")
}

drop missing


/* TABLE 5C BASELINE COVARIATES OF THOSE PARTICIPANTS WHO HAVE THE SECONDARY ENDPOINT OF B-TYPE NATRIURETIC PEPTIDE AT 3 YEARS AVAILABLE OR MISSING, AND THE PROBABILITY OF EACH COVARIATE PREDICTING MISSINGNESS OF THE PRIMARY ENDPOINT */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5C Baseline covariates of those participants who have the secondary endpoint of B-type natriuretic peptide at 3 years available or missing, and the probability of each covariate predicting missingness of the primary endpoint"), bold

gen missing = 0 if !missing(BNP_v15)
replace missing = 1 if missing(BNP_v15)
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if missing == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

local varlist3 = ""

count if missing == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of the availability of B-type natriuretic peptide at 3 years modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,1) = ("Secondary Endpoint: B-type natriuretic peptide at 3 years"), bold
putdocx table table(1,2) = ("Predicting missingness (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Available"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Missing"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Available"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Missing"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit missing c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat age_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit missing i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if missing == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit missing i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit missing i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.sex_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if missing == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit missing i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.ethnicnew_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist3 = "`varlist3' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit missing i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.IMDquintile_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist3 = "`varlist3' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit missing i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.smokstat_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit missing c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.weight_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat weight_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit missing c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.height_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat height_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit missing c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.wstcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit missing c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.hipcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit missing c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist3 = "`varlist3' " + "c.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 67

logit missing i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.renclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit missing i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.livclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit missing i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.bonclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit missing i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.lipclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit missing i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.fbcclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit missing i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.hbaclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit missing i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.fbsclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit missing i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.bnpclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit missing i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "i.ecgclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit missing c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.ACR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if missing == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit missing c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.eGFR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit missing c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.potassium_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit missing c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist3 = "`varlist3' " + "c.creatinine_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("None missing B-type natriuretic peptide at 3 years")
}

drop missing


/* TABLE 5D BASELINE COVARIATES OF THOSE PARTICIPANTS WHO HAVE THE SECONDARY ENDPOINT OF ALBUMIN CREATININE RATIO AT 3 YEARS AVAILABLE OR MISSING, AND THE PROBABILITY OF EACH COVARIATE PREDICTING MISSINGNESS OF THE PRIMARY ENDPOINT */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5D Baseline covariates of those participants who have the secondary endpoint of albumin creatinine ratio at 3 years available or missing, and the probability of each covariate predicting missingness of the primary endpoint"), bold

gen missing = 0 if !missing(ACR_v15)
replace missing = 1 if missing(ACR_v15)
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if missing == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

local varlist4 = ""

count if missing == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of the availability of albumin creatine ratio at 3 years modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,1) = ("Secondary Endpoint: Albumin creatinine ratio at 3 years"), bold
putdocx table table(1,2) = ("Predicting missingness (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Available"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Missing"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Available"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Missing"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit missing c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat age_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit missing i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if missing == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit missing i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit missing i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.sex_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if missing == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit missing i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.ethnicnew_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist4 = "`varlist4' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit missing i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.IMDquintile_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist4 = "`varlist4' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit missing i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.smokstat_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit missing c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.weight_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat weight_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit missing c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.height_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat height_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit missing c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.wstcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit missing c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.hipcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit missing c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist4 = "`varlist4' " + "c.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 67

logit missing i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.renclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit missing i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.livclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit missing i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.bonclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit missing i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.lipclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit missing i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.fbcclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit missing i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.hbaclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit missing i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.fbsclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit missing i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.bnpclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit missing i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "i.ecgclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit missing c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.ACR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if missing == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit missing c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.eGFR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit missing c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.potassium_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit missing c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist4 = "`varlist4' " + "c.creatinine_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("None missing albumin creatinine ratio at 3 years")
}

drop missing


/* TABLE 5E BASELINE COVARIATES OF THOSE PARTICIPANTS WHO HAVE THE SECONDARY ENDPOINT OF ESTIMATED GLOMERULAR FILTRATION RATE AT 3 YEARS AVAILABLE OR MISSING, AND THE PROBABILITY OF EACH COVARIATE PREDICTING MISSINGNESS OF THE PRIMARY ENDPOINT */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5E Baseline covariates of those participants who have the secondary endpoint of estimated glomerular filtration rate available or missing, and the probability of each covariate predicting missingness of the primary endpoint"), bold

gen missing = 0 if !missing(eGFR_v15)
replace missing = 1 if missing(eGFR_v15)
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if missing == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

local varlist5 = ""

count if missing == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of the availability of estimated glomerular filtration rate at 3 years modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,1) = ("Secondary Endpoint: Estimated glomerular filtration rate at 3 years"), bold
putdocx table table(1,2) = ("Predicting missingness (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Available"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Missing"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Available"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Missing"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit missing c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat age_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit missing i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if missing == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit missing i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit missing i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.sex_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if missing == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit missing i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.ethnicnew_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist5 = "`varlist5' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}	
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit missing i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.IMDquintile_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist5 = "`varlist5' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit missing i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.smokstat_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit missing c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.weight_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat weight_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit missing c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.height_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat height_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit missing c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.wstcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit missing c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.hipcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit missing c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist5 = "`varlist5' " + "c.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0)
	}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal profile
local row = 67

logit missing i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.renclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit missing i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.livclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit missing i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.bonclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit missing i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.lipclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit missing i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.fbcclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit missing i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.hbaclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit missing i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.fbsclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit missing i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.bnpclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit missing i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "i.ecgclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit missing c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.ACR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if missing == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit missing c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.eGFR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit missing c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.potassium_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit missing c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist5 = "`varlist5' " + "c.creatinine_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("None missing estimated glomerular filtration rate at 3 years")
}

drop missing


/* TABLE 5F BASELINE COVARIATES OF THOSE PARTICIPANTS WHO HAVE THE SECONDARY ENDPOINT OF TRANSIENT ISCHAEMIC ATTACK AVAILABLE OR MISSING, AND THE PROBABILITY OF EACH COVARIATE PREDICTING MISSINGNESS OF THE PRIMARY ENDPOINT */

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("Table 5F Baseline covariates of those participants who have the secondary endpoint of transient ischaemic attack available or missing, and the probability of each covariate predicting missingness of the primary endpoint"), bold

gen missing = 0 if !missing(TIA)
replace missing = 1 if missing(TIA)
forvalues m = 0(1)1 {
	forvalues g = 1(1)$groups {
		count if missing == `m' & randgrp == `g'
		local N`g'_M`m' = r(N)
	}
}

local varlist6 = ""

count if missing == 1
if r(N) > 0 {

putdocx table table = (106,6), note("NB Percentages have been computed with the number of participants with the response available as the denominator. †Logistic regression of the availability of transient ischemic attack across the study period modelled against baseline characteristics. Level of significance = 0.05")

putdocx table table(1,1) = ("Secondary Endpoint: Transient ischaemic attack during study"), bold
putdocx table table(1,2) = ("Predicting missingness (P-value)†"), halign(center) bold
putdocx table table(1,3) = ("Spironolactone"), halign(center) bold 
putdocx table table(2,3) = ("(N=$N1)"), halign(center) bold 
putdocx table table(1,5) = ("Standard Care"), halign(center) bold 
putdocx table table(2,5) = ("(N=$N2)"), halign(center) bold 

putdocx table table(3,3) = ("Available"), halign(center) bold
putdocx table table(4,3) = ("(N=`N1_M0')"), halign(center) bold
putdocx table table(3,4) = ("Missing"), halign(center) bold
putdocx table table(4,4) = ("(N=`N1_M1')"), halign(center) bold
putdocx table table(3,5) = ("Available"), halign(center) bold
putdocx table table(4,5) = ("(N=`N2_M0')"), halign(center) bold
putdocx table table(3,6) = ("Missing"), halign(center) bold
putdocx table table(4,6) = ("(N=`N2_M1')"), halign(center) bold

putdocx table table(5,1) = ("Age (years), mean (SD) [n]"), bold
putdocx table table(6,1) = ("Age groups (EudraCT guidelines), n/N (%)"), bold
putdocx table table(7,1) = ("     18 to 64 years")
putdocx table table(8,1) = ("     65 to 84 years")
putdocx table table(9,1) = ("     85 years and older")
putdocx table table(10,1) = ("Additional age groups, n/N (%)"), bold 
putdocx table table(11,1) = ("     18 to 54 years")
putdocx table table(12,1) = ("     55 to 64 years")
putdocx table table(13,1) = ("     65 to 74 years")
putdocx table table(14,1) = ("     75 to 84 years")
putdocx table table(15,1) = ("     85 years and older")
putdocx table table(16,1) = ("Sex, n/N (%)"), bold
putdocx table table(17,1) = ("     Male")
putdocx table table(18,1) = ("     Female")
putdocx table table(19,1) = ("Ethnicity, n/N (%)"), bold
putdocx table table(20,1) = ("     White")
putdocx table table(21,1) = ("     Mixed/Multiple ethnic groups")
putdocx table table(22,1) = ("     Asian/Asian British")
putdocx table table(23,1) = ("     Black/African/Caribbean/Black British")
putdocx table table(24,1) = ("     Other ethnic group")
putdocx table table(25,1) = ("Past medical history, n/N (%)"), bold 
putdocx table table(26,1) = ("     Hypertension")
putdocx table table(27,1) = ("     Diabetes")
putdocx table table(28,1) = ("     Impaired fasting glucose and/or glucose tolerance")
putdocx table table(29,1) = ("     Ischaemic heart disease")
putdocx table table(30,1) = ("     Heart failure")
putdocx table table(31,1) = ("     Atrial fibrillation")
putdocx table table(32,1) = ("     Cerebrovascular disease")
putdocx table table(33,1) = ("     Peripheral vascular disease")
putdocx table table(34,1) = ("     Renal disease")
putdocx table table(35,1) = ("     Childhood urinary tract infection")
putdocx table table(36,1) = ("     Adulthood urinary tract infection")
putdocx table table(37,1) = ("     Thyroid disease")
putdocx table table(38,1) = ("     Anaemia")
putdocx table table(39,1) = ("     Osteopenia")
putdocx table table(40,1) = ("     Osteoporosis")
putdocx table table(41,1) = ("Indices of Multiple Deprivation (IMD) Quintile, n/N (%)"), bold
putdocx table table(42,1) = ("     1 (Most deprived)")
putdocx table table(43,1) = ("     2")
putdocx table table(44,1) = ("     3")
putdocx table table(45,1) = ("     4")
putdocx table table(46,1) = ("     5 (Least deprived)")
putdocx table table(47,1) = ("Current medication, n/N (%)"), bold
putdocx table table(48,1) = ("     Beta blockers")
putdocx table table(49,1) = ("     ACE inhibitors")
putdocx table table(50,1) = ("     ARBs")
putdocx table table(51,1) = ("     Statins")
putdocx table table(52,1) = ("     Antihypensives")
putdocx table table(53,1) = ("Smoking status, n/N (%)"), bold
putdocx table table(54,1) = ("     Never smoker")
putdocx table table(55,1) = ("     Current smoker")
putdocx table table(56,1) = ("     Former smoker")
putdocx table table(57,1) = ("Weight (kg), mean (SD) [n]"), bold 
putdocx table table(58,1) = ("Height (cm), mean (SD) [n]"), bold
putdocx table table(59,1) = ("Waist circumference (cm), mean (SD) [n]"), bold
putdocx table table(60,1) = ("Hip circumference (cm), mean (SD) [n]"), bold
putdocx table table(61,1) = ("Office BP measurement (mmHg), mean (SD) [n]"), bold
putdocx table table(62,1) = ("     Systolic BP left arm")
putdocx table table(63,1) = ("     Systolic BP right arm")
putdocx table table(64,1) = ("     Diastolic BP left arm")
putdocx table table(65,1) = ("     Diastolic BP right arm"),
putdocx table table(66,1) = ("LABORATORY AND ECG TEST RESULTS"), bold
putdocx table table(67,1) = ("Renal profile, n/N (%)"), bold
putdocx table table(68,1) = ("     Normal")
putdocx table table(69,1) = ("     Abnormal (not clinically significant)")
putdocx table table(70,1) = ("     Abnormal (clinically significant)")
putdocx table table(71,1) = ("Liver function test, n/N (%)"), bold
putdocx table table(72,1) = ("     Normal")
putdocx table table(73,1) = ("     Abnormal (not clinically significant)")
putdocx table table(74,1) = ("     Abnormal (clinically significant)")
putdocx table table(75,1) = ("Bone profile, n/N (%)"), bold
putdocx table table(76,1) = ("     Normal")
putdocx table table(77,1) = ("     Abnormal (not clinically significant)")
putdocx table table(78,1) = ("     Abnormal (clinically significant)")
putdocx table table(79,1) = ("Lipids, n/N (%)"), bold
putdocx table table(80,1) = ("     Normal")
putdocx table table(81,1) = ("     Abnormal (not clinically significant)")
putdocx table table(82,1) = ("     Abnormal (clinically significant)")
putdocx table table(83,1) = ("Full blood count, n/N (%)"), bold
putdocx table table(84,1) = ("     Normal")
putdocx table table(85,1) = ("     Abnormal (not clinically significant)")
putdocx table table(86,1) = ("     Abnormal (clinically significant)")
putdocx table table(87,1) = ("HbA1C, n/N (%)"), bold
putdocx table table(88,1) = ("     Normal")
putdocx table table(89,1) = ("     Abnormal (not clinically significant)")
putdocx table table(90,1) = ("     Abnormal (clinically significant)")
putdocx table table(91,1) = ("Fasting blood sugar, n/N (%)"), bold
putdocx table table(92,1) = ("     Normal")
putdocx table table(93,1) = ("     Abnormal (not clinically significant)")
putdocx table table(94,1) = ("     Abnormal (clinically significant)")
putdocx table table(95,1) = ("B-type natriuretic peptide"), bold
putdocx table table(96,1) = ("     Normal")
putdocx table table(97,1) = ("     Abnormal (not clinically significant)")
putdocx table table(98,1) = ("     Abnormal (clinically significant)")
putdocx table table(99,1) = ("Electrocardiogram"), bold
putdocx table table(100,1) = ("     Normal")
putdocx table table(101,1) = ("     Abnormal (not clinically significant)")
putdocx table table(102,1) = ("     Abnormal (clinically significant)")
putdocx table table(103,1) = ("Albumin creatinine ratio (mg/mmol), median (IQR) [n]"), bold
putdocx table table(104,1) = ("eGFR (ml/min/1.73m2), mean (SD) [n]"), bold
putdocx table table(105,1) = ("Potassium (mmol/L), mean (SD) [n]"), bold
putdocx table table(106,1) = ("Creatinine (μmol/L), mean (SD) [n]"), bold

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(4,.), font(, , 0 0 0) shading(189 214 238)

putdocx table table(66,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(67,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(68,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(69,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(70,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(71,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(72,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(73,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(74,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(75,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(76,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(77,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(78,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(79,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(80,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(81,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(82,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(83,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(84,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(85,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(86,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(87,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(88,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(89,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(90,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(91,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(92,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(93,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(94,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(95,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(96,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(97,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(98,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(99,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(100,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(101,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(102,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(103,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(104,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(105,.), font(, , 0 0 0) shading(234 234 234)
putdocx table table(106,.), font(, , 0 0 0) shading(234 234 234)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(5,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(15,.), border(bottom, single)
putdocx table table(18,.), border(bottom, single)
putdocx table table(24,.), border(bottom, single)
putdocx table table(40,.), border(bottom, single)
putdocx table table(46,.), border(bottom, single)
putdocx table table(52,.), border(bottom, single)
putdocx table table(56,.), border(bottom, single)
putdocx table table(57,.), border(bottom, single)
putdocx table table(58,.), border(bottom, single)
putdocx table table(59,.), border(bottom, single)
putdocx table table(60,.), border(bottom, single)
putdocx table table(65,.), border(bottom, single)
putdocx table table(66,.), border(bottom, single)
putdocx table table(67,.), border(bottom, single)
putdocx table table(70,.), border(bottom, single)
putdocx table table(74,.), border(bottom, single)
putdocx table table(78,.), border(bottom, single)
putdocx table table(82,.), border(bottom, single)
putdocx table table(86,.), border(bottom, single)
putdocx table table(90,.), border(bottom, single)
putdocx table table(94,.), border(bottom, single)
putdocx table table(98,.), border(bottom, single)
putdocx table table(102,.), border(bottom, single)
putdocx table table(103,.), border(bottom, single)
putdocx table table(104,.), border(bottom, single)
putdocx table table(105,.), border(bottom, single)
putdocx table table(106,.), border(bottom, double)

putdocx table table(1,1), rowspan(4)
putdocx table table(1,2), rowspan(4)
putdocx table table(1,3), colspan(2)
putdocx table table(1,4), colspan(2)
putdocx table table(2,3), colspan(2)
putdocx table table(2,4), colspan(2)

* Age
local row = 5

logit missing c.age_bl, or
capture noisily testparm c.age_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat age_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Age groups (EudraCT guidelines)
local row = 6

logit missing i.age_group1_bl, or 
capture noisily testparm i.age_group1_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount age_group1_bl randgrp if missing == `m', c1(1 2 3) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Additional age groups
local row = 10

logit missing i.age_group2_bl, or 
capture noisily testparm i.age_group2_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.age_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount age_group2_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Sex
local row = 16

logit missing i.sex_bl, or 
capture noisily testparm i.sex_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.sex_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount sex_bl randgrp if missing == `m', v1(1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Ethnicity
local row = 19

logit missing i.ethnicnew_bl, or 
capture noisily testparm i.ethnicnew_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.ethnicnew_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ethnicnew_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Past medical history
local row = 25

foreach var in hypyn diayn imgyn ihdyn hfyn afyn cvdyn pvdyn renyn cutiyn autiyn thyyn anayn opeyn opoyn {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist6 = "`varlist6' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Indices of multiple depirvation 
local row = 41

logit missing i.IMDquintile_bl, or 
capture noisily testparm i.IMDquintile_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.IMDquintile_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount IMDquintile_bl randgrp if missing == `m', v1(1 2 3 4 5) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Current medication
local row = 47

foreach var in betablocker aceinhibitors arb statin antihypensive {
	
	local row = `row' + 1
	
	logit missing i.`var'_bl, or 
	capture noisily testparm i.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist6 = "`varlist6' " + "i.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabcount `var'_bl randgrp if missing == `m', c1(1 0) v2(1 2) zero matrix(MG)
		matrix MGA = J(1,rowsof(MG),1) * MG
		forvalues g = 1(1)$groups {
			local col = 2*`g'+1+`m'
			local freq = string(MG[1,`g'], "%5.0f")
			local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Smoking status
local row = 53

logit missing i.smokstat_bl, or 
capture noisily testparm i.smokstat_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.smokstat_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount smokstat_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Weight (kg)
local row = 57

logit missing c.weight_bl, or
capture noisily testparm c.weight_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.weight_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat weight_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Height (cm)
local row = 58

logit missing c.height_bl, or
capture noisily testparm c.height_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.height_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat height_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Waist circumference (cm)
local row = 59

logit missing c.wstcir_bl, or
capture noisily testparm c.wstcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.wstcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat wstcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Hip circumference (cm)
local row = 60

logit missing c.hipcir_bl, or
capture noisily testparm c.hipcir_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.hipcir_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat hipcir_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Office BP measurement (mmHG)
local row = 61

foreach var in sysbpl sysbpr diabpl diabpr {
	
	local row = `row' + 1
	
	logit missing c.`var'_bl, or
	capture noisily testparm c.`var'_bl
	local pv = string(r(p), "%5.3f")
	if `pv' < 0.001 {
		putdocx table table(`row',2) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row',2) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row',2) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		local varlist6 = "`varlist6' " + "c.`var'_bl"
		putdocx table table(`row',2), shading(255 255 0) 
	}
	
	forvalues m = 0(1)1 {
		tabstat `var'_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
		forvalues g = 1(1)$groups {
			matrix define M`g' = r(Stat`g')
			local col = 2*`g'+1+`m'
			local mean = string(M`g'[1,1], "%5.1f")
			local sd = string(M`g'[2,1], "%5.1f")
			local n = string(M`g'[5,1], "%5.0f")
			putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
		}
	}
}

*** LABORATORY AND ECG TEST RESULTS

* Renal prfile
local row = 67

logit missing i.renclsig_bl, or 
capture noisily testparm i.renclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.renclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount renclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Liver function tests
local row = 71

logit missing i.livclsig_bl, or 
capture noisily testparm i.livclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.livclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount livclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Bone profile
local row = 75

logit missing i.bonclsig_bl, or 
capture noisily testparm i.bonclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.bonclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bonclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Lipids
local row = 79

logit missing i.lipclsig_bl, or 
capture noisily testparm i.lipclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.lipclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount lipclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Full blood count
local row = 83

logit missing i.fbcclsig_bl, or 
capture noisily testparm i.fbcclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.fbcclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount fbcclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* HbA1C
local row = 87

logit missing i.hbaclsig_bl, or 
capture noisily testparm i.hbaclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.hbaclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount hbaclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Fasting blood sugar
local row = 91

logit missing i.fbsclsig_bl, or 
capture noisily testparm i.fbsclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.fbsclsig_bl"
	putdocx table table(`row',2), shading(255 255 0)
}

forvalues m = 0(1)1 {
	tabcount fbsclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* B-type natriuretic peptide
local row = 95

logit missing i.bnpclsig_bl, or 
capture noisily testparm i.bnpclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.bnpclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount bnpclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Electrocardiogram
local row = 99

logit missing i.ecgclsig_bl, or 
capture noisily testparm i.ecgclsig_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "i.ecgclsig_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabcount ecgclsig_bl randgrp if missing == `m', v1(0 1 2) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	local levels = r(N)/$groups
	forvalues g = 1(1)$groups {
		local row2 = `row' 
		local col = 2*`g'+1+`m'
		forvalues l = 1(1)`levels' {
			local row2 = `row2' + 1
			local freq = string(MG[`l',`g'], "%5.0f")
			local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
			local n = string(MGA[1,`g'], "%5.0f")
			putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
		}
	}
}

* Albumin creatinine ratio (mg/mmol)
local row = 103

logit missing c.ACR_old_bl, or
capture noisily testparm c.ACR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.ACR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat ACR_old_bl if missing == `m', by(randgrp) stat(p50 p25 p75 n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local p50 = string(M`g'[1,1], "%5.1f")
		local p25 = string(M`g'[2,1], "%5.1f")
		local p75 = string(M`g'[3,1], "%5.1f")
		local n = string(M`g'[4,1], "%5.0f")
		putdocx table table(`row',`col') = ("`p50' (`p25' to `p75') [`n']"), halign(center)
	}
}

* eGFR (ml/min/1.73m2)
local row = 104

logit missing c.eGFR_old_bl, or
capture noisily testparm c.eGFR_old_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.eGFR_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat eGFR_old_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Potassium (mmol/L)
local row = 105

logit missing c.potassium_bl, or
capture noisily testparm c.potassium_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.potassium_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat potassium_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}

* Creatinine (μmol/L)
local row = 106

logit missing c.creatinine_bl, or
capture noisily testparm c.creatinine_bl
local pv = string(r(p), "%5.3f")
if `pv' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',2) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	local varlist6 = "`varlist6' " + "c.creatinine_bl"
	putdocx table table(`row',2), shading(255 255 0) 
}

forvalues m = 0(1)1 {
	tabstat creatinine_bl if missing == `m', by(randgrp) stat(mean sd min max n) save
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = 2*`g'+1+`m'
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.1f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
}
}

else {
	putdocx paragraph
	putdocx text ("None missing transient ischaemic attack during study")
}

drop missing



********************************************************************************
******************************* PRIMARY ANALYSIS *******************************
********************************************************************************

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("PRIMARY ANALYSIS"), bold


/* TABLE 6 SUMMARY STATISTICS AND THE ADJUSTED HAZARD RATIOS FOR THE PRIMARY ANALYSIS  */

putdocx paragraph
putdocx text ("Table 6 Summary statistics and the adjusted hazard ratios for the primary analysis"), bold

putdocx table table = (15,5), layout(autofitcontents) note("†Spironolactone versus standard care. *Primary endpoint. 1Mixed effects Cox-proportional hazards model with an unstructured variance-covariance structure for the random effects, modelled against randomised arm as a fixed effect, and GP practice as a random effect. ‡Level of significance = 0.05")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Adjusted hazard ratio [95% CI]†"), halign(center) bold
putdocx table table(1,5) = ("P-value‡"), halign(center) bold

putdocx table table(3,1) = ("PRIMARY ANALYSES"), bold colspan(5)
putdocx table table(4,1) = ("Primary endpoint (1)"), bold colspan(5)
putdocx table table(5,1) = ("     Experienced")
putdocx table table(6,1) = ("     Time at risk (incidence rate)*")
putdocx table table(7,1) = ("Primary endpoint component: Hospitalisation (1)"), bold colspan(5)
putdocx table table(8,1) = ("     Experienced")
putdocx table table(9,1) = ("     Time at risk (incidence rate)")
putdocx table table(10,1) = ("Primary endpoint component: Cardiovascular disease (1)"), bold colspan(5)
putdocx table table(11,1) = ("     Experienced")
putdocx table table(12,1) = ("     Time at risk (incidence rate)")
putdocx table table(13,1) = ("Primary endpoint component: Death (1)"), bold colspan(5)
putdocx table table(14,1) = ("     Experienced")
putdocx table table(15,1) = ("     Time at risk (incidence rate)")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(6,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(12,.), border(bottom, single)
putdocx table table(15,.), border(bottom, double)

putdocx table table(1,4), rowspan(2)
putdocx table table(1,5), rowspan(2)

putexcel A1 = "label1"
putexcel B1 = "subgroup"
putexcel C1 = "GroupA_n"
putexcel D1 = "GroupB_n"
putexcel E1 = "hr"
putexcel F1 = "ll"
putexcel G1 = "ul"
putexcel H1 = "pvalue"

putexcel A8 = ""
putexcel B8 = "Main trial result"

/*
PRIMARY ANALYSIS

The primary analyses will be conducted on all randomised participants, applying the principle of intention-to-treat (ITT), as far as is practically possible, given any missing data.  Specifically, the participants will be analysed in the groups to which they were allocated regardless of compliance with the allocated treatment.  The primary outcome will be analysed using a mixed effect Cox proportional-hazards method, with a fixed effect for randomised group and practice included as a random effect, with unstructured variance covariance matrix.   Results will be presented as a hazard ratio with 95% confidence interval and associated two-sided P-value.  A p-value of 0.05 will be used to assess statistical significance. Time to event will be summarised by randomised group using medians and interquartile range.
*/

* PRIMARY ENDPOINT

local row = 4
local cell = 8

local row2 = `row' + 1
tabcount EPyn randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq`g' = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq`g''/`n' (`perc')"), halign(center)
}
putexcel C`cell' = "`freq1'"
putexcel D`cell' = "`freq2'"

putdocx table table(5,4) = ("-"), halign(center)
putdocx table table(5,5) = ("-"), halign(center)

stset EPtime_months, failure(EPyn == 1) id(StudySubjectID)

local row2 = `row' + 2
forvalues g = 1(1)$groups {
    stsum if randgrp == `g'
	local col = `g' + 1
	local risk = string(`r(risk)' / 12, "%5.1f")
	local ir = string(`r(ir)' * 12 * 100, "%5.2f")
	local n = string(`r(N_sub)', "%5.0f")
	putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
}

sts graph, by(randgrp) failure title("", size(medsmall)) xtitle("Time (in months) from randomisation to the first occurance of death or hospitalisation for heart disease (coronary heart disease," "arrhythmia, atrial fibrillation, sudden death, resuscitated sudden death), stroke, transient ischaemic attack, peripheral arterial" "disease or heart failure or first onset of any condition listed above not present at baseline", size(small)) ytitle("Proportion of participants", size(small)) xlabel(0(6)96, labsize(vsmall)) ylabel(, labsize(vsmall) angle(horizontal)) legend(order(1 "Spironolactone" 2 "Standard Care") size(small)) risktable(, order(1 "Spironolactone" 2 "Standard Care") size(vsmall)) ysize(1) xsize(2) graphregion(color(white))
graph save "4.Output\Kaplan-Meier curves\Primary endpoint KM curve_$today.gph", replace
graph export "4.Output\Kaplan-Meier curves\Primary endpoint KM curve_$today.emf", replace
graph close

stcox i.randgrp

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
local hr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
putexcel E`cell' = "`hr'"
putexcel F`cell' = "`ll'"
putexcel G`cell' = "`ul'"
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
	putexcel H`cell' = ("<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
	putexcel H`cell' = ("`pv'")
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
	putexcel H`cell' = (">0.999")
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}


// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Primary endpoint log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Primary endpoint log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of primary endpoint") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Primary endpoint KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Primary endpoint KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Primary endpoint "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


* PRIMARY ENDPOINT COMPONENT: HOSPITALISATION 

local row = 7

local row2 = `row' + 1
tabcount EPhosp randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

putdocx table table(8,4) = ("-"), halign(center)
putdocx table table(8,5) = ("-"), halign(center)

stset EPhosptime_months, failure(EPhosp == 1) id(StudySubjectID)

local row2 = `row' + 2
forvalues g = 1(1)$groups {
    stsum if randgrp == `g'
	local col = `g' + 1
	local risk = string(`r(risk)' / 12, "%5.1f")
	local ir = string(`r(ir)' * 12 * 100, "%5.2f")
	local n = string(`r(N_sub)', "%5.0f")
	putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
}

sts graph, by(randgrp) failure title("", size(medsmall)) xtitle("Time (in months) from randomisation to the first occurance of hospitalisation", size(small)) ytitle("Proportion of participants", size(small)) xlabel(0(6)90, labsize(vsmall)) ylabel(0(0.05)0.2, labsize(vsmall) angle(horizontal)) legend(order(1 "Spironolactone" 2 "Standard Care") size(small)) risktable(, order(1 "Spironolactone" 2 "Standard Care") size(vsmall)) ysize(1) xsize(2) graphregion(color(white))
graph save "4.Output\Kaplan-Meier curves\Hospitalisation KM curve_$today.gph", replace
graph export "4.Output\Kaplan-Meier curves\Hospitalisation KM curve_$today.emf", replace
graph close

stcox i.randgrp

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
local hr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Hospitalisation log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Hospitalisation log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of hositalisation") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Hospitalisation KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Hospitalisation KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Primary endpoint component : hospitalisation "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


* PRIMARY ENDPOINT COMPONENT: CARDIOVASCULAR DISEASE

local row = 10

local row2 = `row' + 1
tabcount EPcvd randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

putdocx table table(11,4) = ("-"), halign(center)
putdocx table table(11,5) = ("-"), halign(center)

stset EPcvdtime_months, failure(EPcvd == 1) id(StudySubjectID)

local row2 = `row' + 2
forvalues g = 1(1)$groups {
    stsum if randgrp == `g'
	local col = `g' + 1
	local risk = string(`r(risk)' / 12, "%5.1f")
	local ir = string(`r(ir)' * 12 * 100, "%5.2f")
	local n = string(`r(N_sub)', "%5.0f")
	putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
}

sts graph, by(randgrp) failure title("", size(medsmall)) xtitle("Time (in months) from randomisation to the first onset of cardiovascular disease", size(small)) ytitle("Proportion of participants", size(small)) xlabel(0(6)96, labsize(vsmall)) ylabel(, labsize(vsmall) angle(horizontal)) legend(order(1 "Spironolactone" 2 "Standard Care") size(small)) risktable(, order(1 "Spironolactone" 2 "Standard Care") size(vsmall)) ysize(1) xsize(2) graphregion(color(white))
graph save "4.Output\Kaplan-Meier curves\Cardiovascular disease KM curve_$today.gph", replace
graph export "4.Output\Kaplan-Meier curves\Cardiovascular disease KM curve_$today.emf", replace
graph close

stcox i.randgrp

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
local hr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Cardiovascular disease log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Cardiovascular disease log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first onset of cardiovascular disease") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Cardiovascular disease KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Cardiovascular disease KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Primary endpoint component : death "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


* PRIMARY ENDPOINT COMPONENT: DEATH

local row = 13

local row2 = `row' + 1
tabcount EPdeath randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

putdocx table table(14,4) = ("-"), halign(center)
putdocx table table(14,5) = ("-"), halign(center)

stset EPdeathtime_months, failure(EPdeath == 1) id(StudySubjectID)

local row2 = `row' + 2
forvalues g = 1(1)$groups {
    stsum if randgrp == `g'
	local col = `g' + 1
	local risk = string(`r(risk)' / 12, "%5.1f")
	local ir = string(`r(ir)' * 12 * 100, "%5.2f")
	local n = string(`r(N_sub)', "%5.0f")
	putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
}

sts graph, by(randgrp) failure title("", size(medsmall)) xtitle("Time (in months) from randomisation to death", size(small)) ytitle("Proportion of participants", size(small)) xlabel(0(6)90, labsize(vsmall)) ylabel(0(0.1)0.5, labsize(vsmall) angle(horizontal)) legend(order(1 "Spironolactone" 2 "Standard Care") size(small)) risktable(, order(1 "Spironolactone" 2 "Standard Care") size(vsmall)) ysize(1) xsize(2) graphregion(color(white))
graph save "4.Output\Kaplan-Meier curves\Death KM curve_$today.gph", replace
graph export "4.Output\Kaplan-Meier curves\Death KM curve_$today.emf", replace
graph close

stcox i.randgrp

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
local hr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Death log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Death log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to death") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Death KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Death KM predicted survival plot_$today.emf", replace
graph close

estat phtest
putdocx paragraph
local pv = string(r(p), "%5.3f")
putdocx text ("Primary endpoint component : cardiovascular disease "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


* Kaplan-Meier Curves

putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Kaplan-Meier curve for the time (in months) from randomisation to the first occurance of death, first onset of hospitalisation for heart disease (crononary heart disease, arrhythmia, new onset/first recorded atrial fibrillation, sudden death, failed sudden death), stroke, or heart failure split by randomised arm") halign(center)
putdocx table table(1,1) = image("4.Output\Kaplan-Meier curves\Primary endpoint KM curve_$today.emf")
putdocx table table(2,.), bold 

putdocx sectionbreak, landscape
putdocx paragraph

putdocx table table = (9,18), layout(autofitcontents)

putdocx table table(1,1) = ("Month"), bold
putdocx table table(2,1) = ("Spironolactone"), bold
putdocx table table(3,1) = ("   At risk")
putdocx table table(4,1) = ("   Censored")
putdocx table table(5,1) = ("   Event")
putdocx table table(6,1) = ("Standard Care"), bold
putdocx table table(7,1) = ("   At risk")
putdocx table table(8,1) = ("   Censored")
putdocx table table(9,1) = ("   Event")

putdocx table table(.,.), border(all, nil)

local col = 1

local row = 2
local col = `col' + 1
putdocx table table(1,`col') = ("0"), halign(center) bold
local row2 = `row'
forvalues g = 1(1)$groups {
	count if EPtime_months > 0 & randgrp == `g' // At risk
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPtime_months >= 0 & EPtime_months <= 0 & EPyn == 0 & randgrp == `g' // Censored
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPtime_months >= 0 & EPtime_months <= 0 & EPyn == 1 & randgrp == `g' // Event
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	local row2 = `row2' + 1
}

foreach i in 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90 96 {
	local row = 2
	local col = `col' + 1
	putdocx table table(1,`col') = ("`i'"), halign(center) bold
	local row2 = `row'
	forvalues g = 1(1)$groups {
		count if EPtime_months >= `i' & randgrp == `g' // At risk
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPtime_months >= 0 & EPtime_months < `i' & EPyn == 0 & randgrp == `g' // Censored
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPtime_months >= 0 & EPtime_months < `i' & EPyn == 1 & randgrp == `g' // Event
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		local row2 = `row2' + 1
	}
}


/* TABLE 7 SUMMARY STATISTICS FOR THE BREAKDOWN OF THE PRIMARY ENDPOINT */

tab randgrp if EPyn == 1, matcell(M)
global N1_EP = M[1,1]
global N2_EP = M[2,1]
global groups_EP = r(r) 

putdocx sectionbreak
putdocx paragraph
putdocx text ("Table 7 Summary statistics for the breakdown of the primary endpoint"), bold

putdocx table table = (35,3), note("")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1_EP)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2_EP)"), halign(center) bold

putdocx table table(3,1) = ("PRIMARY ENDPOINT BREAKDOWN: FIRST EVENT"), bold colspan(5)
putdocx table table(4,1) = ("Death"), bold
putdocx table table(5,1) = ("     Cardiovascular")
putdocx table table(6,1) = ("     Not cardiovascular")
putdocx table table(7,1) = ("     Not stated (missing)")
putdocx table table(8,1) = ("Cardiovascular disease"), bold
putdocx table table(9,1) = ("     Heart disease")
putdocx table table(10,1) = ("          ACS"), italic
putdocx table table(11,1) = ("          CHD"), italic
putdocx table table(12,1) = ("          MI"), italic
putdocx table table(13,1) = ("          Arrhythmia"), italic
putdocx table table(14,1) = ("          AF"), italic
putdocx table table(15,1) = ("          Cardiac arrest"), italic
putdocx table table(16,1) = ("          Other"), italic
putdocx table table(17,1) = ("     Heart failure")
putdocx table table(18,1) = ("     Stroke")
putdocx table table(19,1) = ("     Transient ischaemic attack")
putdocx table table(20,1) = ("     Peripheral arterial disease")
putdocx table table(21,1) = ("     Not stated (missing)")
putdocx table table(22,1) = ("Hospitalisation"), bold
putdocx table table(23,1) = ("     Heart disease")
putdocx table table(24,1) = ("          ACS"), italic
putdocx table table(25,1) = ("          CHD"), italic
putdocx table table(26,1) = ("          MI"), italic
putdocx table table(27,1) = ("          Arrhythmia"), italic
putdocx table table(28,1) = ("          AF"), italic
putdocx table table(29,1) = ("          Cardiac arrest"), italic
putdocx table table(30,1) = ("          Other"), italic
putdocx table table(31,1) = ("     Heart failure")
putdocx table table(32,1) = ("     Stroke")
putdocx table table(33,1) = ("     Transient ischaemic attack")
putdocx table table(34,1) = ("     Peripheral artherial disease")
putdocx table table(35,1) = ("     Not stated (missing)")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(21,.), border(bottom, single)
putdocx table table(35,.), border(bottom, double)

preserve 

* Death
local row = 4 

tabcount EPfirstevent randgrp, c1(<=3 1 2 3) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_EP
forvalues g = 1(1)$groups_EP {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/${N`g'_EP})*100, "%5.1f")
		putdocx table table(`row2',`col') = ("`freq' (`perc')"), halign(center)
		local row2 = `row2' + 1
	}
}

drop if EPfirstevent <= 3

* Cardiovascular disease
local row = 8 

tabcount EPfirstevent randgrp, c1(<=15 <=10 4 5 6 7 8 9 10 11 12 13 14 15) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_EP
forvalues g = 1(1)$groups_EP {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/${N`g'_EP})*100, "%5.1f")
		putdocx table table(`row2',`col') = ("`freq' (`perc')"), halign(center)
		local row2 = `row2' + 1
	}
}

drop if EPfirstevent <= 15

* Hospitalisation
local row = 22 

tabcount EPfirstevent randgrp, c1(<=27 <=22 16 17 18 19 20 21 22 23 24 25 26 27) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_EP
forvalues g = 1(1)$groups_EP {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/${N`g'_EP})*100, "%5.1f")
		putdocx table table(`row2',`col') = ("`freq' (`perc')"), halign(center)
		local row2 = `row2' + 1
	}
}

drop if EPfirstevent <= 27

restore



*******************************************************************************
****************************** SECONDARY ANALYSIS ******************************
********************************************************************************

putdocx sectionbreak
putdocx paragraph
putdocx text ("SECONDARY ANALYSES"), bold


/* TABLE 8 SUMMARY STATISTICS AND THE ADJUSTED TREATMENT DIFFERENCES FOR THE SECONDARY ANALYSES */

putdocx paragraph
putdocx text ("Table 8 Summary statistics and the adjusted treatment differences for the secondary analyses"), bold

putdocx table table = (34,5), layout(autofitcontents) note("†Spironolactone versus standard care. 1Linear mixed effects model adjusted for randomised arm, baseline measurement, assessment timepoint, an interaction between randomised arm and assessment timepoint, and baseline factors that predict missingness of the endpoint as fixed effect, GP practice as a random effect, and a random intercept for each participant. 2Log-binominal regression model adjusted for randomised arm, baseline factors that predict missingness of the endpoint, and GP practice as covariates. 3Quantile regression model adjusted for randomised arm, baseline factors that predict missingness of the endpoint, and GP practice as covariates. ‡Level of significance = 0.05")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Adjusted treatment difference [95% CI]†"), halign(center) bold
putdocx table table(1,5) = ("P-value‡"), halign(center) bold

putdocx table table(3,1) = ("SECONDARY ANALYESE"), bold colspan(5)
putdocx table table(4,1) = ("Office measurements of systolic blood pressure, mean (SD) [n] (1)"), bold colspan(5)
putdocx table table(5,1) = ("     Baseline")
putdocx table table(6,1) = ("     6 months")
putdocx table table(7,1) = ("     1 year")
putdocx table table(8,1) = ("     2 years")
putdocx table table(9,1) = ("     3 years")
putdocx table table(10,1) = ("Rate of hypotension, n/N (%) (2)"), bold colspan(5)
putdocx table table(11,1) = ("     During the study period")
putdocx table table(12,1) = ("B-type natriuretic peptide [BNP] (pg/mL), mean (sd) [n] (3)"), bold colspan(5)
putdocx table table(13,1) = ("     Baseline")
putdocx table table(14,1) = ("     6 months")
putdocx table table(15,1) = ("     1 year")
putdocx table table(16,1) = ("     2 years")
putdocx table table(17,1) = ("     3 years")
putdocx table table(18,1) = ("Albumin creatinine ratio [ACR], mean (sd) [n] (3)"), bold colspan(5)
putdocx table table(19,1) = ("     Baseline")
putdocx table table(20,1) = ("          <3"), italic
putdocx table table(21,1) = ("          3-30"), italic
putdocx table table(22,1) = ("          >30"), italic
putdocx table table(23,1) = ("     3 years")
putdocx table table(24,1) = ("          <3"), italic
putdocx table table(25,1) = ("          3-30"), italic
putdocx table table(26,1) = ("          >30"), italic
putdocx table table(27,1) = ("Estimated glomerular filtration rate [eGFR] (ml/min/1.73m2), mean (SD) [n] (1)"), bold colspan(5)
putdocx table table(28,1) = ("     Baseline")
putdocx table table(29,1) = ("     6 months")
putdocx table table(30,1) = ("     1 year")
putdocx table table(31,1) = ("     2 years")
putdocx table table(32,1) = ("     3 years")
putdocx table table(33,1) = ("Transient ischaemic attack [TIA], n/N (%) (2)"), bold colspan(5)
putdocx table table(34,1) = ("     During the study period")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(9,.), border(bottom, single)
putdocx table table(11,.), border(bottom, single)
putdocx table table(17,.), border(bottom, single)
putdocx table table(26,.), border(bottom, single)
putdocx table table(32,.), border(bottom, single)
putdocx table table(34,.), border(bottom, double)

putdocx table table(1,4), rowspan(2)
putdocx table table(1,5), rowspan(2)


*** THE EFFECT OF ARA IN PATIENTS ON MEASURES OF CARDIOVASCULAR HAEMODYNAMICS **

/*
The mean change in systolic blood pressure each year from baseline will be analysed with a linear mixed effects model.  The model will include systolic blood pressure measurement at each time point and will adjust for baseline measurement and clustering within COL practice will be accounted for as a random effect within the model.  An interaction between time and randomised group will be fitted to allow estimation of treatment effect at 6 months and 1, 2 and 3 years. Although 6 months and 1, 2 and 3 years are the main time points of interest, all visits at which BP is recorded will be included in the model to aid estimation of treatment effects in the presence of missing data.  The model will also include a patient specific random intercept nested within a practice specific random intercept.  Results will be presented as mean difference in change from baseline in systolic blood pressure between the randomised groups at 6 months and 1, 2 and 3 years, with 95% confidence interval and associated 2-sided p value. 

The model will include the following fixed effects:
•	Time
•	Treatment allocation 
•	Time×treatment allocation 
•	Baseline systolic blood pressure

The model will include the following random effects:
•	COL practice
•	Participant ID

The distribution of the change from baseline will be formally assessed for evidence of departure from normality. If necessary, data will either be transformed or analysed using a non-parametric equivalent. 
*/


* OFFICE MEASUREMENTS OF SYSTOLIC BLOOD PRESSURE

local row = 4

local row2 = `row' + 1
foreach v in bl v5 v7 v11 v15 {
	tabstat sysbp_`v', by(randgrp) stat(mean sd min max n) save
	
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = `g' + 1
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.2f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row2',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
	local row2 = `row2' + 1
}

hist sysbp_bl, by(randgrp) freq xtitle("Baseline") ylabel(, angle(0)) name(hist0) nodraw
forvalues i = 1(1)15 {
	hist sysbp_v`i', by(randgrp) freq xtitle("Visit `i'") ylabel(, angle(0)) name(hist`i') nodraw
}
graph combine hist0 hist1 hist2 hist3 hist4 hist5 hist6 hist7 hist8 hist9 hist10 hist11 hist12 hist13 hist14 hist15
graph save "4.Output\Histograms\Office systolic BP_$today.gph", replace
graph export "4.Output\Histograms\Office systolic BP_$today.emf", replace
graph close
graph drop hist*

preserve 

keep StudySubjectID randgrp sysbp_bl sysbp_v* *_bl

reshape long sysbp_v, i(StudySubjectID) j(visit)

mixed sysbp_v i.randgrp i.visit i.randgrp##i.visit c.sysbp_bl `varlist1' || StudySubjectID:
predict res, residuals
predict rstand, rstandard
predict rfit, fitted

contrast ib2.randgrp@i.visit, effect // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
foreach i in 5 7 11 15 {
	local md = string(M[1,`i'], "%5.2f")
	local ll = string(M[5,`i'], "%5.2f")
	local ul = string(M[6,`i'], "%5.2f")
	local pv = string(M[4,`i'], "%5.3f")
	putdocx table table(`row2',4) = ("`md' [`ll' to `ul']"), halign(center)
	if `pv' < 0.001 {
		putdocx table table(`row2',5) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row2',5) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row2',5) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		putdocx table table(`row2',5), shading(255 255 0)
	}
	
	local row2 = `row2' + 1
}

putdocx table table(5,4) = ("-"), halign(center)
putdocx table table(5,5) = ("-"), halign(center)

// Model residuals
hist res, ylabel(, angle(0)) name(resid1) nodraw
qnorm rstand, ylabel(, angle(0)) name(resid2) nodraw
graph twoway scatter res rfit, xtitle("Fitted values") ytitle("Residuals") ylabel(, angle(0)) mcolor(maroon) yline(0, lcolor(navy)) legend(off) name(resid3) nodraw
graph combine resid1 resid2 resid3
graph save "4.Output\Residual plots\Office systolic BP_$today.gph", replace
graph export "4.Output\Residual plots\Office systolic BP_$today.emf", replace
graph close
graph drop resid*
drop res rstand rfit

restore

* RATE OF HYPOTENSION

local row = 10

local row2 = `row' + 1
tabcount hypotension randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

glm hypotension i.randgrp `varlist2', family(bin) link(log) nolog eform

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 1
local rr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`rr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}


*********** THE EFFECT OF ARA IN PATIENTS ON LEFT VENRICULAR FUNCTION **********

/*
B-type Natriuretic Peptide (BNP) at baseline, 6 months and annually will be summarised across treatment arm using mean and standard deviation. The mean change from baseline of BNP annually and at the final visit will be analysed using a linear mixed effects model, similar to the model for systolic blood pressure. Measurements at additional timepoints will be included in the model in order to aid in the estimation of the model in the presence of missing data. Results will be presented as mean difference in change from baseline in BNP between the randomised groups at 6 months and annually, with 95% confidence interval and associated 2-sided p value. 

The model will include the following fixed effects:
•	Time 
•	Treatment allocation 
•	Time×treatment allocation interaction
•	Baseline BNP

The model will include the following random effects:
•	COL practice
•	Participant ID

The distribution of the change from baseline will be formally assessed for evidence of departure from normality. If necessary, data will either be transformed or analysed using a non-parametric equivalent.
*/

* B-TYPE NATRIURETIC PEPTIDE [BNP]

local row = 12

local row2 = `row' + 1
foreach v in bl v5 v7 v11 v15 {
	tabstat BNP_`v', by(randgrp) stat(mean sd min max n) save
	
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = `g' + 1
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.2f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row2',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
	local row2 = `row2' + 1
}

hist BNP_bl, by(randgrp) freq xtitle("Baseline") ylabel(, angle(0)) name(hist0) nodraw
foreach i in 5 7 11 15 {
	hist BNP_v`i', by(randgrp) freq xtitle("Visit `i'") ylabel(, angle(0)) name(hist`i') nodraw
}
graph combine hist0 hist5 hist7 hist11 hist15
graph save "4.Output\Histograms\BNP_$today.gph", replace
graph export "4.Output\Histograms\BNP_$today.emf", replace
graph close
graph drop hist*

preserve

keep StudySubjectID randgrp BNP_bl BNP_v* *_bl

reshape long BNP_v, i(StudySubjectID) j(visit)
drop if visit == 4 | visit == 6 | visit == 9 | visit == 10 | visit == 12 | visit == 13 | visit == 14

mixed BNP_v i.randgrp i.visit i.randgrp##i.visit c.BNP_bl `varlist3' || StudySubjectID:
predict res, residuals
predict rstand, rstandard
predict rfit, fitted

contrast ib2.randgrp@i.visit, effect // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
foreach i in 1 2 3 4 {
	local md = string(M[1,`i'], "%5.2f")
	local ll = string(M[5,`i'], "%5.2f")
	local ul = string(M[6,`i'], "%5.2f")
	local pv = string(M[4,`i'], "%5.3f")
	putdocx table table(`row2',4) = ("`md' [`ll' to `ul']"), halign(center)
	if `pv' < 0.001 {
		putdocx table table(`row2',5) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row2',5) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row2',5) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		putdocx table table(`row2',5), shading(255 255 0)
	}
	
	local row2 = `row2' + 1
}

putdocx table table(13,4) = ("-"), halign(center)
putdocx table table(13,5) = ("-"), halign(center)

// Model residuals
hist res, ylabel(, angle(0)) name(resid1) nodraw
qnorm rstand, ylabel(, angle(0)) name(resid2) nodraw
graph twoway scatter res rfit, xtitle("Fitted values") ytitle("Residuals") ylabel(, angle(0)) mcolor(maroon) yline(0, lcolor(navy)) legend(off) name(resid3) nodraw
graph combine resid1 resid2 resid3 
graph save "4.Output\Residual plots\BNP_$today.gph", replace
graph export "4.Output\Residual plots\BNP_$today.emf", replace
graph close
graph drop resid*
drop res rstand rfit

restore

// Issues with model residuals indicate issues with model fit - try log transformation
putdocx table table(14,4) = (""), halign(center)
putdocx table table(14,5) = (""), halign(center)
putdocx table table(15,4) = (""), halign(center)
putdocx table table(15,5) = (""), halign(center)
putdocx table table(16,4) = (""), halign(center)
putdocx table table(16,5) = (""), halign(center)
putdocx table table(17,4) = (""), halign(center)
putdocx table table(17,5) = (""), halign(center)

ladder BNP_v15

gladder BNP_v15, b1title("") l1title("") xlabel(none) ylabel(none)
graph save "4.Output\Ladder plots\BNP gladder_$today.gph", replace
graph export "4.Output\Ladder plots\BNP gladder_$today.emf", replace
graph close

qladder BNP_v15, b1title("") l1title("") xlabel(none) ylabel(none)
graph save "4.Output\Ladder plots\BNP qladder_$today.gph", replace
graph export "4.Output\Ladder plots\BNP qladder_$today.emf", replace
graph close

foreach v in bl v4 v5 v6 v7 v9 v10 v11 v12 v13 v14 v15 {
	gen log_BNP_`v' = log(BNP_`v')
}

hist log_BNP_bl, by(randgrp) freq xtitle("Baseline") ylabel(, angle(0)) name(hist0) nodraw
foreach i in 5 7 11 15 {
	hist log_BNP_v`i', by(randgrp) freq xtitle("Visit `i'") ylabel(, angle(0)) name(hist`i') nodraw
}
graph combine hist0 hist5 hist7 hist11 hist15
graph save "4.Output\Histograms\log BNP_$today.gph", replace
graph export "4.Output\Histograms\log BNP_$today.emf", replace
graph close
graph drop hist*

preserve

keep StudySubjectID randgrp log_BNP_bl log_BNP_v* *_bl

reshape long log_BNP_v, i(StudySubjectID) j(visit)
drop if visit == 4 | visit == 6 | visit == 9 | visit == 10 | visit == 12 | visit == 13 | visit == 14

mixed log_BNP_v i.randgrp i.visit i.randgrp##i.visit c.log_BNP_bl `varlist3' || StudySubjectID:
predict res, residuals
predict rstand, rstandard
predict rfit, fitted

contrast ib2.randgrp@i.visit, effect // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
foreach i in 1 2 3 4 {
	if M[1,`i'] >= 0 {
		local md = string(10^(abs(M[1,`i'])), "%5.2f")
	}
	else if M[1,`i'] < 0 {
		local md = string((10^(abs(M[1,`i'])))*-1, "%5.2f")
	}
	if M[5,`i'] >= 0 {
		local ll = string(10^(abs(M[5,`i'])), "%5.2f")
	}
	else if M[5,`i'] < 0 {
		local ll = string((10^(abs(M[5,`i'])))*-1, "%5.2f")
	}
	if M[6,`i'] >= 0 {
		local ul = string(10^(abs(M[6,`i'])), "%5.2f")
	}
	else if M[6,`i'] < 0 {
		local ul = string((10^(abs(M[6,`i'])))*-1, "%5.2f")
	}
	local pv = string(M[4,`i'], "%5.3f")
	putdocx table table(`row2',4) = ("`md' [`ll' to `ul']"), halign(center)
	if `pv' < 0.001 {
		putdocx table table(`row2',5) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row2',5) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row2',5) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		putdocx table table(`row2',5), shading(255 255 0)
	}
	
	local row2 = `row2' + 1
}

putdocx table table(13,4) = ("-"), halign(center)
putdocx table table(13,5) = ("-"), halign(center)

// Model residuals
hist res, ylabel(, angle(0)) name(resid1) nodraw
qnorm rstand, ylabel(, angle(0)) name(resid2) nodraw
graph twoway scatter res rfit, xtitle("Fitted values") ytitle("Residuals") ylabel(, angle(0)) mcolor(maroon) yline(0, lcolor(navy)) legend(off) name(resid3) nodraw
graph combine resid1 resid2 resid3 
graph save "4.Output\Residual plots\log BNP_$today.gph", replace
graph export "4.Output\Residual plots\log BNP_$today.emf", replace
graph close
graph drop resid*
drop res rstand rfit

restore

drop log_BNP_*


********** THE EFFECT OF ARA IN PATIENTS ON DECLINE IN RENAL FUNCTION **********

/*
The decline in renal function will be measured by  eGFR and ACR.

eGFR (GFR) at baseline, 6 months and annually will be summarised across treatment arms using means and standard deviations. Mean change in eGFR from baseline to each visit will be assessed using linear mixed models in the same way as for blood pressure.
The model will include the following fixed effects:
•	Time 
•	Treatment allocation 
•	Time×treatment allocation 
•	Baseline BNP

The model will include the following random effects:
•	COL practice
•	Participant ID


Results will be presented as mean difference in change from baseline in eGFR between the randomised groups at each visit, with 95% confidence interval and associated 2-sided p value.

ACR (ALBCREAT) at baseline and the final visit will be summarised across treatment arm using means and standard deviations. The change in ACR from randomisation to the final visit (visit 15, 3 years) will be assessed using a linear mixed effects model. The model will include baseline ACR and treatment allocation as fixed predictors.  Random effects will be participants nested within COL practices.  Results will be presented as the difference in mean change in ACR, with a 95% confidence interval and corresponding P-value.

The distribution of the change from baseline will be formally assessed for evidence of departure from normality. If necessary, data will either be transformed or analysed using a non-parametric equivalent.
*/

* ALBUMIN CREATININE RATIO [ACR]

local row = 18

local row2 = `row' + 1
foreach v in bl v15 {
	tabstat ACR_`v', by(randgrp) stat(mean sd min max n) save
	
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = `g' + 1
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.2f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row2',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
	local row2 = `row2' + 4
}

hist ACR_bl, by(randgrp) freq xtitle("Baseline") ylabel(, angle(0)) name(hist0) nodraw
hist ACR_v15, by(randgrp) freq xtitle("Visit 15") ylabel(, angle(0)) name(hist15) nodraw
graph combine hist0 hist15
graph save "4.Output\Histograms\ACR_$today.gph", replace
graph export "4.Output\Histograms\ACR_$today.emf", replace
graph close
graph drop hist*

preserve

keep StudySubjectID randgrp ACR_bl ACR_v* *_bl

mixed ACR_v15 i.randgrp c.ACR_bl `varlist4' 

predict res, residuals
predict rstand, rstandard
predict rfit, fitted

contrast ib2.randgrp, effect // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 5
local md = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")

putdocx table table(19,4) = ("-"), halign(center)
putdocx table table(19,5) = ("-"), halign(center)

// Model residuals
hist res, ylabel(, angle(0)) name(resid1) nodraw
qnorm rstand, ylabel(, angle(0)) name(resid2) nodraw
graph twoway scatter res rfit, xtitle("Fitted values") ytitle("Residuals") ylabel(, angle(0)) mcolor(maroon) yline(0, lcolor(navy)) legend(off) name(resid3) nodraw
graph combine resid1 resid2 resid3
graph save "4.Output\Residual plots\ACR_$today.gph", replace
graph export "4.Output\Residual plots\ACR_$today.emf", replace
graph close
graph drop resid*
drop res rstand rfit

restore

// Issues with model residuals indicate issues with model fit - log transform
putdocx table table(23,4) = (""), halign(center)
putdocx table table(23,5) = (""), halign(center)

local row2 = `row' + 5

ladder ACR_v15

gladder ACR_v15, b1title("") l1title("") xlabel(none) ylabel(none)
graph save "4.Output\Ladder plots\ACR gladder_$today.gph", replace
graph export "4.Output\Ladder plots\ACR gladder_$today.emf", replace
graph close

qladder ACR_v15, b1title("") l1title("") xlabel(none) ylabel(none)
graph save "4.Output\Ladder plots\ACR qladder_$today.gph", replace
graph export "4.Output\Ladder plots\ACR qladder_$today.emf", replace
graph close

foreach v in bl v15 {
	gen log_ACR_`v' = log(ACR_`v')
}

hist log_ACR_bl, by(randgrp) freq xtitle("Baseline") ylabel(, angle(0)) name(hist0) nodraw
hist log_ACR_v15, by(randgrp) freq xtitle("Visit 15") ylabel(, angle(0)) name(hist15) nodraw
graph combine hist0 hist15
graph save "4.Output\Histograms\log ACR_$today.gph", replace
graph export "4.Output\Histograms\log ACR_$today.emf", replace
graph close
graph drop hist*

preserve

keep StudySubjectID randgrp log_ACR_bl log_ACR_v* *_bl

mixed log_ACR_v15 i.randgrp c.ACR_bl `varlist4' 
predict res, residuals
predict rstand, rstandard
predict rfit, fitted

contrast ib2.randgrp, effect // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 5
if M[1,1] >= 0 {
	local md = string(10^(abs(M[1,1])), "%5.2f")
}
else if M[1,1] < 0 {
	local md = string((10^(abs(M[1,1])))*-1, "%5.2f")
}
if M[5,1] >= 0 {
	local ll = string(10^(abs(M[5,1])), "%5.2f")
}
else if M[5,1] < 0 {
	local ll = string((10^(abs(M[5,1])))*-1, "%5.2f")
}
if M[6,1] >= 0 {
	local ul = string(10^(abs(M[6,1])), "%5.2f")
}
else if M[6,1] < 0 {
	local ul = string((10^(abs(M[6,1])))*-1, "%5.2f")
}
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`md' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

putdocx table table(19,4) = ("-"), halign(center)
putdocx table table(19,5) = ("-"), halign(center)
putdocx table table(20,4) = ("-"), halign(center)
putdocx table table(20,5) = ("-"), halign(center)
putdocx table table(21,4) = ("-"), halign(center)
putdocx table table(21,5) = ("-"), halign(center)
putdocx table table(22,4) = ("-"), halign(center)
putdocx table table(22,5) = ("-"), halign(center)
putdocx table table(24,4) = ("-"), halign(center)
putdocx table table(24,5) = ("-"), halign(center)
putdocx table table(25,4) = ("-"), halign(center)
putdocx table table(25,5) = ("-"), halign(center)
putdocx table table(26,4) = ("-"), halign(center)
putdocx table table(26,5) = ("-"), halign(center)

// Model residuals
hist res, ylabel(, angle(0)) name(resid1) nodraw
qnorm rstand, ylabel(, angle(0)) name(resid2) nodraw
graph twoway scatter res rfit, xtitle("Fitted values") ytitle("Residuals") ylabel(, angle(0)) mcolor(maroon) yline(0, lcolor(navy)) legend(off) name(resid3) nodraw
graph combine resid1 resid2 resid3
graph save "4.Output\Residual plots\log ACR_$today.gph", replace
graph export "4.Output\Residual plots\log ACR_$today.emf", replace
graph close
graph drop resid*
drop res rstand rfit

restore

drop log_ACR_*


// Categories
local row = 19

tabcount ACRcat_bl randgrp, v1(1 2 3) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

local row = 23

tabcount ACRcat_v15 randgrp, v1(1 2 3) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups
forvalues g = 1(1)$groups {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}


* GLOMERULAR FILTRATION RATE [eGFR]

local row = 27

local row2 = `row' + 1
foreach v in bl v5 v7 v11 v15 {
	tabstat eGFR_`v', by(randgrp) stat(mean sd min max n) save
	
	forvalues g = 1(1)$groups {
		matrix define M`g' = r(Stat`g')
		local col = `g' + 1
		local mean = string(M`g'[1,1], "%5.1f")
		local sd = string(M`g'[2,1], "%5.2f")
		local n = string(M`g'[5,1], "%5.0f")
		putdocx table table(`row2',`col') = ("`mean' (`sd') [`n']"), halign(center)
	}
	local row2 = `row2' + 1
}

hist eGFR_bl, by(randgrp) freq xtitle("Baseline") ylabel(, angle(0)) name(hist0) nodraw
forvalues i = 1(1)15 {
	hist eGFR_v`i', by(randgrp) freq xtitle("Visit `i'") ylabel(, angle(0)) name(hist`i') nodraw
}
graph combine hist0 hist1 hist2 hist3 hist4 hist5 hist6 hist7 hist8 hist9 hist10 hist11 hist12 hist13 hist14 hist15
graph save "4.Output\Histograms\eGFR_$today.gph", replace
graph export "4.Output\Histograms\eGFR_$today.emf", replace
graph close
graph drop hist*

preserve

keep StudySubjectID randgrp eGFR_bl eGFR_v* *_bl

reshape long eGFR_v, i(StudySubjectID) j(visit)

mixed eGFR_v i.randgrp i.visit i.randgrp##i.visit c.eGFR_bl `varlist5' || StudySubjectID:
predict res, residuals
predict rstand, rstandard
predict rfit, fitted

contrast ib2.randgrp@i.visit, effect // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
foreach i in 5 7 11 15 {
	local md = string(M[1,`i'], "%5.2f")
	local ll = string(M[5,`i'], "%5.2f")
	local ul = string(M[6,`i'], "%5.2f")
	local pv = string(M[4,`i'], "%5.3f")
	putdocx table table(`row2',4) = ("`md' [`ll' to `ul']"), halign(center)
	if `pv' < 0.001 {
		putdocx table table(`row2',5) = ("<0.001"), halign(center)
	}
	if `pv' >= 0.001 & `pv' <= 0.999 {
		putdocx table table(`row2',5) = ("`pv'"), halign(center)
	}
	else if `pv' > 0.999 {
		putdocx table table(`row2',5) = (">0.999"), halign(center)
	}
	
	if `pv' < 0.05 {
		putdocx table table(`row2',5), shading(255 255 0)
	}
	
	local row2 = `row2' + 1
}

putdocx table table(22,4) = ("-"), halign(center)
putdocx table table(22,5) = ("-"), halign(center)

// Model residuals
hist res, ylabel(, angle(0)) name(resid1) nodraw
qnorm rstand, ylabel(, angle(0)) name(resid2) nodraw
graph twoway scatter res rfit, xtitle("Fitted values") ytitle("Residuals") ylabel(, angle(0)) mcolor(maroon) yline(0, lcolor(navy)) legend(off) name(resid3) nodraw
graph combine resid1 resid2 resid3
graph save "4.Output\Residual plots\eGFR_$today.gph", replace
graph export "4.Output\Residual plots\eGFR_$today.emf", replace
graph close
graph drop resid*
drop res rstand rfit

restore


******************** INCIDENCE OF TRANSIENT ISCHAEMIC ATTACK *******************

/*
TIA will be as defined by the American Heart Association. The incidence of TIA (recorded in the variable CVDEVENT) across the entire study period will be compared across treatment arms by applying a log-binomial regression model. The outcome will be a binary variable coded 1 if the participant records an instance of TIA at any point during the study period and coded 0 otherwise. Fixed effects   in the model will be treatment allocation and random effect will be COL practice. Treatment effect will be reported as a relative risk and 95% confidence interval and will be adjusted for COL practice.
*/

local row = 33

local row2 = `row' + 1
tabcount TIA randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

glm TIA i.randgrp `varlist6', family(bin) link(log) nolog eform

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 1
local rr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`rr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}


putdocx paragraph
putdocx text ("Factors that predict missingness of office measurements of systolic blood pressure (model adjusted for these) : `varlist1'")

putdocx paragraph
putdocx text ("Factors that predict missingness of rate of hypotension (model adjusted for these) : `varlist2'")

putdocx paragraph
putdocx text ("Factors that predict missingness of B-type natriuretic peptide (model adjusted for these) : `varlist3'")

putdocx paragraph
putdocx text ("Factors that predict missingness of albumin creatinine ratio (model adjusted for these) : `varlist4'")

putdocx paragraph
putdocx text ("Factors that predict missingness of estimated glomerular filtration rate (model adjusted for these) : `varlist5'")

putdocx paragraph
putdocx text ("Factors that predict missingness of transient ischaemic attack (model adjusted for these) : `varlist6'")


********************************************************************************
***************************** SENSITIVITY ANALYSES *****************************
********************************************************************************

putdocx sectionbreak
putdocx paragraph
putdocx text ("SENSITIVITY ANALYSIS"), bold

/* TABLE 9 SUMMARY STATISTICS FOR THE SENSITIVITY ANALYSIS AND THE TREATMENT DIFFERENCE BETWEEN THE RANDOMISED ARMS */

putdocx paragraph
putdocx text ("Table 9 Summary statistics for the sensitivity analyses and the treatment difference between the randomised groups"), bold

putdocx table table = (6,5), layout(autofitcontents) note("†Spironolactone versus standard care. *Primary endpoint. 1Mixed effects Cox-proportional hazards model with an unstructured variance-covariance structure for the random effects, modelled against randomised arm, type II diabetes at baseline, coronary artery disease at baseline, and blood pressure below or above NICE target at baseline as a fixed effect, and COL practice as a random effect. ‡Level of significance = 0.05")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Adjusted treatment difference [95% CI]†"), halign(center) bold
putdocx table table(1,5) = ("P-value‡"), halign(center) bold

putdocx table table(3,1) = ("SENSITIVITY ANALYSIS"), bold colspan(5)
putdocx table table(4,1) = ("Primary endpoint, n/N (%) and median (IQR) (1)"), bold colspan(5)
putdocx table table(5,1) = ("     Experienced")
putdocx table table(6,1) = ("     Time at risk (incidence rate)")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(6,.), border(bottom, double)

/*
SENSITIVITY ANALYSIS

To test the robustness of the result for the primary outcome, a sensitivity analysis will be carried out, using the cox proportional hazards model, adjusting the following pre-specified baseline prognostic factors:  diastolic (DIABPR/DIABPL) and/or systolic blood pressure (SYSBPR/SYSBPL) above or below NICE target, type II diabetes (DIAYN) and coronary artery disease (IHDYN) BP targets will be based on the following measures of clinical blood pressure: 
o	People aged under 80 years: lower than 140/90 mm Hg (systolic/diastolic) 
o	People aged 80 years or over: lower than 150/90 mm Hg (systolic/diastolic)
As blood pressure is recorded in both arms at each visit, we will consider the average of the two measures as meeting the criteria.
*/

local row = 4

local row2 = `row' + 1
tabcount EPyn randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

putdocx table table(5,4) = ("-"), halign(center)
putdocx table table(5,5) = ("-"), halign(center)

stset EPtime_months, failure(EPyn == 1) id(StudySubjectID)

local row2 = `row' + 2
forvalues g = 1(1)$groups {
    stsum if randgrp == `g'
	local col = `g' + 1
	local risk = string(`r(risk)' / 12, "%5.1f")
	local ir = string(`r(ir)' * 12 * 100, "%5.2f")
	local n = string(`r(N_sub)', "%5.0f")
	putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
}

stcox i.randgrp i.diayn_bl i.ihdyn_bl i.bpNICE_bl

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
local hr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Sensitivity analysis log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Sensitivity analysis log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of primary endpoint") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Sensitivity analysis KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Sensitivity analysis KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Sensitivity analysis "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


********************************************************************************
******************************* SUBGROUP ANALYSES ******************************
********************************************************************************

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("SUBGROUP ANALYSES"), bold

/* TABLE 9 SUMMARY STATISTICS FOR THE SUBGROUP ANALYSES AND THE TREATMENT DIFFERENCE BETWEEN THE RANDOMISED GROUPS */

putdocx paragraph
putdocx text ("Table 9 Summary statistics for the subgroup analyses and the treatment difference between the randomised groups"), bold

putdocx table table = (24,5), layout(autofitcontents) note("†Spironolactone versus standard care. 1Cox-proportional hazards model adjusted for randomised arm, an indicator variable for the subgroup, and an interaction between randomised arm and the subgroup indicator variable as a fixed effect. ‡Level of significance = 0.05")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold
putdocx table table(1,4) = ("Adjusted Hazard Ratio [95% CI]†"), halign(center) bold
putdocx table table(1,5) = ("Test of interaction (P-value)‡"), halign(center) bold

putdocx table table(3,1) = ("SUBGROUP ANALYSES"), bold colspan(5)
putdocx table table(4,1) = ("Subgroup: Type II diabetes at baseline"), bold colspan(4)
putdocx table table(5,1) = ("     Present"), bold
putdocx table table(6,1) = ("          Experienced primary endpoint, n/N (%)")
putdocx table table(7,1) = ("          Time at risk (incidence rate)")
putdocx table table(8,1) = ("     Absent"), bold
putdocx table table(9,1) = ("          Experienced primary endpoint, n/N (%)")
putdocx table table(10,1) = ("          Time at risk (incidence rate")
putdocx table table(11,1) = ("Subgroup: Coronary artery disease at baseline"), bold colspan(4)
putdocx table table(12,1) = ("     Present"), bold
putdocx table table(13,1) = ("          Experienced primary endpoint, n/N (%)")
putdocx table table(14,1) = ("          Time at risk (incidence rate)")
putdocx table table(15,1) = ("     Absent"), bold
putdocx table table(16,1) = ("          Experienced primary endpoint, n/N (%)")
putdocx table table(17,1) = ("          Time at risk (incidence rate)")
putdocx table table(18,1) = ("Subgroup: Systolic and/or diastolic blood pressure below/above the NICE target at baseline"), bold colspan(4)
putdocx table table(19,1) = ("     Below NICE target"), bold
putdocx table table(20,1) = ("          Experienced primary endpoint, n/N (%)")
putdocx table table(21,1) = ("          Time at risk (incidence rate)")
putdocx table table(22,1) = ("     Above NICE target"), bold
putdocx table table(23,1) = ("          Experienced primary endpoint, n/N (%)")
putdocx table table(24,1) = ("          Time at risk (incidence rate)")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(10,.), border(bottom, single)
putdocx table table(17,.), border(bottom, single)
putdocx table table(24,.), border(bottom, double)

putexcel A2 = "Type II diabetes at baseline"
putexcel B2 = "Present"
putexcel A3 = "Type II diabetes at baseline"
putexcel B3 = "Absent"
putexcel A4 = "Coronary artery disease at baseline"
putexcel B4 = "Present"
putexcel A5 = "Coronary artery disease at baseline"
putexcel B5 = "Absent"
putexcel A6 = "Blood pressure below/above the NICE target at baseline"
putexcel B6 = "Below NICE target"
putexcel A7 = "Blood pressure below/above the NICE target at baseline"
putexcel B7 = "Above NICE target"

/*
SUBGROUP ANALYSES

All subgroup analyses are exploratory and will be conducted on the primary outcome only and on the ITT population.   

The efficacy of the intervention by each subgroup will be examined separately. Subgroups to be tested include:
1.	Presence/absence of type II diabetes at baseline
2.	Presence/absence of coronary artery disease at baseline
3.	Diastolic and/or systolic blood pressure above/below the NICE targets at baseline (Defined as- People aged under 80 years: lower than 140/90 mm Hg (systolic/diastolic), People aged over 80 years: lower than 150/90 mm Hg (systolic/diastolic)
We will include appropriate subgroup by treatment interaction terms and add these terms to the Cox regression model used in the primary outcome analysis.  
*/


************************* TYPE II DIABETES AT BASELINE *************************

local row = 4
local cell = 2

* Expierenced primary endpoint

local row2 = `row' + 2
local cell2 = `cell'
foreach i in 1 0 {
	tabcount EPyn randgrp if diayn_bl == `i', c1(1 0) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq`g' = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq`g''/`n' (`perc')"), halign(center)
	}
	putexcel C`cell2' = "`freq1'"
	putexcel D`cell2' = "`freq2'"
	
	local row2 = `row2' + 3
	local cell2 = `cell2' + 1
}

putdocx table table(6,4) = ("-"), halign(center)
putdocx table table(9,4) = ("-"), halign(center)

* Time to first event

stset EPtime_months, failure(EPyn == 1) id(StudySubjectID)

local row2 = `row' + 3
foreach i in 1 0 {
	forvalues g = 1(1)$groups {
		stsum if randgrp == `g' & diayn_bl == `i'
		local col = `g' + 1
		local risk = string(`r(risk)' / 12, "%5.1f")
		local ir = string(`r(ir)' * 12 * 100, "%5.2f")
		local n = string(`r(N_sub)', "%5.0f")
		putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
	}
	local row2 = `row2' + 3
}

stcox i.randgrp i.diayn_bl i.randgrp##i.diayn_bl

contrast ib2.randgrp@i.diayn_bl, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 3
local cell2 =  `cell'
foreach i in 2 1 {
	local hr = string(M[1,`i'], "%5.2f")
	local ll = string(M[5,`i'], "%5.2f")
	local ul = string(M[6,`i'], "%5.2f")
	putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
	putexcel E`cell2' = "`hr'"
	putexcel F`cell2' = "`ll'"
	putexcel G`cell2' = "`ul'"
	
	local row2 = `row2' + 3
	local cell2 = `cell2' + 1
}

// Test of interaction
contrast i.randgrp#i.diayn_bl, effect eform
matrix M = r(p)

local toi = string(M[1,1], "%5.3f")
if `toi' < 0.001 {
	putdocx table table(`row',2) = ("P<0.001"), halign(center)
	putexcel H`cell' = "<0.001"
	
}
if `toi' >= 0.001 & `toi' <= 0.999 {
	putdocx table table(`row',2) = ("P=`toi'"), halign(center)
	putexcel H`cell' = "`toi'"
}
else if `toi' > 0.999 {
	putdocx table table(`row',2) = ("P>0.999"), halign(center)
	putexcel H`cell' = ">0.999"
}

if `toi' <= 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Diabetes subgroup log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Diabetes subgroup log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of primary endpoint") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Diabetes subgroup KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Diabetes subgroup KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Type II diabetes subgroup "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


********************** CORONARY ARTERY DISEASE AT BASELINE *********************

local row = 11
local cell = 4

* Experienced primary endpoint

local row2 = `row' + 2
local cell2 = `cell'
foreach i in 1 0 {
	tabcount EPyn randgrp if ihdyn_bl == `i', c1(1 0) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq`g' = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq`g''/`n' (`perc')"), halign(center)
	}
	putexcel C`cell2' = "`freq1'"
	putexcel D`cell2' = "`freq2'"
	
	local row2 = `row2' + 3
	local cell2 = `cell2' + 1
}

putdocx table table(13,4) = ("-"), halign(center)
putdocx table table(16,4) = ("-"), halign(center)

* Time to first event

stset EPtime_months, failure(EPyn == 1) id(StudySubjectID)

local row2 = `row' + 3
foreach i in 1 0 {
	forvalues g = 1(1)$groups {
		stsum if randgrp == `g' & ihdyn_bl == `i'
		local col = `g' + 1
		local risk = string(`r(risk)' / 12, "%5.1f")
		local ir = string(`r(ir)' * 12 * 100, "%5.2f")
		local n = string(`r(N_sub)', "%5.0f")
		putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
	}
	local row2 = `row2' + 3
}


stcox i.randgrp i.ihdyn_bl i.randgrp##i.ihdyn_bl

contrast ib2.randgrp@i.ihdyn_bl, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 3
local cell2 = `cell'
foreach i in 2 1 {
	local hr = string(M[1,`i'], "%5.2f")
	local ll = string(M[5,`i'], "%5.2f")
	local ul = string(M[6,`i'], "%5.2f")
	putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
	putexcel E`cell2' = "`hr'"
	putexcel F`cell2' = "`ll'"
	putexcel G`cell2' = "`ul'"
	
	local row2 = `row2' + 3
	local cell2 = `cell2' + 1
}

// Test of interaction
contrast i.randgrp#i.ihdyn_bl, effect eform
matrix M = r(p)

local toi = string(M[1,1], "%5.3f")
if `toi' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
	putexcel H`cell' = "<0.001"
}
if `toi' >= 0.001 & `toi' <= 0.999 {
	putdocx table table(`row',2) = ("`toi'"), halign(center)
	putexcel H`cell' = "`toi'"
}
else if `toi' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
	putexcel H`cell' = ">0.999"
}

if `toi' <= 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Coronary artery disease subgroup log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Coronary artery disease subgroup log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of primary endpoint") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Coronary artery disease subgroup KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Coronary artery disease subgroup KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Coronary artery disease subgroup "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


************ BLOOD PRESSURE BELOW/ABOVE THE NICE TARGET AT BASELINE ************

local row = 18
local cell = 6

* Experienced primary endpoint

local row2 = `row' + 2
local cell2 = `cell'
foreach i in 1 0 {
	tabcount EPyn randgrp if bpNICE_bl == `i', c1(1 0) v2(1 2) zero matrix(MG)
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
		local col = `g' + 1
		local freq`g' = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq`g''/`n' (`perc')"), halign(center)
	}
	putexcel C`cell2' = "`freq1'"
	putexcel D`cell2' = "`freq2'"
	
	local row2 = `row2' + 3
	local cell2 = `cell2' + 1
}

putdocx table table(20,4) = ("-"), halign(center)
putdocx table table(23,4) = ("-"), halign(center)

* Time to first event

stset EPtime_months, failure(EPyn == 1) id(StudySubjectID)

local row2 = `row' + 3
foreach i in 1 0 {
	forvalues g = 1(1)$groups {
		stsum if randgrp == `g' & bpNICE_bl == `i'
		local col = `g' + 1
		local risk = string(`r(risk)' / 12, "%5.1f")
		local ir = string(`r(ir)' * 12 * 100, "%5.2f")
		local n = string(`r(N_sub)', "%5.0f")
		putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
	}
	local row2 = `row2' + 3
}

stcox i.randgrp i.bpNICE_bl i.randgrp##i.bpNICE_bl

contrast ib2.randgrp@i.bpNICE_bl, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 3
local cell2 = `cell'
foreach i in 2 1 {
	local hr = string(M[1,`i'], "%5.2f")
	local ll = string(M[5,`i'], "%5.2f")
	local ul = string(M[6,`i'], "%5.2f")
	putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
	putexcel E`cell2' = "`hr'"
	putexcel F`cell2' = "`ll'"
	putexcel G`cell2' = "`ul'"
	
	local row2 = `row2' + 3
	local cell2 = `cell2' + 1
}

// Test of interaction
contrast i.randgrp#i.bpNICE_bl, effect eform
matrix M = r(p)

local toi = string(M[1,1], "%5.3f")
if `toi' < 0.001 {
	putdocx table table(`row',2) = ("<0.001"), halign(center)
	putexcel H`cell' = "<0.001"
}
if `toi' >= 0.001 & `toi' <= 0.999 {
	putdocx table table(`row',2) = ("`toi'"), halign(center)
	putexcel H`cell' = "`toi'"
}
else if `toi' > 0.999 {
	putdocx table table(`row',2) = (">0.999"), halign(center)
	putexcel H`cell' = ">0.999"
}

if `toi' <= 0.05 {
	putdocx table table(`row',2), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\NICE target subgroup log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\NICE target subgroup log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of primary endpoint") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\NICE target subgroup KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\NICE target subgroup KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("NICE target subgroup "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0


* SUBGROUP FOREST PLOT
preserve

import excel "4.Output\Results_$today.xlsx", firstrow clear

destring GroupA_n, replace
destring GroupB_n, replace
destring hr, replace
destring ll, replace
destring ul, replace

gen n = GroupA_n + GroupB_n
gen stat = string(hr, "%5.2f") + " [" + string(ll, "%5.2f") + " to " + string(ul, "%5.2f") + "]"

label variable label1 " "
label variable subgroup " "
label variable GroupA_n "Spironolactone (N=$N1)"
label variable GroupB_n "Standard Care (N=$N2)"
label variable stat "Hazard Ratio [95% CI]†"
label variable pvalue "Test of Interaction (P-value)‡"

replace hr = ln(hr)
replace ll = ln(ll)
replace ul = ln(ul)

local xline = (hr[7]) // Treatment effect for the primary outcome

metan hr ll ul, eform wgt(n) label(namevar = subgroup) by(label1, missing) nosubgroup nooverall nostats lcols(GroupA_n GroupB_n) rcols(stat pvalue) labtitle("Subgroup") forestplot(favours("Favours Spironolactone" # "Favours Standard Care") xline(`xline', lpattern(dash) lcolor(black)) diamopt(lcolor(black) lwidth(thich)) boxopt(lcolor(black) lwidth(vthick)) texts(100) boxscale(150) ysize(50) xsize(100) graphregion(color(white))) saving("4.Output\Subgroup forest plot_$today.gph", replace)
graph export "4.Output\Subgroup forest plot_$today.emf", replace
graph close

putdocx sectionbreak, landscape
putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Forest plot of the results from the subgroup analyses") halign(center)
putdocx table table(1,1) = image("4.Output\Subgroup forest plot_$today.emf")
putdocx table table(2,.), bold

restore



********************************************************************************
******************************** SAFETY ANALYSIS *******************************
********************************************************************************

tab received, matcell(M)
global N1_safety = M[1,1]
global N2_safety = M[2,1]
global N_safety = M[1,1] + M[2,1]
global groups_safety = r(r) // Number of safety groups

putdocx sectionbreak
putdocx paragraph
putdocx text ("SAFETY ANALYSIS"), bold

/* TABLE 10 FREQUENCY AND PERCENTAGE OF PARICIPANTS EXPERIENCING HYPERKALAEMIA, ADVERSE EVENTS, AND SERIOUS ADVERSE EVENTS */

putdocx paragraph
putdocx text ("Table 10 Frequency and percentage of participants experiencing hyperkalaemia, adverse events, and serious adverse events"), bold

putdocx table table = (33,4), layout(autofitcontents) note("†Group C versus Group D. ‡Level of significance = 0.05")

putdocx table table(1,2) = ("Group C"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1_safety)"), halign(center) bold
putdocx table table(1,3) = ("Group D"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2_safety)"), halign(center) bold
putdocx table table(1,4) = ("P-value†"), halign(center) bold

putdocx table table(3,1) = ("SAFETY ANALYSES"), bold colspan(4)
putdocx table table(4,1) = ("Hyperkalaemia, n/N (%)"), bold colspan(4)
putdocx table table(5,1) = ("     Experienced"), bold
putdocx table table(6,1) = ("     Mild (5.5 to 5.9 mmol/l)")
putdocx table table(7,1) = ("     Moderate (6.0 to 6.4 mmol/l)")
putdocx table table(8,1) = ("     Severe (> 6.5 mmol/l)")
putdocx table table(9,1) = ("Adverse Events (AEs), n/N (%)"), bold colspan(4)
putdocx table table(10,1) = ("     Experienced at least one"), bold
putdocx table table(11,1) = ("     None")
putdocx table table(12,1) = ("     1")
putdocx table table(13,1) = ("     2")
putdocx table table(14,1) = ("     3")
putdocx table table(15,1) = ("     4")
putdocx table table(16,1) = ("     ≥5")
putdocx table table(17,1) = ("Severity of Adverse Events, n/N (%)"), bold colspan(4)
putdocx table table(18,1) = ("     N")
putdocx table table(19,1) = ("     Mild")
putdocx table table(20,1) = ("     Moderate")
putdocx table table(21,1) = ("     Severe")
putdocx table table(22,1) = ("Plausible Relationship of Adverse Event to Study Drug, n/N (%)"), bold colspan(4)
putdocx table table(23,1) = ("     N")
putdocx table table(24,1) = ("     Unrelated")
putdocx table table(25,1) = ("     Possibly related")
putdocx table table(26,1) = ("     Probably related")
putdocx table table(27,1) = ("     Definiely related")
putdocx table table(28,1) = ("Serious Adverse Events (SAEs), n/N (%)"), bold colspan(4)
putdocx table table(29,1) = ("     Experienced at least one"), bold
putdocx table table(30,1) = ("     None")
putdocx table table(31,1) = ("     1")
putdocx table table(32,1) = ("     2")
putdocx table table(33,1) = ("     ≥3")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(8,.), border(bottom, single)
putdocx table table(16,.), border(bottom, single)
putdocx table table(21,.), border(bottom, single)
putdocx table table(27,.), border(bottom, single)
putdocx table table(33,.), border(bottom, double)


********************************* HYPERKALAEMIA ********************************

local row = 5
tabcount hyperkalaemia received, c1(1 0) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups_safety {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

tab hyperkalaemia received, exact
local pv = string(r(p_exact), "%5.3f")
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',4) = ("`pv'"), halign(center) 
}
if `pv' < 0.001 {
	putdocx table table(`row',4) = ("<0.001"), halign(center)
}
else if `pv' > 0.999 {
    putdocx table table(`row',4) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',4), shading(255 255 0)
}


tabcount hyperkalaemia_class received, c1(1 2 3) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_safety
forvalues g = 1(1)$groups_safety {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

********************************* NUMBER OF AES ********************************

local row = 10
tabcount aeyn received, c1(1 0) c2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups_safety {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

tab aeyn received, exact
local pv = string(r(p_exact), "%5.3f")
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',4) = ("`pv'"), halign(center) 
}
if `pv' < 0.001 {
	putdocx table table(`row',4) = ("<0.001"), halign(center)
}
else if `pv' > 0.999 {
    putdocx table table(`row',4) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',4), shading(255 255 0)
}

local row2 = `row' + 1
tabcount aecount received, c1(0 1 2 3 4 >=5) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_safety
forvalues g = 1(1)$groups_safety {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	
	}
}


*********************************** SEVERITY ***********************************

local row = 18

preserve

keep StudySubjectID received aeterm_*_ae aesev_*_ae complete_ae

drop if complete_ae == 0
drop complete_ae

rename aeterm_*_ae aeterm_*
rename aesev_*_ae aesev_*

reshape long aeterm_ aesev_, i(StudySubjectID) j(ae)
drop if missing(aeterm_)

// N
tab received, matcell(M)

forvalues g = 1(1)$groups_safety {
	local col = `g' + 1
	local n = string(M[`g',1], "%5.0f")
	putdocx table table(`row',`col') = ("`n'"), halign(center)
}


// Severity
tabcount aesev_ received, v1(1 2 3) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_safety
forvalues g = 1(1)$groups_safety {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

tab aesev_ received, chi

local pv = string(r(p), "%5.3f")
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',4) = ("`pv'"), halign(center) 
}
if `pv' < 0.001 {
	putdocx table table(`row',4) = ("<0.001"), halign(center)
}
else if `pv' > 0.999 {
    putdocx table table(`row',4) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',4), shading(255 255 0)
} 

restore


**************************** PLAUSIBLE RELATIONSHIP ****************************

local row = 23

preserve

keep StudySubjectID received aeterm_*_ae aerel_*_ae complete_ae

drop if complete_ae == 0
drop complete_ae

rename aeterm_*_ae aeterm_*
rename aerel_*_ae aerel_*

reshape long aeterm_ aerel_, i(StudySubjectID) j(ae)
drop if missing(aeterm_)

// N
tab received, matcell(M)

forvalues g = 1(1)$groups_safety {
	local col = `g' + 1
	local n = string(M[`g',1], "%5.0f")
	putdocx table table(`row',`col') = ("`n'"), halign(center)
}

// Plausible relationship
tabcount aerel_ received, v1(1 2 3 4) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_safety
forvalues g = 1(1)$groups_safety {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

tab aerel_ received, exact

local pv = string(r(p_exact), "%5.3f")
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',4) = ("`pv'"), halign(center) 
}
if `pv' < 0.001 {
	putdocx table table(`row',4) = ("<0.001"), halign(center)
}
else if `pv' > 0.999 {
    putdocx table table(`row',4) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',4), shading(255 255 0)
}

restore


********************************* NUMBER OF SAES *******************************

local row = 29
tabcount saeyn received, c1(1 0) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups_safety {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

tab saeyn received, exact
local pv = string(r(p_exact), "%5.3f")
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row',4) = ("`pv'"), halign(center) 
}
if `pv' < 0.001 {
	putdocx table table(`row',4) = ("<0.001"), halign(center)
}
else if `pv' > 0.999 {
    putdocx table table(`row',4) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row',4), shading(255 255 0)
}

local row2 = `row' + 1
tabcount saecount received, c1(0 1 2 >=3) v2(1 2) zero matrix(MG)

matrix MGA = J(1,rowsof(MG),1) * MG
local levels = r(N)/$groups_safety
forvalues g = 1(1)$groups_safety {
	local row2 = `row'
	local col = `g' + 1
	forvalues l = 1(1)`levels' {
		local row2 = `row2' + 1
		local freq = string(MG[`l',`g'], "%5.0f")
		local perc = string((MG[`l',`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

********************************* MEDDRA CODING ********************************

preserve

keep StudySubjectID received pt_meddra* soc_meddra*

rename pt_meddra*_*_ae pt_meddra*_*
rename soc_meddra*_*_ae soc_meddra*_*

reshape long pt_meddra1_ soc_meddra1_ pt_meddra2_ soc_meddra2_ pt_meddra3_ soc_meddra3_ pt_meddra4_ soc_meddra4_ pt_meddra5_ soc_meddra5_ pt_meddra6_ soc_meddra6_ pt_meddra7_ soc_meddra7_ pt_meddra8_ soc_meddra8_, i(StudySubjectID) j(n)

drop n

rename pt_meddra*_ pt_meddra*
rename soc_meddra*_ soc_meddra*

gen id2 = _n

reshape long pt_meddra soc_meddra, i(id2) j(n)

drop id2 n

drop if pt_meddra == "" & soc_meddra == ""

replace pt_meddra = "Meningioma" if pt_meddra == " Meningioma"
replace pt_meddra = "Sepsis" if pt_meddra == " Sepsis"
replace pt_meddra = "zMissing" if pt_meddra == ""

replace soc_meddra = "Metabolism and nutrition disorders" if soc_meddra == "tabolism and nutrition disorders"
replace soc_meddra = "zMissing" if soc_meddra == ""

encode pt_meddra, gen(pt)
encode soc_meddra, gen(soc)

keep StudySubjectID received pt soc

putdocx sectionbreak
putdocx paragraph
putdocx text ("Table 11 Adverse events coded by MedDRA system organ class"), bold

putdocx table table = (2,4), headerrow(2) border(all, nil) border(top, single) layout(autofitcontents)

putdocx table table(1,2) = ("Group C"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1_safety)"), halign(center) bold
putdocx table table(1,3) = ("Group D"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2_safety)"), halign(center) bold
putdocx table table(1,4) = ("Overall"), halign(center) bold
putdocx table table(2,4) = ("(N=$N_safety)"), halign(center) bold

putdocx table table(1,1) = ("System Organ Class"), bold
putdocx table table(2,1) = ("Number of participants (%) number of events"), halign(right)

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)

local row = 2

levelsof soc, local(level1)

foreach l in `level1' {
	
	putdocx table table(`row',.), addrows(1)
	local row = `row' + 1
	
	local varlabel`l': label (soc) `l'
	putdocx table table(`row',1) = ("`varlabel`l''")
	putdocx table table(`row',.), border(top, single)
		
	forvalues g = 1(1)$groups_safety {
	local gp = `g' + 1
	tab StudySubjectID if received == `g' & soc == `l', nofreq
	local freq = string(r(r), "%5.0f")
	local perc = string((r(r)/${N`g'_safety})*100, "%5.1f")
	local events = string(r(N), "%5.0f")
	putdocx table table(`row',`gp') = ("`freq' (`perc') `events'"), halign(center)
	}
		
	local gp = `gp' + 1
	tab StudySubjectID if soc == `l', nofreq
	local freq = string(r(r), "%5.0f")
	local perc = string((r(r)/$N_safety )*100, "%5.1f")
	local events = string(r(N), "%5.0f")
	putdocx table table(`row',`gp') = ("`freq' (`perc') `events'"), halign(center)
}



putdocx sectionbreak
putdocx paragraph
putdocx text ("Appendix Adverse events coded by MedDRA system organ class and preferred term"), bold


putdocx table table = (2,4), headerrow(2) border(all, nil) border(top, single) layout(autofitcontents)

putdocx table table(1,2) = ("Group C"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1_safety)"), halign(center) bold
putdocx table table(1,3) = ("Group D"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2_safety)"), halign(center) bold
putdocx table table(1,4) = ("Overall"), halign(center) bold
putdocx table table(2,4) = ("(N=$N_safety)"), halign(center) bold

putdocx table table(1,1) = ("System Organ Class"), bold
putdocx table table(2,1) = ("Preferred Term, "), halign(right)
putdocx table table(2,1) = ("number of participants (%) number of events"), append halign(right) italic

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)

local row = 2

levelsof soc, local(level1)

foreach l in `level1' {
	
	putdocx table table(`row',.), addrows(1)
	local row = `row' + 1
	
	local varlabel`l': label (soc) `l'
	putdocx table table(`row',1) = ("`varlabel`l''"), bold
	putdocx table table(`row',.), border(top, single)
	
	levelsof pt if soc == `l', local(level2)
	
	foreach k in `level2' {
		
		putdocx table table(`row',.), addrows(1)
		local row = `row' + 1
		
		local varlab`k': label (pt) `k'
		putdocx table table(`row',1) = ("     `varlab`k''")
		
		forvalues g = 1(1)$groups_safety {
			local gp = `g' + 1
			tab StudySubjectID if received == `g' & soc == `l' & pt == `k', nofreq
			local freq = string(r(r), "%5.0f")
			local perc = string((r(r)/${N`g'_safety})*100, "%5.1f")
			local events = string(r(N), "%5.0f")
			putdocx table table(`row',`gp') = ("`freq' (`perc') `events'"), halign(center)
		}
		
		local gp = `gp' + 1
		tab StudySubjectID if soc == `l' & pt == `k', nofreq
		local freq = string(r(r), "%5.0f")
		local perc = string((r(r)/$N_safety )*100, "%5.1f")
		local events = string(r(N), "%5.0f")
		putdocx table table(`row',`gp') = ("`freq' (`perc') `events'"), halign(center)
	}
}

putdocx table table(`row',.), border(bottom, double)

restore



********************************************************************************
***************************** EXPLORATORY ANALYSES *****************************
********************************************************************************

putdocx sectionbreak
putdocx paragraph
putdocx text ("EXPLORATORY ANALYSES"), bold

/* TABLE 11 SUMMARY STATISTICS FOR THE EXPLORATORY ANALYSES */

putdocx paragraph
putdocx text ("Table 11 Summary statistics for the exploratory analyses"), bold

putdocx table table = (51,3)

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2)"), halign(center) bold

putdocx table table(3,1) = ("EXPLORAOTRY ANALYSES"), bold colspan(4)
putdocx table table(4,1) = ("Increase in creatinine ≥30% from baseline, n/N (%)"), bold colspan(2)
putdocx table table(5,1) = ("     Visit 1 - Week 1 follow-up")
putdocx table table(6,1) = ("     Visit 2 - Week 2 follow-up")
putdocx table table(7,1) = ("     Visit 3 - Week 4 follow-up")
putdocx table table(8,1) = ("     Visit 4 - Week 12 follow-up")
putdocx table table(9,1) = ("     Visit 5 - Month 6 follow-up"), bold
putdocx table table(10,1) = ("     Visit 6 - Week 39 follow-up")
putdocx table table(11,1) = ("     Visit 7 - Year 1 follow-up"), bold
putdocx table table(12,1) = ("     Visit 8 - Week 65 follow-up")
putdocx table table(13,1) = ("     Visit 9 - Week 78 follow-up")
putdocx table table(14,1) = ("     Visit 10 - Week 91 follow-up")
putdocx table table(15,1) = ("     Visit 11 - Year 2 follow-up"), bold
putdocx table table(16,1) = ("     Visit 12 - Week 117 follow-up")
putdocx table table(17,1) = ("     Visit 13 - Week 130 follow-up")
putdocx table table(18,1) = ("     Visit 14 - Week 143 follow-up")
putdocx table table(19,1) = ("     Visit 15 - Year 3 follow-up"), bold
putdocx table table(20,1) = ("Decrease in eGFR ≥25% from baseline, n/N (%)"), bold colspan(2)
putdocx table table(21,1) = ("     Visit 1 - Week 1 follow-up")
putdocx table table(22,1) = ("     Visit 2 - Week 2 follow-up")
putdocx table table(23,1) = ("     Visit 3 - Week 4 follow-up")
putdocx table table(24,1) = ("     Visit 4 - Week 12 follow-up")
putdocx table table(25,1) = ("     Visit 5 - Month 6 follow-up"), bold
putdocx table table(26,1) = ("     Visit 6 - Week 39 follow-up")
putdocx table table(27,1) = ("     Visit 7 - Year 1 follow-up"), bold
putdocx table table(28,1) = ("     Visit 8 - Week 65 follow-up")
putdocx table table(29,1) = ("     Visit 9 - Week 78 follow-up")
putdocx table table(30,1) = ("     Visit 10 - Week 91 follow-up")
putdocx table table(31,1) = ("     Visit 11 - Year 2 follow-up"), bold
putdocx table table(32,1) = ("     Visit 12 - Week 117 follow-up")
putdocx table table(33,1) = ("     Visit 13 - Week 130 follow-up")
putdocx table table(34,1) = ("     Visit 14 - Week 143 follow-up")
putdocx table table(35,1) = ("     Visit 15 - Year 3 follow-up"), bold
putdocx table table(36,1) = ("Decrease in eGFR ≥ 20% from previous reported, n/N (%)"), bold colspan(2)
putdocx table table(37,1) = ("     Visit 1 - Week 1 follow-up")
putdocx table table(38,1) = ("     Visit 2 - Week 2 follow-up")
putdocx table table(39,1) = ("     Visit 3 - Week 4 follow-up")
putdocx table table(40,1) = ("     Visit 4 - Week 12 follow-up")
putdocx table table(41,1) = ("     Visit 5 - Month 6 follow-up"), bold
putdocx table table(42,1) = ("     Visit 6 - Week 39 follow-up")
putdocx table table(43,1) = ("     Visit 7 - Year 1 follow-up"), bold
putdocx table table(44,1) = ("     Visit 8 - Week 65 follow-up")
putdocx table table(45,1) = ("     Visit 9 - Week 78 follow-up")
putdocx table table(46,1) = ("     Visit 10 - Week 91 follow-up")
putdocx table table(47,1) = ("     Visit 11 - Year 2 follow-up"), bold
putdocx table table(48,1) = ("     Visit 12 - Week 117 follow-up")
putdocx table table(49,1) = ("     Visit 13 - Week 130 follow-up")
putdocx table table(50,1) = ("     Visit 14 - Week 143 follow-up")
putdocx table table(51,1) = ("     Visit 15 - Year 3 follow-up"), bold


putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(19,.), border(bottom, single)
putdocx table table(35,.), border(bottom, single)
putdocx table table(51,.), border(bottom, double)

* Increase in creatinine ≥30% from baseline
local row = 4

foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
    tabcount creat30_`v' randgrp, c1(1 0) v2(1 2) zero matrix(MG)
	
	local row = `row' + 1
	
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
	    local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

* Decrease in eGFR ≥25% from baseline
local row = 20

foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
    tabcount eGFR25_`v' randgrp, c1(1 0) v2(1 2) zero matrix(MG)
	
	local row = `row' + 1
	
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
	    local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

* Decrease in eGFR ≥ 20% from previous reported
loca row = 36

foreach v in v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 {
    tabcount eGFR20_`v' randgrp, c1(1 0) v2(1 2) zero matrix(MG)
	
	local row = `row' + 1
	
	matrix MGA = J(1,rowsof(MG),1) * MG
	forvalues g = 1(1)$groups {
	    local col = `g' + 1
		local freq = string(MG[1,`g'], "%5.0f")
		local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
		local n = string(MGA[1,`g'], "%5.0f")
		putdocx table table(`row',`col') = ("`freq'/`n' (`perc')"), halign(center)
	}
}

putdocx table table(9,.), bold
putdocx table table(11,.), bold
putdocx table table(15,.), bold
putdocx table table(19,.), bold
putdocx table table(25,.), bold
putdocx table table(27,.), bold
putdocx table table(31,.), bold
putdocx table table(35,.), bold
putdocx table table(41,.), bold
putdocx table table(43,.), bold
putdocx table table(47,.), bold
putdocx table table(51,.), bold



********************************************************************************
****************************** ADDITIONAL ANALYSIS *****************************
********************************************************************************

putdocx sectionbreak
putdocx paragraph
putdocx text ("ADDITIONAL ANALYSIS"), bold

* Plot of the change in BP over time and by group

preserve

keep StudySubjectID randgrp sysbp_bl sysbp_v1 sysbp_v2 sysbp_v3 sysbp_v4 sysbp_v5 sysbp_v6 sysbp_v7 sysbp_v8 sysbp_v9 sysbp_v10 sysbp_v11 sysbp_v12 sysbp_v13 sysbp_v14 sysbp_v15

rename sysbp_bl sysbp_v0
rename sysbp_v* sysbp_*

reshape long sysbp_, i(StudySubjectID) j(visit)

egen mean = mean(sysbp_), by(randgrp visit)
egen sd = sd(sysbp_), by(randgrp visit)
gen lower = mean - sd
gen upper = mean + sd

replace visit = visit - 0.1 if randgrp == 1
replace visit = visit + 0.1 if randgrp == 2

twoway (scatter mean visit if randgrp == 1, mcolor(navy) lcolor(navy) connect(ascending)) (rcap lower upper visit if randgrp == 1, lcolor(navy)) (scatter mean visit if randgrp == 2, mcolor(maroon) lcolor(maroon) connect(ascending)) (rcap lower upper visit if randgrp == 2, lcolor(maroon)), xtitle("Follow-up visit", size(small)) ytitle("Office measurements of systolic blood pressure (mmHg)", size(small)) xlabel(0(1)15, labsize(small)) ylabel(110(5)160, labsize(small) angle(horizontal)) legend(order(1 "Spironolactone" 3 "Standard Care") size(small)) graphregion(color(white)) saving("4.Output\Change in BP_$today.gph", replace)
graph export "4.Output\Change in BP_$today.emf", replace
graph close

putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Change in office measurements of systolic blood pressure with standard deviation") halign(center)
putdocx table table(1,1) = image("4.Output\Change in BP_$today.emf")
putdocx table table(2,.), bold

restore


* Plot of the change in eGFR over time and by group

preserve

keep StudySubjectID randgrp eGFR_bl eGFR_v1 eGFR_v2 eGFR_v3 eGFR_v4 eGFR_v5 eGFR_v6 eGFR_v7 eGFR_v8 eGFR_v9 eGFR_v10 eGFR_v11 eGFR_v12 eGFR_v13 eGFR_v14 eGFR_v15

rename eGFR_bl eGFR_v0
rename eGFR_v* eGFR_*

reshape long eGFR_, i(StudySubjectID) j(visit)

egen mean = mean(eGFR_), by(randgrp visit)
egen sd = sd(eGFR_), by(randgrp visit)
gen lower = mean - sd
gen upper = mean + sd

replace visit = visit - 0.1 if randgrp == 1
replace visit = visit + 0.1 if randgrp == 2

twoway (scatter mean visit if randgrp == 1, mcolor(navy) lcolor(navy) connect(ascending)) (rcap lower upper visit if randgrp == 1, lcolor(navy)) (scatter mean visit if randgrp == 2, mcolor(maroon) lcolor(maroon) connect(ascending)) (rcap lower upper visit if randgrp == 2, lcolor(maroon)), xtitle("Follow-up visit", size(small)) ytitle("Estimated glomerular filtration rate (ml/min/1.73{sup:2})", size(small)) xlabel(0(1)15, labsize(small)) ylabel(32(3)53, labsize(small) angle(horizontal)) legend(order(1 "Spironolactone" 3 "Standard Care") size(small)) graphregion(color(white)) saving("4.Output\Change in eGFR_$today.gph", replace)
graph export "4.Output\Change in eGFR_$today_$today.emf", replace
graph close

putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Change in estimated glomerular filtration rate with standard deviation") halign(center)
putdocx table table(1,1) = image("4.Output\Change in eGFR_$today.emf")
putdocx table table(2,.), bold

restore



* Post hoc analysis is based on an a per-protocol principle and an on-treatment population

preserve

replace EPyn = 0 if EPtime_months > 3 * 12 
replace EPtime_months = 3 * 12 if EPtime_months > 3 * 12

gen date_wd = visdat_bl if lastvisit == 0
forvalues i = 1(1)15 {
	replace date_wd = visdat_v`i' if lastvisit == `i'
}
format date_wd %tdd_m_y

keep if lastvisit == 15 | (EPdeath == 1 & complete_wd == 0) | (lastvisit < 15 & complete_wd == 1 & date_wd < EPdate & EPyn == 1)
drop if lastvisit < 15 & complete_wd == 0 & EPyn == 0
drop if randgrp == 1 & adherence == 0 

tab randgrp, matcell(M)
global N1_posthoc = M[1,1]
global N2_posthoc = M[2,1]


/* TABLE 14 SUMMARY STATISTICS FOR THE ADDITIONAL ANALYSIS AND THE TREATMENT DIFFERENCE BETWEEN THE RANDOMISED ARMS */

putdocx paragraph
putdocx text ("Table 14 Summary statistics for the additional analyses and the treatment difference between the randomised groups"), bold

putdocx table table = (6,5), layout(autofitcontents) note("†Spironolactone versus standard care. 1Mixed effects Cox-proportional hazards model with an unstructured variance-covariance structure for the random effects, modelled against randomised arme as a fixed effect. ‡Level of significance = 0.05")

putdocx table table(1,2) = ("Spironolactone"), halign(center) bold
putdocx table table(2,2) = ("(N=$N1_posthoc)"), halign(center) bold
putdocx table table(1,3) = ("Standard Care"), halign(center) bold
putdocx table table(2,3) = ("(N=$N2_posthoc)"), halign(center) bold
putdocx table table(1,4) = ("Adjusted treatment difference [95% CI]†"), halign(center) bold
putdocx table table(1,5) = ("P-value‡"), halign(center) bold

putdocx table table(3,1) = ("POST HOC ANALYSIS"), bold colspan(5)
putdocx table table(4,1) = ("Primary endpoint, n/N (%) and median (IQR) (1)"), bold colspan(5)
putdocx table table(5,1) = ("     Experienced")
putdocx table table(6,1) = ("     Time at risk (incidence rate)")

putdocx table table(1,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(2,.), font(, , 0 0 0) shading(189 214 238)
putdocx table table(3,.), font(, , 255 255 255) shading(50 77 122)

putdocx table table(.,.), border(all, nil)
putdocx table table(1,.), border(top, single)
putdocx table table(2,.), border(bottom, single)
putdocx table table(3,.), border(bottom, single)
putdocx table table(6,.), border(bottom, double)

local row = 4

local row2 = `row' + 1
tabcount EPyn randgrp, c1(1 0) v2(1 2) zero matrix(MG)
matrix MGA = J(1,rowsof(MG),1) * MG
forvalues g = 1(1)$groups {
	local col = `g' + 1
	local freq = string(MG[1,`g'], "%5.0f")
	local perc = string((MG[1,`g']/MGA[1,`g'])*100, "%5.1f")
	local n = string(MGA[1,`g'], "%5.0f")
	putdocx table table(`row2',`col') = ("`freq'/`n' (`perc')"), halign(center)
}

putdocx table table(5,4) = ("-"), halign(center)
putdocx table table(5,5) = ("-"), halign(center)

stset EPtime_months, failure(EPyn == 1) id(StudySubjectID)

local row2 = `row' + 2
forvalues g = 1(1)$groups {
    stsum if randgrp == `g'
	local col = `g' + 1
	local risk = string(`r(risk)' / 12, "%5.1f")
	local ir = string(`r(ir)' * 12 * 100, "%5.2f")
	local n = string(`r(N_sub)', "%5.0f")
	putdocx table table(`row2',`col') = ("`risk' (`ir') [`n']"), halign(center)
}

sts graph, by(randgrp) failure title("", size(medsmall)) xtitle("Time (in months) from randomisation to the first primary endpoint event for the on-treatment population", size(small)) ytitle("Proportion of participants", size(small)) xlabel(0(3)36, labsize(vsmall)) ylabel(0(0.05)0.20, labsize(vsmall) angle(horizontal)) legend(order(1 "Spironolactone" 2 "Standard Care") size(small)) risktable(, order(1 "Spironolactone" 2 "Standard Care") size(vsmall)) ysize(1) xsize(2) graphregion(color(white))
graph save "4.Output\Kaplan-Meier curves\Additional KM curve_$today.gph", replace
graph export "4.Output\Kaplan-Meier curves\Additional KM curve_$today.emf", replace
graph close

stcox i.randgrp 

contrast ib2.randgrp, effect eform // Spironolactone versus Standard Care
matrix M = r(table)

local row2 = `row' + 2
local hr = string(M[1,1], "%5.2f")
local ll = string(M[5,1], "%5.2f")
local ul = string(M[6,1], "%5.2f")
local pv = string(M[4,1], "%5.3f")
putdocx table table(`row2',4) = ("`hr' [`ll' to `ul']"), halign(center)
if `pv' < 0.001 {
	putdocx table table(`row2',5) = ("<0.001"), halign(center)
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx table table(`row2',5) = ("`pv'"), halign(center)
}
else if `pv' > 0.999 {
	putdocx table table(`row2',5) = (">0.999"), halign(center)
}

if `pv' < 0.05 {
	putdocx table table(`row2',5), shading(255 255 0)
}

// Model residuals
stphplot, by(randgrp) ylabel(, angle(0)) legend(order(1 "Spironolactone" 2 "Standard Care"))
graph save "4.Output\Residual plots\Additional analysis log-log plot_$today.gph", replace
graph export "4.Output\Residual plots\Additional analysis log-log plot_$today.emf", replace
graph close

stcoxkm, by(randgrp) xtitle("Time (months) to first occurence of primary endpoint") ylabel(, angle(0)) legend(order(1 "Spironolactone Observed" 2 "Standard Care Observed" 3 "Spironolactone Predicted" 4 "Standard Care Predicited"))
graph save "4.Output\Residual plots\Additional analysis KM predicted survival plot_$today.gph", replace
graph export "4.Output\Residual plots\Additional analysis KM predicted survival plot_$today.emf", replace
graph close

estat phtest
local pv = string(r(p), "%5.3f")
putdocx paragraph
putdocx text ("Additional analysis "), bold
putdocx text ("test of proportional-hazards assumption ")
if `pv' < 0.001 {
	putdocx text ("P<0.001")
}
if `pv' >= 0.001 & `pv' <= 0.999 {
	putdocx text ("P=`pv'")
}
if `pv' > 0.999 {
	putdocx text ("P>0.999")
}

drop _st _d _t _t0

putdocx sectionbreak, landscape
putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Kaplan-Meier curve for the time (in months) from randomisation to the first primary endpoint for the post hoc analysis") halign(center)
putdocx table table(1,1) = image("4.Output\Kaplan-Meier curves\Additional KM curve_$today.emf")
putdocx table table(2,.), bold

putdocx sectionbreak, landscape
putdocx paragraph

putdocx table table = (9,14), layout(autofitcontents)

putdocx table table(1,1) = ("Month"), bold
putdocx table table(2,1) = ("Spironolactone"), bold
putdocx table table(3,1) = ("   At risk")
putdocx table table(4,1) = ("   Censored")
putdocx table table(5,1) = ("   Event")
putdocx table table(6,1) = ("Standard Care"), bold
putdocx table table(7,1) = ("   At risk")
putdocx table table(8,1) = ("   Censored")
putdocx table table(9,1) = ("   Event")

putdocx table table(.,.), border(all, nil)

local col = 1

local row = 2
local col = `col' + 1
putdocx table table(1,`col') = ("0"), halign(center) bold
local row2 = `row'
forvalues g = 1(1)$groups {
	count if EPtime_months > 0 & randgrp == `g' // At risk
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPtime_months >= 0 & EPtime_months <= 0 & EPyn == 0 & randgrp == `g' // Censored
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPtime_months >= 0 & EPtime_months <= 0 & EPyn == 1 & randgrp == `g' // Event
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	local row2 = `row2' + 1
}

foreach i in 3 6 9 12 15 18 21 24 27 30 33 36 {
	local row = 2
	local col = `col' + 1
	putdocx table table(1,`col') = ("`i'"), halign(center) bold
	local row2 = `row'
	forvalues g = 1(1)$groups {
		count if EPtime_months >= `i' & randgrp == `g' // At risk
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPtime_months >= 0 & EPtime_months < `i' & EPyn == 0 & randgrp == `g' // Censored
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPtime_months >= 0 & EPtime_months < `i' & EPyn == 1 & randgrp == `g' // Event
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		local row2 = `row2' + 1
	}
}

restore



********************************************************************************
*********************************** APPENDIX  **********************************
********************************************************************************

putdocx sectionbreak, landscape
putdocx paragraph
putdocx text ("APPENDIX"), bold


* KAPLAN-MEIER CURVES FOR THE PRIMARY ENDPOINT COMPONETS
putdocx paragraph
putdocx text ("APPENDIX. Kaplan-Meier Curves for the primary endpoint components"), bold

putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Kaplan-Meier curve for the time (in months) from randomisation to the first occurance of hospitalisation split by randomised arm") halign(center)
putdocx table table(1,1) = image("4.Output\Kaplan-Meier curves\Hospitalisation KM curve_$today.emf")
putdocx table table(2,.), bold 

putdocx sectionbreak, landscape
putdocx paragraph

putdocx table table = (9,17), layout(autofitcontents)

putdocx table table(1,1) = ("Month"), bold
putdocx table table(2,1) = ("Spironolactone"), bold
putdocx table table(3,1) = ("   At risk")
putdocx table table(4,1) = ("   Censored")
putdocx table table(5,1) = ("   Event")
putdocx table table(6,1) = ("Standard Care"), bold
putdocx table table(7,1) = ("   At risk")
putdocx table table(8,1) = ("   Censored")
putdocx table table(9,1) = ("   Event")

putdocx table table(.,.), border(all, nil)

local col = 1

local row = 2
local col = `col' + 1
putdocx table table(1,`col') = ("0"), halign(center) bold
local row2 = `row'
forvalues g = 1(1)$groups {
	count if EPhosptime_months > 0 & randgrp == `g' // At risk
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPhosptime_months >= 0 & EPhosptime_months <= 0 & EPhosp == 0 & randgrp == `g' // Censored
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPhosptime_months >= 0 & EPhosptime_months <= 0 & EPhosp == 1 & randgrp == `g' // Event
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	local row2 = `row2' + 1
}

foreach i in 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90 {
	local row = 2
	local col = `col' + 1
	putdocx table table(1,`col') = ("`i'"), halign(center) bold
	local row2 = `row'
	forvalues g = 1(1)$groups {
		count if EPhosptime_months >= `i' & randgrp == `g' // At risk
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPhosptime_months >= 0 & EPhosptime_months < `i' & EPhosp == 0 & randgrp == `g' // Censored
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPhosptime_months >= 0 & EPhosptime_months < `i' & EPhosp == 1 & randgrp == `g' // Event
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		local row2 = `row2' + 1
	}
}

putdocx sectionbreak, landscape
putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Kaplan-Meier curve for the time (in months) from randomisation to the first onset of cardivascular disease split by randomised arm") halign(center)
putdocx table table(1,1) = image("4.Output\Kaplan-Meier curves\Cardiovascular disease KM curve_$today.emf")
putdocx table table(2,.), bold 

putdocx sectionbreak, landscape
putdocx paragraph

putdocx table table = (9,18), layout(autofitcontents)

putdocx table table(1,1) = ("Month"), bold
putdocx table table(2,1) = ("Spironolactone"), bold
putdocx table table(3,1) = ("   At risk")
putdocx table table(4,1) = ("   Censored")
putdocx table table(5,1) = ("   Event")
putdocx table table(6,1) = ("Standard Care"), bold
putdocx table table(7,1) = ("   At risk")
putdocx table table(8,1) = ("   Censored")
putdocx table table(9,1) = ("   Event")

putdocx table table(.,.), border(all, nil)

local col = 1

local row = 2
local col = `col' + 1
putdocx table table(1,`col') = ("0"), halign(center) bold
local row2 = `row'
forvalues g = 1(1)$groups {
	count if EPcvdtime_months > 0 & randgrp == `g' // At risk
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPcvdtime_months >= 0 & EPcvdtime_months <= 0 & EPcvd == 0 & randgrp == `g' // Censored
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPcvdtime_months >= 0 & EPcvdtime_months <= 0 & EPcvd == 1 & randgrp == `g' // Event
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	local row2 = `row2' + 1
}

foreach i in 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90 96 {
	local row = 2
	local col = `col' + 1
	putdocx table table(1,`col') = ("`i'"), halign(center) bold
	local row2 = `row'
	forvalues g = 1(1)$groups {
		count if EPcvdtime_months >= `i' & randgrp == `g' // At risk
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPcvdtime_months >= 0 & EPcvdtime_months < `i' & EPcvd == 0 & randgrp == `g' // Censored
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPcvdtime_months >= 0 & EPcvdtime_months < `i' & EPcvd == 1 & randgrp == `g' // Event
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		local row2 = `row2' + 1
	}
}

putdocx sectionbreak, landscape
putdocx paragraph
putdocx table table = (1,1), border(all, nil) note("Figure: Kaplan-Meier curve for the time (in months) from randomisation to death split by randomised arm") halign(center)
putdocx table table(1,1) = image("4.Output\Kaplan-Meier curves\Death KM curve_$today.emf")
putdocx table table(2,.), bold 

putdocx sectionbreak, landscape
putdocx paragraph

putdocx table table = (9,17), layout(autofitcontents)

putdocx table table(1,1) = ("Month"), bold
putdocx table table(2,1) = ("Spironolactone"), bold
putdocx table table(3,1) = ("   At risk")
putdocx table table(4,1) = ("   Censored")
putdocx table table(5,1) = ("   Event")
putdocx table table(6,1) = ("Standard Care"), bold
putdocx table table(7,1) = ("   At risk")
putdocx table table(8,1) = ("   Censored")
putdocx table table(9,1) = ("   Event")

putdocx table table(.,.), border(all, nil)

local col = 1

local row = 2
local col = `col' + 1
putdocx table table(1,`col') = ("0"), halign(center) bold
local row2 = `row'
forvalues g = 1(1)$groups {
	count if EPdeathtime_months > 0 & randgrp == `g' // At risk
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPdeathtime_months >= 0 & EPdeathtime_months <= 0 & EPdeath == 0 & randgrp == `g' // Censored
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	count if EPdeathtime_months >= 0 & EPdeathtime_months <= 0 & EPdeath == 1 & randgrp == `g' // Event
	local row2 = `row2' + 1
	putdocx table table(`row2',`col') = ("`r(N)'")
	local row2 = `row2' + 1
}

foreach i in 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90 {
	local row = 2
	local col = `col' + 1
	putdocx table table(1,`col') = ("`i'"), halign(center) bold
	local row2 = `row'
	forvalues g = 1(1)$groups {
		count if EPdeathtime_months >= `i' & randgrp == `g' // At risk
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPdeathtime_months >= 0 & EPdeathtime_months < `i' & EPdeath == 0 & randgrp == `g' // Censored
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		count if EPdeathtime_months >= 0 & EPdeathtime_months < `i' & EPdeath == 1 & randgrp == `g' // Event
		local row2 = `row2' + 1
		putdocx table table(`row2',`col') = ("`r(N)'")
		local row2 = `row2' + 1
	}
}


* LOG-LOG PLOTS AND KAPLAN-MEIER PREDICTED SURVIVAL PLOTS TESTING THE PROPORTIONAL HAZARDS ASSUMPTIONS FOR THE PRIMARY ANALYSIS
putdocx sectionbreak
putdocx paragraph
putdocx text ("APPENDIX. Log-log plots and Kaplan-Meier predicted survival plots testing the proportional hazards assumption for the primary analysis"), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals fro the primary endpoint") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Primary endpoint log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Primary endpoint KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the primary endpoint component: hospitalisation") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Hospitalisation log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Hospitalisation KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the primary endpoint component: cardiovascular disease") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Cardiovascular disease log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Cardiovascular disease KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the primary endpoint component: death") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Death log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Death KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 


* HISOGRAMS AND QUANTILE-NORMAL PLOTS OF TRANSFORMATIONS ACCORDING TO THE LADDER OF POWERS FOR THE NON-NORMALLY DISTRIBUTED SECONDARY ENDPOINTS
putdocx sectionbreak
putdocx paragraph
putdocx text ("APPENDIX. Histograms and quantile-normal plots of transformations according to the ladder of powers for the non-normally distributed  secondary endpoints"), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Ladder-of-powers histograms and quantile-normal plots for B-type natruretic peptide at 3 years follow-up") halign(center)
putdocx table table(1,1) = image("4.Output\Ladder plots\BNP gladder_$today.emf")
putdocx table table(1,2) = image("4.Output\Ladder plots\BNP qladder_$today.emf")
putdocx table table(2,.), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Ladder-of-powers histograms and quantile-normal plots for albumin creatinine ratio at 3 years follow-up") halign(center)
putdocx table table(1,1) = image("4.Output\Ladder plots\ACR gladder_$today.emf")
putdocx table table(1,2) = image("4.Output\Ladder plots\ACR qladder_$today.emf")
putdocx table table(2,.), bold


* HISTOGRAMS OF THE SECONDARY ENDPOINTS BY RANDOMISED ARM AT EACH ASSESSMENT TIME POINT AND POST ESTIMATE PLOTS OF THE MODEL RESIDUALS FROM THE LINEAR MIXED EFFECTS MODELS
putdocx sectionbreak
putdocx paragraph
putdocx text ("APPENDIX. Histograms of the secondary endpoints by randomised arm at each assessment time point and post estimate plots of the model residuals from the linear mixed effects model"), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Histograms and model residuals for office measurements of systolic blood pressure") halign(center)
putdocx table table(1,1) = image("4.Output\Histograms\Office systolic BP_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Office systolic BP_$today.emf")
putdocx table table(2,.), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Histograms and model residuals for B-type natruretic peptide") halign(center)
putdocx table table(1,1) = image("4.Output\Histograms\BNP_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\BNP_$today.emf")
putdocx table table(2,.), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Histograms and model residuals for the logarithmic transformation of B-type natriuretic peptide") halign(center)
putdocx table table(1,1) = image("4.Output\Histograms\log BNP_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\log BNP_$today.emf")
putdocx table table(2,.), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Histograms and model residuals for albumin creatinine ratio") halign(center)
putdocx table table(1,1) = image("4.Output\Histograms\ACR_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\ACR_$today.emf")
putdocx table table(2,.), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Histograms and model residuals for the logarithmic transformation of albumin creatinine ratio") halign(center)
putdocx table table(1,1) = image("4.Output\Histograms\log ACR_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\log ACR_$today.emf")
putdocx table table(2,.), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Histograms and model residuals for estimated glomerular filtration rate") halign(center)
putdocx table table(1,1) = image("4.Output\Histograms\eGFR_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\eGFR_$today.emf")
putdocx table table(2,.), bold


* LOG-LOG PLOTS ANS KAPLAN-MEIER PREDICTED SURVIVAL PLOTS TESTING THE PROPORTIONAL HAZARDS ASSUMPTION FOR THE SENSITIVITY ANALYSIS
putdocx sectionbreak
putdocx paragraph
putdocx text ("APPENDIX. Log-log plots and Kaplan-Meier predicted survival plots testing the proportional hazards assumptions for the sensitivity analysis"), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the primary endpoint") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Sensitivity analysis log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Sensitivity analysis KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 


* LOG-LOG PLOTS AND KAPLAN-MEIER PREDICTED SURVIVAL PLOTS TESTING THE PROPORTIONAL HAZARDS ASSYMPTION FOR THE SUBGROUP ANALYSES
putdocx sectionbreak
putdocx paragraph
putdocx text ("APPENDIX. Log-log plots and Kaplan-Meier predicted survival plots testing the proportional hazards assumption for the subgroup analyses"), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the type II diabetes at baseline subgroup") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Diabetes subgroup log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Diabetes subgroup KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the coronary artery disease at baseline subgroup") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Coronary artery disease subgroup log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Coronary artery disease subgroup KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the blood pressure below/above the NICE target at baseline") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\NICE target subgroup log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\NICE target subgroup KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 


* LIST OF ADVERSE EVENTS

preserve

keep StudySubjectID received *_ae

rename *_ae *

reshape long aeterm_ aestdat_ aeout_ aeendat_ aesev_ aerel_ aeser_, i(StudySubjectID) j(ae)

egen miss = rownonmiss(ae*_), strok
drop if miss == 0 // No AE

sort StudySubjectID ae

drop ae miss

keep StudySubjectID aeterm_ aestdat_ aeendat_ aesev_ aeser_ aerel_ aeout_ received
order StudySubjectID aeterm_ aestdat_ aeendat_ aesev_ aeser_ aerel_ aeout_ received

label variable aeterm_ "Adverse Event"
label variable aestdat_ "Date of Onset"
label variable aeendat_ "Date of Resolution"
label variable aesev_ "Severity"
label variable aeser_ "Is the Adverse Event Serious?"
label variable aerel_ "Plauible relationship to study drug"
label variable aeout_ "Outcome"
label variable received "Intervention recieved"

export excel using "4.Output\List of adverse events_$today.xlsx", firstrow(varlabels) missing(" ") replace

export excel using "4.Output\List of adverse events related to study drug_$today.xlsx" if aerel_ == 2 | aerel_ == 3 | aerel_ == 4, firstrow(varlabels) missing(" ") replace

restore


* LIST OF SERIOUS ADVERSE EVENTS 
preserve

keep StudySubjectID received saeterm_*_new

rename *_new *

reshape long saeterm_, i(StudySubjectID) j(sae)

drop if missing(saeterm_)

sort StudySubjectID
keep StudySubjectID saeterm_ received
order StudySubjectID saeterm_ received

label variable saeterm_ "Serious Adverse Event"
label variable received "Intervention received"


export excel StudySubjectID saeterm_ received using "4.Output\List of serious adverse events_$today.xlsx", firstrow(varlabels) missing(" ") replace

restore


* LOG-LOG PLOTS AND KAPLAN-MEIER PREDICTED SURVIVAL PLOTS TESTING THE PROPORTIONAL HAZARDS ASSUMPTIONS FOR THE PRIMARY ANALYSIS
putdocx sectionbreak
putdocx paragraph
putdocx text ("APPENDIX. Log-log plots and Kaplan-Meier predicted survival plots testing the proportional hazards assumption for the additional analysis"), bold

putdocx paragraph
putdocx table table = (1,2), border(all, nil) note("Figure: Model residuals for the additional endpoint") halign(center)
putdocx table table(1,1) = image("4.Output\Residual plots\Additional analysis log-log plot_$today.emf")
putdocx table table(1,2) = image("4.Output\Residual plots\Additional analysis KM predicted survival plot_$today.emf")
putdocx table table(2,.), bold 



********************************************************************************
************************************* SAVE *************************************
********************************************************************************

putdocx save "4.Output\Stata putdocx output_$today.docx", replace

putexcel save

log close
