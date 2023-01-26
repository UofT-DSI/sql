library(DBI)
library(RSQLite)
library(dplyr)
library(tidymodels)
library(vetiver)
library(plumber)

### DATA EXTRACT ###
#set your location, slash direction will change for windows and mac
DB <- '/Users/thomas/Documents/GitHub/02-intro_sql/SQL/FarmersMarket.db'

#establish your connection
conn <- dbConnect(SQLite(), DB) 


### DATA MANIPULATION ###
#run your query (technically part of extract too)
db_df <- dbGetQuery(conn, 
        "SELECT 
           species,
           island,
           bill_length_mm,
           bill_depth_mm,
           flipper_length_mm,
           body_mass_g,
           CASE WHEN sex = 'NA' 
            THEN NULL
            ELSE sex
            END AS sex
         FROM penguins
         WHERE sex != 'NA'") # removing our missing sex variables, R likes NA better than NULL

# our decision tree algorithm requires our text values become factors instead
db_df <- 
  db_df %>% tibble() %>% 
  mutate(species = as.factor(species),
         island = as.factor(island),
         sex = as.factor(sex))


### MACHINE LEARNING, DECISION TREE ALGORITHM ###
# split into training and testing
set.seed(123)
penguin_split <- initial_split(db_df, strata = species) #for tidymodels, strata specifies our label
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)

# cross validate specifications
set.seed(234)
penguins_folds <- vfold_cv(penguin_train)

# specify the algorithm and the mode (classification vs regression)
dt_spec <- 
  decision_tree() %>%
  set_mode("classification")

# R requires a formula to pass to the algorithm
# this formula is `label ~ column1,column2,...`
# here we use ~ . to say all columns, since we already filtered which columns we wanted in SQL 
# tidymodels allows us to perform additional preprocessing here, but we aren't doing any
# some examples would be: create dummy variables, remove zero variance variables, etc
penguin_wf <- workflow() %>%
  add_formula(species ~ .)

# we build our "recipe":
# using the formula
# 1) add the DT model
# 2) perform cross validation
# 3) save the outcome predictions
dt_rs <- penguin_wf %>%
  add_model(dt_spec) %>%
  fit_resamples(
    resamples = penguins_folds,
    control = control_resamples(save_pred = TRUE)
  )

# get our metrics
collect_metrics(dt_rs)

# using the "previous fit" aka the model parameters
# run the model
penguin_final <- penguin_wf %>%
  add_model(dt_spec) %>%
  last_fit(penguin_split)

# get our final metrics
collect_metrics(penguin_final)

# produce our confusion matrix
collect_predictions(penguin_final) %>%
  conf_mat(species, .pred_class)

### MODEL MONITORING ###
# create a live model using our workflow from above
v <- penguin_final %>%
  extract_workflow() %>%
  vetiver_model("penguins")

#augment(v, slice_sample(penguin_test, n = 25))

# use a built in API to test the model in real-time!
pr() %>% 
  vetiver_api(v) %>% 
  pr_run()



