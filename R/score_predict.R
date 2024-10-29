#library(ggplot2)
#library(rpart)
#library(neuralnet)
#library(reshape2)
#library(class)
#library(randomForest)
#library(e1071)
#' Predict movie scores using different machine learning models
#'
#' This function takes in a machine learning method and new data and returns a predicted score using that method.
#'
#' @param method A character string indicating the machine learning method to use. The available options are "svm", "neural network", "decision tree", "randomforest", and "linear regression".
#' @param newdata A data frame containing the features of budget, runtime, votes, gross in order.
#' @return The predicted score of the new movie based on the chosen machine learning method.
#' @examples
#' score_predict("linear regression", newdata = data.frame(budget = 10000000, runtime = 120, votes = 2000, gross = 1000000))
#' score_predict("neural network", newdata = data.frame(budget = 12000000, runtime = 106, votes = 4000, gross = 1650000))
#' @import ggplot2
#' @import reshape2
#' @importFrom  randomForest randomForest
#' @import rpart
#' @importFrom neuralnet neuralnet
#' @import class
#' @import e1071
#' @export
score_predict<-function(method,newdata){
  method_list<-c("svm","neural network","desicion tree","randomforest","linear regression")
  stopifnot(method %in% method_list,is.data.frame(newdata))

  # 选取需要计算相关性的列
  cols <- c("budget", "runtime", "score", "votes", "gross")
  # 删除包含 NA 值的行
  movie_data_clean <- na.omit(movie_data[, cols])

  # 计算相关系数矩阵
  corr <- cor(movie_data_clean[, c("budget", "runtime", "score", "votes", "gross")], use = "complete.obs")

  print(cor_plot(corr))

  # 绘制热力图
  if (method=="linear regression"){
    model <- lm(score ~ budget + runtime + votes + gross, data=movie_data_clean)
    print(summary(model))
    prediction <- predict(model, newdata)
    # 打印预测结果
    cat("Predicted score:", prediction)
  }
  if (method=="desicion tree"){
    model <- rpart(score ~ budget + runtime + votes + gross, data = movie_data_clean)
    summary(model)
    printcp(model)
    prediction<-predict(model, newdata)
    cat("Predicted score:", prediction)
  }
  if (method=="neural network"){
    data=movie_data_clean
    train_idx <- sample(nrow(data), 0.7 * nrow(data))
    train_data <- data[train_idx, ]
    test_data <- data[-train_idx, ]

    # create neural network model
    model <- neuralnet(score ~ budget + runtime + votes + gross,
                       data = train_data, hidden = c(5, 3))
    # use test data to evaluate model performance
    test_inputs <- test_data[, c("budget", "runtime", "votes", "gross")]
    test_outputs <- test_data[, "score"]
    predictions <- predict(model, test_inputs)

    # calculate mean squared error
    mse <- mean((test_outputs - predictions)^2)
    #通过计算平均平方误差（MSE）来评估模型的性能，MSE越低，模型越准确。
    print(paste("mse:",mse))
    print(summary(model))
    prediction <- predict(model, newdata)
    print(paste("Predicted score:", prediction))
  }
  if (method=="randomforest"){
    train_idx <- sample(nrow(movie_data_clean), 0.7 * nrow(movie_data_clean))
    train_data <- movie_data_clean[train_idx, c("budget", "runtime", "votes", "gross")]
    train_labels <- movie_data_clean[train_idx, "score"]
    test_data <- movie_data_clean[-train_idx, c("budget", "runtime", "votes", "gross")]
    model <- randomForest(train_labels ~ ., data = train_data, ntree = 500)

    # 预测结果
    predicted_scores <- predict(model, test_data)

    # 查看模型的准确率
    actual_scores <- movie_data_clean[-train_idx, "score"]
    accuracy <- sum(predicted_scores == actual_scores) / length(actual_scores)
    cat("Accuracy:", accuracy)
    prediction <- predict(model, newdata)
    print(paste("Predicted score:", prediction))
  }
  if (method=="svm"){
    train_idx <- sample(nrow(movie_data_clean), 0.7 * nrow(movie_data_clean)) # 选取70%的数据作为训练集
    train_data <- movie_data_clean[train_idx, c("budget", "runtime", "votes", "gross")]
    train_labels <- movie_data_clean[train_idx, "score"]
    test_data <- movie_data_clean[-train_idx, c("budget", "runtime", "votes", "gross")]
    svm_model <- svm(train_labels ~ ., data = train_data, kernel = "linear", cost = 1)
    predicted_scores <- predict(svm_model, test_data)
    # 计算MSE
    mse <- mean((predicted_scores - movie_data_clean[-train_idx, "score"])^2)
    cat("MSE:", mse, "\n")

    # 计算RMSE
    rmse <- sqrt(mse)
    cat("RMSE:", rmse, "\n")

    # 计算MAE
    mae <- mean(abs(predicted_scores - movie_data_clean[-train_idx, "score"]))
    cat("MAE:", mae, "\n")
    prediction <- predict(svm_model, newdata)
    print(paste("Predicted score:", prediction))
  }
}

cor_plot<-function(corr){
  # 绘制热力图

  ggplot(data = reshape2::melt(corr), aes(x = Var1, y = Var2, fill = value, label = round(value, 2))) +
  geom_tile(color = "white", linewidth = 0.2) +
  geom_text(color = "black", size = 3) +
  scale_fill_gradient2(low = "#1a3e63", mid = "#f6f7f8", high = "#e84c3d", midpoint = 0, limits = c(-1,1), name = "Correlation") +
  labs(title = "Correlation Heatmap of Movie Data",
       x = "Variables", y = "Variables") +
  theme(plot.title = element_text(size = 16, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10, color = "black"),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10),
        legend.key.size = unit(1.5, "cm"))
}
