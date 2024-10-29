
# Load movie data
data(movie_data)
# Define test function

test_that("reco input restriction",{
  input <- data.frame("user.id"=sample(1:50, 6000,replace = TRUE), "movie"=sample(movie_data$name,6000), "rating"=sample(1:10, 6000,replace = TRUE))

  # Test if output is a list
  #expect_true(is.list(reco(history = input, method = "POPULAR", id = 1)))

  history <- data.frame("user.id"=sample(1:50, 6000,replace = TRUE), "movie"=sample(movie_data$name,6000), "rating"=sample(1:10, 6000,replace = TRUE))
  Algorithms <- c("UBCF", "IBCF", "RANDOM", "POPULAR", "SVD")
  method <- "UBCF"
  id <- 1

  # Test that the values are valid
  expect_true(is.data.frame(history))
  expect_true(method %in% Algorithms)
  expect_true(id %in% unique(history$user.id))
})

