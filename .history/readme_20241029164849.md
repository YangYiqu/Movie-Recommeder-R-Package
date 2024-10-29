# **Movie Recommender**

Through STA3005, we learned many knowledge about R, we will list the knowledge adopted in our package as follows.

1.  basic concepts of list, data frame

    design and check our build-in dataset "movie_data", which is a big dataframe with 15 columns

2.  basic knowledge of ifelse, for loops

    in some of our functions, we need to use ifelse to distinguish different situations and use for loops to check each element and do some operations, for example, we use ifelse to distinguish valid input and invalid input, if the input is invalid, we will raise a reminder output

3.  use functions in plyr, dplyr packages to perform complex data frame operations

    in movie dataset analysis and visualization section, we need to use functions in plyr, dplyr packages to select and summarize our built-in movie dataset, such as group_by, summarize, arrange, mutate functions......

4.  use %\>% in magrittr package to simplify our logic

    in some of our functions, instead of writing a long line of code with many brackets, we use %\>% in magrittr package to reorganize our logic and finally achieve a clear and brief code

5.  use ggplot2 to design beautiful graph

    in movie dataset analysis and visualization section, after we process the data, we need to use ggplot2 to create various plots, such as bar plot, pie chart, and line chart......., and finallly combined them as one graph via patchwork.

6.  function writing

    in our entire package, we write 9 valid and useful functions related to movie industry

7.  model fitting knowledge

    in prediction section, we need to fit different machine learning models, such as linear regression, svm, decision tree......, and evaluate the model performance.

8.  text manipulation

    in our natural language proccessing section, we use text manipulation such as substr(), grep(), table() to divide the movie text into sentence and perform emotion score and trend analysis based on each sentence.

9.  R package constructing

    based on the R package development procedures in lecture notes, we write, document, test, build our movie recommender package step by step

10. debugging

    after finish the main part of our package, we need to use our debugging skills to remove all the errors raised by devtools::check() function methods, such as

In this package, instead of only focusing on movies recommendation, our Movie Recommender package is an integrated package, which provides 4 different sections with 9 functions in total to satisfy different needs of our users. Besides the comprehensive sections we provide, all our functions have very simple input, thus is very user friendly. More detailed information can be found through the following vignette.

## **Movie Dataset Analysis and Visualization Section**

In this section, we provide 4 functions to analyze and visualize our built-in movie dataset.

### **Heat world map**

-   **Function Description:**

    heat_world_map targets on comparing different countries' movie data based on "count", "score", "count_prop", or "score_ranking" during a given decade using a heat world map.

-   **Input parameters:**

    *decade* : A character string representing the decade to plot, which must be chosen from "1980-1989", "1990-1999", "2000-2009", or "2010-2020".

    *type* : A character string representing the comparison criterion of plot to generate, which must be chosen from "count", "score", "count_prop", or "score_ranking".

-   **Output:**

    A heat world map.

-   **Example:**

    Here, we provide two examples to show how to use this function.

    1.  heat_world_map("1980-1989", "count") : total number of films heat map during 1980-1989
    2.  heat_world_map("2010-2020", "score") : average score of all films heat map during 2010-2020

    The running results of the above examples are as follows.

```{r}
#total number of films heat map during 1980-1989
heat_world_map("1980-1989", "count")
```

```{r}
#average score of all films heat map during 2010-2020
heat_world_map("2010-2020", "score")
```

### Individual data visualization

-   **Function Description:**

    individual_data_visualization function targets on searching and visualizing the information of a specific movie star, director, company, or country.

-   **Input parameters:**

    *type :* A character string indicating the type of input. It can be "movie star", "director", "company", "country". Default is "country". If the input type isn't chosen from movie star, director, company, or country, it will raise a remind "Invalid input. The type must be chosen from star, director, company, or country."

    *name :* A character string indicating the name of the movie star, director, company, or country. Default is "China". If the input name of the corresponding type(movie star, director, company, or country) doesn't exist in our build-in movie dataset, it will raise a remind "Sorry, the type name you want doesn't exist in our database."

-   **Output:**

    One wordcloud and one 2 by 2 conbined plot.

    1.  wordcloud for genres' names of movies
    2.  2 by 2 conbined plot: In the first line, one pie chart and one pie circle chart to show the different genres' proportions; In the second line, two line charts to show the variations of total number of movie and the average movie score over different years respectively, for these two plots, the x axis represents different years and the y axis represents the total number of movie and the average movie score in each year.

-   **Examples:**

    Here, we provide six examples to show how to use this function.

    1.  individual_data("star", "Denzel Washington")
    2.  individual_data("director", "Steven Spielberg")
    3.  individual_data("company", "Warner Bros.")
    4.  individual_data("country", "Canada")
    5.  individual_data("12345", "Canada")
    6.  individual_data("director", "Stephen Curry")

    The running results of the above examples are as follows.

```{r}
#wrong type input
individual_data_visualization("12345", "Canada")
```

```{r}
#correct input, but doesn't exist in build-in movie dataset
individual_data_visualization("director", "Stephen Curry")
```

```{r}
individual_data_visualization("star", "Denzel Washington")
```

```{r}
individual_data_visualization("director", "Steven Spielberg")
```

```{r}
individual_data_visualization("company", "Warner Bros.")
```

```{r}
individual_data_visualization("country", "Canada")
```

### Top movies comparison

-   **Function Description:**

    top_movies_comparison targets on comparing specific number of the top movies under a specific sorting criterion("score" or "gross").

-   **Input parameters:**

    *time.start* : the start year of the movie data to be analyzed (default: 1900)

    *time.end* : the end year of the movie data to be analyzed (default: 2022)

    *sort.criterion* : the criterion by which to sort the movie data ("score" or "gross", default: "score")

    *show.number* : the number of movies to display, **suggest to use 10 or 20** (default: 10)

-   **Output:**

    One data frame and generate one 2 by 2 conbined plot.

    1.  Data frame: detailed information of specific number of the top movies ("name", "rating", "genre", "year", "released", "score", "votes", "director", "writer", "star", "country", "budget", "gross", "company", and "runtime" )
    2.  2 by 2 conbined plot: In the first line, two bar charts to show the rating and director proportion respectively. In the second line, two bar charts to show the company and country proportion respectively

-   **Examples:**

    Here, we provide two examples to show how to use this function.

    1.  top_movies_comparison(1900, 2020, "score", 20)
    2.  top_movies_comparison(2000, 2020, "gross", 10)

    The running results of the above examples are as follows.

```{r}
#top 20 movies based on score during 1900-2020  
top_movies_comparison(1900, 2020, "score", 20)
```

```{r}
#top 10 movies based on gross during 2000-2020
top_movies_comparison(2000, 2020, "gross", 10)
```

## The analyze_company function

The analyze_company function is designed to analyze information for two movie production companies. The function takes in two arguments, which are the names of the two companies to be analyzed. The function returns three plots, which can be used to compare various aspects of the two companies' performance.

-   **Data**

The analyze_company function uses a movie dataset to analyze information about movie production companies. The dataset contains information about movies, including their budget, gross revenue, and the company that produced them. The dataset is loaded using the utils package and is stored in the movie_data object. The default dataset is "moive_data.rda".

-   **Usage**

To use the analyze_company function, you need to provide the names of two companies to be

analyzed. Here's an example of how to call the function:

```{r analyze}
analyze_company("Paramount Pictures", "Twentieth Century Fox")
```

```{r analyze_company}
analyze_company("Paramount Pictures","Columbia Pictures")
```

-   **Description of the Three Plots**

    The analyze_company function creates three plots that help compare the two companies.

    **1. Total Number of Moives**

    The first plot shows the total number of movies produced by each company. The x-axis shows the two companies being compared, and the y-axis shows the total number of movies produced. The plot uses a bar chart with each bar colored according to the company being represented. The plot also includes a label above each bar indicating the total number of movies produced.

    **2. Gross Revenue Over Time**

    The second plot shows the gross revenue of each company over time. The x-axis shows the years from 1916 to 2017, and the y-axis shows the gross revenue in USD. The plot uses a line chart with each line colored according to the company being represented. The plot also includes a legend indicating which line represents which company.

    **3. Budget Over Time**

    The third plot shows the budget of each company over time. The x-axis shows the years from 1916 to 2017, and the y-axis shows the budget in USD. The plot uses a line chart with each line colored according to the company being represented. The plot also includes a legend indicating which line represents which company.

-   **Conclusion**

The analyze_company function is a useful tool for analyzing information about movie production companies. The function uses a movie dataset to compare the performance of two companies based on various factors. The function returns three plots that help visualize the differences between the two companies. This vignette has explained how to use the analyze_company function and what the resulting plots represent

## Prediction Section

### Score Predict

-   **Function Description:**

    Based on the build-in movie dataset, score prediction function will find the most related features among all features ("name", "rating", "genre", "year", "released", "score", "votes", "director", "writer", "star", "country", "budget", "gross", "company", and "runtime" ), then train a specific machine learning model ("svm", "neural network", "decision tree", "randomforest", or "linear regression"). Finally, it will make a prediction on the input new movie data.

-   **Input parameters:**

    *method* : A character string indicating the machine learning method to use. The available options are "svm", "neural network", "decision tree", "randomforest", and "linear regression".

    *newdata* : A data frame containing the features of budget, runtime, votes, gross in order.

    **(remark: must be correct order, budget -\> runtime -\> votes -\> gross)**

-   **Machine learning methods**

    More detailed information about machine learning methods can be found through following websites.

    1.  **linear regression:** <https://en.wikipedia.org/wiki/Linear_regression>
    2.  **support vector machine(svm)**: <https://en.wikipedia.org/wiki/Support_vector_machine>
    3.  **decision tree**: <https://en.wikipedia.org/wiki/Decision_tree>
    4.  **random forest**: <https://en.wikipedia.org/wiki/Random_forest>
    5.  **neural network**: <https://en.wikipedia.org/wiki/Neural_network>

    **remark: Though support vector machine(svm), decision tree, and random forest are usually used in classification problems, they can also be modified to solve regression problems.**

-   **Output:**

    One correlation heat map, machine learning model summary, final prediction value.

    1.  Correlation heat map:

        Show correlations between different features, and find the most correlated features.

        Remark: correlation formula

        $Cov(x,y)=\frac{\sum_{i=1}^{n}({x_i-\bar{x})^2}*\sum_{i=1}^{n}({y_i-\bar{y})^2}}{\sqrt{\sum_{i=1}^{n}({x_i-\bar{x})^2}}*\sqrt{\sum_{i=1}^{n}({y_i-\bar{y})^2}}}$

    2.  Machine learning model summary:

        For linear regression and decision tree: build-in summary

        For neural network: build-in summary and Mean Squared Error

        For random forest: Prediction Accuracy

        For svm: Mean Absolute Error, Mean Squared Error, and Root Mean Squared Error

        **remark: some related formula**

        Mean Absolute Error(MAE):

        $MAE = {\frac{1}{N}\sum_{i=1}^{N}|actual.y_i-predict.y_i|}$

        Mean Squared Error(MSE):

        $MSE = {\frac{1}{N}\sum_{i=1}^{N}(actual.y_i-predict.y_i)^2}$

        Root Mean Squared Error(RMSE):

        $RMSE = \sqrt{MSE}$

        For MAE, MSE, RMSE, the smaller values indicate smaller differences between prediction values and actual values, which further indicates better performance of the machine learning model.

        Prediction Accuracy:

        $Prediction\space{}Accuracy = {\frac{1}{N}\sum_{i=1}^{N}Indicator_{predict.y_i == actual.y_i}}$

        For Prediction Accuracy, the larger values indicate more accurate predictions among all predictions, which further indicates better performance of the machine learning model.

    3.  Final prediction value:

        A float value between 0 and 10.

-   **Examples:**

    Here we provides two examples to show how to use this function.

    1.  score_predict("linear regression", newdata = data.frame(budget = 10000000, runtime = 120, votes = 2000, gross = 1000000))
    2.  score_predict("neural network", newdata = data.frame(budget = 12000000, runtime = 106, votes = 4000, gross = 1650000))

```{r}
score_predict("linear regression", newdata = data.frame(budget = 10000000, runtime = 120, votes = 2000, gross = 1000000))
```

```{r}
score_predict("neural network", newdata = data.frame(budget = 12000000, runtime = 106, votes = 4000, gross = 1650000))
```

## Natural language processing(NLP) Section

In this section, we provide two functions to analyze the emotion score and trend of the movies.

## The emotion scores function

The emotion_score function first uses the get_nrc_sentiment function from the syuzhet package to calculate the emotion scores for the input text using the NRC sentiment lexicon. The resulting scores are then plotted in a bar chart, with each emotion category represented by a different color. The function also outputs a string describing the two most prevalent emotions in the input text.

-   **Brief illustration of the NRC sentiment lexicon**

The NRC sentiment lexicon is a list of English words and their corresponding sentiment scores, developed by the National Research Council of Canada. Each word in the lexicon is assigned scores for eight basic emotions (anger, anticipation, disgust, fear, joy, sadness, surprise, trust) and two sentiment dimensions (negative and positive).

-   **Details**

The emotion_score function first uses the get_nrc_sentiment function from the syuzhet package to calculate the emotion scores for the input text using the NRC sentiment lexicon. The resulting scores are then plotted in a bar chart, with each emotion category represented by a different color. The function also outputs a string describing the two most prevalent emotions in the input text.

-   **Usage**

Here is an example of how to use the emotion_score function:

```{r emotion_score}
emotion_score("jaunty Hit me again, Sven. The moment of truth boys. Somebody's life's about to change. Let's see... Fabrizio's got niente. Olaf, you've got squat. Sven, uh oh... two pair... mmm. turns to his friend Sorry Fabrizio. Sorry, you're not gonna see your mama again for a long time... grinning 'Cause you're goin' to America!! Full house boys! to the Swedes Sorry boys. Three of a kind and a pair. I'm high and you're dry and... to Fabrizio we're going to -- Goin' home... to the land o' the free and the home of the real hot- dogs! On the TITANIC!! We're ridin' in high style now! We're practically goddamned royalty, ragazzo mio!! Shit!! Come on, Fabri! grabbing their stuff Come on!!")

```

## The emo_trend function

The emo_trend function is a tool for analyzing the emotional trend trajectory of a given text. It uses sentiment analysis to calculate the emotional scores of each sentence in the input string and then segments the scores into 10 equally-sized sections. The function then identifies the segment with the largest emotional fluctuations and another segment with the highest average emotional score, and highlights them in the plot.

-   **Brief description of the sentiment analysis**

The sentiment_analysis is a natural language processing function that analyzes the sentiment of a given piece of text. It can determine whether the text expresses a positive, negative, or neutral sentiment.

-   **Usage**

To use the emo_trend function, simply pass a character string containing the input text as the data parameter. The function will then return a ggplot object showing the emotional trend trajectory over time. Here is an example of how to use this function.

```{r emo_trend}
review <- "This is a fantastic movie! The acting is superb, and the story is
           gripping from beginning to end. I was on the edge of my seat the whole
           time. Highly recommended!"
emo_trend(review)

```

## Recommend system

In this section, we provide two functions to recommend similarly users and movies based on users ' historical data.

We know that "user behavior data is the most commonly used and most critical data for recommendation systems. The user's potential interest and user's evaluation of items are reflected in the user's behavior history."

We first need to convert the user's historical movie viewing data into a rating matrix with rows for users and columns for movie genres. Each element represents the user's rating for that movie genre. Then, we can find other users whose interests are most similar to each user by calculating the similarity between users.

The collaborative filtering algorithm is a recommendation algorithm that completely relies on the behavioral relationship between users and items. The principle behind it is to "cooperate with everyone's feedback, evaluation and opinions to filter massive information, and to screen out users who may be interested. Information".

The application of recommendation system is very extensive. This package is for the recommendation of movie data, but it can be further expanded and updated on the basis of this package. For example, in the field of e-commerce, products can be recommended according to the user's historical purchase records; in the field of music, it can Recommend new songs based on the user's historical listening records; in the social field, it can recommend content that may be of interest based on the user's friends and hobbies. \### user_similarity(history)

### User_similarity

The row vector corresponding to each user can actually be regarded as a user's Embedding vector.

Cosine similarity: The most classic way is to use cosine similarity to measure the angle between user vectors i and j. The smaller the angle, the greater the cosine similarity, and the more similar two users are. $$\text{similarity} = \cos(\theta) = \frac{\mathbf{A} \cdot \mathbf{B}}{\|\mathbf{A}\|\|\mathbf{B}\|} = \frac{\sum_{i=1}^{n} A_i B_i}{\sqrt{\sum_{i=1}^{n} A_i^2} \sqrt{\sum_{i=1}^{n} B_i^2}}$$

-   **history:**

It should be a dataframe: users' history data including columns of "user.id","movie", and "rating".

```{r}
input <- data.frame("user.id"=sample(1:10, 5000,replace = TRUE), "movie"=sample(movie_data$name,5000), "rating"=sample(1:10, 5000,replace = TRUE))
user_similarity(input)
```

-   **Output**:

In the similarity matrix graph, for every columns,the most similar user is marked by black frame.

### Reco

In reco, we use different recommendation algorithms to predict movies that users might like and recommend these movies to users.

The reco system can be implemented based on different recommendation algorithms, such as content-based recommendation, collaborative filtering recommendation, deep learning recommendation, etc. Different algorithms have different advantages and disadvantages, which need to be selected according to the actual situation.

For the reco system, we can first model the user's interests into a vector based on the user's historical viewing records. Then, we can use different recommendation algorithms to calculate the similarity between this vector and each movie vector in the movie library, and select some movies with the highest similarity as recommendation results.

Finally, we can recommend these movies to users to help them discover new movies and increase user stickiness to the platform.

-   **history**

Dataframe with columns of "user.id","movie", and "rating".

-   **method**

    1\. **UBCF** (User-based Collaborative Filtering): This method makes recommendation based on user similarity, that is to say, for a target user, find other users with similar interests and recommend the items they like to the target user.

    2\. **IBCF** (Item-based Collaborative Filtering): This method is based on item similarity to recommend, that is, for a target user, find the items that the user used to like, find out other items similar to these items, and recommend these items to the target user.

    3\. **RANDOM**: The method is random recommendation, that is, randomly select an item from all the items to recommend.

    4\. **POPULAR**: This method is based on item popularity, that is, choosing the most popular items to recommend, usually based on the most frequent items in the user's historical behavior data.

    5\. **SVD** (Singular Value Decomposition): It is a collaborative filtering algorithm based on matrix decomposition. It decomposes the scoring matrix into three matrices: a user matrix, an item matrix, and a singular value matrix. In these three matrices, the user matrix and item matrix represent the characteristics of the user and item respectively, while the singular value matrix contains the weight of these characteristics.

-   **id**

It should in the **history**\$user.id, which we should recommend top three movies to the **id** based on

historical data and the algorithm we use

```{r}
input <- data.frame("user.id"=sample(1:50, 6000,replace = TRUE), "movie"=sample(movie_data$name,6000), "rating"=sample(1:10, 6000,replace = TRUE))
reco(input,"IBCF",1)

```

-   **Output**:

we will output a list of top3 recommended items, and a measure of performance evaluation

parameters such as MAE,MSE,and RMSE.

-   MAE: $\frac{1}{D}\sum_{i=1}^{D}|x_i-y_i|$

-   MSE: $\frac{1}{D}\sum_{i=1}^{D}(x_i-y_i)^2$

-   RMSE: $\sqrt{(\frac{1}{n})\sum_{i=1}^{n}(y_{i} - x_{i})^{2}}$
