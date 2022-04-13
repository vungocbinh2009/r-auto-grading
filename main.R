library(here)
library(writexl)
library(readxl)
library(gradeR)

# Các bước viết file này
# 1. Liệt kê các file
# 1.1. Liệt kê các file trong folder answer_files
file_list <- list.files(here("answer_files"))

# 1.2. Lấy file trong folder example_data và test_data để sử dụng. Ví dụ.
# read.csv(here("example_data", "file.csv"))
# read_excel(here("example_data", "file.xlsx"))

# 2. Tạo các vector để lưu lại kết quả thi.
student_name <- NULL
student_id <- NULL
path <- NULL

# 3. Đối với mỗi file trong answer_files, tạo 1 environment và test code để tính điểm, lưu lại thông tin trong dataframe
for(file in file_list) {
  test_env <- new.env()
  sys.source(file = here("answer_files", file), envir = test_env, toplevel.env = test_env)
  student_name <- c(student_name, test_env$STUDENT_NAME)
  student_id <- c(student_id, test_env$STUDENT_ID)
  path <- c(path, here("answer_files", file))
}

info_df <- data.frame(student_name, student_id, path)
grade_df <- calcGrades(
  submission_dir = trimws(here("answer_files", " ")),
  your_test_file = here("test_answer.R")
)
colnames(grade_df) <- c("path", "bai_1", "bai_2")
final_result <- merge(info_df, grade_df, by = "path")

# 4. Xuất dataframe sang file excel. Có thể viết 1 số hàm để sử lý bảng trước khi xuất file excel
final_result$total <- final_result$bai_1 + final_result$bai_2
write_xlsx(final_result, "final_result.xlsx")
