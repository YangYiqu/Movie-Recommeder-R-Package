
# Define a test for the function
test_that("heat_world_map input restriction", {

  # Call the function again with different inputs
  plot <- heat_world_map("2010-2020", "score_ranking")
  decades<-c("1980-1989","1990-1999","2000-2009","2010-2020")
  decade<-"2010-2020"
  types<-c("count", "score","count_prop","score_ranking")
  type<- "score_ranking"

  expect_true(decade %in% decades)
  expect_true(type %in% types)
})
