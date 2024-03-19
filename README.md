R code used to generate figures included in: 

<b>Whole-population perspective is needed for analyses and actions to address linear growth faltering in low- and middle-income countries</b>

Authors: Daniel E. Roth, Kelly M. Watson & Diego G. Bassani

// PROJECT: Matters Arising response to Benjamin-Chung et al. 2023
// PROGRAM: DR_KW_DB_MattersArising_SimCode_20240208
// TASK: Simulate population datasets and generate stunting indicators
// CREATED BY: Kelly Watson, The Hospital for Sick Children
// DATE: Feb 08, 2023


/* Table of contents: 
PART 1: Simulate datasets (w/ varying correlation) and generate stunting incidence for Figure 1
PART 2: Simulate datasets (w/ varying correlation) and generate stunting reversal for Figure 1
PART 3: Simulate datasets w/ varying starting LAZ and LAZ shifts and generate stunting indicators for Figure 2a
PART 4: Simulate datasets w/ varying starting LAZ and corr and generate stunting indicators for Figure 2b
PART 5: Generate LAZ-, stunting-, and growth delay-by-age trajectories for Figures 3 and 4
PART 6: Generate simulated dataset w/ missingness and calculate indicators - Extended Data Table 2
*/

