# Script to split dataframe
# Load file:
# data <- read.csv(here("full_data", "file.csv"))
# data <- read_excel(here("full_data", "file.xlsx"))
split_prob <- sample(2, size = nrow(data), prob = c(0.7, 0.3))
# Sau đó split data và lưu lại.
# data1 <- data[split_prob == 1, ]
# write_xlsx(data, here("example_data", "data1.xlsx"))