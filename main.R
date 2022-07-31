library(here)
library(writexl)
library(readxl)
library(gradeR)
library(stringr)
library(SimilaR)

# Các bước viết file này
# 1. Liệt kê các file

# 1.1. Liệt kê các file trong folder answer_files
file_list <- list.files(here("answer_files"))

# 1.2. Lấy file trong folder example_data và test_data để sử dụng. Ví dụ.
# read.csv(here("example_data", "file.csv"))
# read_excel(here("example_data", "file.xlsx"))

# 2. Tạo các vector để lưu lại kết quả thi.
student_order <- NULL
student_name <- NULL
student_id <- NULL
id <- NULL

# 3. Duyệt qua file_list để lấy thông tin về sinh viên
# Tên file code của sinh viên phải đặt theo cú pháp stt_HoVaTen_masv.R. Ví dụ: 1_VuNgocBinh_12345678.R
for(file in file_list) {
  file_name <- str_remove(file, "\\.[Rr]")
  split_result <- str_split(string = file_name, pattern = "_")
  student_order <- c(student_order, split_result[[1]][1])
  student_name <- c(student_name, split_result[[1]][2])
  student_id <- c(student_id, split_result[[1]][3])
  id <- c(id, here("answer_files", file))
}

# 4. Thực hiện việc chấm điểm và ghép 2 bảng lại với nhau
info_df <- data.frame(student_order, student_name, student_id, id)
grade_df <- calcGrades(
  submission_dir = trimws(here("answer_files", " ")),
  your_test_file = here("test_answer.R")
)

print(colnames(grade_df))

final_result <- merge(info_df, grade_df, by = "id")

# 5. Tính toán cột điểm tổng kết.
final_result$total <- final_result$bai_1 + final_result$bai_2

# 6. Xuất dataframe sang file excel. Có thể viết 1 số hàm để sử lý bảng trước khi xuất file excel
write_xlsx(final_result, "final_result.xlsx")

# 7. Check sự giống nhau về code của sinh viên
similarity <- SimilaR_fromDirectory(
  dirname = trimws(here("answer_files", " ")),
  returnType = "data.frame",
  fileTypes = "file",
  aggregation = "tnorm"
)

write_xlsx(similarity, "similarity.xlsx")
