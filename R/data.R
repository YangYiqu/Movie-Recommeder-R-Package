#' Movies Data
#'
#' This dataset contains the information of 53940 movies with 14 attributes.
#' Each row in the table represents a different movie, and the following are the details of each column:
#'
#' \itemize{
#'   \item \code{rating}: The rating of the movie (e.g., G, PG, R).
#'   \item \code{genre}: The genre of the movie (e.g., Drama, Adventure, Comedy).
#'   \item \code{year}: The year the movie was released.
#'   \item \code{released}: The date the movie was released (including the country).
#'   \item \code{score}: The average rating of the movie (out of 10).
#'   \item \code{votes}: The number of votes used to calculate the movie's score.
#'   \item \code{director}: The name of the movie's director.
#'   \item \code{writer}: The name of the movie's writer.
#'   \item \code{star}: The name of the movie's star (lead actor/actress).
#'   \item \code{country}: The country where the movie was produced.
#'   \item \code{budget}: The production budget of the movie.
#'   \item \code{gross}: The box office gross of the movie.
#'   \item \code{company}: The production company that made the movie.
#'   \item \code{runtime}: The length of the movie in minutes.
#' }
#'
#' @name movie_data
#' @docType data
#' @usage data(movie_data)
#' @importFrom utils read.csv
#'
#'
"movie_data"

#' Jack
#'
#' This dataset contains all of Jack's lines from Titanic, and can be used to do emotion analysis later.
#'
#' @name Jack
#' @docType data
#' @usage data(Jack)
#'
"Jack"

#' Rose
#'
#' This dataset contains all of Rose's lines from Titanic, and can be used to do emotion analysis later.
#'
#' @name Rose
#' @docType data
#' @usage data(Rose)
#'
"Rose"
