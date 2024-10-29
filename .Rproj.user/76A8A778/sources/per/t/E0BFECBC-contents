#library(syuzhet)
#library(ggplot2)

#' Calculate Emotion Scores
#'
#' This function calculates emotion scores for a given text using the NRC sentiment lexicon and plots a bar chart showing the scores for each emotion category.
#'
#' @param data A character string containing the input text to analyze
#' @return A bar chart showing the emotion scores for each category and a string describing the two most prevalent emotions in the input text.
#' @importFrom ggplot2 ggplot geom_bar aes position_dodge theme_minimal labs scale_fill_manual scale_x_discrete geom_text
#' @importFrom reshape2 melt
#' @import syuzhet
#' @import pander
#' @export
#' @examples
#' emotion_score("jaunty Hit me again, Sven. The moment of truth boys. Somebody's life's about to change. Let's see... Fabrizio's got niente. Olaf, you've got squat. Sven, uh oh... two pair... mmm. turns to his friend Sorry Fabrizio. Sorry, you're not gonna see your mama again for a long time... grinning 'Cause you're goin' to America!! Full house boys! to the Swedes Sorry boys. Three of a kind and a pair. I'm high and you're dry and... to Fabrizio we're going to -- Goin' home... to the land o' the free and the home of the real hot- dogs! On the TITANIC!! We're ridin' in high style now! We're practically goddamned royalty, ragazzo mio!! Shit!! Come on, Fabri! grabbing their stuff Come on!!")
emotion_score<-function(data){

  stopifnot(is.character(data))
  nrc_data <- get_nrc_sentiment(data)
  pander::pandoc.table(nrc_data[, 1:8], split.table = Inf)
  # 将数据转换为适合绘制的格式
  nrc_data <- nrc_data[, 1:8] # 仅选取情感列
  nrc_data$Emotion <- rownames(nrc_data) # 添加情感名称列
  nrc_data <- reshape2::melt(nrc_data, id.vars = "Emotion")
  nrc_data <- nrc_data[order(nrc_data$value), ] # 按照value从小到大排序
  nrc_data$variable <- factor(nrc_data$variable, levels = nrc_data$variable)
  # 绘制条形图
  a<-ggplot(nrc_data, aes(x = variable, y = value, fill = variable)) +
    geom_bar(stat = "identity", position = "dodge",alpha = 0.9) +
    theme_minimal() + # 设置主题
    labs(title = "Emotions in Sample Text", x = "Emotion", y = "Scores") + # 添加标题和坐标轴标签
    scale_fill_manual(values = c("#56B1F7", "#E69F00", "#F0E442", "#009E73", "#D55E00", "#CC79A7", "#0072B2", "#999999"))+ # 设置颜色
    scale_x_discrete(labels = NULL)+
    geom_text(aes(label=round(value,1)), position=position_dodge(width=0.9), size=3,
              vjust=-0.25, fontface="bold")
  a <- a + geom_bar(stat = "identity", position = "dodge", width = 0.9, alpha = 0.2, color = "black", size = 0.5, show.legend = FALSE, aes(y = -0.01))
  print(a)
  print(paste("The emotion keynote of this movie may be",nrc_data$variable[8],"and",nrc_data$variable[7]))
}

#my_example_text_1<-readLines(Jack)#readLines("C:/Users/11872/Desktop/filmReco/Rose.txt")
#my_example_text_2<-readLines(Rose)#readLines("C:/Users/11872/Desktop/filmReco/Jack.txt")

#emotion_score(my_example_text_1)
