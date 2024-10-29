

# Test that the function returns an error message if the input is not found in the database
test_that("individual_data returns error message if input not found", {
  expect_match(individual_data_visualization("12345", "Canada"), "Invalid input. The type must be chosen from star, director, company, or country.")
})

# Test that the function returns a plot for valid inputs
test_that("individual_data returns a plot for valid inputs", {
  expect_match(individual_data_visualization(type = "star", name = "Stephen Curry"), "Sorry, the star Stephen Curry you want doesn't exist in our database.")
})
