
// PROJECT: Matters Arising response to Benjamin-Chung et al. 2023
// PROGRAM: DR_KW_DB_MattersArising_SimCode_20240208
// TASK: Simulate population datasets and generate stunting indicators
// CREATED BY: Kelly Watson, The Hospital for Sick Children
// DATE: Feb 08, 2024


/* Table of contents: 
PART 1: Simulate datasets (w/ varying corr) and generate stunting incidence for Figure 1
PART 2: Simulate datasets (w/ varying corr) and generate stunting reversal for Figure 1
PART 3: Simulate datasets w/ varying starting LAZ and LAZ shifts and generate stunting indicators for Figure 2a
PART 4: Simulate datasets w/ varying starting LAZ and corr and generate stunting indicators for Figure 2b
PART 5: Generate LAZ-, stunting-, and growth delay-by-age trajectories for Figures 3 and 4
PART 6: Generate simulated dataset w/ missingness and calculate indicators - Extended Data Table 2
*/


*****************************************
*****************************************
// PART 1: Simulate population dataset and generate stunting INCIDENCE at tri-monthly intervals (0-24mos) for Figure 1

*****************************************
*** Set parameters (empirical corr, mean LAZ, SD) to sim dataset
clear all
set seed 81625
set obs 10000
* Corr matrix- empirical
matrix I =  (1.00, 0.79, 0.77, 0.76, 0.75, 0.74, 0.73, 0.71, 0.70)
matrix I =   I\ (0.79, 1.00, 0.82, 0.81, 0.80, 0.79, 0.77, 0.76, 0.75)
matrix I =   I\ (0.77, 0.82, 1.00, 0.86, 0.85, 0.83, 0.82, 0.81, 0.80)
matrix I =   I\ (0.76, 0.81, 0.86, 1.00, 0.89, 0.88, 0.87, 0.86, 0.85)
matrix I =   I\ (0.75, 0.80, 0.85, 0.89, 1.00, 0.93, 0.92, 0.91, 0.89)
matrix I =   I\ (0.74, 0.79, 0.83, 0.88, 0.93, 1.00, 0.97, 0.95, 0.94)
matrix I =   I\ (0.73, 0.77, 0.82, 0.87, 0.92, 0.97, 1.00, 0.99, 0.99)
matrix I =   I\ (0.71, 0.76, 0.81, 0.86, 0.91, 0.95, 0.99, 1.00, 0.99)
matrix I =   I\ (0.70, 0.75, 0.80, 0.85, 0.89, 0.94, 0.99, 0.99, 1.00)
* Mean LAZ:
matrix F1I = (-1.0000, -1.2667, -1.3674, -1.5382, -1.7607, -1.9175, -2.0906, -2.0772, -2.0141)
* SD:
matrix SDI = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

*** Simulate population dataset using empirical correlation structure (matrix "I")
drawnorm laz0 laz3 laz6 laz9 laz12 laz15 laz18 laz21 laz24, means(F1I) sds(SDI) corr(I)

*** Calculate stunting incident onset
count if laz0<-2
display r(N)/10000
* 0-3 month interval 
count if laz0>=-2 & laz3<-2
display r(N)/10000
* 3-6 month interval
count if laz0>=-2 & laz3>=-2 & laz6<-2
display r(N)/10000
* 6-9 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9<-2
display r(N)/10000
* 9-12 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12<-2
display r(N)/10000
* 12-15 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15<-2
display r(N)/10000
* 15-18 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15>=-2 & laz18<-2
display r(N)/10000
* 18-21 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15>=-2 & laz18>=-2 & laz21<-2
display r(N)/10000
* 21-24 month interval
count if laz0>=-2 & laz3>=-2 & laz6>=-2 & laz9>=-2 & laz12>=-2 & laz15>=-2 & laz18>=-2 & laz21>=-2 & laz24<-2
display r(N)/10000

*****************************************
*** Set parameters (perfect corr, mean LAZ, SD) to sim dataset
clear all
set seed 81625
set obs 10000
* Corr matrix - perfect
matrix PI =   (1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix PI =   PI\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
* Mean LAZ:
matrix F1I = (-1.0000, -1.2667, -1.3674, -1.5382, -1.7607, -1.9175, -2.0906, -2.0772, -2.0141)
* SD:
matrix SDI = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

*** Simulate population dataset using perfect correlation dataset (matrix "PI")
drawnorm laz0 laz3 laz6 laz9 laz12 laz15 laz18 laz21 laz24, means(F1I) sds(SDI) corr(PI) 

* (Re-run lines for "Calculate stunting incident onset")



*****************************************
*****************************************
// PART 2: Simulate population dataset and generate stunting REVERSAL at monthly intervals (0-15mos) for Figure 1

*****************************************
*** Set parameters (empirical corr, mean LAZ, SD) to sim dataset
clear all
set seed 81625
set obs 10000
* Corr - empirical
matrix R =  (1.00, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75, 0.75, 0.75, 0.74, 0.74)
matrix R =   R\ (0.79, 1.00, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75)
matrix R =   R\ (0.79, 0.81, 1.00, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77)
matrix R =   R\ (0.79, 0.80, 0.82, 1.00, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79)
matrix R =   R\ (0.78, 0.80, 0.81, 0.83, 1.00, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80)
matrix R =   R\ (0.78, 0.79, 0.81, 0.83, 0.84, 1.00, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82)
matrix R =   R\ (0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 1.00, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83)
matrix R =   R\ (0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 1.00, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85)
matrix R =   R\ (0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 1.00, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87)
matrix R =   R\ (0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 1.00, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88)
matrix R =   R\ (0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 1.00, 0.91, 0.91, 0.91, 0.90, 0.90)
matrix R =   R\ (0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 1.00, 0.93, 0.92, 0.92, 0.91)
matrix R =   R\ (0.75, 0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 1.00, 0.94, 0.93, 0.93)
matrix R =   R\ (0.75, 0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94, 1.00, 0.95, 0.95)
matrix R =   R\ (0.74, 0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95, 1.00, 0.96)
matrix R =   R\ (0.74, 0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96, 1.00)
* Mean LAZ
matrix F1R = (-0.8185, -0.8746, -0.9346, -0.9921, -1.0460, -1.1078, -1.1532, -1.2151, -1.2703, -1.3374, -1.4122	, -1.4880, -1.5654, -1.6343, -1.7017, -1.7549)
* SD
matrix SDR = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

*** Simulate population dataset using empirical correlation structure (matrix "R")
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15, means(F1R) sds(SDR) corr(R) 

*** Calculate stunting reversal
* Reversal not possible at birth
* 0-1 month interval
count if laz0 <-2 & laz1 >=-2
display r(N)/10000 
* 1-2 month interval
count if laz1 <-2 & laz2 >=-2 
display r(N)/10000 
* 2-3 month interval
count if laz2 <-2 & laz3 >=-2
display r(N)/10000 
* 3-4 month interval
count if laz3 <-2 & laz4 >=-2
display r(N)/10000 
* 4-5 month interval
count if laz4 <-2 & laz5 >=-2
display r(N)/10000
* 5-6 month interval
count if laz5 <-2 & laz6 >=-2
display r(N)/10000
* 6-7 month interval
count if laz6 <-2 & laz7 >=-2
display r(N)/10000
* 7-8 month interval
count if laz7 <-2 & laz8 >=-2
display r(N)/10000
* 8-9 month interval
count if laz8 <-2 & laz9 >=-2
display r(N)/10000
* 9-10 month interval
count if laz9 <-2 & laz10 >=-2
display r(N)/10000
* 10-11 month interval
count if laz10 <-2 & laz11 >=-2
display r(N)/10000
* 11-12 month interval
count if laz11 <-2 & laz12 >=-2
display r(N)/10000
* 12-13 month interval
count if laz12 <-2 & laz13 >=-2
display r(N)/10000
* 13-14 month interval
count if laz13 <-2 & laz14 >=-2
display r(N)/10000
* 14-15 month interval
count if laz14 <-2 & laz15 >=-2
display r(N)/10000

*****************************************
*** Set parameters (perfect corr, mean LAZ, SD) to sim dataset
clear all
set seed 81625
set obs 10000
* Corr - perfect
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
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15, means(F1R) sds(SDR) corr(PR) 

* Re-run lines for "Calculate stunting reversal")



*****************************************
*****************************************
// PART 3: Simulate multiple population datasets with varying distribution shifts and generate stunting indicators for Figure 2a

*** Set constant parameters for simulated population datasets
clear all
set seed 81625
set obs 10000
matrix CA = (1, .79 \ .79, 1) // Correlation corresponding to 0-3months
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

*** Simulate dataset for first variation of starting mean laz and laz shift 
drawnorm laz0 laz3, means(MA1) sds(SDA) seed(81625) corr(CA)

*** Calculate 'Incident stunting onset'
count if laz0 >=-2 & laz3 <-2
display r(N)/10000
*** Calculate 'Stunting reversal'
count if laz0 <-2 & laz3 >=-2
display r(N)/10000

*** Re-set parameters (re-run lines in this section up to drawnorm)
* Change to next mean matrix
* Repeat for all 25 cases



*****************************************
*****************************************
// PART 4: Simulate multiple population datasets with varying correlations and generate stunting indicators for Figure 2b

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

*** Simulate dataset for first variation of starting mean laz and correlation
drawnorm laz0 laz3, means(MB1) sds(SDB) seed(81625) corr(CB1)

*** Calculate 'Incident stunting onset'
count if laz0 >=-2 & laz3 <-2
display r(N)/10000
*** Calculate 'Stunting reversal'
count if laz0 <-2 & laz3 >=-2
display r(N)/10000

*** Re-set parameters (re-run lines in this section up to drawnorm)
* Change to next mean matrix
* Repeat so each correlation matrix and mean matrix are run together once (25 simulations total)



*****************************************
*****************************************
// PART 5: Generate LAZ-, stunting-, and growth delay-by-age trajectories for Figures 3 and 4 (3-23mos)

* Set parameters for simulated dataset used in Figure 3
clear all
set seed 81625
set obs 10000

matrix M3 = (-0.9921, -1.0460, -1.1078, -1.1532, -1.2151, -1.2703, -1.3374, -1.4122	, -1.4880, -1.5654, -1.6343, -1.7017, -1.7549, -1.8096, -1.8518, -1.8908, -1.9242, -1.9515, -1.9603, -1.9577, -1.9400)

matrix SD34 = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)

matrix C34 = (1.00, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75)
matrix C34 = C34 \ (0.83, 1.00, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77)
matrix C34 = C34 \ (0.83, 0.84, 1.00, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79)
matrix C34 = C34 \ (0.82, 0.84, 0.85, 1.00, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80)
matrix C34 = C34 \ (0.82, 0.83, 0.85, 0.87, 1.00, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82)
matrix C34 = C34 \ (0.81, 0.83, 0.85, 0.86, 0.88, 1.00, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83)
matrix C34 = C34 \ (0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 1.00, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85)
matrix C34 = C34 \ (0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 1.00, 0.91, 0.91, 0.91, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87)
matrix C34 = C34 \ (0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 1.00, 0.93, 0.92, 0.92, 0.91, 0.91, 0.91, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88)
matrix C34 = C34 \ (0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 1.00, 0.94, 0.93, 0.93, 0.93, 0.92, 0.92, 0.91, 0.91, 0.91, 0.90, 0.90)
matrix C34 = C34 \ (0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94, 1.00, 0.95, 0.95, 0.94, 0.94, 0.93, 0.93, 0.93, 0.92, 0.92, 0.91)
matrix C34 = C34 \ (0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95, 1.00, 0.96, 0.96, 0.95, 0.95, 0.95, 0.94, 0.94, 0.93, 0.93)
matrix C34 = C34 \ (0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96, 1.00, 0.97, 0.97, 0.97, 0.96, 0.96, 0.95, 0.95, 0.95)
matrix C34 = C34 \ (0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 0.94, 0.96, 0.97, 1.00, 0.99, 0.98, 0.98, 0.97, 0.97, 0.97, 0.96)
matrix C34 = C34 \ (0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94, 0.95, 0.97, 0.99, 1.00, 0.99, 0.99, 0.99, 0.99, 0.98, 0.98)
matrix C34 = C34 \ (0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95, 0.97, 0.98, 0.99, 1.00, 0.99, 0.99, 0.99, 0.99, 0.99)
matrix C34 = C34 \ (0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96, 0.98, 0.99, 0.99, 1.00, 0.99, 0.99, 0.99, 0.99)
matrix C34 = C34 \ (0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 0.94, 0.96, 0.97, 0.99, 0.99, 0.99, 1.00, 0.99, 0.99, 0.99)
matrix C34 = C34 \ (0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94, 0.95, 0.97, 0.99, 0.99, 0.99, 0.99, 1.00, 0.99, 0.99)
matrix C34 = C34 \ (0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95, 0.97, 0.98, 0.99, 0.99, 0.99, 0.99, 1.00, 0.99)
matrix C34 = C34 \ (0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96, 0.98, 0.99, 0.99, 0.99, 0.99, 0.99, 1.00)

* Simulate dataset used in Figure 3
drawnorm laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23, means(M3) sds(SD34) corr(C34) forcepsd

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
save "growth_delay1.dta", replace

*** Download "lenanthro.dta" dataset from https://github.com/unicef-drp/igrowup_update
* Save dataset to working directory
* Assume equal proportion of girls to boys in dataset, so collapse dataset
use "lenanthro.dta"
collapse (mean) l m s, by(_agedays)
gen merger =1
save "lenanthro_collapsed.dta", replace

*** Calculate height-age and growth delay from mean laz per month
clear
forvalues counter = 1 (1) 21 {
use "growth_delay1.dta", clear 
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
	merge 1:1 row_count using "growth_delay1.dta" 
	drop _merge
	save "growth_delay1.dta", replace 
	clear
}

use "growth_delay1.dta"
sort row_count
save, replace

*****************************************

*** REPEAT steps above but to show an increasing LAZ trajectory (for Figure 4) 
* Repeat everything above EXCEPT:
* Simulate new dataset w/ new mean matrix below (M4)
* Make sure to re-name file with data to calculate growth delay (e.g., "growthdelay2.dta")
* Do not need to re-run lines to collapse lenanthro file (can re-use already collapsed file)

matrix M4 = (-1.20, -1.25, -1.30, -1.35, -1.40, -1.45, -1.50, -1.55, -1.60, -1.65, -1.70, -1.75, -1.80, -1.85, -1.80, -1.75, -1.70, -1.65, -1.60, -1.55, -1.50)

* Simulate dataset used in Figure 4
drawnorm laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23, means(M4) sds(SD34) corr(C34) forcepsd

* Repeat steps from gen age_mos=_n (with the exceptions stated above in mind)



*****************************************
*****************************************
// PART 6: Generate simulated dataset w/ missingness and calculate indicators - Extended Data Table 2

*** Set parameters for simulated population dataset
clear all
set seed 81625
set obs 10000
matrix CE = (1, .79 \ .79, 1) // Correlation corresponding to 0-3months
matrix SDE = (1.1, 1.1) // Constant SD
matrix ME = (-1.0000, -1.2667)

* Simulate population dataset
drawnorm laz0 laz3, means(ME) sds(SDE) corr(CE)
*****************************************
*** Add varying levels of missingness to dataset at birth

*** 10% missingness
* Flag every 10th observation
gen byte tag = mod(_n, 10) == 0
replace laz0 =. if tag==1
* Determine stunting prevalence at birth
count if laz0<-2 // # classified as 'stunted' at birth = 1648
display 1648/9000 // manual calculation of stunting prev. (# stunted/total N)
* Determine incident stunting onset between 0-3 mos
count if laz0>=-2 & laz3<-2 & tag==0 // normal calculation of 'newly stunted' = 1036
count if laz3<-2 & tag==1 // Infants with missing birth measurements were considered `newly stunted' if their 3-month LAZ <-2 = 247
display (1036+247)/10000 // (full sample size now as denominator as now missingness at 3-months)


*** 20% missingness
* Rerun lines up to (and including) drawnorm
gen byte tag = mod(_n, 5) == 0
replace laz0 =. if tag==1
* Determine stunting prevalence at birth
count if laz0<-2 // # classified as 'stunted' at birth = 1467
display 1467/8000 // manual calculation of stunting prev. (# stunted/total N)
* Determine incident stunting onset between 0-3 mos
count if laz0>=-2 & laz3<-2 & tag==0 // normal calculation of 'newly stunted' =  927
count if laz3<-2 & tag==1 // Infants with missing birth measurements were considered `newly stunted' if their 3-month LAZ <-2 = 247
display (927+491)/10000 // (full sample size now as denominator as now missingness at 3-months)


*** 25% missingness
* Rerun lines up to (and including) drawnorm
gen byte tag = mod(_n, 4) == 0
replace laz0 =. if tag==1
* Determine stunting prevalence at birth
count if laz0<-2 // # classified as 'stunted' at birth = 1394
display 1394/7500 // manual calculation of stunting prev. (# stunted/total N)
* Determine incident stunting onset between 0-3 mos
count if laz0>=-2 & laz3<-2 & tag==0 // normal calculation of 'newly stunted' =  927
count if laz3<-2 & tag==1 // Infants with missing birth measurements were considered `newly stunted' if their 3-month LAZ <-2 = 247
display (873+599)/10000 // (full sample size now as denominator as now missingness at 3-months)

*****************************************
*****************************************







