

# test if the function throws an error when input is not a data frame
test_that("user_similarity throws an error when input is not a data frame", {
  input <- list("user.id"=c(1,1,2,2), "movie"=c("The Shining","The Blue Lagoon","Caddyshack","Friday the 13th"), "rating"=c(5,4,3,2))
  expect_error(user_similarity(input))
  history <- data.frame("user.id"=sample(1:50, 6000,replace = TRUE), "movie"=sample(movie_data$name,6000), "rating"=sample(1:10, 6000,replace = TRUE))
  # Test that the values are valid
  expect_true(is.data.frame(history))
})
