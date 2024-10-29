#' Create a wordcloud and 2 by 2 conbined plot for a specific movie star, director, company, country.
#'
#' This function generates a wordcloud for the genres of movies produced by a movie star, director, company, or country.
#' In the 2 by 2 combined plot, it plots one pie chart and one pie circle chart to show the different genres' proportions in the first line; and two line charts to show the total number of movie and the average movie score variations over different years in the second line.
#'
#' @param type A character string indicating the type of input. It can be "movie star", "director", "company", "country". Default is "country".
#' @param name A character string indicating the name of the movie star, director, company, or country. Default is "China".
#'
#' @examples
#' individual_data_visualization("12345", "Canada")
#' individual_data_visualization("director", "Stephen Curry")
#' individual_data_visualization("star", "Denzel Washington")
#' individual_data_visualization("director", "Steven Spielberg")
#' individual_data_visualization("company", "Warner Bros.")
#' individual_data_visualization("country", "Canada")
#'
#' @import ggplot2
#' @import wordcloud2
#' @import dplyr
#' @import reshape2
#' @import patchwork
#' @importFrom scales percent
#' @importFrom graphics plot
#'
#' @export
individual_data_visualization = function(type = "country", name = "China") {
  if (type != "star" & type != "director" & type != "company" & type != "country"){
    return ("Invalid input. The type must be chosen from star, director, company, or country.")
  }else{
    if (sum(movie_data[[type]] == name) != 0) {
    one = movie_data[movie_data[[type]] == name, ]
    new_data = plyr::ddply(one, .(genre), summarise, number = length(genre))
    new_data = arrange(new_data, desc(number))
    mylabel = paste(new_data$genre, "(", round(new_data$number/sum(new_data$number)*100, 2), "%)  ", sep = "")

    wordcloud = table(one$genre)
    print(wordcloud2(1+log10(wordcloud), size = 0.3, fontFamily = 'Times New Roman', shape = "cardioid", color = "random-light", backgroundColor = "grey", minRotation = -pi/6, maxRotation = pi/6))

    p1 = ggplot(new_data, aes(x = "", y = number, fill = genre)) +
      theme(panel.background = element_rect(fill = "white")) +
      geom_bar(stat = "identity", color = "white", width = 0.1) +
      coord_polar(theta = "y") +
      labs(x = "", y = "", title = "") +
      scale_fill_discrete(breaks = new_data$genre, labels = mylabel) +
      theme(legend.title = element_blank(), legend.position = "left") +
      theme(axis.text = element_blank()) +
      theme(axis.ticks = element_blank()) +
      theme(panel.grid = element_blank()) +
      theme(panel.border = element_blank())

    new_data$fraction = new_data$number / sum(new_data$number)
    new_data$ymax = cumsum(new_data$fraction)
    new_data$ymin = c(0, head(new_data$ymax, n = -1))

    p2 = ggplot(data = new_data, aes(fill = genre, ymax = ymax, ymin = ymin, xmax = 4, xmin = 2)) +
      geom_rect(colour = "white", show.legend = FALSE) +
      coord_polar(theta = "y") +
      labs(x = "", y = "", title = "") +
      xlim(c(0, 4)) +
      theme_bw() +
      theme(panel.grid=element_blank()) +
      theme(axis.text=element_blank()) +
      theme(axis.ticks=element_blank()) +
      theme(panel.border=element_blank())

    time_data = dplyr::summarise(group_by(one, year), total.number = length(score), average.score = mean(score))
    p3 = ggplot(time_data, aes(x = year, y = total.number)) +
      geom_point(color = "blue") +
      geom_line(color = "blue") +
      labs(x = "Year", y = "Count")

    p4 = ggplot(time_data, aes(x = year, y = average.score)) +
      geom_point(color = "red") +
      geom_line(color = "red") +
      labs(x = "Year", y = "Average Score")

    print(p1 + p2 + p3 + p4 + patchwork::plot_layout(ncol = 2))
  } else {
    return (paste("Sorry, the", type, name, "you want doesn't exist in our database.", sep = " "))
  }
  }
}

