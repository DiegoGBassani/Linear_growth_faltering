
cd "/Users/kellywatson/Desktop"

// PROJECT: Matters Arising response to Benjamin-Chung et al. 2023
// PROGRAM: Matters_arising_code_20231215
// TASK: Simulate population datasets and generate stunting indicators
// CREATED BY: Kelly Watson, The Hospital for Sick Children
// DATE: December 15, 2023


/* Table of contents: 
PART 1: Set parameters for simulated population datasets in Figure 1
PART 2: Simulate population dataset and generate stunting incidence for Figure 1
PART 3: Simulate population dataset and generate stunting reversal for Figure 1
PART 4: Simulate multiple population datasets with varying distribution shifts and generate stunting indicators for Figure 2a
Part 5: Simulate multiple population datasets with varying correlations and generate stunting indicators for Figure 2b
PART 6: Compare LAZ-, stunting-, and growth delay-by-age trajectories for Figures 3 and 4
*/

*****************************************
*****************************************
// PART 1: Set parameters for simulated population datasets for Figure 1
clear all
set seed 81625
set obs 10000
* Number of observations in a simulated dataset = 10,000

*** Correlation matrices
* Empirical monthly predicted between-timepoint correlations (birth-24mos)
matrix V =   (1.0, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75, 0.75, 0.75, 0.74, 0.74, 0.73, 0.73, 0.73, 0.72, 0.72, 0.71, 0.71, 0.71, 0.70)  
matrix V =   V\ (0.79,  1.0, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75, 0.75, 0.75, 0.74, 0.74, 0.73, 0.73, 0.73, 0.72, 0.72)  
matrix V =   V\ (0.79, 0.81,  1.0, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75, 0.75, 0.75, 0.74, 0.74, 0.73) 
matrix V =   V\ (0.79, 0.80, 0.82,  1.0, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77, 0.76, 0.76, 0.75, 0.75)
matrix V =   V\ (0.78, 0.80, 0.81, 0.83,  1.0, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78, 0.78, 0.77, 0.77, 0.77)
matrix V =   V\ (0.78, 0.79, 0.81, 0.83, 0.84,  1.0, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80, 0.79, 0.79, 0.79, 0.78)
matrix V =   V\ (0.77, 0.79, 0.81, 0.82, 0.84, 0.85,  1.0, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81, 0.81, 0.81, 0.80, 0.80)
matrix V =   V\ (0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87,  1.0, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83, 0.83, 0.82, 0.82, 0.81)
matrix V =   V\ (0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88,  1.0, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85, 0.84, 0.84, 0.83, 0.83)
matrix V =   V\ (0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89,  1.0, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87, 0.86, 0.86, 0.85, 0.85, 0.85)
matrix V =   V\ (0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90,  1.0, 0.91, 0.91, 0.91, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88, 0.88, 0.87, 0.87, 0.87, 0.86)
matrix V =   V\ (0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91,  1.0, 0.93, 0.92, 0.92, 0.91, 0.91, 0.91, 0.90, 0.90, 0.89, 0.89, 0.89, 0.88, 0.88)
matrix V =   V\ (0.75, 0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93,  1.0, 0.94, 0.93, 0.93, 0.93, 0.92, 0.92, 0.91, 0.91, 0.91, 0.90, 0.90, 0.89)
matrix V =   V\ (0.75, 0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94,  1.0, 0.95, 0.95, 0.94, 0.94, 0.93, 0.93, 0.93, 0.92, 0.92, 0.91, 0.91)
matrix V =   V\ (0.74, 0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95,  1.0, 0.96, 0.96, 0.95, 0.95, 0.95, 0.94, 0.94, 0.93, 0.93, 0.93)
matrix V =   V\ (0.74, 0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96,  1.0, 0.97, 0.97, 0.97, 0.96, 0.96, 0.95, 0.95, 0.95, 0.94)
matrix V =   V\ (0.73, 0.75, 0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 0.94, 0.96, 0.97,  1.0, 0.99, 0.98, 0.98, 0.97, 0.97, 0.97, 0.96, 0.96)
matrix V =   V\ (0.73, 0.75, 0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94, 0.95, 0.97, 0.99,  1.0, 0.99, 0.99, 0.99, 0.99, 0.98, 0.98, 0.97)
matrix V =   V\ (0.73, 0.74, 0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95, 0.97, 0.98, 0.99,  1.0, 0.99, 0.99, 0.99, 0.99, 0.99, 0.99)
matrix V =   V\ (0.72, 0.74, 0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96, 0.98, 0.99, 0.99,  1.0, 0.99, 0.99, 0.99, 0.99, 0.99)
matrix V =   V\ (0.72, 0.73, 0.75, 0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 0.94, 0.96, 0.97, 0.99, 0.99, 0.99,  1.0, 0.99, 0.99, 0.99, 0.99)
matrix V =   V\ (0.71, 0.73, 0.75, 0.76, 0.78, 0.79, 0.81, 0.83, 0.84, 0.86, 0.87, 0.89, 0.91, 0.92, 0.94, 0.95, 0.97, 0.99, 0.99, 0.99, 0.99,  1.0, 0.99, 0.99, 0.99)
matrix V =   V\ (0.71, 0.73, 0.74, 0.76, 0.77, 0.79, 0.81, 0.82, 0.84, 0.85, 0.87, 0.89, 0.90, 0.92, 0.93, 0.95, 0.97, 0.98, 0.99, 0.99, 0.99, 0.99,  1.0, 0.99, 0.99)
matrix V =   V\ (0.71, 0.72, 0.74, 0.75, 0.77, 0.79, 0.80, 0.82, 0.83, 0.85, 0.87, 0.88, 0.90, 0.91, 0.93, 0.95, 0.96, 0.98, 0.99, 0.99, 0.99, 0.99, 0.99,  1.0, 0.99)
matrix V =   V\ (0.70, 0.72, 0.73, 0.75, 0.77, 0.78, 0.80, 0.81, 0.83, 0.85, 0.86, 0.88, 0.89, 0.91, 0.93, 0.94, 0.96, 0.97, 0.99, 0.99, 0.99, 0.99, 0.99, 0.99,  1.0)

* Perfect between-timepoint correlations (birth-24 mos)
matrix P =   (1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
matrix P =   P\(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)


*** Set mean LAZ estimates for Figure 1 simulated dataset to calculate stunting incidence
matrix F1I = (-1.0000, -1.0000, -1.0000, -1.2667, -1.2967, -1.3252, -1.3674, -1.4167, -1.4752, -1.5382, -1.6102, -1.6886, -1.7607, -1.8171, -1.8607, -1.9175, -1.9766, -2.0408, -2.0906, -2.0988, -2.0918, -2.0772, -2.0611, -2.0470, -2.0141)
* Mean LAZ values estimated from Benjamin-Chung et al. Supp. Material Figure 3.1.1 South Asian trajectory 

*** Set mean LAZ estimates for Figure 1 simulated dataset to calculate stunting reversal
matrix F1R = (-0.8185, -0.8746, -0.9346, -0.9921, -1.0460, -1.1078, -1.1532, -1.2151, -1.2703, -1.3374, -1.4122	, -1.4880, -1.5654, -1.6343, -1.7017, -1.7549, -1.8096, -1.8518, -1.8908, -1.9242, -1.9515, -1.9603, -1.9577, -1.9400, -1.9221)
* Mean LAZ estimated from Benjamin-Chung et al. Supp. Material Figure 3.1.2 South Asian trajectory

*** Set standard deviation (SD) for both simulated datasets used in Figure 1 (constant)
matrix SD = (1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1)
* Constant SD to enforce whole-population shift; estimated from Benjamin-Chung et al. Extended Data Figure 7


*****************************************
*****************************************
// PART 2: Simulate population dataset and generate stunting incidence for Figure 1

*** Stunting incidence with empirical between-timepoint correlations: 

* Simulate population dataset using empirical correlation dataset (matrix "V")
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24, means(F1I) sds(SD) corr(V) forcepsd
* Assumes LAZ normally distributed at each measurement (birth-24 months) in population dataset

drop laz1 laz2 laz4 laz5 laz7 laz8 laz10 laz11 laz13 laz14 laz16 laz17 laz19 laz20 laz22 laz23 
* Only interested in calculating stunting indicators at tri-monthly intervals, as done in Benjamin-Chung et al.'s Figure 3a

* Calculate 'incident stunting onset'
* Birth = stunting prevalence
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


*** Stunting incidence with perfect between-timepoint correlations: 

* Re-set parameters in Part 1 

* Simulate population dataset using perfect correlation matrix (matrix "P")
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24, means(F1I) sds(SD) corr(P) forcepsd
* Assumes LAZ normally distributed at each measurement (birth-24 months) in population dataset

drop laz1 laz2 laz4 laz5 laz7 laz8 laz10 laz11 laz13 laz14 laz16 laz17 laz19 laz20 laz22 laz23 
* Only interested in calculating stunting indicators at tri-monthly intervals, as done in Benjamin-Chung et al.'s Figure 3a

* Re-run "Calculate 'incident stunting onset'" lines from above

*****************************************
*****************************************
// PART 3: Simulate population dataset and generate stunting reversal for Figure 1

* Re-set parameters in Part 1 

*** Stunting reversal with empirical between-timepoint correlations: 

* Simulate population dataset using empirical correlation dataset (matrix "V")
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24, means(F1R) sds(SD) corr(V) forcepsd
* Assumes LAZ normally distributed at each measurement (birth-24 months) in population dataset

drop laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24
* Only interested in calculating stunting indicators at monthly intervals up to 15mos, as done in Benjamin-Chung et al.'s Figure 4a&b + Ext.Fig.12

* Calculate 'stunting reversal'
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

*** Stunting reversal with perfect between-timepoint correlations: 

* Re-set parameters in Part 1 

* Simulate population dataset using perfect correlation matrix (matrix "P")
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24, means(F1R) sds(SD) corr(P) forcepsd
* Assumes LAZ normally distributed at each measurement (birth-24 months) in population dataset

drop laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24
* Only interested in calculating stunting indicators at monthly intervals up to 15mos, as done in Benjamin-Chung et al.'s Figure 4a&b + Ext.Fig.12

* Re-run "Calculate 'stunting reversal'" lines from above

*****************************************
*****************************************
// PART 4: Simulate multiple population datasets with varying distribution shifts and generate stunting indicators for Figure 2a

* Isolating observation period for each dataset to 0-3month interval
* Set parameters for the simulated population datasets
clear all
set seed 81625
set obs 10000
matrix C = (1, .79 \ .79, 1) 
* New correlation matrix, with corr value corresponding to 0-3mos
matrix SD = (1.1, 1.1)
* Constant SD to enforce whole-population shift; estimated from Benjamin-Chung et al. Extended Data Figure 7

*** Alter starting mean LAZ and change in mean LAZ for each dataset (25 total)
matrix F1P1=(0,0)
matrix F1P2=(0,-0.1)
matrix F1P3=(0,-0.2)
matrix F1P4=(0,-0.3)
matrix F1P5=(0,-0.4)
matrix F1P6=(-0.4,-0.4)
matrix F1P7=(-0.4,-0.5)
matrix F1P8=(-0.4,-0.6)
matrix F1P9=(-0.4,-0.7)
matrix F1P10=(-0.4,-0.8)
matrix F1P11=(-0.8,-0.8)
matrix F1P12=(-0.8,-0.9)
matrix F1P13=(-0.8,-1)
matrix F1P14=(-0.8,-1.1)
matrix F1P15=(-0.8,-1.2)
matrix F1P16=(-1.2,-1.2)
matrix F1P17=(-1.2,-1.3)
matrix F1P18=(-1.2,-1.4)
matrix F1P19=(-1.2,-1.5)
matrix F1P20=(-1.2,-1.6)
matrix F1P21=(-1.6,-1.6)
matrix F1P22=(-1.6,-1.7)
matrix F1P23=(-1.6,-1.8)
matrix F1P24=(-1.6,-1.9)
matrix F1P25=(-1.6,-2)

*** Sub each mean matrix into drawnorm function to generate 25 unique pop datasets 
drawnorm laz0 laz3, means(F1P25) sds(SD) seed(81625) corr(C)

*** Calculate 'Incident stunting onset'
count if laz0 >=-2 & laz3 <-2
display r(N)/10000
*** Calculate 'Stunting reversal'
count if laz0 <-2 & laz3 >=-2
display r(N)/10000

* Input results to external Excel file

*** Re-set parameters (re-run lines in this section, Part 4, up to drawnorm)
* change P# in drawnorm then run rest of lines again
* Repeat until all 25 population datasets have been generated


*****************************************
*****************************************
// PART 5: Simulate multiple population datasets with varying between-visit correlations and generate stunting indicators for Figure 2b

* Isolating observation period for each dataset to 0-3month interval
* Set constant parameters for the simulated population datasets
clear all
set seed 81625
set obs 10000
matrix SD = (1.1, 1.1)
* Constant SD to enforce whole-population shift; estimated from Benjamin-Chung et al. Extended Data Figure 7

*** Set varying parameters for the simulated population datasets
* Alter correlation matrix
matrix C1 = (1, .6 \ .6, 1) 
matrix C2 = (1, .7 \ .7, 1) 
matrix C3 = (1, .8 \ .8, 1)
matrix C4 = (1, .9 \ .9, 1)
matrix C5 = (1, 1 \ 1, 1)  
* Alter starting LAZ 
matrix M1 = (0, -0.2)
matrix M2 = (-0.4, -0.6)
matrix M3 = (-0.8, -1)
matrix M4 = (-1.2, -1.4)
matrix M5 = (-1.6, -1.8)

*** Sub each matrix into drawnorm function to generate 25 unique pop datasets 
drawnorm laz0 laz3, means(M5) sds(SD) seed(81625) corr(C5)

*** Calculate 'Incident stunting onset'
count if laz0 >=-2 & laz3 <-2
display r(N)/10000
*** Calculate 'Stunting reversal'
count if laz0 <-2 & laz3 >=-2
display r(N)/10000

* Input results to external Excel file
 
*****************************************
*****************************************
// PART 6: Compare LAZ-, stunting-, and growth delay-by-age trajectories

*** Compare trajectories using LAZ-by-age trajectory as in Figure 1 for reversal estimates 
* Re-set parameters in Part 1
* Simulate dataset for LAZ-by-age trajectory
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24, means(F1R) sds(SD) corr(V) forcepsd

drop laz0 laz1 laz2 laz24
* Avoid calculating height-age (to calc. growth delay) near birth/2-years

gen age_mos=_n

*** Calculate stunting prevalence-by-age (in months)
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

*** REPEAT steps above but to show an increasing LAZ trajectory 
* Re-set parameters in Part 1
* Generate new mean LAZ matrix to be used with increasing LAZ (selected values)
matrix I = (-1.0, -1.10, -1.15, -1.20, -1.25, -1.30, -1.35, -1.40, -1.45, -1.50, -1.55, -1.60, -1.65, -1.70, -1.75, -1.80, -1.85, -1.80, -1.75, -1.70, -1.65, -1.60, -1.55, -1.50, -1)
* Generate population dataset
drawnorm laz0 laz1 laz2 laz3 laz4 laz5 laz6 laz7 laz8 laz9 laz10 laz11 laz12 laz13 laz14 laz15 laz16 laz17 laz18 laz19 laz20 laz21 laz22 laz23 laz24, means(I) sds(SD) corr(V) forcepsd
* Don't calculate height-age around birth or 2 years
drop laz0 laz1 laz2 laz24

*** Re-run lines in this section (Part 5) using new LAZ trajectory
* Start from gen age_mos=_n 
* Make sure to re-name file with data (e.g., "growthdelay2.dta")
* Do not need to re-run lines to collapse lenanthro file (can use already collapsed file)

*****************************************
*****************************************
