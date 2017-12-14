
##Load packages and set directory
setwd("~/Documents/GitHub/groceries")
library(arules)
library(readr)
library(arulesViz)
library(rJava)
library(iplots)
library(colorspace)
install.packages("tkplot")
library(Rgraphviz)

#Loading data and treating data

#orders <- data.frame(orderID=order_prod$order_id, prod_name=order_prod$product_name)
#write.csv(orders, "./orders.csv")
orders <- read_csv("~/Documents/GitHub/groceries/orders.csv")
View(orders)
baskets<- read.transactions(file="~/Documents/GitHub/groceries/orders.csv",
                            format = "single",
                            sep = ";",
                            quote = "",
                            cols= c(1,2))

inspect(head(baskets))
summary(baskets)

itemFrequency(baskets)
test1<-eclat(baskets, parameter = list(supp=0.00, maxlen=3))
inspect(test1)

#Produtos mais comprados
itemFrequencyPlot(baskets, 
                  top="10", 
                  type="absolute", 
                  main="Best Sellers Brio", 
                  col="#0296A5")


  #1 itemset
#Rule0:supp:0.00199, conf:0.47, maxlen=3
rule0 <- apriori(baskets, parameter=list(supp=0.00199, conf=0.47, maxlen=3))
rule0

  #4 itemsets
#Rule 1: supp:0.003, conf:0.35, maxlen=2
rule1 <- apriori(baskets, parameter=list(supp=0.003, conf=0.35, maxlen=2))
inspect(rule1)

  #7 itemsets
#Rule 2: supp:0.003, conf:0.38, maxlen=3
rule2 <- apriori(baskets, parameter=list(supp=0.003, conf=0.38, maxlen=3))
inspect(rule2)

  #14 itemsets
#Rule3: supp = 0.002, conf = 0.40
rule3 <- apriori(baskets,parameter = list(supp = 0.002, conf = 0.40))
rule3

#14 itemsets
#Rule3: supp = 0.002, conf = 0.40
rule4 <- apriori(baskets,parameter = list(supp = 0.0009, conf = 0.30, maxlen=2))
rule4

  #350 itemsets
#rulesall (almost all of them - 350 rules)
rulesall <- rule2 <- apriori(baskets,  parameter=list(supp=0.001, conf=0.30, maxlen=3))
rulesall


  #subrules
subrules <- subset(rulesall, lift>4)
subrules

#Sort rules by conf
rules_conf <- sort (rule0, by="confidence", decreasing=TRUE)
inspect(rules_conf)

#by lift
rules_lift <- sort(rule0, by="lift", decreasing=TRUE)
inspect(rules_lift)
#Fazer isto: arules::supportingTransactions(transactions = baskets )

#Lift for Organic milk
milk <- apriori (data=baskets, parameter=list (supp=0.001,conf = 0.12), 
                 appearance = list (default="lhs",rhs="Organic Whole Milk"), control = list (verbose=F))
inspect(milk)
rules_lift_milk <- sort(milk, by="lift", decreasing=TRUE)
inspect(rules_lift_milk)

#Lift for Bread
bread <- apriori (data=baskets, parameter=list (supp=0.001,conf = 0.03), 
                 appearance = list (default="lhs",rhs="100% Whole Wheat Bread"), control = list (verbose=F))
inspect(bread)
rules_lift_bread <- sort(bread, by="lift", decreasing=TRUE)
inspect(rules_lift_bread)

#packagedoc: https://cran.rstudio.com/web/packages/arulesViz/arulesViz.pdf
#Viz - multiple rules

#Plots (interactive and non)
plot(rulesall[1:300], verbose=TRUE,  engine="htmlwidget")
plot(subrules[1:100], verbose=TRUE, engine="htmlwidget")
plot(rulesall, control = list(col=sequential_hcl(100)))

#Grouped matrix
plot(rule3, method="grouped matrix")

#Graphs
plot(rule2, method="graph", engine = "interactive")
plot(rule2, method="graph", engine="htmlwidget",
     igraphLayout = "layout_in_circle")

#Parallel coordinates plot
plot(rule2, method="paracoord", reorder=TRUE)
plot(rule2, method="graph")
