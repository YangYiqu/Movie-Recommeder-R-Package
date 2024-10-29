#UBCF（User-based Collaborative Filtering，基于用户的协同过滤）：该方法是基于用户相似度来进行推荐的，即对于一个目标用户，找到与其兴趣相似的其他用户，将这些用户喜欢的物品推荐给目标用户。

#IBCF（Item-based Collaborative Filtering，基于物品的协同过滤）：该方法是基于物品相似度来进行推荐的，即对于一个目标用户，找到该用户曾经喜欢的物品，找出与这些物品相似的其他物品，将这些物品推荐给目标用户。

#RANDOM：该方法是随机推荐，即从所有物品中随机选择一个物品进行推荐。

#POPULAR：该方法是基于物品热度进行推荐，即选择最受欢迎的物品进行推荐，通常是根据用户历史行为数据中最常出现的物品来推荐。

#SVD（Singular Value Decomposition）是一种基于矩阵分解的协同过滤算法。它将评分矩阵分解成三个矩阵：一个用户矩阵、一个物品矩阵和一个奇异值矩阵。在这三个矩阵中，用户矩阵和物品矩阵分别表示用户和物品的特征，而奇异值矩阵则包含了这些特征的权重。

#SVD的推荐过程是将用户矩阵和物品矩阵相乘，得到一个预测评分矩阵，然后根据预测评分矩阵进行推荐。相比于基于邻域的协同过滤算法，SVD在处理大规模数据集时更加高效，且对稀疏矩阵有较好的处理能力。
#library(ggplot2)
#library(reshape2)
#library(recommenderlab)
#library(magrittr)
#library(dplyr)
#library(tidyr)


#' Calculate recommendations based on user preferences
#'
#' This function takes in a user's preferences and generates recommendations for items
#' that match those preferences.
#'
#' @param history A data frame containing columns, namely, "user.id", "movie", and "rating".
#' @param method Algorithms used in predicting user preferences, such as "UBCF","IBCF","RANDOM","POPULAR","SVD".
#' @param id The id of the user whom we need to recommend to.
#'
#' @return A list of top3 recommended items, and a measure of performance evaluation parameters such as MAE,MSE,and RMSE.
#'
#' @examples
#' data(movie_data)
#' input <- data.frame("user.id"=sample(1:50, 6000,replace = TRUE), "movie"=sample(movie_data$name,6000), "rating"=sample(1:10, 6000,replace = TRUE))
#' reco(input,"IBCF",1)
#'
#' @importFrom recommenderlab Recommender predict calcPredictionAccuracy evaluationScheme getData normalize image
#' @import tidyr
#' @import tibble
#' @export
#'
reco<-function(history,method,id){
  Algorithms=c("UBCF","IBCF","RANDOM","POPULAR","SVD")
  stopifnot(is.data.frame(history),method %in% Algorithms,id %in% unique(history$user.id))
  #movie_data <-read.csv("C:/Users/11872/Desktop/filmReco/movie.csv")
  new_movie_data <- movie_data[!(movie_data$name %in% history$movie),]
  #print(new_movie_data)
  movie_data = movie_data[c(1,3)]
  movie_data=unique(movie_data)
  genre_list<-unique(movie_data$genre)
  #print(genre_list)
  genre_number<-length(genre_list)
  user_list<-unique(history$user.id)
  user_number<-length(user_list)
  m <- matrix(0, nrow =user_number, ncol =genre_number)
  g<-merge(history,movie_data,by.x="movie", by.y="name", all.x=TRUE)
  g <- g %>%
    dplyr::group_by(user.id, genre) %>%
    dplyr::summarise(rating = mean(rating),.groups="drop") %>%
    ungroup()
  #print(g)

  # 定义用户-电影评分矩阵
  mapply(function(rating, genre_idx, user_idx) {
    m[user_idx, genre_idx] <<- rating
  }, g$rating, match(g$genre, genre_list), as.numeric(g$user.id))

  colnames(m) <- genre_list
  rownames(m) <- paste("User", user_list)
  m[m == 0] <- NA
  #print(m)


  ratings <- as(m, "realRatingMatrix")
  model <- Recommender(ratings, method = method)
  prediction=predict(model, ratings, n = 5)


  #prediction5=predict(model5, ratings, n = 1)
  user_reco_list<-as(prediction,"list")
  reco_movie<-data.frame(name = character(), score = numeric(), genre = character(),stringsAsFactors = FALSE)
  #print(reco_movie)
  i=0
  while (nrow(reco_movie)<3){
    i <- i+1
    reco_type<-user_reco_list[[which(user_list==id)]][i]
    reco_movie_1<- new_movie_data %>%
      filter(genre == reco_type) %>%
      arrange(desc(score)) %>%
      slice_head(n = 3) %>%
      dplyr::select(name,score,genre)
    reco_movie<-rbind(reco_movie,reco_movie_1)
  }
  print(reco_movie[1:3,])
  error_plot(history = history)
}



error_plot<-function(history){
  #movie_data <-read.csv("C:/Users/11872/Desktop/filmReco/movie.csv")
  movie_data = movie_data[c(1,3)]
  movie_data=unique(movie_data)
  genre_list<-unique(movie_data$genre)
  #print(genre_list)
  genre_number<-length(genre_list)
  user_list<-unique(history$user.id)
  user_number<-length(user_list)
  m <- matrix(0, nrow =user_number, ncol =genre_number)
  g<-merge(history,movie_data,by.x="movie", by.y="name", all.x=TRUE)
  g <- g %>%
    dplyr::group_by(user.id, genre) %>%
    dplyr::summarise(rating = mean(rating),.groups="drop") %>%
    ungroup()
  #print(g)

  # 定义用户-电影评分矩阵
  mapply(function(rating, genre_idx, user_idx) {
    m[user_idx, genre_idx] <<- rating
  }, g$rating, match(g$genre, genre_list), as.numeric(g$user.id))

  colnames(m) <- genre_list
  rownames(m) <- paste("User", user_list)
  m[m == 0] <- NA



  ratings <- as(m, "realRatingMatrix")
  ratings_m <- normalize(ratings)
  #print(image(ratings, main = "Raw Ratings"))
  #print(image(ratings_m, main = "Normalized Ratings"))
  e <- evaluationScheme(ratings, method="split", train=0.9,
                        given=3, goodRating=5)
  Algorithms=c("UBCF","IBCF","RANDOM","POPULAR","SVD")
  r1 <- Recommender(getData(e, "train"), "UBCF")
  r2 <- Recommender(getData(e, "train"), "IBCF")
  r3 <- Recommender(getData(e, "train"), "RANDOM")
  r4 <- Recommender(getData(e, "train"), "POPULAR")
  r5 <- Recommender(getData(e, "train"), "SVD")

  p1 <- predict(r1, getData(e, "known"), type="ratings")
  p1_list=as(p1,"list")$`0`
  max_index_1 <- which.max(p1_list)
  max_element_1 <- p1_list[max_index_1]


  p2 <- predict(r2, getData(e, "known"), type="ratings")
  #print(as(p2,"list"))
  p2_list=as(p2,"list")$`0`
  max_index_2 <- which.max(p2_list)
  max_element_2 <- p2_list[max_index_2]


  p3 <- predict(r3, getData(e, "known"), type="ratings")
  #print(as(p2,"list"))
  p3_list=as(p3,"list")$`0`
  max_index_3 <- which.max(p3_list)
  max_element_3 <- p3_list[max_index_3]


  p4 <- predict(r4, getData(e, "known"), type="ratings")
  #print(as(p2,"list"))
  p4_list=as(p4,"list")$`0`
  max_index_4 <- which.max(p4_list)
  max_element_4 <- p4_list[max_index_4]


  p5 <- predict(r5, getData(e, "known"), type="ratings")
  #print(as(p2,"list"))
  p5_list=as(p5,"list")$`0`
  max_index_5 <- which.max(p5_list)
  max_element_5 <- p5_list[max_index_5]

  elements<-c(max_element_1,max_element_2,max_element_3,max_element_3,max_index_5)
  #print(elements)

  error <- rbind(
    UBCF = calcPredictionAccuracy(p1, getData(e, "unknown")),
    IBCF = calcPredictionAccuracy(p2, getData(e, "unknown")),
    RANDOM=calcPredictionAccuracy(p3, getData(e, "unknown")),
    POPULAR=calcPredictionAccuracy(p4, getData(e, "unknown")),
    SVD=calcPredictionAccuracy(p5, getData(e, "unknown"))
  )
  print(error)
  error=as.data.frame(error)
  error=tibble::rownames_to_column(error, var = "Algorithms")
  error_longer=error %>% tidyr::pivot_longer(names_to = "error_name",values_to = "n",cols = 2:4)
  #print(error_longer)

  ggplot(error_longer, aes(x=error_name, y=n, fill=Algorithms)) +
    geom_col(position="dodge") +
    labs(x="Error Name", y="N", title="Grouped Bar Chart of Error and Algorithm") +
    scale_fill_manual(values=c("#F8766D", "#7CAE00", "#00BFC4", "#C77CFF", "#619CFF")) +
    theme_minimal() +
    geom_text(aes(label=round(n,1)), position=position_dodge(width=0.9), size=3,
              vjust=-0.25, fontface="bold")+ theme(legend.background = element_rect(fill = "white", color = "grey"))

}


#movie_data <-read.csv("C:/Users/11872/Desktop/filmReco/movie.csv")
#input <- data.frame("user.id"=sample(1:50, 6000,replace = TRUE), "movie"=sample(movie_data$name,6000), "rating"=sample(1:10, 6000,replace = TRUE))
#reco(input,"IBCF",1)
