library("stringr")



# move sol environment inside problem environment
# to use answers latex package

TransformFile <- function(file_name) {
  new_name <- str_replace(file_name, pattern = "chapters",
                          replacement = "chapters_new")
  
  file_size <- file.info(file_name)$size
  
  data <- readChar(file_name, file_size)
  
  
  data <- str_replace_all(data, pattern = "\\\\begin\\{solution\\}", 
                          replacement = "\\\\begin\\{sol\\}")
  
  data <- str_replace_all(data, pattern = "\\\\end\\{solution\\}", 
                          replacement = "\\\\end\\{sol\\}")
  
  
  data <- paste0(data, "\n\\Closesolutionfile{solution_file}\n")
  
  num_part <- str_extract(file_name, "([0-9]+)")
  add_before <- paste0("\\Opensolutionfile{solution_file}[sols_", 
                       num_part, "]\n% в квадратных скобках фактическое имя файла\n\n")
  
  data <- paste0(add_before, data)
  
  
  data <- str_replace_all(data, pattern = "\\\\end\\{problem\\}", 
                          replacement = "")
  
  data <- str_replace_all(data, pattern = "\\\\end\\{sol\\}", 
                          replacement = "\\\\end\\{sol\\}\n\\\\end\\{problem\\}\n")
  
  
  
  # clear leading space:
  data <- str_replace_all(data, pattern = "\\\\begin\\{sol\\}\n ", 
                          replacement = "\\\\begin\\{sol\\}\n")
  data <- str_replace_all(data, pattern = "\\\\begin\\{problem\\}\n ", 
                          replacement = "\\\\begin\\{problem\\}\n")
  
  
  file_conn <- file(new_name)
  writeLines(data, file_conn)
  close(file_conn)
  return(0)
}


all_files <- list.files("~/Documents/em_pset/chapters/", 
                        pattern = "Rnw$",
                        full.names = TRUE)
for (file_name in all_files) {
  cat("Transforming ", file_name, "\n")
  res <- TransformFile(file_name)
}


all_files <- list.files("~/Documents/em_pset/", 
                        pattern = "^sols_")
all_files_no_ext <- str_sub(all_files, end = -5)
res <- paste0("\\input{", all_files_no_ext, "}", collapse = "\n")
cat(res)


