# r-auto-grading

A simple project for auto grading R coding exam

# Project structure
- `answer_files`: Include all students' answer in R script file (.R)
- `example_data`: Data for student to test theirs function.
- `full_data`: All data in `example_data` and `test_data`
- `test_data`: Data for grading students' answer
- `answer_template.R`: R script template file for students
- `main.R`: main script to grading student's answers.
- `train_test_split.R`: R script to split dataframe to multiple part (for example and test)

# How to use
1. Clone this repo. You can use RStudio to do this easily
2. Add all your students' R script file in `answer_files` folder
3. Add your test data (data for grading students' answer) to `test_data` folder
4. You can add your example data (data for students' test their function) in `example_data` folder
5. Edit `main.R` file to grading students' answer and run it!


