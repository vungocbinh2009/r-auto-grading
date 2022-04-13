library(testthat)
# override method to avoid error in Pycharm
# https://youtrack.jetbrains.com/issue/R-1230
rlang::env_unlock(env = asNamespace('testthat'))
rlang::env_binding_unlock(env = asNamespace('testthat'))
assign('rstudio_tickle', function(){}, envir = asNamespace('testthat'))
rlang::env_binding_lock(env = asNamespace('testthat'))
rlang::env_lock(asNamespace('testthat'))

test_that("bai_1", {
  expect_match(bai1_a(), "Bài 1 khó quá")
})

test_that("bai_2", {
  expect_match(bai1_b(), "Bài này vẫn khó")
})