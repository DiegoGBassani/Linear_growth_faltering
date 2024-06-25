
########################################################################
## PROJECT: Response to HBGDki consortium 2023 paper #1
## PROGRAM: DR_KW_DB_FigCode_20240208
## TASK: Generate main figures
## CREATED BY: Kelly Watson, The Hospital for Sick Children
## DATE: Feb 08, 2024
## Updated: Jun 25th 2024
## Update note: Changing file name.

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

# Load data for Fig2a
Fig1 <- read_excel("DR_KW_DB_Fig1_Rdata_20240208.xlsx")

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


ggsave("DR_KW_DB_Fig1_20240208.jpg", plot = Fig1Plot, units = "in", dpi = 300, width = 5, height = 5)

####################################################################

####################################################################
### Figure 2 Code

# Load data for Fig2a
Fig2a <- read_excel("DR_KW_DB_MattersArising_Fig2a_Rdata_20240208.xlsx")
Fig2a$change_laz_factor <- as.factor(Fig2a$change_laz)
Fig2a$laz0_factor <- as.factor(Fig2a$laz0)

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
Fig2b <- read_excel("DR_KW_DB_Fig2b_Rdata_20240208.xlsx")
Fig2b$corr_factor <- as.factor(Fig2b$correlation)
Fig2b$laz0_factor <- as.factor(Fig2b$LAZ0)

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
ggsave("DR_KW_DB_Fig2_20240208.jpg", plot = combined_plot, units = "in", dpi = 300, width = 10, height = 5)

####################################################################
### Figure 3 Code

SA_monthly <- read_excel("DR_KW_DB_MattersArising_Fig3_Rdata_20240208.xlsx")

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

Fig3 <- ggarrange(SA_LAZ_age, SA_stunt_age, SA_GD_age, labels = c("a", "b","c"),ncol=3)

ggsave("DR_KW_DB_Fig3_20240208.jpg", plot = Fig3, units = "in", dpi = 300, width = 10, height = 2.5)

####################################################################
### Figure 4 Code

fig4 <- read_excel("DR_KW_DB_MattersArising_Fig4_Rdata_20240208.xlsx")

fig4_LAZ_age <- ggplot(data=fig4, aes(x=age_mos, y=m_laz))+
  geom_smooth(se=FALSE, size = 1, colour = 'forestgreen')+
  ylim(-2,-0.5)+
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

fig4$stunt_perct <- fig4$stunt_prop * 100

fig4_stunt_age <-ggplot(data=fig4, aes(x=age_mos, y=stunt_perct))+
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

fig4$GD_mos <- fig4$GD / 30.4375

fig4_GD_age <- ggplot(data=fig4, aes(x=age_mos, y=GD_mos))+
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

Fig4 <- ggarrange(fig4_LAZ_age, fig4_stunt_age, fig4_GD_age, labels = c("a", "b","c"),ncol=3)

ggsave("DR_KW_DB_Fig4_20240208.jpg", plot = Fig4, units = "in", dpi = 300, width = 10, height = 2.5)
