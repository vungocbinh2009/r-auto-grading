library(here)
library(writexl)
library(readxl)
# Một số hàm cần dùng
check_answer <- function(condition, score) {
  return(ifelse(condition, score, 0))
}

# Các hàm chứa lời giải các bài tập
answer_bai1a <- function() {
  return("Bài 1 khó quá")
}

answer_bai1b <- function() {
  return("Bài này vẫn khó")
}

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
bai1_a <- NULL
bai1_b <- NULL

# 3. Đối với mỗi file trong answer_files, tạo 1 environment và test code để tính điểm, lưu lại thông tin trong dataframe
for(file in file_list) {
  test_env <- new.env()
  sys.source(file = here("answer_files", file), envir = test_env, toplevel.env = test_env)
  student_name <- c(student_name, test_env$STUDENT_NAME)
  student_id <- c(student_id, test_env$STUDENT_ID)
  # Kiểm tra đáp số câu 1
  score_1 <- check_answer(test_env$bai1_a() == answer_bai1a(), 1)
  bai1_a <- c(bai1_a, score_1)
  # Kiểm tra đáp số câu 2
  score_2 <- check_answer(test_env$bai1_b() == answer_bai1b(), 1)
  bai1_b <- c(bai1_b, score_2)
}

# 4. Xuất dataframe sang file excel. Có thể viết 1 số hàm để sử lý bảng trước khi xuất file excel
final_result <- data.frame(student_name, student_id, bai1_a, bai1_b)
final_result$total <- final_result$bai1_a + final_result$bai1_b
write_xlsx(final_result, "final_result.xlsx")
