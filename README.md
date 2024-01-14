# Retail-lost-sales-prediction-and-pricing-analytics
Employing advanced analytics, the project addresses leading retail clothing giant business challenges through Lost Sales and Price Prediction. These strategic endeavors boost revenue by predicting lost sales to optimize pricing strategies for enhanced profitability.

### Introduction
A retail organization operating in an online fashion sample sales industry offers extremely limited time discounts on designer apparel and accessories.
The oragnization host online events of sales on their website. Upon encountering an appealing event, a customer has the option to click on it, leading them to a dedicated page displaying all products available within that event. Each item featured on this page is denoted as a "style". Ultimately, should the customer find a specific style appealing, they can click on it, redirecting them to a new page presenting comprehensive details about the style. This information encompasses available sizes, with each size-specific product being termed as an "item" or "SKU".The pricing for each item is established at the style level, where a style essentially consolidates all sizes of identical items. The duration of each event is 24 hrs.

The demand of a style is highly correlated with it's price. If in an event a style is in huge amount of stock and is not getting sold rapidly then a dynamic reduction in price is applied which would boost the sales of that style. Moreover, company can earn more revenue by increasing price of a style dynamically for the styles which are high in demand.

So, the company can earn more by choosing optimum price of a style in an event based on predicted demand of the product.

### Dataset
The dataset consists percentage of sales of each item in an event. Upon detailed examination, it is observed that some items were sold out before event is completed.
So in this case demand prediction for those items becomes difficult because we donot have subsequent information of sales if we have enough stock.

### Lost Sales Prediction
Machine learning appoarch is employed to solved this issue. By carrying out clustering over non-sold out tems we can form groups of items with identical selling behaviour.
Now based on distance of sold-out item from this cluster centroids, all sold-out items would be allocated to the nearest cluster.
The missing information about lost sales in sold out items can be filled with the help of alloted cluster configuration.
In this way lost sales are predicted for sold out items.

![image](https://github.com/neelpdesai/Retail-lost-sales-prediction-and-pricing-analytics/assets/137664550/3848a16d-dd9d-434f-a16b-12810e3aedd3)

Based on elbow graph the optimal number of clusters is 3. 

Thus the sold out item is alloted to one of the 3 formed segments/groups. Subsequently, their lost sales are predicted based on cluster behaviour.

### Demand Prediction

Demand is predicted based on available features. 
Mutiple Linear Regression and Decision Tree algorithm is trained over train data. 
![image](https://github.com/neelpdesai/Retail-lost-sales-prediction-and-pricing-analytics/assets/137664550/a6368254-6755-4020-a78c-98ff1827b90f)
MSE comparision on test data reveal that Linear Regression performs better than Decision Tree Algorithm. However, price optimization is carried out by demand predicted by both Linear Regression Model and Decision Tree algorithm.

### Optimum Price Prediction
Optimum Price of each item is found by Integer Formulation approach.

* Consider a scenario where we have a set 𝑁 of styles within a specific subclass, and each style is associated with a set 𝑀 of possible prices. The number of styles is denoted by 𝑁=|𝑁|, and 𝑀=|𝑀| represents the count of potential prices for each style.
* The range of possible prices is defined by a lower and upper bound, with increments of $5 between them. For instance, if a style's price ranges from $24.90 to $44.90, the set of possible prices would be 𝑀={24.90;$29.90;$34.90;$39.90;$44.90}, with 𝑀=5.
* Let 𝑝𝑗 denote the 𝑗𝑡ℎ possible price in the set 𝑀, where 𝑗=1,2,…𝑀.
* The primary objective of the price optimization problem is to strategically choose a price from 𝑀 for each style, aiming to maximize the revenue generated during their initial exposure.
* A less efficient approach to addressing this problem would involve calculating and comparing the expected revenue for every possible combination of prices assigned to each style, resulting in 𝑀𝑁 potential combinations.

* The demand for a style is solely determined by its price and the cumulative prices of all competing styles, not the individual prices of each style.

* Let 𝑘 represent the total of competing styles' prices.

* For instance, in a given subclass and event with N=3 styles, under equal conditions, the relative price for the first style remains constant whether the prices are {24.90, $29.90, $39.90} or {24.90, $34.90, $34.90}. In both cases, 𝑘=$94.70, and the relative price for the first style is $24.90𝑘/3=0.79.


* Let 𝐾 represent the set of possible values for 𝑘, taking into account that 𝑘 can assume all values ranging from the minimum of 𝑁∗min𝑗{𝑝𝑗} to the maximum of 𝑁∗max𝑗{𝑝𝑗}, with increments of 5.
* The size of set 𝐾 can be determined by the formula: 𝐾 = 𝑁∗(𝑀−1)+1.
* By focusing on the summation of prices for all competing styles rather than individually considering each style's price, we have efficiently transformed the 𝑀𝑁 possible price combinations into a manageable set of 𝑂(𝑀𝑁) possible sums to evaluate.
  
#### Integer Programming Model for Pricing Optimization

This mathematical formulation represents an integer programming model for pricing optimization. The goal is to maximize revenue considering sales of each style at various prices, taking into account the sum of prices for competing styles.

Objective Function (Maximization):
Maximize sum over j in M, sum over i in N of D_ij * k * x_ij

Subject to Constraints:

sum over j in M of x_ij = 1 for all i in N
sum over i in N, sum over j in M of p_j * x_ij = k for all k in K
x_ij is binary (0 or 1) for all i in N, j in M
Variables:

N: Set of styles.
M: Set of possible prices.
D_ij: Sales of i-th style at j-th possible price given the sum of prices of competing styles is k.
k: Variable representing the sum of prices of competing styles.
p_j: j-th possible price in the set of all prices M.
x_ij: Binary variable, 1 if style i is assigned price p_j, 0 otherwise.
Objective:
Maximize total revenue derived from sales by determining optimal prices for each style in the presence of competition.

The result of solving this Integer Programming Problem over demand predicted by Decision Tree Model is:
![image](https://github.com/neelpdesai/Retail-lost-sales-prediction-and-pricing-analytics/assets/137664550/6c13fff6-12c5-4017-bb69-a30803a590ce)
![image](https://github.com/neelpdesai/Retail-lost-sales-prediction-and-pricing-analytics/assets/137664550/56ccf145-eed1-420e-8e41-25b1bb4735ac)

The optimal price of item A,B and C is 30 that generates max revenue of 533103.9 USD.

The result of solving this Integer Programming Problem over demand predicted by Linear Regression Model is:
![image](https://github.com/neelpdesai/Retail-lost-sales-prediction-and-pricing-analytics/assets/137664550/74732ee3-3448-49db-9fde-feba17604b0e)
![image](https://github.com/neelpdesai/Retail-lost-sales-prediction-and-pricing-analytics/assets/137664550/8a0960ee-0fd8-4a88-9819-470fdeb0a1fa)

The optimal price of item A,B and C is 30 that generates max revenue of 533103.9 USD.

