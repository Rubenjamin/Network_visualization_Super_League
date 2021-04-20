###network visualization #Superleagues
  
  # active libraries
library(dplyr)
library(ggraph)
library(ggplot2)
library(readr)
library(rlist)
library(rtweet)
library(tibble)
library(tidygraph)
library(tidyr)

#harvesting twitter API

super_league_tweets <- search_tweets ('#superleague
                                      -filter:quote',
                                      n = 1000)


write_rds(super_league_tweets, "super_league_tweets.rds")

##REPLY section

#cleaning up for replies only + unique interaction couple

sl_rply <- super_league_tweets %>%
           drop_na(reply_to_screen_name) 

sl_rply_edge <- sl_rply %>%
                select('screen_name','reply_to_screen_name')
                names(sl_rply_edge)[1] <- "from"
                names(sl_rply_edge)[2] <- "to"

sl_rply_edge_u <- sl_rply_edge %>%                
                  filter((sl_rply_edge)[1] != (sl_rply_edge)[2])

#graphing

sl_rply_grph_u <- sl_rply_edge_u

sl_rply_grph_u %>%
                ggraph(layout = "fr") +
                geom_edge_link(alpha = 0.8) +
                geom_node_point(size = 1) +
                theme_graph() +
                ggtitle('#Superleague Reply')

ggsave("Superleague_reply_graph.pdf")


## RETWEET section
#cleaning up for retweet #superleague uniques

sl_rt <- super_league_tweets %>%
         filter(is_retweet == TRUE)

sl_rt_edge <- sl_rt %>%
              select(screen_name, retweet_screen_name) %>%
              distinct()

#graphing

sl_rt_grph <- sl_rt_edge

sl_rt_grph %>%
              ggraph(layout = "fr") +
              geom_edge_link(alpha = 0.8) +
              geom_node_point (size = 1) +
              theme_graph() +
              ggtitle('#Superleague Retweet')

ggsave("Superleague_rt_graph.pdf")  


#credits to the creators of the assignment
@misc{ddw2021,
  title={"Social Media and Web Analytics"},
  author={Lachlan Deer and Henrik de With},
  year={2021},
  url = "https://tisem-digital-marketing.github.io/2021-smwa"}


#원숭이도 나무에서 떨어질 때가 있다
