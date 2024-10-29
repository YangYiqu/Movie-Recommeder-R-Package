#library(ggplot2)
#library(reshape2)
#library(dplyr)

#' Calculate user similarity matrix based on user's historical movie genre ratings
#'
#' This function takes a data frame which is composed of 'user.id','movie', and 'ratings' and calculates a user similarity matrix based on the genre ratings of the movies. The similarity matrix is calculated using cosine similarity.
#'
#' @param history A data frame containing columns, namely, "user.id", "movie", and "rating".
#'
#' @import ggplot2
#' @import dplyr
#' @importFrom reshape2 melt
#'
#' @examples
#' input <- data.frame("user.id"=sample(1:10, 5000,replace = TRUE), "movie"=sample(movie_data$name,5000), "rating"=sample(1:10, 5000,replace = TRUE))
#' user_similarity(input)
#'
#' @export
user_similarity<-function(history){
  stopifnot(is.data.frame(history))
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
  g<-g[-1]

  g <- g %>%
    dplyr::group_by(user.id, genre) %>%
    dplyr::summarise(rating = mean(rating),.groups="drop") %>%
    ungroup()

  # 定义用户-电影评分矩阵
  mapply(function(rating, genre_idx, user_idx) {
    m[user_idx, genre_idx] <<- rating
  }, g$rating, match(g$genre, genre_list), as.numeric(g$user.id))

  colnames(m) <- genre_list
  rownames(m) <- paste("User", user_list)
  #print(m)

  # 计算用户之间的相似度
  similarity <- matrix(0, nrow = user_number, ncol = user_number)
  for (i in 1:user_number) {
    for (j in 1:user_number) {
      if (i == j) {
        similarity[i, j] <- 1
      } else {
        user1 <- m[i, ]
        user2 <- m[j, ]
        # 计算用户之间的余弦相似度
        similarity[i, j] <- sum(user1 * user2) / (sqrt(sum(user1^2)) * sqrt(sum(user2^2)))
      }
    }
  }
  colnames(similarity) <- paste("User", user_list)
  rownames(similarity) <- paste("User", user_list)
  similarity


  # 将相似度矩阵转化为长格式
  similarity_df <- reshape2::melt(similarity)

  # 找到每行相似度的第二大值及其位置
  a<-0
  second_max_index <- apply(similarity, 1, function(x) {
    a <<- a + 1
    temp <- sort(x, decreasing = TRUE)
    index <- match(temp[2], x)
    if (temp[2] == 0) {
      index <- NA
    }

    if (index==a){
      index<-match(temp[2], x[-a])
      if (index>a){
        index=index+1
      }
    }
    print(paste("AS for user",user_list[a],", User",user_list[index],"is the most similar one."))
    return(index)
  })

  # 绘制矩形图并添加矩形框
  p <- ggplot(similarity_df, aes(Var1, Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "red") +
    theme_minimal() +
    labs(x = "User", y = "User", title = "Similarity Matrix")

  for (i in 1:nrow(similarity)) {
    if (!is.na(second_max_index[i])) {
      p <- p + annotate("rect", xmin = i-0.5, xmax = i+0.5, ymin = second_max_index[i]-0.5, ymax = second_max_index[i]+0.5, fill = NA, color = "black", size = 1)
    }
    for (j in 1:ncol(similarity)) {
      if (similarity[i, j] != 0) {
        p <- p + annotate("text", x = j, y = i, label = round(similarity[i, j],2), size = 3, color = "black")
      }
    }
  }

  p

}
#set.seed(0)
#input <- data.frame("user.id"=c(1,1,2,2,3,4,1,4,2,5,3,6,6,7), "movie"=c("The Shining","The Blue Lagoon","Caddyshack","Friday the 13th","Airplane!","Popeye","One Woman or Two","Here Come the Littles","Tea in the Harem","Sincerely Charlotte","My Chauffeur","Shanghai Surprise","Out of Bounds","Power"), "rating"=c(5,7,8,4,6,1,6,4,2,2,10,1,7,5))
#input <- data.frame("user.id"=sample(1:10, 5000,replace = TRUE), "movie"=sample(movie_data$name,5000), "rating"=sample(1:10, 5000,replace = TRUE))

#similar_matrix(input)


