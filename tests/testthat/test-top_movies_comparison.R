

# Define test cases
test_that("top_movies_comparison returns expected output", {
  expect_match(top_movies_comparison(1900, 2000, "abc", 10), "Invalid input, the sorting criterion must be chosen from score and gross")
})

