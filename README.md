# Linear Growth Faltering in LMICs – Simulations and Figures
### Authors: 	Daniel E. Roth, Kelly M. Watson & Diego G. Bassani

These are code and data files related to simulations and figures described in the paper entitled, “Stunting incidence and reversal as metrics of postnatal linear growth faltering in low- and middle-income countries: a critical appraisal and simulation study”.  

The sub-folder labeled [“Preprint”]( https://github.com/DiegoGBassani/Linear_growth_faltering/tree/main/Preprint) contains files related to the pre-print version of the article, entitled [“Whole-population perspective is needed for analyses and actions to address linear growth faltering in low- and middle-income countries”]( https://doi.org/10.1101/2024.06.24.24309409).  Consult the separate README file in that folder.

The study was originally conducted as a response to [“Early-childhood linear growth faltering in low- and middle-income countries”]( https://doi.org/10.1038/s41586-023-06418-5) by Benjamin-Chung and HBGDki collaborators (Nature 2023; 621, 550–557).

The files listed here are related to the most recent version of the study. 


This is the STATA do file that runs the simulations and generates the estimates that are plotted in the figures:

>LGF_SimCode_20240807.do 	

These are the individual data input files called by the R code that generates the figures:
>LGF_Fig1_Rdata_240722.xlsx  
>LGF_Fig2a_Rdata_240722.xlsx  
>LGF_Fig2b_Rdata_240722.xlsx  
>LGF_Fig3a_Rdata_240722.xlsx  
>LGF_Fig3b_Rdata_240722.xlsx  
>LGF_Fig4_Rdata_240722.xlsx  

This is the R code file that uses the xlsx input files listed above to generate the figures shown in the paper:
>LGF_FigCode_20240722.R

This file includes the mean LAZ values extracted and used in the figure 1 simulations of incident stunting onset:
>LGF_Fig1_uLAZ_inc.xlsx

This file includes the mean LAZ values extracted and used in the figure 1 simulations of stunting reversal: 
>LGF_Fig1_uLAZ_rev.xlsx

This file includes inputs parameters used in figure 2a simulations:
>LGF_Fig2a_sim_parameters.xlsx

This file includes inputs parameters used in figure 2b simulations:
>LGF_Fig2b_sim_parameters.xlsx
