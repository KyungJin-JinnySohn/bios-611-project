##########################
# 02_EDA                 #
# Writer: Kyungjin Sohn  #
# Date: 10/27/2022       #
##########################

# 0. Call libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# 1. Read cleaned data
cardio.df <- read.csv("./derived_data/cardio_clean.csv", header = TRUE)
cardio.df <- cardio.df %>% 
     mutate(across(cholesterol:cardio, as.factor)) 
str(cardio.df)

# 2. Distribution of age groups by the presence of cardiovascular disease
dist.age <- cardio.df %>% 
     mutate(cardio = ifelse(cardio == 1, "Yes", "No")) %>% 
     group_by(age, cardio) %>% 
     summarise(total_cardio = n()) %>% 
     ggplot(., aes(x = age, y = total_cardio, fill = cardio)) +
     geom_bar(stat = "identity", position = "dodge") +
     theme_bw() +
     scale_fill_manual(values=c("lightblue", "pink")) +
     labs(title = "Distribution of age groups by the presence of cardio disease",
          x = "Age",
          y = "Total Count",
          fill = "Presence of cardio")
ggsave("./figures/dist_age.png", plot = dist.age, width = 10)

# 3. Density of BMI by the presence of cardio disease
dist.bmi <- cardio.df %>% 
     mutate(cardio = ifelse(cardio == 1, "Yes", "No")) %>% 
     ggplot(., aes(x = bmi, fill = cardio)) +
     geom_density(alpha = 0.4) +
     theme_bw() +
     scale_fill_manual(values=c("lightblue", "pink")) +
     labs(title = "Density of BMI by the presence of cardiovascular disease",
          x = "BMI",
          fill = "Presence of cardio")
ggsave("./figures/dist_bmi.png", plot = dist.bmi, width = 10)

# 4. Box-plot of blood pressure by the presence of cardiovascular disease
box.ap <- cardio.df %>% 
     select(ap_hi, ap_lo, cardio) %>%
     pivot_longer(., cols = c(ap_hi, ap_lo), names_to = "Var", values_to = "ap") %>%
     mutate(cardio = as.factor(ifelse(cardio == 1, "Yes", "No")),
            Var = ifelse(Var == "ap_hi", "Systolic(high)", "Diastolic(low)")) %>% 
     ggplot(aes(x = Var, y = ap, fill = cardio)) +
     geom_boxplot() +
     theme_bw() +
     scale_fill_manual(values=c("lightblue", "pink")) +
     labs(title = "Box-plot of blood pressure by the presence of cardio disease",
          x = "Types of blood pressure",
          y = "Blood pressure level",
          fill = "Presence of cardio")
ggsave("./figures/box_ap.png", plot = box.ap, width = 10)

# 5. Distribution of Categorical var. by the presence of cardio disease
order.col <- colnames(cardio.df)[7:ncol(cardio.df)]
bar.cate <- cardio.df %>% 
     select(cholesterol:cardio) %>% 
     mutate(cardio = as.factor(ifelse(cardio == 1, "Yes", "No"))) %>% 
     pivot_longer(., cols = cholesterol:is_male, names_to = "Var", values_to = "Val") %>% 
     mutate(Var = factor(Var, levels = order.col),
            Val = factor(Val, levels = 0:3)) %>% 
     ggplot(., aes(Val))+
     geom_bar(aes(fill = as.factor(cardio), y = (..count..)/sum(..count..)), 
              position="dodge") +
     facet_wrap(~Var) +
     theme_bw() +
     scale_fill_manual(values=c("lightblue", "pink")) +
        labs(title = "Distribution of Categorical var. by the presence of cardio disease",
             x = "Categorical variable",
             y = "Total Rate",
             fill = "Presence of cardio")
ggsave("./figures/bar_cate.png", plot = bar.cate, width = 10)
