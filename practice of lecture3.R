install.packages("tidyverse")
library(tidyverse)

install.packages("palmerpenguins")
library(palmerpenguins)

# we can take a look at the data set by using the head()   function
head(penguins)

##  Univariate plots
# Histograms plots
univar_plot <- ggplot(data = penguins, aes(x = flipper_length_mm)) + xlab("Flipper length (mm)")
univar_plot + geom_histogram(binwidth = 5) + ylab("Count")

# the density plots
univar_plot + geom_density(adjust = 0.5) + ylab("Density")
# A density plot is a smoothed
# analogue of a histogram.
# Counts are replaced with smoothed
# bump functions ie. kernels

## Skewness
# nagative skewed data and positive ...

# Unimodal vs. multi-moda
# The number of modes refers to the number of peaks within the data.

## Bivariate plots
ggplot(data = rename(penguins, Species = species), aes(x = flipper_length_mm, color = Species)) + 
  geom_density() + theme_bw() + xlab("Flipper length (mm)") + ylab("Density")

# Box plots
ggplot(data = penguins, aes(x = flipper_length_mm, y = species)) + geom_boxplot() + 
  xlab("Flipper length (mm)") + ylab("Panguin species")

# Violin plots
ggplot(data = rename(penguins, Species = species), aes(x = flipper_length_mm, y = Species, fill = Species)) +
   geom_violin()+ theme_bw() + xlab("Flipper length (mm)")

# Scatter plots
mass_flipper_scatter <- ggplot(data = penguins, aes(y = body_mass_g, x = flipper_length_mm)) +
   xlab("Flipper length (mm)") + ylab("Body mass (g)")
mass_flipper_scatter + geom_point(size = 3)

## Multivariate plots
mass_flipper_scatter + geom_point(aes(color = bill_length_mm), size = 3) + 
   scale_color_gradient(low = "blue", high = "red") + guides(color = guide_legend("Bill length (mm)"))

mass_flipper_scatter + geom_point(aes(color = bill_length_mm, size = bill_depth_mm)) + 
   scale_color_gradient(low = "blue", high = "red") +
   guides(color = guide_legend("Bill length (mm)"), size = guide_legend("Bill depth (mm)"))

mass_flipper_scatter + geom_point(aes(color = species, shape = species))

mass_flipper_scatter + geom_text(aes(label = species, color = species)) + guides(color = guide_legend("Species"))

## Facets
# different group in different panels
mass_flipper_scatter + geom_point() + facet_wrap(~species)

## Trend lines
trend_plot <- ggplot(data = filter(penguins, species == "Gentoo"), aes(y = body_mass_g, x = flipper_length_mm)) +
   xlab("Flipper length (mm)") + ylab("Body mass (g)") + geom_point()
trend_plot + geom_smooth()
# Trend lines illustrate the relationship between two variables.
# the grey confidence region allows us to understand the degree of the uncertainty about the trend line

# create a linear lne
trend_plot + geom_smooth(method = 'lm')

## Annotation
min(filter(penguins, species == "Gentoo")$body_mass_g, na.rm = TRUE)
trend_plot + geom_smooth(method = "lm") + 
   geom_curve(x = 220, xend = 209, y = 4250, yend = 3975, arrow = arrow(length = unit(0.5, 'cm')), curvature = 0.1) + 
   geom_text(x = 225, y = 4250, label = "The lightest Gentoo \n penguin weighs 39.5kg")

