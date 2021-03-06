library(tidyverse)
library(waffle)
library(cowplot)
fgd <- list()
custom_waffle <- 
  function(inp, rows = 4, title = "", xlab = "", size = 2, legend_pos = "none", colors = c("#e04c41", "#8ad468", "#4e95d4")){
  waffle(inp, rows = rows, title = title, xlab = xlab, 
         size = size, legend_pos = legend_pos,
         colors = colors, equal = TRUE)
} # custom plot to apply the same settings consistently
# Fig 2. Impact on Ag System (v. 2, avail, qual, price groups) ----
fgd$ag.sys$avail$seed <- custom_waffle(c(D=11, S=3, I=0), xlab = "Seeds and planting materials")
fgd$ag.sys$quali$seed <- custom_waffle(c(D=8, S=6, I=0), xlab = "Seeds and planting materials")
fgd$ag.sys$price$seed <- custom_waffle(c(D=0, S=6, I=8), xlab = "Seeds and planting materials")

fgd$ag.sys$avail$fert <- custom_waffle(c(D=12, S=2, I=0), xlab = "Chemical fertilizers")
fgd$ag.sys$quali$fert <- custom_waffle(c(D=6, S=8, I=0), xlab = "Chemical fertilizers")
fgd$ag.sys$price$fert <- custom_waffle(c(D=0, S=10, I=4), xlab = "Chemical fertilizers")

fgd$ag.sys$avail$feed <- custom_waffle(c(D=8, S=6, I=0), xlab = "Feed and veterinary medicine")
fgd$ag.sys$quali$feed <- custom_waffle(c(D=0, S=14, I=0), xlab = "Feed and veterinary medicine")
fgd$ag.sys$price$feed <- custom_waffle(c(D=0, S=11, I=3), xlab = "Feed and veterinary medicine")

fgd$ag.sys$avail$pest <- custom_waffle(c(D=3, S=11, I=0), xlab = "Pesticides")
fgd$ag.sys$quali$pest <- custom_waffle(c(D=0, S=14, I=0), xlab = "Pesticides")
fgd$ag.sys$price$pest <- custom_waffle(c(D=0, S=12, I=2), xlab = "Pesticides")

fgd$ag.sys$avail$labor <- custom_waffle(c(D=4, S=2, I=8), xlab = "Agricultural labor")
fgd$ag.sys$quali$labor <- custom_waffle(c(D=0, S=14, I=0), xlab = "Agricultural labor")
fgd$ag.sys$price$labor <- custom_waffle(c(D=0, S=13, I=1), xlab = "Agricultural labor")

fgd$ag.sys$avail$tech <- custom_waffle(c(D=8, S=6, I=0), xlab = "Technical services")
fgd$ag.sys$quali$tech <- custom_waffle(c(D=1, S=13, I=0), xlab = "Technical services")
fgd$ag.sys$price$tech <- custom_waffle(c(D=0, S=14, I=0), xlab = "Technical services")

fgd$ag.sys$mkt.acc <- custom_waffle(c(D=14, S=0, I=0), xlab = "Access")
fgd$ag.sys$mkt.pri <- custom_waffle(c(D=4, S=2, I=8), xlab = "Price")
fgd$ag.sys$mkt.dem <- custom_waffle(c(D=3, S=4, I=7), xlab = "Demand")
blank <- custom_waffle(c(D=0, S=0, I=0))

attach(fgd$ag.sys$avail)
a <- plot_grid(nrow = 1, labels = "(a) Change in availability of", hjust = 0, seed, fert, feed, pest, labor, tech)
detach()
attach(fgd$ag.sys$quali)
b <- plot_grid(nrow = 1, labels = "(b) Change in quality of", hjust = 0, seed, fert, feed, pest, labor, tech)
detach()
attach(fgd$ag.sys$price)
c <- plot_grid(nrow = 1, labels = "(c) Change in price of", hjust = 0, seed, fert, feed, pest, labor, tech)
detach()
attach(fgd$ag.sys)
d <- plot_grid(nrow = 1, labels = "(d) Change in market", hjust = 0, mkt.acc, mkt.pri, mkt.dem, blank, blank, blank)
detach()
plot_grid(nrow = 2, rel_heights = c(1, .4),
          plot_grid(nrow = 4, a, b, c, d),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig2_AgSystemsv2.pdf", units = "in", height = 10, width = 12, dpi = 600, device = "pdf")

# Fig 3. Impact on Production ----
fgd$prod$cereal <- custom_waffle(c(D=0, S=2, I=12), title = "Cereal production area")
fgd$prod$fruit <- custom_waffle(c(D=0, S=12, I=2), title = "Fruit production area")
fgd$prod$veg <- custom_waffle(c(D=0, S=0, I=12, pad=2), title = "Vegetable production area", 
                              colors = c("#e04c41", "#8ad468", "#4e95d4", "white"))
# added padding to align the vegetable plots
fgd$prod$all.crops <- custom_waffle(c(D=0, S=0, I=14), title = "Crop productivity")
fgd$prod$buff <- custom_waffle(c(D=2, S=7, I=5), title = "No. of buffaloes or cows")
fgd$prod$goat <- custom_waffle(c(D=0, S=1, I=13), title = "No. of goats")
fgd$prod$lo.chicken <- custom_waffle(c(D=0, S=1, I=13), title = "No. of local chicken")
fgd$prod$br.chicken <- custom_waffle(c(D=7, S=6, I=0), title = "No. of broiler chicken")
#combine it all
plot_grid(nrow = 2, rel_heights = c(1, .4),
          plot_grid(fgd$prod$cereal, fgd$prod$fruit, fgd$prod$veg, fgd$prod$all.crops, 
                    fgd$prod$buff, fgd$prod$goat, fgd$prod$lo.chicken, fgd$prod$br.chicken, ncol = 4),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "Legend", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig3_ImpactOnProduction.pdf", units = "in", height = 6, width = 14, dpi = 600, device = "pdf")


# Fig 4. Impact on Wetland Ecosystems ----
fgd$wetland$pollution <- custom_waffle(c(D=1, S=1, I=6), title = "Pollution")
fgd$wetland$res.use <- custom_waffle(c(D=3, S=2, I=3), title = "Resource use")
fgd$wetland$soc.con <- custom_waffle(c(D=0, S=1, I=7), title = "Social conflict")
fgd$wetland$fish.fin <- custom_waffle(c(D=6, S=2, I=0), title = "Fingerlings availability")
fgd$wetland$fish.prod <- custom_waffle(c(D=5, S=2, I=1), title = "Fish productivity")
fgd$wetland$fish.dem <- custom_waffle(c(D=0, S=0, I=8), title = "Fish demand")
fgd$wetland$fish.pri <- custom_waffle(c(D=0, S=7, I=1), title = "Fish price")
fgd$wetland$fish.sales <- custom_waffle(c(D=8, S=0, I=0), title = "Fish sales")
fgd$wetland$fish.ill <- custom_waffle(c(D=1, S=0, I=7), title = "Illegal fishing")

attach(fgd$wetland)
plot_grid(nrow = 2, rel_heights = c(1, .4), 
          plot_grid(ncol = 5, 
                    fish.fin, fish.prod, fish.dem, fish.pri, fish.sales, 
                    fish.ill, pollution, res.use, soc.con),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig4_Wetlands.pdf", units = "in", height = 6, width = 16, dpi = 600, device = "pdf")
detach()

# Fig 5. Impact on Forest Ecosystems ----
fgd$forest$poach <- custom_waffle(c(D=0, S=11, I=3), title = "Wildlife poaching")
fgd$forest$timber <- custom_waffle(c(D=0, S=9, I=5), title = "Illegal firewood/timber harvesting")
fgd$forest$hwc <- custom_waffle(c(D=0, S=14, I=0), title = "Human-wildlife conflict")
fgd$forest$soc <- custom_waffle(c(D=0, S=7, I=7), title = "Forest resource conflict")
fgd$forest$enc <- custom_waffle(c(D=0, S=12, I=2), title = "Forest area encroachment")
fgd$forest$overuse <- custom_waffle(c(D=0, S=6, I=8), title = "Resource overuse")
fgd$forest$mgmt <- custom_waffle(c(D=9, S=3, I=2), title = "Forest management activities")
# combined timber and firewood harvesting with resource over use as fire wood and staking material were mentioned in both notes.
fgd$forest$res.overuse <- custom_waffle(c(D=0, S=6, I=8), title = "Illegal resource use")

plot_grid(nrow = 2, rel_heights = c(1, .4), 
          plot_grid(ncol = 4,
                    fgd$forest$hwc, fgd$forest$poach, fgd$forest$enc, fgd$forest$res.overuse, 
                    fgd$forest$soc, fgd$forest$mgmt),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig5_Forests.pdf", units = "in", height = 6, width = 16, dpi = 600, device = "pdf")
          

# Fig 6. Survey results ----
custom_lollipop <- function(inp, x.label = ""){
  # inp has 2 columns: group as factor with levels, value with numbers
  ggplot(inp, aes(x=group, y=value, label=value, fill = group)) +
    geom_segment(aes(x=group, xend=group, y=0, yend=value), color = "grey", size = 1) +
    geom_point() +
    geom_label(color = "white", label.size = 0) +
    scale_fill_manual(values = c("#e04c41", "#8ad468", "#4e95d4")) +
    theme_light() +
    geom_hline(yintercept = 0, linetype = "solid", color = "grey", size = 2) +
    geom_hline(yintercept = 357, linetype = "dotted", color = "grey", size = .5) +
    geom_text(aes(1,357, label = "n = 357")) + # adjusts the position of the label (HHs no) on the dotted line
    theme_bw() +
    theme(legend.position = "none",
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank()) +
    labs(title = "", x = x.label, y = "")
} # function to draw lollipop plots with consistent settings.
sur <- list()
sur$conflict <- tibble(group = factor(c("D", "S", "I"), levels = c("D", "S", "I")), value = c(21, 296, 40)) %>%  
  custom_lollipop(x.label = "Family conflict")
sur$workload <- tibble(group = factor(c("D", "S", "I"), levels = c("D", "S", "I")), value = c(36, 207, 114)) %>%  
  custom_lollipop(x.label = "Women's workload")
sur$dv <- tibble(group = factor(c("D", "S", "I"), levels = c("D", "S", "I")), value = c(23, 307, 27)) %>%  
  custom_lollipop(x.label = "Violence against women")
sur$income <- tibble(group = factor(c("D", "S", "I"), levels = c("D", "S", "I")), value = c(230, 108, 19)) %>%  
  custom_lollipop(x.label = "Household income")
sur$expenses <- tibble(group = factor(c("D", "S", "I"), levels = c("D", "S", "I")), value = c(33, 79, 245)) %>%  
  custom_lollipop(x.label = "Household expenses")
sur$forest.use <- tibble(group = factor(c("D", "S", "I"), levels = c("D", "S", "I")), value = c(18, 284, 55)) %>%  
  custom_lollipop(x.label = "Forest resource use")
# combine it all - survey
attach(sur)
plot_grid(nrow = 2, rel_heights = c(1, .4),
          plot_grid(nrow = 1,
                    forest.use, income, expenses, conflict, workload, dv),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig6_HH_survey_results.pdf", units = "in", height = 4, width = 12, dpi = 600, device = "pdf")
detach()

# Fig 7. Impact on Livelihoods ----
fgd$live$skill.labor <- custom_waffle(c(D=9, S=3, I=3), title = "Skilled labor availability")
fgd$live$unskill.labor <- custom_waffle(c(D=1, S=3, I=11), title = "Unskilled labor availability")
fgd$live$mig.engage <- custom_waffle(c(D=0, S=5, I=10), title = "Returnee migrant engagement")
fgd$live$new.biz <- custom_waffle(c(D=0, S=9, I=6), title = "New enterprises or intiatives")
fgd$live$invest <- custom_waffle(c(D=11, S=0, I=4), title = "Cooperative investments")
fgd$live$inter <- custom_waffle(c(D=12, S=2, I=0), title = "Cooperative interest rates")

attach(fgd$live)
plot_grid(nrow = 2, rel_heights = c(1, .4), 
          plot_grid(ncol = 3, 
                    skill.labor, unskill.labor, mig.engage, new.biz, invest, inter),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig7_Livelihoods.pdf", units = "in", height = 6, width = 18, dpi = 600, device = "pdf")
detach()

# Fig 8. Impact on social and gender dimensions ----
fgd$soc$soc.con <- custom_waffle(c(D=0, S=8, I=7), title = "Social conflict")
fgd$soc$workload <- custom_waffle(c(D=8, S=1, I=6), title = "Women's workload")
fgd$soc$dv <- custom_waffle(c(D=1, S=14, I=0), title = "Violence against women")
fgd$soc$alcohol <- custom_waffle(c(D=1, S=7, I=7), title = "Alcohol consumption")
fgd$soc$stress <- custom_waffle(c(D=0, S=1, I=14), title = "Mental stress")
fgd$soc$festivals <- custom_waffle(c(D=3, S=12, I=0), title = "Celebrations and festivities")
# combine it all
attach(fgd$soc)
plot_grid(nrow = 2, rel_heights = c(1, .4),
          plot_grid(ncol = 3, labels = "",
                    soc.con, workload, dv, alcohol, stress, festivals),
          custom_waffle(c(Decrease=1, Same=0, Increase=0), xlab = "", legend_pos = "top")) %>% 
  ggsave(plot = ., filename = "Fig8_SocialGender.pdf", units = "in", height = 6, width = 18, dpi = 600, device = "pdf")
detach()
# save session info ----
writeLines(capture.output(sessionInfo()), "sessionInfo.txt")
