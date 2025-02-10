########################################################################
## PROJECT: Linear Growth Faltering simulations
## PROGRAM: LGF_FigCode
## TASK: Generate figures
## ORIGINAL VERSION CREATED BY: Kelly Watson, The Hospital for Sick Children
## UPDATED BY: Daniel Roth, The Hospital for Sick Children
## VERSION DATE: Jan 20, 2025

####################################################################
## Load necessary packages
install.packages("tidyverse")
install.packages("ggplot2")
install.packages ("ggpubr") 
library(ggplot2)
library(rms)
library(ggpubr)
require(gridExtra)

####################################################################
### Figure 1

# Load data for Fig1
library(readxl)
Fig1 <- read_excel("/{FOLDER_PATH}/LGF_Fig1_Rdata_250120.xlsx")

# Set variables as factors
Fig1$Metric_factor <- as.factor(Fig1$Metric)
Fig1$Metric_factor <- factor(Fig1$Metric_factor, levels=c("Reported_inc", "Sim_inc_imperf","Sim_inc_perf", 
                                                          "Reported_rev", "Sim_rev_imperf","Sim_rev_perf"),
                             labels=c("Reported incidence", "Simulated incidence", "Simulated incidence (corr=1)",
                                      "Reported reversal", "Simulated reversal", "Simulated reversal (corr=1)"))

Fig1Plot <- ggplot() +
  
  geom_point(data = Fig1, aes(x = Month, y = Percent, color = Metric_factor), size = 1.3) +
  geom_smooth(data = Fig1, aes(x = Month, y = Percent, color = Metric_factor, linetype = Metric_factor), 
              method = "loess", se = FALSE) +
  
  scale_color_manual(name = "Stunting Indicator", 
                     values = c('#c51b7d', '#f7b6d2', '#fce7f0', '#4e9342', '#a2cf6b', '#d2e9b6')) +
  scale_linetype_manual(name = "Stunting Indicator", 
                        values = c("solid", "solid", "twodash", "solid", "solid", "twodash")) +
  
  theme(panel.grid.major.y = element_line(color = "grey90"),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour = 'black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        legend.key = element_rect(fill = "white", color = NA),  # Set color to NA to make it transparent
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8),
        plot.title = element_text(hjust = 0.5, size = 8, face = 'bold')) +
  
  xlab("Child age (months)") +
  ylab("Percent of total (%)") +
  scale_y_continuous(
    limits = c(0, 40),
    breaks = seq(0, 40, by = 5)
    )  +
  guides(color = guide_legend(override.aes = list(linetype = c("solid", "solid", "twodash", "solid", "solid", "twodash"),
                                                  shape = c(NA, NA, NA, NA, NA, NA)) ),
         title.position = "top", title.hjust = 0.5) +
  
  theme(legend.key.size = unit(1, "lines"),  
        legend.position = c(0.8,0.8))

Fig1Plot

ggsave("LGF_Fig1_250120.jpg", plot = Fig1Plot, units = "in", dpi = 300, width = 5, height = 5)
####################################################################

####################################################################
### Figure 2

# Load data for Fig2
library(readxl)
Fig2 <- read_excel("/{FOLDER_PATH}/LGF_Fig2_Rdata_250120.xlsx")

# Set variables as factors
Fig2$Scenario_factor <- as.factor(Fig2$Scenario)
Fig2$Scenario_factor <- factor(Fig2$Scenario_factor, levels=c("SDcons", "SDwide","lowcorr"),
                               labels=c("Primary", "Wider SD", "Lower between-timepoint correlation"))

# Make the plot for Fig2
Fig2Plot <- ggplot() +
  
  geom_smooth(data = Fig2,
              aes(x = missingp, y = Stuntinc3m, color = Scenario_factor, linetype = Scenario_factor),
              method = "loess", se = FALSE,
              linewidth = 1.3) +
  
  scale_color_manual(
    name = NULL,
    values = c('#9e145e', '#d25b94','#f7b6d2')
  ) +
  
  scale_linetype_manual(
    name = NULL, 
    values = c("solid", "solid", "solid") 
  ) +
  
  geom_hline(
    yintercept = 18.3,
    color = "grey70",
    linetype = "dashed", 
    size = 0.8
  ) +
  
  annotate("text", 
           x = 4, y = 18.5,
           label = "Incidence at birth",
           size = 2.5,
           color = "grey40",
           hjust = 0.5) +  
  
  theme(
    panel.grid.major.y = element_line(color = "grey90"),
    plot.background = element_rect(fill = "#FFFFFF"),
    panel.background = element_rect(fill = "#FFFFFF"),
    panel.border = element_blank(),
    axis.line = element_line(colour = 'black'),
    axis.title = element_text(size = 10),
    legend.title = element_text(size = 9),
    legend.text = element_text(size = 9),
    legend.key.size = unit(1, "lines"),
    legend.key = element_rect(fill = "white", color = NA),
    axis.text.y = element_text(size = 8),
    axis.text.x = element_text(size = 8),
    plot.title = element_text(hjust = 0.5, size = 8, face = 'bold'),
    legend.position = c(0.75, 0.15)
  ) +
  
  xlab("Missing observations at birth (%)") +
  scale_x_continuous(
    limits = c(0, 50),
    breaks = seq(0, 50, by = 10)
  ) +
  
  ylab("Incidence proportion at 3 months (%)") +
  scale_y_continuous(
    limits = c(14, 22),
    breaks = seq(14, 22, by = 1)
  ) +
  
  guides(
    color = guide_legend(override.aes = list(
      linetype = "solid",
      size = 1
    ))
  )

Fig2Plot

ggsave("LGF_Fig2_250120.jpg", plot = Fig2Plot, units = "in", dpi = 300, width = 5, height = 5)

####################################################################

####################################################################
### Figure 3 (panels a and b)

# Load data for Fig3a
library(readxl)
Fig3a <- read_excel("/{FOLDER_PATH}/LGF_Fig3a4a_Rdata_250120.xlsx")

# Set up variables
Fig3a$change_laz <- as.character(round(as.numeric(as.character(Fig3a$change_laz)), 1))
Fig3a$change_laz[Fig3a$change_laz=="0"] <- "0"
Fig3a$laz0 <- as.character(round(as.numeric(as.character(Fig3a$laz0)), 1))
Fig3a$laz0[Fig3a$laz0=="0"] <- "0"
Fig3a$change_laz_factor <- factor(Fig3a$change_laz, levels=c("-0.4", "-0.3", "-0.2", "-0.1", "0"))
Fig3a$laz0_factor <- factor(Fig3a$laz0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create Fig3a plot
Figure3a <- ggplot(Fig3a) +
  geom_bar(aes(x = laz0_factor, y = percentage, fill = Metric),
           position = "dodge",
           stat = "identity") +
  facet_grid(~change_laz_factor) +
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        strip.background = element_rect(fill='grey', size=0.5),
        strip.text = element_text(size = 8, face = 'bold'),
        panel.spacing = unit(0.09, "cm"),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour = 'black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8),
        plot.title = element_text(hjust = 0.5, size=9, face='bold', vjust = 0)) +
  xlab("Starting mean LAZ") +
  ylab("Percent (%)") +
  ylim(0, 31) +
  ggtitle('Change in mean LAZ') +
  scale_fill_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c("#332288", "#88CCEE"))

# Load data for Fig3b
Fig3b <- read_excel("/{FOLDER_PATH}/LGF_Fig3b4b_Rdata_250120.xlsx")

# Set up variables
Fig3b$correlation <- as.character(round(as.numeric(as.character(Fig3b$correlation)), 1))
Fig3b$correlation[Fig3b$correlation=="1"] <- "1"
Fig3b$LAZ0 <- as.character(round(as.numeric(as.character(Fig3b$LAZ0)), 1))
Fig3b$LAZ0[Fig3b$LAZ0=="0"] <- "0"
Fig3b$corr_factor <- factor(Fig3b$correlation, levels=c("0.6", "0.7", "0.8", "0.9", "1"))
Fig3b$laz0_factor <- factor(Fig3b$LAZ0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create Fig3b plot
Figure3b <- ggplot(Fig3b) +
  geom_bar(aes(x = laz0_factor, y = percentage, fill = Metric),
           position = "dodge",
           stat = "identity") +
  facet_grid(~correlation) +
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        strip.background = element_rect(fill='grey', size=1.5),
        strip.text = element_text(size = 8, face = 'bold'),
        panel.spacing = unit(0.09, "cm"),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill  = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour='black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8),
        plot.title = element_text(hjust = 0.5, size=9, face='bold', vjust = 0)) +
  xlab("Starting mean LAZ") +
  ylab("Percent (%)") +
  ylim(0, 30) +
  ggtitle('Between-timepoint correlation') +
  scale_fill_manual(name="", labels=c("Incident stunting onset", "Stunting reversal"), values=c("#332288", "#88CCEE"))

# Combine the plots without the numbers above the bars
combined_plot3 <- ggarrange(Figure3a, Figure3b, nrow=2, labels = c("a", "b"), common.legend = TRUE, legend="right")

combined_plot3

# Save the combined plot as a jpeg
ggsave("LGF_Fig3_250120.jpg", plot = combined_plot3, units = "in", dpi = 300, width = 10, height = 5)


####################################################################

####################################################################
### Figure 4 (panels a and b)

# Load data for Fig4a
library(readxl)
Fig4a <- read_excel("/{FOLDER_PATH}/LGF_Fig3a4a_Rdata_250120.xlsx")

# Set up variables
Fig4a$change_laz <- as.character(round(as.numeric(as.character(Fig4a$change_laz)), 1))
Fig4a$change_laz[Fig4a$change_laz=="0"] <- "0"
Fig4a$laz0 <- as.character(round(as.numeric(as.character(Fig4a$laz0)), 1))
Fig4a$laz0[Fig4a$laz0=="0"] <- "0"
Fig4a$change_laz_factor <- factor(Fig4a$change_laz, levels=c("-0.4", "-0.3", "-0.2", "-0.1", "0"))
Fig4a$laz0_factor <- factor(Fig4a$laz0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create 4a plot
Fig4a<- ggplot(Fig4a) +
  geom_point(aes(x = laz0_factor, y = Ratio, colour = Metric, shape = Metric, size = Metric)) +
  facet_grid(~change_laz_factor) +
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        strip.background = element_rect(fill='grey', size=0.5),
        strip.text = element_text(size = 8, face = 'bold'),
        panel.spacing = unit(0.09, "cm"),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour = 'black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8),
        plot.title = element_text(hjust = 0.5, size=9, face='bold', vjust = 0)) +
  xlab("Starting mean LAZ") +
  ylab("Ratio (reference LAZ change = 0)") +
  ylim(1, 3) +
  ggtitle('Change in mean LAZ') +
  scale_colour_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c("#332288", "#88CCEE")) +
  scale_shape_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c(15, 16)) +
  scale_size_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c(2.4, 2)) +
  guides(
    color = guide_legend(override.aes = list(shape = c(15, 16))),
    shape = guide_legend(override.aes = list(colour = c("#332288", "#88CCEE"))
    ))
    
# Load data for Fig4b
Fig4b <- read_excel("/{FOLDER_PATH}/LGF_Fig3b4b_Rdata_250120.xlsx")

# Set up variables
Fig4b$correlation <- as.character(round(as.numeric(as.character(Fig4b$correlation)), 1))
Fig4b$correlation[Fig4b$correlation=="1"] <- "1"
Fig4b$LAZ0 <- as.character(round(as.numeric(as.character(Fig4b$LAZ0)), 1))
Fig4b$LAZ0[Fig4b$LAZ0=="0"] <- "0"
Fig4b$corr_factor <- factor(Fig4b$correlation, levels=c("0.6", "0.7", "0.8", "0.9", "1"))
Fig4b$laz0_factor <- factor(Fig4b$LAZ0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create Fig4b plot
Fig4b<- ggplot(Fig4b) +
  geom_point(aes(x = laz0_factor, y = Ratio, colour = Metric, shape = Metric, size = Metric)) +
  facet_grid(~corr_factor) +
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        strip.background = element_rect(fill='grey', size=0.5),
        strip.text = element_text(size = 8, face = 'bold'),
        panel.spacing = unit(0.09, "cm"),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour = 'black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8),
        plot.title = element_text(hjust = 0.5, size=9, face='bold', vjust = 0)) +
  xlab("Starting mean LAZ") +
  ylab("Ratio (reference corr = 0.9)") +
  ylim(1, 3) +
  ggtitle('Between-timepoint correlation') +
  scale_colour_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c("#332288", "#88CCEE")) +
  scale_shape_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c(15, 16)) +
  scale_size_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c(2.4, 2)) +
  guides(
  color = guide_legend(override.aes = list(shape = c(15, 16))),
  shape = guide_legend(override.aes = list(colour = c("#332288", "#88CCEE"))
  ))

#################
combined_plot4 <- ggarrange(Fig4a, Fig4b, nrow=2, labels = c("a", "b"), common.legend = TRUE, legend="right")

combined_plot4

# Save the combined plot as a jpeg
ggsave("LGF_Fig4_250120.jpg", plot = combined_plot4, units = "in", dpi = 300, width = 8, height = 6)


####################################################################

####################################################################
### Figure 5

SA_monthly <- read_excel("/{FOLDER_PATH}/LGF_Fig5_Rdata_250120.xlsx")

SA_LAZ_age <- ggplot(data=SA_monthly, aes(x=age_mos, y=m_laz))+
  geom_smooth(se=FALSE, size = 1, colour = 'forestgreen')+
  ylim(-2,0.5)+
  xlab("Child age (months)")+
  ylab("Length-for-age Z-score")+
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill  = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour='black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8))

SA_monthly$stunt_perct <- SA_monthly$stunt_prop * 100

SA_stunt_age <-ggplot(data=SA_monthly, aes(x=age_mos, y=stunt_perct))+
  geom_smooth(se=FALSE, size = 1, colour = 'royalblue')+
  ylim(0,100)+
  xlab("Child age (months)")+
  ylab("Stunting Prevalence (%)")+
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill  = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour='black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8))

SA_monthly$GD_mos <- SA_monthly$GD / 30.4375

SA_GD_age <- ggplot(data=SA_monthly, aes(x=age_mos, y=GD_mos))+
  geom_smooth(se=FALSE, size = 1, colour = 'maroon')+
  ylim(0,6)+
  xlab("Child age (months)")+
  ylab("Growth Delay (months)")+
  theme(panel.grid.major.y = element_line(color = "grey90",
                                          size = 0.3),
        plot.background = element_rect(fill = "#FFFFFF"),
        panel.background = element_rect(fill  = "#FFFFFF"),
        panel.border = element_blank(),
        axis.line = element_line(colour='black'),
        axis.title = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8))

Fig5 <- ggarrange(SA_LAZ_age, SA_stunt_age, SA_GD_age, labels = c("a", "b","c"),ncol=3)

Fig5

ggsave("LGF_Fig5_250120.jpg", plot = Fig5, units = "in", dpi = 300, width = 10, height = 2.5)
  
####################################################################
#END
####################################################################
