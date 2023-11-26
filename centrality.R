---
title: "Shenzhen Metro"
author: "Hanson Chong"
date: "2023-11-26"
output: html_document
---

library(dplyr)
library(igraph)
library(ergm)
data <- read.csv("shenzhenmetro2023.csv")
graph <- graph_from_data_frame(data %>% select(-X), directed = F)
plot(simplify(graph), vertex.size= 0.1, edge.arrow.size=0.001,
     vertex.label.cex = 0.75,vertex.label.color = "black",
     vertex.frame.color = adjustcolor("white", alpha.f = 0),
     vertex.color = adjustcolor("white", alpha.f = 0),
     edge.color=adjustcolor(1, alpha.f = 0.15),
     display.isolates=FALSE,
     vertex.label=ifelse(page_rank(graph)$vector > 0.1 , "important nodes", NA)) # viz credits: https://stackoverflow.com/questions/22453273/how-to-visualize-a-large-network-in-r

# Degree centrality (number of connections each node has)
deg <- degree(graph)
# Eigenvector/PageRank (number of corrections weighted by importance of nodes): 
eig <- evcent(graph)$vector
pr <- page.rank(graph)$vector
# Closeness (how far/close each node is to every other node in the network): 
clo <- closeness(graph)
# Betweenness (the extent to which each node serves as an artery connecting other nodes): 
bet <- betweenness(graph)

compare <- data.frame(deg, bet, clo, eig, pr)
write.csv(compare, file = "centralitymeasures.csv")