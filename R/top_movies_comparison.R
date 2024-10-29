#' Create a 2 by 2 conbined plot for the top movies.
#'
#' top_movies_comparison targets on the comparison between a specific number of the top movies under a specific sorting criterion("score" or "gross"). It will generate one 2 by 2 conbined plot.
#'
#' @param time.start the start year of the movie data to be analyzed (default: 1900)
#' @param time.end the end year of the movie data to be analyzed (default: 2022)
#' @param sort.criterion the criterion by which to sort the movie data ("score" or "gross", default: "score")
#' @param show.number the number of movies to display, suggest 10 or 20 (default: 10)
#'
#' @return This function has no return value, but prints out the filtered and sorted movie data as well as four bar charts of the count of movies by rating, genre, company, and country.
#'
#' @importFrom  plyr ddply .
#' @export
#'
#' @examples
#' top_movies_comparison(1900, 2020, "score", 20)
#' top_movies_comparison(2000, 2020, "gross", 10)
#'
top_movies_comparison = function(time.start = 1900, time.end = 2022, sort.criterion = "score", show.number = 10){
  movie_data = movie_data[movie_data$year>=time.start & movie_data$year <= time.end, ] %>% head(., show.number)
  if (sort.criterion == "score"){
    movie_data = arrange(movie_data, desc(score), desc(year))
  }else{
    if (sort.criterion == "score"){
      movie_data = arrange(movie_data, desc(gross), desc(year))
    }else{
      return ("Invalid input, the sorting criterion must be chosen from score and gross")
    }
  }
  print(movie_data)

  movie_data = movie_data[movie_data$genre != "" &  movie_data$rating != "" & movie_data$company != "" & movie_data$country != "", ]

  new_data1 = plyr::ddply(movie_data, .(rating), summarise, number = length(genre)) %>% arrange(., desc(number))
  new_data2 = plyr::ddply(movie_data, .(genre), summarise, number = length(director)) %>% arrange(., desc(number))
  new_data3 = plyr::ddply(movie_data, .(company), summarise, number = length(company)) %>% arrange(., desc(number))
  new_data4 = plyr::ddply(movie_data, .(country), summarise, number = length(country)) %>% arrange(., desc(number))

  p1 = ggplot(new_data1, aes(x = rating, y = number)) +
    geom_bar(stat = "identity", aes(fill = number)) +
    scale_fill_gradient(low = "white", high = "steelblue") +
    labs(x = "rating", y = "count")

  p2 = ggplot(new_data2, aes(x = genre, y = number)) +
    geom_bar(stat = "identity", aes(fill = number)) +
    scale_fill_gradient(low = "white", high = "steelblue") +
    theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) +
    labs(x = "genre", y = "count")

  p3 = ggplot(new_data3, aes(x = company, y = number)) +
    geom_bar(stat = "identity", aes(fill = number)) +
    scale_fill_gradient(low = "white", high = "steelblue") +
    theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) +
    labs(x = "company", y = "count")

  p4 = ggplot(new_data4, aes(x = country, y = number)) +
    geom_bar(stat = "identity", aes(fill = number)) +
    scale_fill_gradient(low = "white", high = "steelblue") +
    theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) +
    labs(x = "country", y = "count")
  print(p1 + p2 + p3 + p4 + patchwork::plot_layout(nrow = 2))
}
