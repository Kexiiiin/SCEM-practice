## Data wrangling

# We will then introduce and explore the basics of data wrangling using the dplyr library.
# What will we cover today?
# • Extracting subsets
# • Adding new columns
# • Rearranging your rows
# • Summarizing your data
# • Fusing together data frames.

library(tidyverse)
library(palmerpenguins)

head(penguins)

## Tabular data (include rows and columns data)

## The select function
# The select function allows us to extract several columns.
select(penguins, species, bill_length_mm, body_mass_g)

# The select function also allows us to remove several columns.
select(penguins, -species, -bill_length_mm, -body_mass_g)

## The filter function
# The filter function allows us to extract a subset of rows
filter(penguins, species == "Gentoo")

# We can also combine two or more conditions within the filter function
filter(penguins, species == "Gentoo" & body_mass_g > 5000)

## Combining filter & select functions
# We often combine filter with select to get a sub table.
select(filter(penguins, species == "Gentoo"), species, bill_length_mm, body_mass_g)

# The pipe operator
# We can also chain multiple operations with the pipe operator %>%
penguins %>% 
  filter(species == "Gentoo") %>%
  select(species, bill_length_mm, body_mass_g)
# The pipe operator %>% is taken from the magrittr package which is also part of the tidyverse

# The pipe   operator %>% allows arguments to be implicitly passed as objects to the function after the pipe
f <- function(a, b){ return(a ^ 2 + b)}
f(3, 1)
3 %>% f(1)

## The mutate function
# The mutate function allows us to create a new column as a function of existing columns.
my_penguins <- penguins %>%
  mutate(flipper_bill_ratio = flipper_length_mm / bill_length_mm) %>%
  select(species, bill_length_mm, flipper_length_mm, flipper_bill_ratio)
my_penguins

ggplot(data = rename(my_penguins, Species = species), aes(x = flipper_bill_ratio, y = Species, fill = Species)) +
  geom_violin() + theme_bw() + xlab("Flipper bill ratio")

## The rename function
# The rename function allows us to rename an existing column. 
my_penguins %>% rename(f_over_b = flipper_bill_ratio)

## The arrange function
# We can sort the rows of a table via the arrange function.
my_penguins %>% arrange(desc(bill_length_mm)) # decresing order (dec for decending)
my_penguins %>% arrange(bill_length_mm) 

## Summarizing data
# To understand data we can extract summary statistics from a data frame.
# The summarize function computes vector functions across the entire data frame.
# mean() function: to calculate the average number
# na.rm = TRUE: telling R how to treat missing number, remove any not numbers.
penguins %>% 
  summarize(
    num_rows = n(), avg_weight_kg = mean(body_mass_g / 1000, na.rm = TRUE), avg_flipper_bill_ratio = 
      mean(flipper_length_mm / bill_length_mm, na.rm = TRUE)
  )

## The groupby function
# To obtain summaries by group we can combine the summarize and groupby functions
# Group the summaries by different species
penguins %>% 
  group_by(species) %>%
  summarize(
    num_rows = n(), avg_weight_kg = mean(body_mass_g / 1000, na.rm = TRUE), avg_flipper_bill_ratio = 
      mean(flipper_length_mm / bill_length_mm, na.rm = TRUE)
  )
  
## The across function
# The across function allows us to apply a function within summarize to all columns at once.
penguins %>%
  summarise(across(everything(), ~sum(is.na(.x))))
# work out the total number of the missing values in each of the columns within our data frame
# is.na(.x): check each of the rows of that column to see are they missing values

## The across function combined with where
# We can also restrict apply the function to a subset of columns of a prescribed form
penguins %>% 
  summarize(across(where(is.numeric), ~mean(.x, na.rm = TRUE)))

## Combining the summarize, groupby and across functions
# To obtain summaries by group we can combine the summarize and groupby functions.
penguins %>%
  select(-year) %>%
  group_by(species) %>%
  summarize(across(where(is.numeric), ~mean(.x, na.rm = TRUE)), num_rows = n())

## Join functions
# Join functions allow us to fuse multiple data frames
# First we extract a data frame of bill lengths by species.
penguin_bill_lengths_df <- penguins %>%
  arrange(desc(bill_length_mm)) %>%
  select(species, bill_length_mm)
penguin_bill_lengths_df
# Next we create a data frame of latin species names.
species <- unique(penguins$species)
latin_name <- c("Pygoscelies adeliae", "Pygoscelis papua", "Pygoscelis antarcticus")
latin_name_df <- data.frame(species, latin_name)
latin_name_df
# Finally we can fuse these two data frames with a join function.
penguin_bill_lengths_df %>%
  inner_join(latin_name_df)

## Types of join functions
#  There are four basic join functions, each of which deals with missing rows differently
# inner join; full join; left join and right join
# What happens when the set of values on the common column is not the same for both tables?
band_members
band_instruments
# “Mick” only appears in “band_members” and “Keith” only appears in “band_instruments”. 

# inner join: The inner join extracts the rows with a common entry in both tables
# which the value in common column appears in  both data frmaes
inner_join(band_members, band_instruments)

# full join: The full join (also known as an outer join) extracts the rows with an entry in either tables.
full_join(band_members, band_instruments)

# left join: The left join extracts the rows with an entry in the left table.
left_join(band_members, band_instruments)

# right join: The right join extracts the rows with an entry in the right table.
right_join(band_members, band_instruments)
