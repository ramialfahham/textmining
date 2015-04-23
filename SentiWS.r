### Resources
# http://asv.informatik.uni-leipzig.de/download/sentiws.html
# http://wortschatz.uni-leipzig.de/download/SentiWS_v1.8c.zip
# http://stackoverflow.com/questions/22116938/twitter-sentiment-analysis-w-r-using-german-language-set-sentiws
# http://regexone.com/

### Preparing SentimentWortschatz as Dataframe

# Load positive / negative SentiWS in German language
positivDE <- readLines("SentiWS_v1.8c_Positive.txt", encoding="UTF-8")
negativDE <- readLines("SentiWS_v1.8c_Negative.txt", encoding="UTF-8")

# Write function to create dataframes of words with positive / negative sentiment

df_sentiment <- function(object){
  
  # Separating words from scores
  words <- sub("\\|[A-Z]+\t[0-9.-]+\t?", ",", object)
  words <- strsplit(words, ",")
  
  # Separating (decimal) scores from words
  m <- gregexpr("-?[0-9].[0-9]{1,4}", object, perl=TRUE)
  scores <- regmatches(object, m)
  
  # Combining lists (words, scores) in a dataframe)
  do.call(rbind, Map(data.frame, words = words, scores = scores))
  
}

# Sentiment dataframes
positiv <- df_sentiment(positivDE)
negativ <- df_sentiment(negativDE)
