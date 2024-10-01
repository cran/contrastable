## ----include = FALSE----------------------------------------------------------
 knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
 )

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(contrastable)
library(rlang)

## ----results='hide'-----------------------------------------------------------
set_contrasts(mtcars, cyl ~ sum_code)

## ----results='hide'-----------------------------------------------------------
my_data <- mtcars
my_data$gear <- ordered(my_data$gear)
my_data$carb <- factor(my_data$carb)
my_data$cyl <- factor(my_data$cyl)

set_contrasts(my_data, cyl ~ sum_code)

## ----results='hide'-----------------------------------------------------------
my_data <- mtcars
my_data$gear <- ordered(my_data$gear)

set_contrasts(my_data, gear ~ sum_code)

## -----------------------------------------------------------------------------
my_data <- data.frame(foo = factor("A"),
                      boo = factor(c("B", "C")))

enlist_contrasts(my_data, foo ~ sum_code, boo ~ sum_code)

## -----------------------------------------------------------------------------
my_data <- data.frame(foo = factor("A"),
                      boo = factor(c("B", "C")))

try(enlist_contrasts(my_data, foo ~ sum_code))

## ----results='hide'-----------------------------------------------------------
my_matrix <- sum_code(3)  # current class is "matrix" "array"
class(my_matrix) <- "foo" # now class is "foo"

set_contrasts(mtcars, cyl ~ my_matrix) # idk what to do with "foo" objects

## ----results='hide'-----------------------------------------------------------
class(my_matrix) <- c("foo", "matrix", "array")
set_contrasts(mtcars, cyl ~ my_matrix) # idk what "foo" is but i know "matrix"!

## ----results='hide'-----------------------------------------------------------
try(set_contrasts(mtcars, cyl ~ "sum_code")) # sum_code shouldnt be in quotes

## ----results='hide'-----------------------------------------------------------
try(set_contrasts(mtcars, cyl ~ 4 + sum_code)) # bad!
try(set_contrasts(mtcars, cyl ~ sum_code + 4)) # good!

# These give different kinds of errors, all are ill-formed
try(set_contrasts(mtcars, cyl ~ +4 + sum_code)) 
try(set_contrasts(mtcars, cyl ~ c("a", "b") + sum_code)) 
try(set_contrasts(mtcars, cyl ~ 1 + 2 + 3 + sum_code)) 

## ----eval=FALSE, results='hide'-----------------------------------------------
#  library(hypr)
#  my_data <- data.frame(foo = factor(c("A", "B", "C")))
#  
#  hypr_object <- hypr::hypr(A ~ B, A ~ C)
#  
#  set_contrasts(my_data, foo ~ hypr_object + "B" * "B" - "C")

## ----eval=FALSE, results='hide'-----------------------------------------------
#  my_data <- data.frame(foo = factor(c("A", "B", "C")))
#  
#  hypr_object <- hypr::hypr(varA ~ varB, varA ~ varC)
#  
#  set_contrasts(my_data, foo ~ hypr_object)$foo

## ----eval=FALSE,results='hide'------------------------------------------------
#  my_data <- data.frame(foo = factor(c("A", "B", "C")),
#                        boo = factor(c("A", "B", "C")))
#  
#  hypr_object <- hypr::hypr(A ~ B, A ~ C)
#  
#  enlist_contrasts(my_data, foo ~ hypr_object, boo ~ sum_code)

## ----results='hide'-----------------------------------------------------------
my_data <- data.frame(foo = factor("A"),
                      boo = factor(c("B", "C")))

glimpse_contrasts(my_data, boo ~ sum_code)

## ----results='hide'-----------------------------------------------------------
my_data <- data.frame(foo = factor("A"),
                      boo = factor(c("B", "C")))

# Define our contrasts outside the call
clist <- list(boo ~ sum_code)

glimpse_contrasts(my_data, clist) # Note the final line in the warning

## ----results='hide'-----------------------------------------------------------
my_data <- mtcars
my_data$cyl <- factor(my_data$cyl)

# This will erase the column names
contrasts(my_data$cyl) <- helmert_code(3)

glimpse_contrasts(my_data, cyl ~ helmert_code)

## ----results='hide'-----------------------------------------------------------
my_data <- mtcars
my_data$cyl <- factor(my_data$cyl) # contr.treatment by default

glimpse_contrasts(my_data, cyl ~ treatment_code | c("6vs4", "8vs4"))

## ----results='hide'-----------------------------------------------------------
my_data <- mtcars

glimpse_contrasts(my_data, cyl ~ sum_code)

## ----results='hide'-----------------------------------------------------------
my_data <- mtcars
my_data$cyl <- factor(my_data$cyl) # contr.treatment by default
my_data$carb <- factor(my_data$carb)
contrasts(my_data$cyl) <- sum_code(3)
my_data$am <- factor(my_data$am)

glimpse_contrasts(my_data, 
                  cyl ~ sum_code, 
                  carb ~ sum_code, 
                  gear ~ sum_code,
                  am ~ treatment_code | c("diffLabel"))

## -----------------------------------------------------------------------------
my_data <- set_contrasts(mtcars, cyl ~ sum_code, verbose = FALSE)

glimpse_contrasts(my_data)

## ----results='hide'-----------------------------------------------------------
contrast_list <- list(cyl ~ scaled_sum_code, 
                      carb ~ sum_code, 
                      gear ~ sum_code,
                      am ~ treatment_code | c("diffLabel"))

my_data <- set_contrasts(mtcars, contrast_list, verbose = FALSE)
glimpse_contrasts(my_data, contrast_list)

## -----------------------------------------------------------------------------
my_matrix <- sum_code(4)
try(set_contrasts(mtcars, cyl ~ my_matrix)) # cyl has 3 levels, not 4

## -----------------------------------------------------------------------------
try(set_contrasts(mtcars, cyl ~ sum_code + 100))
try(set_contrasts(mtcars, cyl ~ sum_code * "blah"))

## -----------------------------------------------------------------------------
try(set_contrasts(mtcars, cyl = sum_code))

## -----------------------------------------------------------------------------
try(set_contrasts(mtcars,
                         cyl ~ sum_code, 
                         cyl ~ scaled_sum_code))

try(set_contrasts(mtcars, 
                         cyl + gear ~ sum_code,
                         cyl ~ scaled_sum_code))

try(set_contrasts(mtcars, 
                         where(is.numeric) ~ sum_code, 
                         cyl ~ scaled_sum_code))

these_vars <- c("cyl", "gear")

try(set_contrasts(mtcars, 
                         all_of(these_vars) ~ sum_code, 
                         where(is.numeric) ~ scaled_sum_code))

## -----------------------------------------------------------------------------
try(set_contrasts(cyl ~ sum_code))

## -----------------------------------------------------------------------------
try(set_contrasts(mtcars))

## -----------------------------------------------------------------------------
try(set_contrasts(data.frame(a = factor(1)),
                         a ~ sum_code))

