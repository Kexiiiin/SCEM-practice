
## sample mode
# The sample mode is the value which occurs with the highest frequency for a feature 
mfv1(penguins$species)

## Estimates of location for continuous data
# Let’s look at rainfall data for San Martino for the first 100 days of 1985 using the hydroTSM library
data(SanMartinoPPts)
rainfall <- as.vector(window(SanMartinoPPts, start = as.Date("1985-01-01"), end = as.Date("1985-01-01") + 99))
                    
ggplot(tibble(rainfall), aes(x = rainfall)) + xlab("Daily rainfall (mm)") + geom_density(adjust = 10, size = 1) + xlim(c(0, 50))

## The sample mean
# The most well known estimate of location is the sample mean (the arithmetic mean)
mean(rainfall, na.rm = TRUE)

## The sample median
# The sample median is the middle value after sorting the values by numerical order
median(rainfall, na.rm = TRUE)

## Outliers
# An outlier is a value in a data set which differs substantially from other values.

## Robustness of the sample median
# A major advantage of the median over the mean is that it is robust to small corruptions in the data set.

## The trimmed sample mean
# The trimmed sample mean is the mean computed after removing a prescribed fraction of the data. 
mean(rainfall, na.rm = TRUE, trim = 0.05)

## Estimates of location with penguins data
# First load the palmer penguins library
library(palmerpenguins)
# Estimates of location
flippers <- penguins %>%
  filter(species == "Adelie") %>%
  select(flipper_length_mm) %>%
  unlist() %>%
  as.vector()
flippers
ggplot(tibble(flippers), aes(x = flippers)) + xlab("Flipper length (mm)") + geom_density(adjust = 1, size = 1)
ggplot(tibble(flippers), aes(x = flippers)) +
  geom_density(adjust = 1, size = 1) + xlab("Flipper length (mm)") + ylab("Density") +
  geom_vline(aes(xintercept = mean(flippers, na.rm = 1), linetype = "mean", color = "mean"), size = 1) +
  geom_vline(aes(xintercept = median(flippers, na.rm = 1), linetype = "median", color = "median"), size = 1) + 
  geom_vline(aes(xintercept = mean(flippers, na.rm = 1, trim = 0.1), linetype = "t_mean", color = "t_mean"), size = 1) +
  scale_linetype_manual(name = "stats", values =  c(mean = "dashed", median = "dotted", t_mean = "dotdash")) +
  scale_color_manual(name = "stats", values = c(mean = "red", median = "blue", t_mean = "purple")) + 
  ggtitle("Location estimatiors applied to flipper lengths")

ggplot(tibble(rainfall), aes(x = rainfall)) + 
  geom_density(adjust = 5, size = 1) + xlab("Daily rainfall (mm)") + ylab("Density") + 
  geom_vline(aes(xintercept = mean(rainfall, na.rm = 1), linetype = "mean", color = "mean"), size = 1) +
  geom_vline(aes(xintercept = median(rainfall, na.rm = 1), linetype = "median", color = "median"), size = 1) + 
  geom_vline(aes(xintercept = mean(rainfall, na.rm = 1, trim = 0.1), linetype = "t_mean", color = "t_mean"), size = 1) +
  scale_linetype_manual(name = "stats", values =  c(mean = "dashed", median = "dotted", t_mean = "dotdash")) +
  scale_color_manual(name = "stats", values = c(mean = "red", median = "blue", t_mean = "purple")) + 
  ggtitle("Location estimatiors applied to rainfall lengths")

## Sample quantiles and sample percentiles
quantile(flippers, na.rm = 1, probs = seq(from = 0, to = 1, by = 0.1))
probabilities <- c(0.25, 0.5, 0.75)
quantiles <- quantile(flippers, probs = probabilities, na.rm = 1)
quantiles
ggplot(tibble(flippers), aes(x = flippers)) + theme_bw() +
  geom_density(adjust = 1, size = 1) + xlab("Flipper length (mm)") + ylab("Density") + 
  geom_vline(xintercept = quantiles, linetype = "dashed", color = "blue") +
  annotate("label", x = quantiles, y = 0.0325, size = 5, fill = "white", label = probabilities) + 
  annotate("label", x = quantiles, y = 0.0275, size = 5, fill = "white", label = quantiles)

## The sample variance and sample standard deviation
# The classical measures of variability are the sample variance and sample standard deviation.
var(flippers, na.rm = 1)
sd(flippers, na.rm = 1)

## The sample median absolute deviation
# The median absolute deviation is a robust alternative to the standard deviation.
mad(flippers, na.rm = 1)

## The sample range
diff(range(flippers, na.rm = 1))

## The interquartile range
# The concept of quantiles can be used to give a more robust estimate of variability
quantile(flippers, probs = c(0.25, 0.5, 0.75), na.rm = 1)
IQR(flippers, na.rm = 1)

## Understanding box plots
ggplot(data = penguins, aes(y = flipper_length_mm, x = species)) + geom_boxplot() +
  ylab("Flipper length (mm)") + xlab("Penguin species")

## Interquartile range and outliers
# An outlier is a value in a data set which differs substantially from other values.
q25 <- quantile(flippers, 0.25, na.rm = 1)
q75 <- quantile(flippers, 0.75, na.rm = 1)
iq_range <- q75 - q25
outliers <- flippers[(flippers > q75 + 1.5 * iq_range) | (flippers < q25 - 1.5 * iq_range)]
outliers

## Relating variables via sample covariance and sample correlation
# The sample covariance give us ways to see how connected two variables or features.
cov(penguins$flipper_length_mm, penguins$bill_length_mm, use = "complete.obs")

# The sample correlation give us a way to see how connected two variables or features are
cor(penguins$flipper_length_mm, penguins$bill_length_mm, use = "complete.obs")
