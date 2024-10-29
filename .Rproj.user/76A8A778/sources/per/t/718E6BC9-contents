
test_that("analyze_company returns error message if input not found", {

  # Test that function returns an error message for invalid input
  expect_match(analyze_company("Donald Duck", "Universal Pictures"),
               "Invalid input. The company names is not in our database")

  expect_match(analyze_company("Paramount Pictures", "Snow White"),
               "Invalid input. The company names is not in our database")
})

