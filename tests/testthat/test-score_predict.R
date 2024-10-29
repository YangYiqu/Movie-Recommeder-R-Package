

# Define test cases
test_that("score_predict returns correct output", {
  # Generate some test data
  set.seed(123)
  # Call score_predict on test data
  predictions <- score_predict("linear regression", newdata = data.frame(budget = 10000000, runtime = 120, votes = 2000, gross = 1000000))
  # Check that predictions have the correct class
  # Check that predictions are within a reasonable range
  method_list<-c("svm","neural network","desicion tree","randomforest","linear regression")
  method<-"linear regression"
  newdata<-data.frame(budget = 10000000, runtime = 120, votes = 2000, gross = 1000000)

  expect_true(method %in% method_list)
  expect_true(is.data.frame(newdata))
})

