    # Author : Paula Andrea Martinez
    # Topic: Separate a column list
    # Date 14/10/2020



    library(tidyverse)
    #> Warning: replacing previous import 'vctrs::data_frame' by 'tibble::data_frame'
    #> when loading 'dplyr'
    
    
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
    #> [[1]]
    #> # A tibble: 5 x 3
    #>      id  some growth
    #>   <int> <dbl>  <dbl>
    #> 1     1     1      0
    #> 2     2     1      1
    #> 3     3     1      0
    #> 4     4     1      1
    #> 5     5     1      0
    #> 
    #> [[2]]
    #> # A tibble: 4 x 3
    #>      id  some growth
    #>   <int> <dbl>  <dbl>
    #> 1     1     2      0
    #> 2     2     2      1
    #> 3     3     2      0
    #> 4     4     2      1

    summary(file_contents)
    #>      Length Class  Mode
    #> [1,] 3      tbl_df list
    #> [2,] 3      tbl_df list


    # Step 2 add list column to a tibble ----
    # create a tibble
    # holding the file names
    # with the contents per file

    bData <- tibble(filename = c("File1", "File2"),
                    contents = file_contents) 
                                   
    bData
    #> # A tibble: 2 x 2
    #>   filename contents        
    #>   <chr>    <list>          
    #> 1 File1    <tibble [5 × 3]>
    #> 2 File2    <tibble [4 × 3]>

    # Step 3 open up the list column, take 1 ----
    bigTable <- unnest_longer(bData, contents)
    bigTable
    #> # A tibble: 9 x 2
    #>   filename contents$id $some $growth
    #>   <chr>          <int> <dbl>   <dbl>
    #> 1 File1              1     1       0
    #> 2 File1              2     1       1
    #> 3 File1              3     1       0
    #> 4 File1              4     1       1
    #> 5 File1              5     1       0
    #> 6 File2              1     2       0
    #> 7 File2              2     2       1
    #> 8 File2              3     2       0
    #> 9 File2              4     2       1

    dim(bigTable)
    #> [1] 9 2

    ### Question, why does bigTable has 2 columns instead of 4?

    # Step 4 open up the list column, take 2 ----
    bigTable <- unnest_longer(bData, contents) %>% 
      # manually extract the columns? there must be a better way!
      tibble(id = contents$id,
             some = contents$some,
             growth = contents$growth) %>% 
      select(-contents) # remove the column list

    bigTable
    #> # A tibble: 9 x 4
    #>   filename    id  some growth
    #>   <chr>    <int> <dbl>  <dbl>
    #> 1 File1        1     1      0
    #> 2 File1        2     1      1
    #> 3 File1        3     1      0
    #> 4 File1        4     1      1
    #> 5 File1        5     1      0
    #> 6 File2        1     2      0
    #> 7 File2        2     2      1
    #> 8 File2        3     2      0
    #> 9 File2        4     2      1

    dim(bigTable)
    #> [1] 9 4

    # now I have 4 columns. What I initially wanted

<sup>Created on 2020-10-14 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>
