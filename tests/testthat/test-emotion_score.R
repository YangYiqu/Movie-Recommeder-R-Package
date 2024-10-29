
# Define a test function
test_that("emotion_score calculates emotion scores correctly", {

  # Input text to test the function on
  input_text <- as.character(Jack)

  # Call the function and save the output
  output <- emotion_score(input_text)

  # Assert that the output has a legend
  expect_true(!is.null(guide_legend(output)))

  data= "The COVID-19 pandemic continues to ravage the world, with new cases and deaths reported every day. Vaccination efforts are ramping up, but many people remain hesitant to get vaccinated. Experts say that the best way to protect yourself and others is to follow public health guidelines and get vaccinated as soon as possible."
  expect_true(is.character(data))
})
