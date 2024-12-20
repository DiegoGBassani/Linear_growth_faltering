
########################################################################
## PROJECT: Linear Growth Faltering simulations
## PROGRAM: LGF_FigCode
## TASK: Generate main figures
## CREATED BY: Kelly Watson, The Hospital for Sick Children
## VERSION DATE: Nov 26, 2024


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

####################################################################
### Figure 1 Code

# Load data for Fig1
library(readxl)
Fig1 <- read_excel("C:/Data/LGF_Fig1_Rdata_241126.xlsx")

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
                        values = c("solid", "solid", "twodash", "solid", "solid", "twodash")) +  # Specify line types
  
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
  ylim(0, 25) +
  guides(color = guide_legend(override.aes = list(linetype = c("solid", "solid", "twodash", "solid", "solid", "twodash"),
                                                  shape = c(NA, NA, NA, NA, NA, NA)) ),
         title.position = "top", title.hjust = 0.5) +
  theme(legend.key.size = unit(1, "lines"),  
        legend.position = c(0.8,0.8))


ggsave("C:/Output/LGF_Fig1_241126.jpg", plot = Fig1Plot, units = "in", dpi = 300, width = 5, height = 5)

####################################################################

####################################################################
### Figure 2 Code

# Load data for Fig2a
library(readxl)
Fig2a <- read_excel("C:/Data/LGF_Fig2a3a_Rdata_241126.xlsx")
Fig2a$change_laz <- as.character(round(as.numeric(as.character(Fig2a$change_laz)), 1))
Fig2a$change_laz[Fig2a$change_laz=="0"] <- "0"
Fig2a$laz0 <- as.character(round(as.numeric(as.character(Fig2a$laz0)), 1))
Fig2a$laz0[Fig2a$laz0=="0"] <- "0"
Fig2a$change_laz_factor <- factor(Fig2a$change_laz, levels=c("-0.4", "-0.3", "-0.2", "-0.1", "0"))
Fig2a$laz0_factor <- factor(Fig2a$laz0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create Fig2a plot
Figure2a <- ggplot(Fig2a) +
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
        plot.title = element_text(hjust = 0.5, size=8, face='bold')) +
  xlab("") +
  ylab("Percent of total (%)") +
  ylim(0, 20) +
  ggtitle('Change in mean LAZ') +
  scale_fill_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c("#332288", "#88CCEE"))

# Load data for Fig2b
Fig2b <- read_excel("C:/Data/LGF_Fig2b3b_Rdata_241126.xlsx")
Fig2b$correlation <- as.character(round(as.numeric(as.character(Fig2b$correlation)), 1))
Fig2b$correlation[Fig2b$correlation=="1"] <- "1"
Fig2b$LAZ0 <- as.character(round(as.numeric(as.character(Fig2b$LAZ0)), 1))
Fig2b$LAZ0[Fig2b$LAZ0=="0"] <- "0"
Fig2b$corr_factor <- factor(Fig2b$correlation, levels=c("0.6", "0.7", "0.8", "0.9", "1"))
Fig2b$laz0_factor <- factor(Fig2b$LAZ0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create Fig2b plot
Figure2b <- ggplot(Fig2b) +
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
        plot.title = element_text(hjust = 0.5, size=8, face='bold')) +
  xlab("Starting mean LAZ") +
  ylab("Percent of total (%)") +
  ylim(0, 20) +
  ggtitle('Between-timepoint correlation') +
  scale_fill_manual(name="", labels=c("Incident stunting onset", "Stunting reversal"), values=c("#332288", "#88CCEE"))

# Combine the plots without the numbers above the bars
combined_plot <- ggarrange(Figure2a, Figure2b, nrow=2, labels = c("a", "b"), common.legend = TRUE, legend="right")

# Save the combined plot as a jpeg
ggsave("C:/Output/LGF_Fig2_241126.jpg", plot = combined_plot, units = "in", dpi = 300, width = 10, height = 5)


####################################################################

####################################################################
### Figure 3 Code

# Load data for Fig3a
library(readxl)
Fig3a <- read_excel("C:/Data/LGF_Fig2a3a_Rdata_241126.xlsx")
Fig3a$change_laz <- as.character(round(as.numeric(as.character(Fig3a$change_laz)), 1))
Fig3a$change_laz[Fig3a$change_laz=="0"] <- "0"
Fig3a$laz0 <- as.character(round(as.numeric(as.character(Fig3a$laz0)), 1))
Fig3a$laz0[Fig3a$laz0=="0"] <- "0"
Fig3a$change_laz_factor <- factor(Fig3a$change_laz, levels=c("-0.4", "-0.3", "-0.2", "-0.1", "0"))
Fig3a$laz0_factor <- factor(Fig3a$laz0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create 3a plot
Fig3a<- ggplot(Fig3a) +
  geom_point(aes(x = laz0_factor, y = Ratio, colour = Metric)) +
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
        plot.title = element_text(hjust = 0.5, size=8, face='bold')) +
  xlab("") +
  ylab("Ratio (reference LAZ change = 0)") +
  ylim(1, 3) +
  ggtitle('Change in mean LAZ') +
  scale_colour_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c("#332288", "#88CCEE"))

################################

# Load data for Fig3b
Fig3b <- read_excel("C:/Data/LGF_Fig2b3b_Rdata_241126.xlsx")
Fig3b$correlation <- as.character(round(as.numeric(as.character(Fig3b$correlation)), 1))
Fig3b$correlation[Fig3b$correlation=="1"] <- "1"
Fig3b$LAZ0 <- as.character(round(as.numeric(as.character(Fig3b$LAZ0)), 1))
Fig3b$LAZ0[Fig3b$LAZ0=="0"] <- "0"
Fig3b$corr_factor <- factor(Fig3b$correlation, levels=c("0.6", "0.7", "0.8", "0.9", "1"))
Fig3b$laz0_factor <- factor(Fig3b$LAZ0, levels=c("-1.6", "-1.2", "-0.8", "-0.4", "0"))

# Create Ext Data Fig1b plot
Fig3b<- ggplot(Fig3b) +
  geom_point(aes(x = laz0_factor, y = Ratio, colour = Metric)) +
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
        plot.title = element_text(hjust = 0.5, size=8, face='bold')) +
  xlab("Starting mean LAZ") +
  ylab("Ratio (reference corr = 0.9)") +
  ylim(1, 3) +
  ggtitle('Between-timepoint correlation') +
  scale_colour_manual(name = "", labels = c("Incident stunting onset", "Stunting reversal"), values = c("#332288", "#88CCEE"))

#################
combined_plot <- ggarrange(Fig3a, Fig3b, nrow=2, labels = c("a", "b"), common.legend = TRUE, legend="right")

# Save the combined plot as a jpeg
ggsave("C:/Output/LGF_Fig3_241126.jpg", plot = combined_plot, units = "in", dpi = 300, width = 8, height = 6)


####################################################################

####################################################################
### Figure 4 Code

SA_monthly <- read_excel("C:/Data/LGF_Fig4_Rdata_241126.xlsx")

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

Fig4 <- ggarrange(SA_LAZ_age, SA_stunt_age, SA_GD_age, labels = c("a", "b","c"),ncol=3)

ggsave("C:/Output/LGF_Fig4_241126.jpg", plot = Fig4, units = "in", dpi = 300, width = 10, height = 2.5)
