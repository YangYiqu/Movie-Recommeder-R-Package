#' Analyze Company Information
#'
#' This function takes the name of two companies and analyzes their information based on data from a movie dataset.
#'
#' @param company1 character string representing the first company name.
#' @param company2 character string representing the second company name.
#'
#' @return This function does not return a value, but creates three plots.
#'
#' @export
#'
#' @examples
#' analyze_company("Paramount Pictures","Universal Pictures")
#'
#' @import ggplot2
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom tidyr replace_na
#' @importFrom scales comma_format dollar_format
#' @importFrom utils data
#' @importFrom grDevices colors
analyze_company <- function(company1,company2) {
  movies_df=as.data.frame(movie_data)
  if (sum(movies_df["company"] == company1)==0|sum(movies_df["company"] == company2)==0){
    return ("Invalid input. The company names is not in our database")
  }
  company_name <- vector(mode = "character", length = 2)
  company_name[1] <- company1
  company_name[2] <- company2


  #print(company_names)
  #stopifnot(company_name[1] %in% movies_df$name,
  #          company_name[2] %in% movies_df$name)
  movies_df_company=cbind(data.frame(movies_df$name),data.frame(movies_df$year),data.frame(movies_df$country),data.frame(movies_df$budget),data.frame(movies_df$gross),data.frame(movies_df$company))
  head(movies_df_company)

  company_information=vector("character", length = 0)
  for (i in company_name){

    index=grep(i, movies_df$company)
    ith_company=movies_df_company[index, ]
    company_information=rbind(company_information,ith_company)
  }
  head(company_information)
  first_length=length(grep(company_name[1], movies_df$company))
  second_length=length(grep(company_name[2], movies_df$company))

  first_company=data.frame(company_information[1:first_length,])

  second_company=data.frame(company_information[first_length+1:nrow(company_information),])

  #print(first_length)
  #print(second_length)

  df <- data.frame(Company = company_name,
                   Total_Movies = c(first_length, second_length))

  p1<-ggplot(df, aes(x = Company, y = Total_Movies, fill = Company,size=4)) +
    geom_bar(stat = "identity", width = 0.2) +
    scale_fill_manual(values = c("red", "blue")) +
    labs(x = "film company", y = "total ", title = "The number of movies") +
    scale_y_continuous(labels = scales::comma_format(), limits = c(0, 400)) +
    theme_minimal() +
    theme(text = element_text(size = 15),
          legend.position = "none") +
    geom_text(aes(label = Total_Movies), vjust = -0.5, size = 4)

  impute_mean <- function(df, var) {
    mean_val <- mean(df[[var]], na.rm = TRUE)
    df[[var]] <- replace_na(df[[var]], mean_val)
    return(df)
  }

  first_company <- impute_mean(first_company, "movies_df.gross")
  second_company <- impute_mean(second_company, "movies_df.gross")

  first_company_gross <- first_company %>%
    dplyr::group_by(movies_df.year) %>%
    dplyr::summarize(gross = sum(movies_df.gross))

  second_company_gross <- second_company %>%
    dplyr::group_by(movies_df.year) %>%
    dplyr::summarize(gross = sum(movies_df.gross))

  first_company <- impute_mean(first_company, "movies_df.budget")
  second_company <- impute_mean(second_company, "movies_df.budget")

  first_company_budget <- first_company %>%
    dplyr::group_by(movies_df.year) %>%
    dplyr::summarize(budget = sum(movies_df.budget))

  second_company_budget <- second_company %>%
    dplyr::group_by(movies_df.year) %>%
    dplyr::summarize(budget = sum(movies_df.budget))


  first_company_gross
  # Convert year to numeric value
  #first_company_gross$movies_df.year <- as.numeric(first_company_gross$movies_df.year)



  p2 <- ggplot() +
    geom_line(data = first_company_gross, aes(x = movies_df.year, y = gross, col = "red")) +
    geom_line(data = second_company_gross, aes(x = movies_df.year, y = gross, col = "lightblue")) +
    labs(title = "Gross Revenue of Companies Over Time", x = "Year", y = "Gross Revenue (USD)") +
    theme_minimal() +
    theme(text = element_text(size = 15)) +
    scale_color_manual(values = c("red", "blue"), name = "Film Company",
                       labels = c(company_name[1], company_name[2])) +
    geom_text(aes(label = company_name), x = 3, y = 6, vjust = -0.5, size = 8) +
    scale_y_continuous(labels = scales::dollar_format(), limits = c(0, 1.5e9)) +
    theme_bw() +
    theme(legend.position = "bottom")

  p3 <- ggplot() +
    geom_line(data = first_company_budget, aes(x = movies_df.year, y = budget, col = "red")) +
    geom_line(data = second_company_budget, aes(x = movies_df.year, y = budget, col = "blue")) +
    labs(title = "Budget of Companies Over Time", x = "Year", y = "Budget (USD)") +
    theme_minimal() +
    theme(text = element_text(size = 15)) +
    scale_color_manual(values = c("red", "blue"), name = "Film Company",
                       labels = c(company_name[1], company_name[2])) +
    geom_text(aes(label = company_name), x = 3, y = 6, vjust = -0.5, size = 8) +
    scale_y_continuous(labels = scales::dollar_format(), limits = c(0, 1.5e9)) +
    theme_bw() +
    theme(legend.position = "bottom")

  p4<- p1 + p2 + p3+ plot_layout(ncol = 2)
  p4
}

#analyze_company(a,b)







