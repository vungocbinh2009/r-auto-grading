library(here)
library(writexl)
# Một số hàm cần dùng
check_answer <- function(condition, score) {
  return(ifelse(condition, score, 0))
}

# Các bước viết file này
# 1. Liệt kê các file trong folder answer_files
file_list <- list.files(here("answer_files"))

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
  score_1 <- check_answer(test_env$bai1_a() == "Bài 1 khó quá", 1)
  bai1_a <- c(bai1_a, score_1)
  # Kiểm tra đáp số câu 2
  score_2 <- check_answer(test_env$bai1_b() == "Bài này vẫn khó", 1)
  bai1_b <- c(bai1_b, score_2)
}

# 4. Xuất dataframe sang file excel
final_result <- data.frame(student_name, student_id, bai1_a, bai1_b)
write_xlsx(final_result, "final_result.xlsx")
