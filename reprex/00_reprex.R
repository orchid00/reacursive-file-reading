# Author : Paula Andrea Martinez
# Topic: Separate a column list
# Date 14/10/2020


library(tidyverse)


# step 1 Create list column ----
# create a column list of tibbles each with three columns and variable nrows
file_contents <- list(
  tibble(id = 1:5,
         some = rep(1, 5),
         growth = rep(x = c(0,1),
                      length.out = 5
                      )),
  tibble(id = 1:4,
         some = rep(2, 4),
         growth = rep(x = c(0,1),
                      length.out = 4
         ))
  )

# check the tibble  
file_contents

summary(file_contents)


# Step 2 add list column to a tibble ----
# create a tibble
# holding the file names
# with the contents per file

bData <- tibble(filename = c("File1", "File2"),
                contents = file_contents) 
                               
bData

# Step 3 open up the list column, take 1 ----
bigTable <- unnest_longer(bData, contents)
bigTable

dim(bigTable)

### Question, why does bigTable has 2 columns instead of 4?

# Step 4 open up the list column, take 2 ----
bigTable <- unnest_longer(bData, contents) %>% 
  # manually extract the columns? there must be a better way!
  tibble(id = contents$id,
         some = contents$some,
         growth = contents$growth) %>% 
  select(-contents) # remove the column list

bigTable

dim(bigTable)

# now I have 4 columns. What I initially wanted
