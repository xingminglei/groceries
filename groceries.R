
##Load packages and set directory
setwd("~/Documents/GitHub/groceries")
library(arules)
??read.transactions
library(readr)


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
test1<-eclat(baskets, parameter = list(supp=0.05, maxlen=15))
inspect(test1)

#Produtos mais comprados
itemFrequencyPlot(baskets, 
                  top="10", 
                  type="absolute", 
                  main="Best Sellers Brio", 
                  col="#0296A5")



#Rule0:supp:0.005, conf:0.5, maxlen=5
rule0 <- apriori(baskets, parameter=list(supp=0.002, conf=0.45, maxlen=4))

#Rule 1: supp:0.009, conf:0.5, maxlen=2
rule1 <- apriori(baskets, parameter=list(supp=0.009, conf=0.5, maxlen=4))
inspect(rule1)

#Rule 2: supp:0.01, conf:0.30, maxlen=4
rule2 <- apriori(baskets, parameter=list(supp=0.009, conf=0.51, maxlen=5))
inspect(rule2)

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


rules <- apriori(baskets,parameter = list(supp = 0.0018, conf = 0.40))
rules
plot(rules[1:10], method=graph, control=list(type=items()))

