#' Create a plotly map of movie data by decade and type
#'
#' This function generates a map of movie data for a given decade and type.
#'
#' @param decade A character string representing the decade to plot, which must be one of "1980-1989", "1990-1999", "2000-2009", or "2010-2020".
#' @param type A character string representing the type of plot to generate, which must be one of "count", "score", "count_prop", or "score_ranking".
#'
#' @return A plotly map of the specified movie data.
#' @import dplyr
#' @import DescTools
#' @importFrom plotly add_trace colorbar layout plot_geo
#' @importFrom utils read.csv
#' @export
#'
#' @examples
#' # Generate a count map for the 1980s
#' heat_world_map("1980-1989", "count")
#'
#' # Generate a score map for the 2010s
#' heat_world_map("2010-2020", "score")
#'
#' @seealso \code{\link{plotly}}
#' @seealso \code{\link{read.csv}}
#' @seealso \code{\link{table}}
#' @seealso \code{\link{mean}}



heat_world_map<-function(decade,type){
  # Function body goes here
  stopifnot(decade %in% c("1980-1989","1990-1999","2000-2009","2010-2020"),
            type %in% c("count", "score","count_prop","score_ranking"))

  df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
  # movie_data <- read.csv("C:/Users/11872/Desktop/filmReco/movie.csv")
  decade_list=c("1980-1989","1990-1999","2000-2009","2010-2020")
  # Create an empty list to store the four data frame
  df_list <- list()

  # Iterate through each decade interval and store the data in the corresponding data frame
  for (i in 1:4) {
    # Calculate the start and end years of the current decade interval
    start_year <- 1980 + (i-1) * 10
    end_year <- start_year + 9

    # Filter the data frames by year
    df_list[[i]] <- subset(movie_data, year >= start_year & year <= end_year)
  }
  # The df_list now contains four data frames corresponding to the four decade intervals of 1980-1989, 1990-1999, 2000-2009 and 2010-2020
  # You can access these data boxes by df_list[[1]], df_list[[2]], etc
  position <- which( decade_list== decade)
  movie_data_year<-df_list[[position]]
  if (type=="count"){
    # Process data and import the number of films produced in each country
    count_country=table(movie_data_year$country)
    count_country_df <- as.data.frame(count_country)
    count_country_df <- subset(count_country_df, Var1 != "")

    merged_data <- merge(df, count_country_df, by.x="COUNTRY", by.y="Var1", all.x=TRUE)
    merged_data$Freq<-log(merged_data$Freq,10)
    merged_data$Freq[is.na(merged_data$Freq)] <- 0

    df<-merged_data[,c(1,4,3)]
    #df$Freq[df$COUNTRY == "United States"] <- 400
    # light grey boundaries
    l <- list(color = ColToRgb("grey"), width = 0.5)

    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )

    fig <- plotly::plot_geo(df)
    fig <- fig %>% plotly::add_trace(
      z = ~Freq, color = ~Freq, colors = 'Blues',
      text = ~COUNTRY, locations = ~CODE, marker = list(line = l)
    )
    fig <- fig %>% plotly::colorbar(title = 'log10(Number)')
    fig <- fig %>% plotly::layout(
      title = paste('The number of films distributed in each country in',decade,' <br>Source:<a href="https://www.kaggle.com/datasets/danielgrijalvas/movies?select=movies.csv">Movie Industry</a>'),
      geo = g
    )

    print(fig)
  }
  if(type=="score"){
    avg_scores <- dplyr::summarise(dplyr::group_by(movie_data, country), avg_score = mean(score, na.rm = TRUE))

    score_country_df <- subset(avg_scores, country != "")

    merged_data <- merge(df, score_country_df, by.x="COUNTRY", by.y="country", all.x=TRUE)
    merged_data$avg_score[is.na(merged_data$avg_score)] <- 0

    df<-merged_data[,c(1,4,3)]
    names(df)[names(df) == "avg_score"] <- "Freq"
    # light grey boundaries
    l <- list(color = ColToRgb("grey"), width = 0.5)

    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )

    fig <- plotly::plot_geo(df)
    fig <- fig %>% plotly::add_trace(
      z = ~Freq, color = ~Freq, colors = 'Blues',
      text = ~COUNTRY, locations = ~CODE, marker = list(line = l)
    )
    fig <- fig %>% plotly::colorbar(title = 'Avg_score')
    fig <- fig %>% plotly::layout(
      title = paste('The avg_score of films distributed in each country in',decade,' <br>Source:<a href="https://www.kaggle.com/datasets/danielgrijalvas/movies?select=movies.csv">Movie Industry</a>'),
      geo = g
    )

    print(fig)
  }
  if (type=="count_prop"){
    # Process data and import the number of films produced in each country
    count_country=table(movie_data_year$country)
    count_country_df <- as.data.frame(count_country)
    count_country_df <- subset(count_country_df, Var1 != "")

    merged_data <- merge(df, count_country_df, by.x="COUNTRY", by.y="Var1", all.x=TRUE)
    merged_data$Freq[is.na(merged_data$Freq)] <- 0

    df<-merged_data[,c(1,4,3)]
    df_top25 <- head(df[order(df$Freq, decreasing = TRUE),], 25)
    pie_chart<-plotly::plot_ly(df_top25, labels = ~COUNTRY, values = ~Freq, type = 'pie', hole = 0.4) %>%
      plotly::layout(title = paste("Top 25 Countries by movie numbers in",decade))
    print(pie_chart)
  }
  if (type=="score_ranking"){
    avg_scores <- movie_data %>%
      dplyr::group_by(country) %>%
      dplyr::summarise(avg_score = mean(score, na.rm = TRUE))

    score_country_df <- subset(avg_scores, country != "")

    merged_data <- merge(df, score_country_df, by.x="COUNTRY", by.y="country", all.x=TRUE)
    merged_data$avg_score[is.na(merged_data$avg_score)] <- 0

    df<-merged_data[,c(1,4,3)]

    names(df)[names(df) == "avg_score"] <- "Freq"
    df_top25 <- head(df[order(df$Freq, decreasing = TRUE),], 25)
    df_top25_sorted <- df_top25 %>% arrange(desc(Freq))
    df_top25_sorted$COUNTRY <- factor(df_top25_sorted$COUNTRY, levels = df_top25_sorted$COUNTRY)
    #plot_ly(df_top20_sorted, x = ~COUNTRY, y = ~Freq, type = 'bar')
    chart<-plotly::plot_ly(df_top25_sorted, x = ~COUNTRY, y = ~Freq, type = 'bar') %>%
      plotly::layout(title = paste("Top 25 Countries by movie score in",decade),
             xaxis = list(title = "Country"),
             yaxis = list(title = "Score"))
    print(chart)
  }
}


