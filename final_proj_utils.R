source('final_proj_imports.R')

# Import skin cancer files for analysis from uncompressed file name/location
import_skin_cancer_data <- function(filename, pattern_regex) {
  # Check mandatory function arguments
  if (is.null(filename) | is.null(pattern_regex)) {
    return(NULL)
  }
  
  # Scan directory for files matching regular expression pattern for file name
  data_files = list.files(paste(filename, "/", sep=""), pattern=pattern_regex)
  
  # Instantiate list to hold imported data frames from plain text files
  data_sets <- list()
  for (file in data_files) {
    if (endsWith(file, '.txt') & grepl("_clinical_", file, fixed = TRUE)) {
      print(paste(file, "- importing clinical data"))
      data_sets[[file_path_sans_ext(file)]] <- import(paste(filename, file, sep="/"), skip=4, format = "txt")
    } else if (startsWith(file, 'cases_') & endsWith(file, '.txt')) {
      print(paste(file, "- importing cases data"))
      data_sets[[file_path_sans_ext(file)]] <- read_delim(paste(filename, file, sep="/"), delim = "\t", escape_double=FALSE, trim_ws=TRUE)
    } else if (endsWith(file, '.txt')) {
      print(paste(file, "- importing other data"))
      data_sets[[file_path_sans_ext(file)]] <- import(paste(filename, file, sep="/"), format = "txt")
    } else {
      print(paste(file, "is not needed for import..."))
    }
  }
  return(data_sets)
}

# Produce generic count n and frequency proportion/ percentage per specified 
# group column.
# There is also the option to specify the number of decimal digits to be 
# displayed for percentage frequency.
count_agg <- function(df, grp_col, n_results = 20, digits = 0, remove_ind = T) {
  # Check mandatory function arguments
  if (is.null(df) | is.null(grp_col)) {
    return(NULL)
  }
  
  # Group by column symbol
  col_name <- ensym(grp_col)
  grp_df <- df |> group_by(!!col_name) |> count()
  grp_df_prop <- grp_df |> mutate(Freq = round(100 * n / sum(grp_df$n), digits))
  
  # Sort by count aggregation in descending order
  grp_o <- order(grp_df_prop[["n"]], decreasing = TRUE)
  grp <- data.frame(grp_df_prop)[grp_o,]
  
  # Remove row sort index if show index is False
  rownames(grp) <- NULL
  if (rlang::is_false(remove_ind)) {
    grp$rank <- 1:nrow(grp)
    grp <- grp |> relocate(rank)
  }
    
  # Pretty print n results of aggregation, default is top 20
  kable(head(grp, n=n_results), format = "simple")
}
