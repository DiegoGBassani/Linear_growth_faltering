
// PROJECT: Linear Growth Faltering Simulations
// PROGRAM: LGF_SimCode
// TASK: Simulate population datasets and generate stunting indicators
// Original code created by: Kelly Watson, The Hospital for Sick Children
// Updates by: Diego Bassani & Daniel Roth, The Hospital for Sick Children
// VERSION DATE: Nov 26, 2024

/* Table of contents: 
PART 1: Simulate datasets (w/ varying corr) and generate stunting incidence for Figure 1
PART 2: Simulate datasets (w/ varying corr) and generate stunting reversal for Figure 1
PART 3: Simulate datasets w/ varying starting LAZ and LAZ shifts and generate stunting indicators for Figures 2a and 3a
PART 4: Simulate datasets w/ varying starting LAZ and corr and generate stunting indicators for Figures 2b and 3b
PART 5: Generate LAZ-, stunting-, and growth delay-by-age trajectories for Figure 4
PART 6: Generate simulated dataset w/ missingness and calculate incidence - Table 1
*/

*Note: Parts 1-5 generate excel files which are called by the accompanying figure-generating R code (LGF_FigCode_20241126.R)

*****************************************
*****************************************
// PART 1: Simulate population dataset and generate stunting INCIDENCE at tri-monthly intervals (0-24mos) for Figure 1

*****************************************
*** Set parameters (empirical corr, mean LAZ, SD) to sim dataset
clear all
set seed 81625
set obs 10000
* Corr matrix- Anderson matrix 0-24mos at tri-monthly intervals
matrix I = (1.000, 0.767, 0.619, 0.535, 0.502, 0.488, 0.501, 0.494, 0.453)
matrix I = I\ (0.767, 1.000, 0.789, 0.697, 0.673, 0.655, 0.657, 0.646, 0.594)
matrix I = I\ (0.619, 0.789, 1.000, 0.879, 0.857, 0.833, 0.813, 0.793, 0.764)
matrix I = I\ (0.535, 0.697, 0.879, 1.000, 0.890, 0.869, 0.849, 0.830, 0.806)
matrix I = I\ (0.502, 0.673, 0.857, 0.890, 1.000, 0.893, 0.875, 0.855, 0.830)
matrix I = I\ (0.488, 0.655, 0.833, 0.869, 0.893, 1.000, 0.895, 0.877, 0.853)
matrix I = I\ (0.501, 0.657, 0.813, 0.849, 0.875, 0.895, 1.000, 0.897, 0.875)
matrix I = I\ (0.494, 0.646, 0.793, 0.830, 0.855, 0.877, 0.897, 1.000, 0.892)
matrix I = I\ (0.453, 0.594, 0.764, 0.806, 0.830, 0.853, 0.875, 0.892, 1.000)

* Mean LAZ:
matrix F1I = (-1.0000, -1.2667, -1.3674, -1.5382, -1.7607, -1.9175, -2.0906, -2.0772, -2.0141)
* SD:
matrix SDI = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)


*** Simulate population dataset using empirical correlation structure (matrix "I")
drawnorm laz0 laz3 laz6 laz9 laz12 laz15 laz18 laz21 laz24, means(F1I) sds(SDI) corr(I)


*** Calculate stunting incident onset (imperfect correlation)
count if laz0<-2
gen incident_0 = r(N)/100
* 0-3 month interval 
count if laz0>=-2 & laz3<-2
gen incident_0_3 = r(N)/100
* 3-6 month interval
count if laz0>=-2 & laz3>=-2 & laz6<-2
gen incident_3_6 =  r(N)/100
* 6-9 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9<-2
gen incident_6_9 =  r(N)/100
* 9-12 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12<-2
gen incident_9_12 =  r(N)/100
* 12-15 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15<-2
gen incident_12_15 =  r(N)/100
* 15-18 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15>=-2 & laz18<-2
gen incident_15_18 =  r(N)/100
* 18-21 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15>=-2 & laz18>=-2 & laz21<-2
gen incident_18_21 =  r(N)/100
* 21-24 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15>=-2 & laz18>=-2 & laz21>=-2 & laz24<-2
gen incident_21_24 =  r(N)/100

*****************************************
* Corr matrix - perfect matrix 0-24mos at tri-monthly intervals
matrix PI =   (1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)

*** Simulate population dataset using perfect correlation dataset (matrix "PI")
set seed 81625
drawnorm p_laz0 p_laz3 p_laz6 p_laz9 p_laz12 p_laz15 p_laz18 p_laz21 p_laz24, means(F1I) sds(SDI) corr(PI) 

*** Calculate stunting incident onset (perfect correlation)
count if p_laz0<-2
gen p_incident_0 = r(N)/100
* 0-3 month interval 
count if p_laz0>=-2 & p_laz3<-2
gen p_incident_0_3 = r(N)/100
* 3-6 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6<-2
gen p_incident_3_6 =  r(N)/100
* 6-9 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6>=-2 & p_laz9<-2
gen p_incident_6_9 =  r(N)/100
* 9-12 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6>=-2 & p_laz9>=-2 & p_laz12<-2
gen p_incident_9_12 =  r(N)/100
* 12-15 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6>=-2 & p_laz9>=-2 & p_laz12>=-2 & p_laz15<-2
gen p_incident_12_15 =  r(N)/100
* 15-18 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6>=-2 & p_laz9>=-2 & p_laz12>=-2 & p_laz15>=-2 & p_laz18<-2
gen p_incident_15_18 =  r(N)/100
* 18-21 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6>=-2 & p_laz9>=-2 & p_laz12>=-2 & p_laz15>=-2 & p_laz18>=-2 & p_laz21<-2
gen p_incident_18_21 =  r(N)/100
* 21-24 month interval
count if p_laz0>=-2 & p_laz3>=-2 & p_laz6>=-2 & p_laz9>=-2 & p_laz12>=-2 & p_laz15>=-2 & p_laz18>=-2 & p_laz21>=-2 & p_laz24<-2
gen p_incident_21_24 =  r(N)/100

drop p_laz* laz*
gen id = _n
drop if id!=1
reshape long incident_ p_incident_, i(id) j(age, string)

rename incident_ Sim_inc_imperf2
rename p_incident_ Sim_inc_perf1


* Reshape the dataset from wide to long format
reshape long Sim_inc_perf Sim_inc_imperf, i(age) j(metric)

*  Combine Incidence and Reversal into Metric
gen metric_value = Sim_inc_perf
replace metric_value = Sim_inc_imperf if metric == 2

gen Metric = "."
replace Metric="Sim_inc_perf" if metric==1
replace Metric="Sim_inc_imperf" if metric==2

rename metric_value Percent
split age, parse(_) generate(month)
drop month1 
rename month2 Month
destring Month, replace
drop Sim*
drop age metric id
recode Month .=0
save "LGF_Fig1a_Rdata_241126.dta", replace


*****************************************
*****************************************
// PART 2: Simulate population dataset and generate stunting REVERSAL at monthly intervals (0-15mos) for Figure 1

*****************************************
*** Set parameters (empirical corr, mean LAZ, SD) to sim dataset
clear all
set seed 81625
set obs 10000
* Corr - Anderson matrix 0-15mos at monthly intervals
matrix R = (1.000, 0.876, 0.820, 0.767, 0.716, 0.659, 0.619, 0.584, 0.553, 0.535, 0.522, 0.511, 0.502, 0.494, 0.490, 0.488)
matrix R =   R\ (0.876, 1.000, 0.857, 0.814, 0.769, 0.713, 0.671, 0.635, 0.602, 0.583, 0.572, 0.561, 0.553, 0.544, 0.539, 0.538)
matrix R =   R\ (0.820, 0.857, 1.000, 0.866, 0.831, 0.781, 0.740, 0.703, 0.668, 0.650, 0.641, 0.632, 0.623, 0.615, 0.610, 0.607)
matrix R =   R\ (0.767, 0.814, 0.866, 1.000, 0.867, 0.826, 0.789, 0.752, 0.715, 0.697, 0.688, 0.680, 0.673, 0.664, 0.659, 0.655)
matrix R =   R\ (0.716, 0.769, 0.831, 0.867, 1.000, 0.865, 0.834, 0.800, 0.765, 0.747, 0.737, 0.729, 0.723, 0.715, 0.709, 0.705)
matrix R =   R\ (0.659, 0.713, 0.781, 0.826, 0.865, 1.000, 0.871, 0.843, 0.813, 0.795, 0.784, 0.775, 0.768, 0.761, 0.756, 0.751)
matrix R =   R\ (0.619, 0.671, 0.740, 0.789, 0.834, 0.871, 1.000, 0.898, 0.887, 0.879, 0.872, 0.863, 0.857, 0.848, 0.841, 0.833)
matrix R =   R\ (0.584, 0.635, 0.703, 0.752, 0.800, 0.843, 0.898, 1.000, 0.899, 0.892, 0.885, 0.876, 0.870, 0.862, 0.855, 0.848)
matrix R =   R\ (0.553, 0.602, 0.668, 0.715, 0.765, 0.813, 0.887, 0.899, 1.000, 0.902, 0.896, 0.888, 0.881, 0.874, 0.867, 0.860)
matrix R =   R\ (0.535, 0.583, 0.650, 0.697, 0.747, 0.795, 0.879, 0.892, 0.902, 1.000, 0.903, 0.895, 0.890, 0.882, 0.876, 0.869)
matrix R =   R\ (0.522, 0.572, 0.641, 0.688, 0.737, 0.784, 0.872, 0.885, 0.896, 0.903, 1.000, 0.903, 0.897, 0.890, 0.884, 0.877)
matrix R =   R\ (0.511, 0.561, 0.632, 0.680, 0.729, 0.775, 0.863, 0.876, 0.888, 0.895, 0.903, 1.000, 0.905, 0.899, 0.893, 0.886)
matrix R =   R\ (0.502, 0.553, 0.623, 0.673, 0.723, 0.768, 0.857, 0.870, 0.881, 0.890, 0.897, 0.905, 1.000, 0.904, 0.898, 0.893)
matrix R =   R\ (0.494, 0.544, 0.615, 0.664, 0.715, 0.761, 0.848, 0.862, 0.874, 0.882, 0.890, 0.899, 0.904, 1.000, 0.904, 0.900)
matrix R =   R\ (0.490, 0.539, 0.610, 0.659, 0.709, 0.756, 0.841, 0.855, 0.867, 0.876, 0.884, 0.893, 0.898, 0.904, 1.000, 0.905)
matrix R =   R\ (0.488, 0.538, 0.607, 0.655, 0.705, 0.751, 0.833, 0.848, 0.860, 0.869, 0.877, 0.886, 0.893, 0.900, 0.905, 1.000)

* Mean LAZ
matrix F1R = (-0.8185, -0.8746, -0.9346, -0.9921, -1.0460, -1.1078, -1.1532, -1.2151, -1.2703, -1.3374, -1.4122	, -1.4880, -1.5654, -1.6343, -1.7017, -1.7549)
* SD
matrix SDR = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

*** Simulate population dataset using empirical correlation structure (matrix "R")
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15, means(F1R) sds(SDR) corr(R) 

*** Calculate stunting reversal
* Reversal not possible at birth
forvalues month = 0 (1) 14 {
	count if laz`month' <-2 & laz`=`month'+1' >=-2
	gen imp_rev_`month'_`=`month'+1' =  r(N)/100 
}

drop laz*
gen id = _n
drop if id!=1
reshape long imp_rev_ , i(id) j(age, string)

rename imp_rev_ Sim_rev_imperf1 


* Reshape the dataset from wide to long format
reshape long Sim_rev_imperf, i(age) j(metric)

*  Combine Incidence and Reversal into Metric
gen metric_value = Sim_rev_imperf


gen Metric = "."
replace Metric="Sim_rev_imperf" if metric==1

rename metric_value Percent
split age, parse(_) generate(month)
drop month1 
rename month2 Month
destring Month, replace
drop Sim*
drop age metric id
recode Month .=0
save "LGF_Fig1b_Rdata_241126.dta", replace

*****************************************
*** Set parameters (perfect corr, mean LAZ, SD) to sim dataset

clear all
set seed 81625
set obs 10000
* Corr - perfect matrix 0-15mos at monthly intervals
matrix PR =  (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
matrix PR =   PR\ (1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00)
* Mean LAZ
matrix F1R = (-0.8185, -0.8746, -0.9346, -0.9921, -1.0460, -1.1078, -1.1532, -1.2151, -1.2703, -1.3374, -1.4122	, -1.4880, -1.5654, -1.6343, -1.7017, -1.7549)
* SD
matrix SDR = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

*** Simulate population dataset using perfect correlation dataset (matrix "PR")
drawnorm p_laz0 p_laz1 p_laz2 p_laz3 p_laz4 p_laz5 p_laz6 p_laz7 p_laz8 p_laz9 p_laz10 p_laz11 p_laz12 p_laz13 p_laz14 p_laz15, means(F1R) sds(SDR) corr(PR) 

*** Calculate stunting reversal (perfect correlation)
* Reversal not possible at birth
forvalues month = 0 (1) 14 {
	count if p_laz`month' <-2 & p_laz`=`month'+1' >=-2
	gen perf_rev_`month'_`=`month'+1' =  r(N)/100 
}

drop p_laz*

gen id = _n
drop if id!=1
reshape long perf_rev_ , i(id) j(age, string)
rename perf_rev_ Sim_rev_perf1 

* Reshape the dataset from wide to long format
reshape long Sim_rev_perf, i(age) j(metric)

gen metric_value = Sim_rev_perf


gen Metric = "."
replace Metric="Sim_rev_perf" if metric==1

rename metric_value Percent
split age, parse(_) generate(month)
drop month1 
rename month2 Month
destring Month, replace
drop Sim*
drop age metric id
recode Month .=0
save "LGF_Fig1c_Rdata_241125.dta", replace

append using "LGF_Fig1a_Rdata_241126.dta" "LGF_Fig1b_Rdata_241126.dta"
save "LGF_Fig1_Rdata_241126.dta", replace

*****************************************
*Generate file with reported incident onset (HBGDKi paper - fig 2) and reported reversal (HBGDK paper - fig S12, using digipot)
*	for HBGDki South Asia pooled cohorts 

clear

input Month Percent str12 Metric
0 20 "Reported_inc"
0 . "Reported_rev"
1 . "Reported_inc"
1 4.3 "Reported_rev"
2 . "Reported_inc"
2 4.8 "Reported_rev"
3 18 "Reported_inc"
3 5.2 "Reported_rev"
4 . "Reported_inc"
4 4.6 "Reported_rev"
5 . "Reported_inc"
5 4.5 "Reported_rev"
6 10 "Reported_inc"
6 4.5 "Reported_rev"
7 . "Reported_inc"
7 4.1 "Reported_rev"
8 . "Reported_inc"
8 4 "Reported_rev"
9 6 "Reported_inc"
9 3.5 "Reported_rev"
10 . "Reported_inc"
10 2.9 "Reported_rev"
11 . "Reported_inc"
11 2.7 "Reported_rev"
12 7 "Reported_inc"
12 2.7 "Reported_rev"
13 . "Reported_inc"
13 2.9 "Reported_rev"
14 . "Reported_inc"
14 3.1 "Reported_rev"
15 6 "Reported_inc"
15 3.1 "Reported_rev"
16 . "Reported_inc"
16 . "Reported_rev"
17 . "Reported_inc"
17 . "Reported_rev"
18 5 "Reported_inc"
18 . "Reported_rev"
19 . "Reported_inc"
19 . "Reported_rev"
20 . "Reported_inc"
20 . "Reported_rev"
21 4 "Reported_inc"
21 . "Reported_rev"
22 . "Reported_inc"
22 . "Reported_rev"
23 . "Reported_inc"
23 . "Reported_rev"
24 4 "Reported_inc"
24 . "Reported_rev"
end


save "LGF_Fig1d_Rdata_241126.dta", replace

*Append simulated estimates
append using "LGF_Fig1_Rdata_241126.dta"
gsort Month Metric
save "LGF_Fig1_Rdata_241126.dta", replace
*****************************************

export excel using "LGF_Fig1_Rdata_241126.xlsx", replace first(var) keepcellfmt

*****************************************
*****************************************
// PART 3: Simulate multiple population datasets with varying distribution shifts and generate stunting indicators for Figure 2a and Figure 3a
*Note: Figure 3a is based on re-expressions of the same data used in Figure 2a


*** Set constant parameters for simulated population datasets
clear all
set seed 81625
set obs 10000
matrix CA = (1, .77 \ .77, 1) // Anderson corr (0-3mos)
matrix SDA = (1.1, 1.1) // Constant SD

*** Set varying parameters for the simulated population datasets
* Alter starting mean LAZ and change in mean LAZ for each dataset (25 total)
matrix MA1=(0,0)
matrix MA2=(0,-0.1)
matrix MA3=(0,-0.2)
matrix MA4=(0,-0.3)
matrix MA5=(0,-0.4)

matrix MA6=(-0.4,-0.4)
matrix MA7=(-0.4,-0.5)
matrix MA8=(-0.4,-0.6)
matrix MA9=(-0.4,-0.7)
matrix MA10=(-0.4,-0.8)

matrix MA11=(-0.8,-0.8)
matrix MA12=(-0.8,-0.9)
matrix MA13=(-0.8,-1)
matrix MA14=(-0.8,-1.1)
matrix MA15=(-0.8,-1.2)

matrix MA16=(-1.2,-1.2)
matrix MA17=(-1.2,-1.3)
matrix MA18=(-1.2,-1.4)
matrix MA19=(-1.2,-1.5)
matrix MA20=(-1.2,-1.6)

matrix MA21=(-1.6,-1.6)
matrix MA22=(-1.6,-1.7)
matrix MA23=(-1.6,-1.8)
matrix MA24=(-1.6,-1.9)
matrix MA25=(-1.6,-2)

*** Simulate dataset for variations of starting mean laz and laz shift 

***Loop over parameters
forvalues counter = 1 (1) 25 {
	drawnorm laz0_`counter' laz3_`counter', means(MA`counter') sds(SDA) seed(81625) corr(CA)
	scalar fe_`counter' = MA`counter'[1,1]
	scalar se_`counter' = MA`counter'[1,2]
	scalar change_`counter' = se_`counter' - fe_`counter'
	gen change_laz_`counter' = change_`counter'
	gen blaz_`counter' = fe_`counter'
	*** Calculate 'Incident stunting onset'
	count if laz0_`counter' >=-2 & laz3_`counter' <-2
	display r(N)/10000
	gen incidence_`counter' = r(N)/10000
	*** Calculate 'Stunting reversal'
	count if laz0_`counter' <-2 & laz3_`counter' >=-2
	display r(N)/10000
	gen reversal_`counter' = r(N)/10000
}

drop laz*
gen id = _n
keep if id==1

* Reshape the dataset from wide to long format
reshape long incidence_ reversal_ blaz_ change_laz_, i(id) j(matrix)

rename incidence_ Incidence1 
rename reversal_ Reversal2
rename change_laz_ change_laz
rename blaz_ laz0

* Reshape the dataset from wide to long format
reshape long Incidence Reversal, i(change_laz laz0) j(metric)

*  Combine Incidence and Reversal into Metric
gen metric_value = Incidence
replace metric_value = Reversal if metric == 2

gen Metric = "."
replace Metric="Incidence" if metric==1
replace Metric="Reversal" if metric==2

rename metric_value prop
generate percentage = prop*100

gsort -laz0 -change_laz Metric

* Drop variables
drop Incidence Reversal
drop matrix
drop metric
drop id

*Calculate ratios for Figure 3a (using same data as used for Figure 2a)
*Reference values are for change in LAZ = 0 and the corresponding LAZ at birth

gen inc_refa_0=percentage if change_laz==float(0) & laz0==float(0) & Metric=="Incidence"
egen inc_refb_0=max(inc_refa_0)
gen inc_ref=inc_refb_0 if laz0==float(0) & Metric=="Incidence"

gen inc_refa_04=percentage if change_laz==float(0) & laz0==float(-0.4) & Metric=="Incidence"
egen inc_refb_04=max(inc_refa_04)
replace inc_ref=inc_refb_04 if laz0==float(-0.4) & Metric=="Incidence"

gen inc_refa_08=percentage if change_laz==float(0) & laz0==float(-0.8) & Metric=="Incidence"
egen inc_refb_08=max(inc_refa_08)
replace inc_ref=inc_refb_08 if laz0==float(-0.8) & Metric=="Incidence"

gen inc_refa_12=percentage if change_laz==float(0) & laz0==float(-1.2) & Metric=="Incidence"
egen inc_refb_12=max(inc_refa_12)
replace inc_ref=inc_refb_12 if laz0==float(-1.2) & Metric=="Incidence"

gen inc_refa_16=percentage if change_laz==float(0) & laz0==float(-1.6) & Metric=="Incidence"
egen inc_refb_16=max(inc_refa_16)
replace inc_ref=inc_refb_16 if laz0==float(-1.6) & Metric=="Incidence"

gen rev_refa_0=percentage if change_laz==float(0) & laz0==float(0) & Metric=="Reversal"
egen rev_refb_0=max(rev_refa_0)
gen rev_ref=rev_refb_0 if laz0==float(0) & Metric=="Reversal"

gen rev_refa_04=percentage if change_laz==float(0) & laz0==float(-0.4) & Metric=="Reversal"
egen rev_refb_04=max(rev_refa_04)
replace rev_ref=rev_refb_04 if laz0==float(-0.4) & Metric=="Reversal"

gen rev_refa_08=percentage if change_laz==float(0) & laz0==float(-0.8) & Metric=="Reversal"
egen rev_refb_08=max(rev_refa_08)
replace rev_ref=rev_refb_08 if laz0==float(-0.8) & Metric=="Reversal"

gen rev_refa_12=percentage if change_laz==float(0) & laz0==float(-1.2) & Metric=="Reversal"
egen rev_refb_12=max(rev_refa_12)
replace rev_ref=rev_refb_12 if laz0==float(-1.2) & Metric=="Reversal"

gen rev_refa_16=percentage if change_laz==float(0) & laz0==float(-1.6) & Metric=="Reversal"
egen rev_refb_16=max(rev_refa_16)
replace rev_ref=rev_refb_16 if laz0==float(-1.6) & Metric=="Reversal"

capture drop inc_refa* inc_refb* inc_refb_*
capture drop rev_refa* rev_refb* rev_refb_*

*Calculate ratios (always >1)
gen inc_ratio=percentage/inc_ref 
gen rev_ratio=percentage/rev_ref if percentage>=rev_ref
replace rev_ratio=rev_ref/percentage if percentage<rev_ref

gen Ratio=inc_ratio
replace Ratio=rev_ratio if Ratio==.

capture drop inc_ref rev_ref
capture drop inc_ratio rev_ratio

export excel using "LGF_Fig2a3a_Rdata_241126.xlsx", replace first(var) keepcellfmt



*****************************************
*****************************************
// PART 4: Simulate multiple population datasets with varying correlations and generate stunting indicators for Figure 2b and Figure 3b
*Note: Figure 3b is based on re-expressions of the same data used in Figure 2b

*** Set constant parameters for simulated population datasets
clear all
set seed 81625
set obs 10000
matrix SDB = (1.1, 1.1) // Constant SD

*** Set varying parameters for the simulated population datasets
* Alter correlation matrix
matrix CB1 = (1, .6 \ .6, 1) 
matrix CB2 = (1, .7 \ .7, 1) 
matrix CB3 = (1, .8 \ .8, 1)
matrix CB4 = (1, .9 \ .9, 1)
matrix CB5 = (1, 1 \ 1, 1)  
* Alter starting LAZ (holding LAZ shift constant at -0.2)
matrix MB1 = (0, -0.2)
matrix MB2 = (-0.4, -0.6)
matrix MB3 = (-0.8, -1)
matrix MB4 = (-1.2, -1.4)
matrix MB5 = (-1.6, -1.8)



***Loop over parameters
forvalues counter = 1 (1) 5 {
	forvalues counter_c = 1 (1) 5 {
	drawnorm laz0_`counter'_`counter_c' laz3_`counter'_`counter_c', means(MB`counter') sds(SDB) seed(81625) corr(CB`counter_c')
	scalar fe_`counter'_`counter_c' = MB`counter'[1,1]
	scalar se_`counter'_`counter_c' = MB`counter'[1,2]
	scalar change_`counter'_`counter_c' = se_`counter'_`counter_c' - fe_`counter'_`counter_c'
	scalar corr_`counter'_`counter_c' = CB`counter_c'[1,2]
	gen corr_`counter'_`counter_c' = corr_`counter'_`counter_c'
	gen change_laz_`counter'_`counter_c' = change_`counter'_`counter_c'
	gen blaz_`counter'_`counter_c' = fe_`counter'_`counter_c'
	*** Calculate 'Incident stunting onset'
	count if laz0_`counter'_`counter_c' >=-2 & laz3_`counter'_`counter_c' <-2
	display r(N)/10000
	gen incidence_`counter'_`counter_c' = r(N)/10000
	*** Calculate 'Stunting reversal'
	count if laz0_`counter'_`counter_c' <-2 & laz3_`counter'_`counter_c' >=-2
	display r(N)/10000
	gen reversal_`counter'_`counter_c' = r(N)/10000
}
}
drop laz*
gen id = _n
keep if id==1

* Reshape the dataset from wide to long format
reshape long incidence_ reversal_ corr_ blaz_ change_laz_, i(id) j(matrix, string)

rename incidence_ Incidence1 
rename reversal_ Reversal2
rename corr_ correlation3
rename change_laz_ change_laz
rename blaz_ laz0

* Reshape the dataset from wide to long format
reshape long Incidence Reversal correlation, i(change_laz laz0 correlation) j(metric)

*  Combine Incidence and Reversal into Metric
gen metric_value = Incidence
replace metric_value = Reversal if metric == 2

gen Metric = "."
replace Metric="Incidence" if metric==1
replace Metric="Reversal" if metric==2

rename metric_value prop
generate percentage = prop*100

drop if percentage==.

gsort Metric -laz0 correlation

* Drop variables
drop Incidence Reversal
drop matrix
drop metric
drop id
drop correlation
drop change_laz

rename correlation3 correlation
rename laz0 LAZ0
order correlation percentage Metric LAZ0

gsort Metric -LAZ0 correlation

*Calculate ratios for Figure 3b
*Reference values are for correlation coefficient = 0.9 and the corresponding LAZ at birth

gen inc_refa_0=percentage if correlation==float(0.9) & LAZ0==float(0) & Metric=="Incidence"
egen inc_refb_0=max(inc_refa_0)
gen inc_ref=inc_refb_0 if LAZ0==float(0) & Metric=="Incidence"

gen inc_refa_04=percentage if correlation==float(0.9) & LAZ0==float(-0.4) & Metric=="Incidence"
egen inc_refb_04=max(inc_refa_04)
replace inc_ref=inc_refb_04 if LAZ0==float(-0.4) & Metric=="Incidence"

gen inc_refa_08=percentage if correlation==float(0.9) & LAZ0==float(-0.8) & Metric=="Incidence"
egen inc_refb_08=max(inc_refa_08)
replace inc_ref=inc_refb_08 if LAZ0==float(-0.8) & Metric=="Incidence"

gen inc_refa_12=percentage if correlation==float(0.9) & LAZ0==float(-1.2) & Metric=="Incidence"
egen inc_refb_12=max(inc_refa_12)
replace inc_ref=inc_refb_12 if LAZ0==float(-1.2) & Metric=="Incidence"

gen inc_refa_16=percentage if correlation==float(0.9) & LAZ0==float(-1.6) & Metric=="Incidence"
egen inc_refb_16=max(inc_refa_16)
replace inc_ref=inc_refb_16 if LAZ0==float(-1.6) & Metric=="Incidence"

gen rev_refa_0=percentage if correlation==float(0.9) & LAZ0==float(0) & Metric=="Reversal"
egen rev_refb_0=max(rev_refa_0)
gen rev_ref=rev_refb_0 if LAZ0==float(0) & Metric=="Reversal"

gen rev_refa_04=percentage if correlation==float(0.9) & LAZ0==float(-0.4) & Metric=="Reversal"
egen rev_refb_04=max(rev_refa_04)
replace rev_ref=rev_refb_04 if LAZ0==float(-0.4) & Metric=="Reversal"

gen rev_refa_08=percentage if correlation==float(0.9) & LAZ0==float(-0.8) & Metric=="Reversal"
egen rev_refb_08=max(rev_refa_08)
replace rev_ref=rev_refb_08 if LAZ0==float(-0.8) & Metric=="Reversal"

gen rev_refa_12=percentage if correlation==float(0.9) & LAZ0==float(-1.2) & Metric=="Reversal"
egen rev_refb_12=max(rev_refa_12)
replace rev_ref=rev_refb_12 if LAZ0==float(-1.2) & Metric=="Reversal"

gen rev_refa_16=percentage if correlation==float(0.9) & LAZ0==float(-1.6) & Metric=="Reversal"
egen rev_refb_16=max(rev_refa_16)
replace rev_ref=rev_refb_16 if LAZ0==float(-1.6) & Metric=="Reversal"

capture drop inc_refa* inc_refb* inc_refb_*
capture drop rev_refa* rev_refb* rev_refb_*
*capture drop inc_ref rev_ref

*Calculate ratios (always >1)
gen inc_ratio=percentage/inc_ref if percentage>=inc_ref
replace inc_ratio=inc_ref/percentage if percentage<inc_ref
gen rev_ratio=percentage/rev_ref if percentage>=rev_ref
replace rev_ratio=rev_ref/percentage if percentage<rev_ref

gen Ratio=inc_ratio
replace Ratio=rev_ratio if Ratio==.

capture drop inc_ref rev_ref
capture drop inc_ratio rev_ratio

export excel using "LGF_Fig2b3b_Rdata_241126.xlsx", replace first(var) keepcellfmt

*****************************************
*****************************************
// PART 5: Generate LAZ-, stunting-, and growth delay-by-age trajectories for Figure 4 (3-23mos)

* Set parameters for simulated dataset used in Figure 4
clear all
set seed 81625
set obs 10000

matrix M4 = (-0.9921, -1.0460, -1.1078, -1.1532, -1.2151, -1.2703, -1.3374, -1.4122	, -1.4880, -1.5654, -1.6343, -1.7017, -1.7549, -1.8096, -1.8518, -1.8908, -1.9242, -1.9515, -1.9603, -1.9577, -1.9400)

matrix SD45 = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

matrix C45 = (1.000, 0.867, 0.826, 0.789, 0.752, 0.715, 0.697, 0.688, 0.680, 0.673, 0.664, 0.659, 0.655, 0.654, 0.654, 0.657, 0.655, 0.652, 0.646, 0.634, 0.617)
matrix C45 = C45 \ (0.867, 1.000, 0.865, 0.834, 0.800, 0.765, 0.747, 0.737, 0.729, 0.723, 0.715, 0.709, 0.705, 0.701, 0.699, 0.700, 0.696, 0.692, 0.686, 0.673, 0.655)
matrix C45 = C45 \ (0.826, 0.865, 1.000, 0.871, 0.843, 0.813, 0.795, 0.784, 0.775, 0.768, 0.761, 0.756, 0.751, 0.745, 0.739, 0.738, 0.733, 0.728, 0.721, 0.708, 0.690)
matrix C45 = C45 \ (0.789, 0.834, 0.871, 1.000, 0.898, 0.887, 0.879, 0.872, 0.863, 0.857, 0.848, 0.841, 0.833, 0.825, 0.817, 0.813, 0.805, 0.799, 0.793, 0.784, 0.775)
matrix C45 = C45 \ (0.752, 0.800, 0.843, 0.898, 1.000, 0.899, 0.892, 0.885, 0.876, 0.870, 0.862, 0.855, 0.848, 0.839, 0.832, 0.828, 0.820, 0.814, 0.808, 0.799, 0.792)
matrix C45 = C45 \ (0.715, 0.765, 0.813, 0.887, 0.899, 1.000, 0.902, 0.896, 0.888, 0.881, 0.874, 0.867, 0.860, 0.851, 0.844, 0.840, 0.832, 0.827, 0.821, 0.812, 0.806)
matrix C45 = C45 \ (0.697, 0.747, 0.795, 0.879, 0.892, 0.902, 1.000, 0.903, 0.895, 0.890, 0.882, 0.876, 0.869, 0.860, 0.853, 0.849, 0.841, 0.835, 0.830, 0.821, 0.815)
matrix C45 = C45 \ (0.688, 0.737, 0.784, 0.872, 0.885, 0.896, 0.903, 1.000, 0.903, 0.897, 0.890, 0.884, 0.877, 0.869, 0.862, 0.857, 0.850, 0.844, 0.838, 0.830, 0.824)
matrix C45 = C45 \ (0.680, 0.729, 0.775, 0.863, 0.876, 0.888, 0.895, 0.903, 1.000, 0.905, 0.899, 0.893, 0.886, 0.879, 0.872, 0.867, 0.860, 0.854, 0.848, 0.839, 0.833)
matrix C45 = C45 \ (0.673, 0.723, 0.768, 0.857, 0.870, 0.881, 0.890, 0.897, 0.905, 1.000, 0.904, 0.898, 0.893, 0.886, 0.880, 0.875, 0.867, 0.861, 0.855, 0.846, 0.840)
matrix C45 = C45 \ (0.664, 0.715, 0.761, 0.848, 0.862, 0.874, 0.882, 0.890, 0.899, 0.904, 1.000, 0.904, 0.900, 0.894, 0.888, 0.883, 0.876, 0.870, 0.864, 0.855, 0.848)
matrix C45 = C45 \ (0.659, 0.709, 0.756, 0.841, 0.855, 0.867, 0.876, 0.884, 0.893, 0.898, 0.904, 1.000, 0.905, 0.900, 0.894, 0.889, 0.882, 0.877, 0.871, 0.862, 0.855)
matrix C45 = C45 \ (0.655, 0.705, 0.751, 0.833, 0.848, 0.860, 0.869, 0.877, 0.886, 0.893, 0.900, 0.905, 1.000, 0.904, 0.898, 0.895, 0.888, 0.883, 0.877, 0.869, 0.862)
matrix C45 = C45 \ (0.654, 0.701, 0.745, 0.825, 0.839, 0.851, 0.860, 0.869, 0.879, 0.886, 0.894, 0.900, 0.904, 1.000, 0.904, 0.900, 0.895, 0.891, 0.886, 0.878, 0.871)
matrix C45 = C45 \ (0.654, 0.699, 0.739, 0.817, 0.832, 0.844, 0.853, 0.862, 0.872, 0.880, 0.888, 0.894, 0.898, 0.904, 1.000, 0.905, 0.900, 0.896, 0.892, 0.884, 0.878)
matrix C45 = C45 \ (0.657, 0.700, 0.738, 0.813, 0.828, 0.840, 0.849, 0.857, 0.867, 0.875, 0.883, 0.889, 0.895, 0.900, 0.905, 1.000, 0.905, 0.901, 0.897, 0.890, 0.884)
matrix C45 = C45 \ (0.655, 0.696, 0.733, 0.805, 0.820, 0.832, 0.841, 0.850, 0.860, 0.867, 0.876, 0.882, 0.888, 0.895, 0.900, 0.905, 1.000, 0.906, 0.902, 0.896, 0.890)
matrix C45 = C45 \ (0.652, 0.692, 0.728, 0.799, 0.814, 0.827, 0.835, 0.844, 0.854, 0.861, 0.870, 0.877, 0.883, 0.891, 0.896, 0.901, 0.906, 1.000, 0.905, 0.900, 0.894)
matrix C45 = C45 \ (0.646, 0.686, 0.721, 0.793, 0.808, 0.821, 0.830, 0.838, 0.848, 0.855, 0.864, 0.871, 0.877, 0.886, 0.892, 0.897, 0.902, 0.905, 1.000, 0.903, 0.898)
matrix C45 = C45 \ (0.634, 0.673, 0.708, 0.784, 0.799, 0.812, 0.821, 0.830, 0.839, 0.846, 0.855, 0.862, 0.869, 0.878, 0.884, 0.890, 0.896, 0.900, 0.903, 1.000, 0.903)
matrix C45 = C45 \ (0.617, 0.655, 0.690, 0.775, 0.792, 0.806, 0.815, 0.824, 0.833, 0.840, 0.848, 0.855, 0.862, 0.871, 0.878, 0.884, 0.890, 0.894, 0.898, 0.903, 1.000)


* Simulate dataset used in Figure 4
drawnorm laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23, means(M4) sds(SD45) corr(C45) forcepsd

gen age_mos=_n // this does not correspond to the existing variables in the dataset; it's used to document the following calculations:

*** Calculate stunting prevalence-by-age 
* 3-months
count if laz3<-2 
gen stunt_prop = r(N)/10000 if age_mos==3
* 4-months
count if laz4<-2
replace stunt_prop = r(N)/10000 if age_mos==4
* 5-months
count if laz5<-2
replace stunt_prop = r(N)/10000 if age_mos==5
* 6-months
count if laz6<-2
replace stunt_prop = r(N)/10000 if age_mos==6
* 7-months
count if laz7<-2
replace stunt_prop = r(N)/10000 if age_mos==7
* 8-months
count if laz8<-2
replace stunt_prop = r(N)/10000 if age_mos==8
* 9-months
count if laz9<-2
replace stunt_prop = r(N)/10000 if age_mos==9
* 10-months
count if laz10<-2
replace stunt_prop = r(N)/10000 if age_mos==10
* 11-months
count if laz11<-2
replace stunt_prop = r(N)/10000 if age_mos==11
* 12-months
count if laz12<-2
replace stunt_prop = r(N)/10000 if age_mos==12
* 13-months
count if laz13<-2
replace stunt_prop = r(N)/10000 if age_mos==13
* 14-months
count if laz14<-2
replace stunt_prop = r(N)/10000 if age_mos==14
* 15-months
count if laz15<-2
replace stunt_prop = r(N)/10000 if age_mos==15
* 16-months
count if laz16<-2
replace stunt_prop = r(N)/10000 if age_mos==16
* 17-months
count if laz17<-2
replace stunt_prop = r(N)/10000 if age_mos==17
* 18-months
count if laz18<-2
replace stunt_prop = r(N)/10000 if age_mos==18
* 19-months
count if laz19<-2
replace stunt_prop = r(N)/10000 if age_mos==19
* 20-months
count if laz20<-2
replace stunt_prop = r(N)/10000 if age_mos==20
* 21-months
count if laz21<-2
replace stunt_prop = r(N)/10000 if age_mos==21
* 22-months
count if laz22<-2
replace stunt_prop = r(N)/10000 if age_mos==22
* 23-months
count if laz23<-2
replace stunt_prop = r(N)/10000 if age_mos==23

*** Calculate mean growth delay-by-age (in months)
* Growth delay = chronological age - height-age (means)
* First generate mean chronological age at each time point (assuming avg age = timepoint converted to days)
gen age3=91   // (03*30.4375 = 91.3125)
gen age4=122  // (04*30.4375 = 121.75)
gen age5=152  // (05*30.4375 = 152.1875)
gen age6=183  // (06*30.4375 = 182.625)
gen age7=213  // (07*30.4375 = 213.0625)
gen age8=244  // (08*30.4375 = 243.5)
gen age9=274  // (09*30.4375 = 273.9375)
gen age10=304 // (10*30.4375 = 304.375)
gen age11=335 // (11*30.4375 = 334.8125)
gen age12=365 // (12*30.4375 = 365.25)
gen age13=396 // (13*30.4375 = 395.6875)
gen age14=426 // (14*30.4375 = 426.125)
gen age15=457 // (15*30.4375 = 456.5625)
gen age16=487 // (16*30.4375 = 487)
gen age17=517 // (17*30.4375 = 517.4375)
gen age18=548 // (18*30.4375 = 547.875)
gen age19=578 // (19*30.4375 = 578.3125)
gen age20=609 // (20*30.4375 = 608.75)
gen age21=639 // (21*30.4375 = 639.1875)
gen age22=670 // (22*30.4375 = 669.625)
gen age23=700 // (23*30.4375 = 700.0625)

* Then calculate mean laz at each age, as will be calc. height-age from mean LAZ
egen m_laz =mean(laz3)
replace m_laz=. if age_mos!=3

* Then format age in days in same row as associated mean LAZ
gen age_days=age3
replace age_days=. if age_mos!=3

* Repeat at all ages (3-23 mos)
egen m_laz4 =mean(laz4)
gen age_days4=age4
replace m_laz=m_laz4 if age_mos==4
replace age_days=age_days4 if age_mos==4
drop m_laz4 age_days4

egen m_laz5 =mean(laz5)
gen age_days5=age5
replace m_laz=m_laz5 if age_mos==5
replace age_days=age_days5 if age_mos==5
drop m_laz5 age_days5

egen m_laz6 =mean(laz6)
gen age_days6=age6
replace m_laz=m_laz6 if age_mos==6
replace age_days=age_days6 if age_mos==6
drop m_laz6 age_days6

egen m_laz7 =mean(laz7)
gen age_days7=age7
replace m_laz=m_laz7 if age_mos==7
replace age_days=age_days7 if age_mos==7
drop m_laz7 age_days7

egen m_laz8 =mean(laz8)
gen age_days8=age8
replace m_laz=m_laz8 if age_mos==8
replace age_days=age_days8 if age_mos==8
drop m_laz8 age_days8

egen m_laz9 =mean(laz9)
gen age_days9=age9
replace m_laz=m_laz9 if age_mos==9
replace age_days=age_days9 if age_mos==9
drop m_laz9 age_days9

egen m_laz10 =mean(laz10)
gen age_days10=age10
replace m_laz=m_laz10 if age_mos==10
replace age_days=age_days10 if age_mos==10
drop m_laz10 age_days10

egen m_laz11 =mean(laz11)
gen age_days11=age11
replace m_laz=m_laz11 if age_mos==11
replace age_days=age_days11 if age_mos==11
drop m_laz11 age_days11

egen m_laz12 =mean(laz12)
gen age_days12=age12
replace m_laz=m_laz12 if age_mos==12
replace age_days=age_days12 if age_mos==12
drop m_laz12 age_days12

egen m_laz13 =mean(laz13)
gen age_days13=age13
replace m_laz=m_laz13 if age_mos==13
replace age_days=age_days13 if age_mos==13
drop m_laz13 age_days13

egen m_laz14 =mean(laz14)
gen age_days14=age14
replace m_laz=m_laz14 if age_mos==14
replace age_days=age_days14 if age_mos==14
drop m_laz14 age_days14

egen m_laz15 =mean(laz15)
gen age_days15=age15
replace m_laz=m_laz15 if age_mos==15
replace age_days=age_days15 if age_mos==15
drop m_laz15 age_days15

egen m_laz16 =mean(laz16)
gen age_days16=age16
replace m_laz=m_laz16 if age_mos==16
replace age_days=age_days16 if age_mos==16
drop m_laz16 age_days16

egen m_laz17 =mean(laz17)
gen age_days17=age17
replace m_laz=m_laz17 if age_mos==17
replace age_days=age_days17 if age_mos==17
drop m_laz17 age_days17

egen m_laz18 =mean(laz18)
gen age_days18=age18
replace m_laz=m_laz18 if age_mos==18
replace age_days=age_days18 if age_mos==18
drop m_laz18 age_days18

egen m_laz19 =mean(laz19)
gen age_days19=age19
replace m_laz=m_laz19 if age_mos==19
replace age_days=age_days19 if age_mos==19
drop m_laz19 age_days19

egen m_laz20 =mean(laz20)
gen age_days20=age20
replace m_laz=m_laz20 if age_mos==20
replace age_days=age_days20 if age_mos==20
drop m_laz20 age_days20

egen m_laz21 =mean(laz21)
gen age_days21=age21
replace m_laz=m_laz21 if age_mos==21
replace age_days=age_days21 if age_mos==21
drop m_laz21 age_days21

egen m_laz22 =mean(laz22)
gen age_days22=age22
replace m_laz=m_laz22 if age_mos==22
replace age_days=age_days22 if age_mos==22
drop m_laz22 age_days22

egen m_laz23 =mean(laz23)
gen age_days23=age23
replace m_laz=m_laz23 if age_mos==23
replace age_days=age_days23 if age_mos==23
drop m_laz23 age_days23

drop if m_laz==.
keep age_mos m_laz age_days stunt_prop
gen row_count=_n
gen HA_days=.
gen GD=.
save "growth_delay.dta", replace

*** Download "lenanthro.dta" dataset from https://github.com/unicef-drp/igrowup_update
copy "https://raw.githubusercontent.com/unicef-drp/igrowup_update/master/lenanthro.dta" "lenanthro.dta", replace
use "lenanthro.dta"

* Assume equal proportion of girls to boys in dataset, so collapse dataset
collapse (mean) l m s, by(_agedays)
gen merger =1
save "lenanthro_collapsed.dta", replace

*** Calculate height-age and growth delay from mean laz per month
clear
forvalues counter = 1 (1) 21 {
use "growth_delay.dta", clear 
	gen merger = 1
	keep if row_count==`counter'
	joinby merger using "lenanthro_collapsed.dta"
	drop HA_days GD
	gen lenhei = m*((m_laz*s)+1) if _agedays == age_days
	sort lenhei
	replace lenhei = lenhei[1] if missing(lenhei)
	bysort _agedays: egen minabs_diff = min(abs(lenhei-m))
	sort minabs_diff
	gen HA_days = _agedays[1]
	gen HA_mos = HA_days/30.4375
	gen GD = (age_days-HA_days)
	drop if _n != 1
	keep row_count HA_days GD
	merge 1:1 row_count using "growth_delay.dta" 
	drop _merge
	save "growth_delay.dta", replace 
	clear
}

use "growth_delay.dta"
sort row_count
save, replace

export excel using "LGF_Fig4_Rdata_241126.xlsx", replace first(var) keepcellfmt

*****************************************


***************************************************************************************
// PART 6: Generate simulated dataset w/ missingness and calculate incidence - Table 1
***************************************************************************************
*** These simulations induce varying levels of missingness at the birth timepoint, while assuming no missingness at 3 months

*** 10% missingness
********************

*** Set parameters for simulated population dataset
clear all
set seed 81625
set obs 10000
matrix CE = (1, .77 \ .77, 1) // Correlation corresponding to 0-3months
matrix SDE = (1.1, 1.1) // Constant SD
matrix ME = (-1.0000, -1.2667)

* Simulate population dataset
drawnorm laz0 laz3, means(ME) sds(SDE) corr(CE)

* Flag every 10th observation
gen byte tag = mod(_n, 10) == 0
replace laz0 =. if tag==1

* Determine stunting prevalence at birth
count if laz0<-2 // # classified as 'stunted' at birth (n= 1648)
scalar stunted_birth_10perc_count = r(N) // store count value
display stunted_birth_10perc_count/9000 // manual calculation of stunting prev. (# stunted/total N)
scalar stunted_birth_10perc_percentage = (stunted_birth_10perc_count/9000)*100 // store same as percentage 
scalar list

* Determine incident stunting onset between 0-3 mos
count if laz0>=-2 & laz3<-2 & tag==0 // normal calculation of 'newly stunted' (n=1069)
scalar new_stunted_0_3_10perc_count = r(N) // store count value
count if laz3<-2 & tag==1 // Infants with missing birth measurements were considered `newly stunted' if their 3-month LAZ <-2 (n=250)
scalar stunted_missed_0_3_10perc_count = r(N) // store count value
display (new_stunted_0_3_10perc_count+stunted_missed_0_3_10perc_count)/10000 // full sample size now is denominator, assuming no missingness at 3-months
scalar inc_stunt_0_3_10perc_perc = ((new_stunted_0_3_10perc_count+stunted_missed_0_3_10perc_count)/10000) *100 // store percentage 

****************************************************************
****Counts and Percentages for 10% missingness at birth scenario
*----------------------------------------------------------------
scalar list
****************************************************************


*** 20% missingness
*********************

*** Set parameters for simulated population dataset
clear all
set seed 81625
set obs 10000
matrix CE = (1, .77 \ .77, 1) // Correlation corresponding to 0-3months
matrix SDE = (1.1, 1.1) // Constant SD
matrix ME = (-1.0000, -1.2667)

* Simulate population dataset
drawnorm laz0 laz3, means(ME) sds(SDE) corr(CE)

* Flag every 5th observation
gen byte tag = mod(_n, 5) == 0
replace laz0 =. if tag==1

* Determine stunting prevalence at birth
count if laz0<-2 // # classified as 'stunted' at birth (n= 1467)
scalar stunted_birth_20perc_count = r(N) // store count value
display stunted_birth_20perc_count/8000 // manual calculation of stunting prev. (# stunted/total N)
scalar stunted_birth_20perc_percentage = (stunted_birth_20perc_count/8000)*100 // store same as percentage 
scalar list

* Determine incident stunting onset between 0-3 mos
count if laz0>=-2 & laz3<-2 & tag==0 // normal calculation of 'newly stunted' (n=959)
scalar new_stunted_0_3_20perc_count = r(N) // store count value
count if laz3<-2 & tag==1 // Infants with missing birth measurements were considered `newly stunted' if their 3-month LAZ <-2 (n=492)
scalar stunted_missed_0_3_20perc_count = r(N) // store count value
scalar all_stunted_0_3_20per_count=new_stunted_0_3_20perc_count+stunted_missed_0_3_20perc_count // add up all cases considered newly stunted by 3 months
display all_stunted_0_3_20per_count/10000 // full sample size now is denominator, assuming no missingness at 3-months
scalar inc_stunt_0_3_20perc_perc = (all_stunted_0_3_20per_count/10000) *100 // store as percentage 

****************************************************************
****Counts and Percentages for 20% missingness at birth scenario
*----------------------------------------------------------------
scalar list
****************************************************************



*****************************************
*END*************************************
*****************************************




