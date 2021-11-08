library(tidyverse)
num_trials <- 1000000 # set the number of trials
set.seed(0) # set the random seed
sample_size <- 10 # set the sample siz

# simulate the sample average of a dice roll
dice_sample_average_simulation <- data.frame(trial = 1:num_trials) %>%
  mutate(dice_sample = map(.x = trial, ~sample(6, sample_size, replace = TRUE))) %>%
  mutate(sampl_avg = map_dbl(.x = dice_sample, ~mean(.x)))

# plot a histogram to display the results
dice_sample_average_simulation %>%
  ggplot(aes(x = sampl_avg)) + 
  geom_histogram(aes(y = ..count../sum(..count..)),
                 binwidth = 1/sample_size, fill = "blue", color = "blue") + 
  theme_bw() + 
  xlim(c(1, 6)) + 
  xlab("Sample average") + ylab("Proportion")

