# Linear Growth Faltering in LMICs – Simulations and Figures
### Authors: 	Daniel E. Roth, Kelly M. Watson & Diego G. Bassani

These code and data files pertain to simulations and figures in the paper entitled, “Stunting incidence and reversal as metrics of postnatal linear growth faltering in low- and middle-income countries: a critical appraisal and simulation study”. 

The sub-folder labeled [“Preprint”]( https://github.com/DiegoGBassani/Linear_growth_faltering/tree/main/Preprint) contains files related to the pre-print version of the article, entitled [“Whole-population perspective is needed for analyses and actions to address linear growth faltering in low- and middle-income countries”]( https://doi.org/10.1101/2024.06.24.24309409).  Consult the separate README file in that folder.

The study was originally conducted as a response to [“Early-childhood linear growth faltering in low- and middle-income countries”]( https://doi.org/10.1038/s41586-023-06418-5) by Benjamin-Chung and HBGDki collaborators (Nature 2023; 621, 550–557).

The files listed here relate to simulations/figures that have been updated to correspond to a December 12, 2024 [correction of the HBGDki paper](https://www.nature.com/articles/s41586-024-08344-6). The main arguments and conclusions of our critique were unaffected by the HBGDki authors’ correction, but the updates ensured that the simulations remain aligned with the primary analyses used in the HBGDki paper.

This is the STATA do file that runs the simulations and generates the datasets containing the estimates that are plotted in Figures 1 – 5:

>LGF_SimCode_20250120.do 	

These are the individual data input files generated by the STATA code and then called by the R code that generates the figures:
>LGF_Fig1_Rdata_250120.xlsx  
>LGF_Fig2_Rdata_250120.xlsx  
>LGF_Fig3a4a_Rdata_250120.xlsx  
>LGF_Fig3b4b_Rdata_250120.xlsx  
>LGF_Fig5_Rdata_250120.xlsx  

This is the R code file that uses all the xlsx input files listed above to generate figures 1 – 5 shown in the paper:
>LGF_FigCode_20250120.R

#### Additional Resources:

This file includes the mean LAZ values extracted and used in the simulations of incident stunting onset shown in Figure 1:
>LGF_Fig1_uLAZ_inc.xlsx

This file includes the mean LAZ values extracted and used in the simulations of stunting reversal shown in Figure 1: 
>LGF_Fig1_uLAZ_rev.xlsx
