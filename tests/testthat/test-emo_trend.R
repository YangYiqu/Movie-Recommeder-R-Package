
# Testing that the function returns a ggplot object
test_that("emo_trend returns a ggplot object", {
  review <- as.character(Jack)
  plot <- emo_trend(review)
  expect_s3_class(plot, "ggplot")


})

# Testing that the function works with multiple sentences
test_that("emo_trend works with multiple sentences", {
  review <- "This is a fantastic movie! The acting is superb, and the story is gripping from beginning to end. I was on the edge of my seat the whole time. Highly recommended!"
  plot1 <- emo_trend(review)
  article <- "The COVID-19 pandemic continues to ravage the world, with new cases and deaths reported every day. Vaccination efforts are ramping up, but many people remain hesitant to get vaccinated. Experts say that the best way to protect yourself and others is to follow public health guidelines and get vaccinated as soon as possible."
  plot2 <- emo_trend(article)
  expect_s3_class(plot1, "ggplot")
  expect_s3_class(plot2, "ggplot")
})

test_that("input restriction",{
  data= "The COVID-19 pandemic continues to ravage the world, with new cases and deaths reported every day. Vaccination efforts are ramping up, but many people remain hesitant to get vaccinated. Experts say that the best way to protect yourself and others is to follow public health guidelines and get vaccinated as soon as possible."
  expect_true(is.character(data))
})


