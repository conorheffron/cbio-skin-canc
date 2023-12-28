# Load unit test framework and libraries needed for source code
library(testthat)
library(rlang)

# Import source code for test
source("final_proj_imports.R")
source("final_proj_utils.R")

# Test variables / constants
test_col_vals <- c("CAT_3", "CAT_1", "CAT_2", "CAT_2", "CAT_3", "CAT_2")

test_col <- "DMT_PRIMARY_SITE"
test_df <- data.frame(DMT_PRIMARY_SITE = test_col_vals)

test_df_empty <- data.frame()

# Test Suite
test_that("Test count_agg NULL parameter for data frame or grouping column is NULL", {
  # When / Then
  expect_null(count_agg(NULL, NULL))
  expect_null(count_agg(test_df_empty, NULL))
  expect_null(count_agg(NULL, test_col))
})

test_that("Test count_agg(test_df, test_col) is equal to expected_result", {
  # Given
  test_col1_vals <- c("CAT_2", "CAT_3", "CAT_1")
  test_col2_vals <- c(3, 2, 1)
  test_col3_vals <- c(50, 33, 17)
  expected_result <- data.frame(DMT_PRIMARY_SITE = test_col1_vals, 
                                n = test_col2_vals, Freq = test_col3_vals)
  
  # When
  result <- count_agg(test_df, test_col)
  
  # Then
  expect_false(is.null(result))
  expect_equal(result, kable(expected_result, format = "simple"))
})

test_that("Test count_agg(test_df, test_col) is not equal to expected_result", {
  # Given
  test_col1_vals <- c("CAT_2", "CAT_3", "CAT_1")
  test_col2_vals <- c(5, 7, 3)# not equal expected
  test_col3_vals <- c(50, 17, 33)# not equal expected
  expected_result <- data.frame(DMT_PRIMARY_SITE = test_col1_vals, 
                                n = test_col2_vals, Freq = test_col3_vals)
  # When
  result <- count_agg(test_df, test_col)
  
  # Then
  expect_failure(expect_equal(result, kable(expected_result, format = "simple")))
})

test_that("Test import_skin_cancer_data function for all files that start with 'data_'", {
  # Given
  expected_df_ls <- c("data_clinical_patient", "data_clinical_sample", "data_cna", "data_gene_panel_matrix", "data_mutations", "data_sv")
  
  # When
  result <- import_skin_cancer_data(paste("mel_mskimpact_2020", sep="/"), "^data_")
  
  # Then
  expect_false(is.null(result))
  expect_equal(names(result), expected_df_ls)
  expect_false(is.null(result$data_clinical_patient))
})

test_that("Test import_skin_cancer_data function for all files that start with 'cases_'", {
  # Given
  expected_df_ls <- c("cases_all", "cases_cna", "cases_cnaseq", "cases_sequenced", "cases_sv")
  
  # When
  result <- suppressWarnings(import_skin_cancer_data(paste("mel_mskimpact_2020", "case_lists", sep="/"), "^cases_"))
  
  # Then
  expect_false(is.null(result))
  expect_equal(names(result), expected_df_ls)
  expect_false(is.null(result$cases_all))
})


