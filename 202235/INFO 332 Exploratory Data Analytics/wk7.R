install.packages("gutenbergr")
install.packages("tidyverse")
install.packages("tidytext")
install.packages("wordcloud")
install.packages("stringr")


library(gutenbergr)
library(tidyverse)
library(tidytext)
library(wordcloud)
library(stringr)

myPhrase <- "The quick brown fox jumps over the lazy dog"
class(myPhrase)
length(myPhrase)
nchar(myPhrase)
nchar(c("phrase number one is longer", "phrase #2 is shorter"))

myPhrase <- "The quick brown fox jumps over the lazy dog"
substr(myPhrase, 4, 13)
substr(myPhrase, 4, 1000)

toupper(myPhrase)
tolower(myPhrase)
identical("I like R", "i like R")
identical(toupper("I like R"), toupper("i like R"))

myPhrase <- "        The quick brown fox jumps over the lazy dog  "
myPhrase
trimws(myPhrase)
trimws(myPhrase, which="left")
trimws(myPhrase, which="right")

T <- "[23.2, 24.7, 22, 16.9, 25, 17, 20, 19.8, 18, 22]"
class(T)
T2 <- substr(T,2,nchar(T)-1)
T2

T3 <- str_split(T2, pattern=",")
T3
myPhrase <- "The quick brown fox jumps over the lazy dog."
stringr::str_split(myPhrase, pattern = " ")
T4 <- as.numeric(T3[[1]]) 
T4
T <- "[23.2, 24.7, 22, 16.9, 25, 17, 20, 19.8, 18, 22]"
as.numeric(str_split(substr(T, 2, nchar(T)-1), pattern = ",")[[1]])

myPhrase <- "        The quick brown fox jumps over the lazy dog  "
myPhrase
str_split(tolower(myPhrase), pattern = "")
table(str_split(tolower(myPhrase), pattern = ""))

data(mtcars)
car_names <- rownames(mtcars)
car_names

grep("Toyota", car_names)
grep("Toyota", car_names, value = TRUE)
grepl("Toyota", car_names)
grep("toyota", car_names, value =TRUE, ignore.case = TRUE)

myPhrase <- "The quick brown fox jumps over the lazy dog"
gsub("dog", "cat", myPhrase)
gsub("Toyota", "Honda", car_names)

txt = "a man and a woman, a man and a woman, a man and a woman"
gsub("man", "woman", txt)
gsub("\\bman\\b", "woman", txt)
str_extract_all(stringr::words, "^y.+") %>% unlist()
str_view(stringr::words, "^y.+", match=TRUE)


physics <- gutenberg_download(c(13476, 30155), meta_fields = "author")
glimpse(physics)

physics$text[1717]
physics %>% group_by(author, gutenberg_id) %>% summarize(total = n())

physics_words <- physics %>% unnest_tokens(word, text)
glimpse(physics_words)
physics_words_count <- count(physics_words, author, word) %>%
  arrange(desc(n))
physics_words_count
stop_words

physics_words_count <-  count(physics_words, author, word) %>%
  anti_join(stop_words, by="word") %>%
  arrange(desc(n))
physics_words_count

physics_words_count %>% 
  ggplot(aes(x=word, y=n)) + 
  geom_col() + 
  facet_wrap(~author)

physics_words_count %>% 
  group_by(author) %>%
  top_n(20, n) %>%
  ungroup() %>%
  ggplot(aes(x=word, y=n)) + 
  geom_col() + 
  facet_wrap(~author, scales = "free") +
  coord_flip()

physics_words_count %>% 
  group_by(author) %>%
  top_n(20, n) %>%
  ungroup() %>%
  mutate(word = fct_reorder(word, n)) %>%
  ggplot(aes(x=word, y=n)) + 
  geom_col() + 
  facet_wrap(~author, scales = "free") +
  coord_flip()

tesla_words <- filter(physics_words_count, author == "Tesla, Nikola")

wordcloud(word = tesla_words$word, freq = tesla_words$n, max.words = 50, colors = "blue")
