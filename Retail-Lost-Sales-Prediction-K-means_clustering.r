library(factoextra)
#Reading csv data file
data_1 <- read.csv("C:\\Users\\Neel\\Desktop\\Operations Analytics\\Assignment6\\Assignment_6_\\Assignment_6.csv")
set.seed(44)
#Randomly selecting 1000 observations from data
df1 <-random_sample <- data[sample(nrow(data_1), 1000), ]
df1 <- data.frame(df1)
#Non_stock_out variable
Not_stocked_out <- subset(df, Sold_Out == "No")
#Stocked_out_variable
Stock_out <- subset(df1, Sold_Out == "Yes")
#Elbow graph visualization
fviz_nbclust(Not_stocked_out[,3:26], FUNcluster = kmeans, method = "wss")
#Average_Distance
avg_dist_plot <- fviz_nbclust(Not_stocked_out[,3:26], kmeans, method = "silhouette") + ggtitle("Average Distance") + theme(plot.title = element_text(hjust = 0.5))
avg_dist_plot
#Empty list
cluster <- list()
centr <- list()
TWSS <- list()
avg_dist <-list()
cluster_plot <- list()
#Loop for clustering 
for(i in 1:5)
{
#Clustering
cluster[[i]]= kmeans(Not_stocked_out[,3:26],i)
#Extracting center of cluster for different values of k
centr[[i]]= cluster[[i]]$centers
#Calculating total within sum of squares for different k
TWSS[[i]] = cluster[[i]]$tot.withinss
#Calculating Average distance
avg_dist[[i]] = mean(sqrt(cluster[[i]]$betweenss)/sqrt(cluster[[i]]$size))
cluster_plot[[i]] <- fviz_cluster(cluster[[i]], data=Not_stocked_out[,3:26], palette = c("red","yellow","blue","green","orange"),
                      geom = "point",
                      ellipse.type = "convex",
                      ggtheme = theme_bw())
#Plotting cluster plot for different values of k
cluster_plot[i]
file_name <- paste0("Centroid_", i, ".csv")
#Creating centroid csv files for different values of k
write.csv(centr[[i]],file_name)
}
#Plotting the scatterlots
cluster_plot[1:5]
k <- c(2:5)
TWSS <- TWSS[-1]
avg_dist <- avg_dist[-1]
plot(k,TWSS)
plot(k,avg_dist)
