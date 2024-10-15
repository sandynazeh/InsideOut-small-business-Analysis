#packages 
library(dplyr)
library(ggplot2)
library(DBI)
library(RSQLite)
library(readr) #to read csv files 
library(tidyr) 
library(patchwork) 
library(plotly) # to make interactive chart

# Connect to SQL lite database
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db") 
#creating tables 
#1.customers table
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS customers (
    Customer_ID INTEGER PRIMARY KEY,
    Gender TEXT,
    Location TEXT
);
")
#2.products table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS products (
    Product_ID INTEGER PRIMARY KEY,
    Product_Type TEXT
);
") 
#3.orders table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS orders (
    Date_ID INTEGER,
    Order_ID INTEGER PRIMARY KEY,
    Customer_ID INTEGER,
    Product_ID INTEGER,
    Order_Status TEXT,
    No_of_products INTEGER,
    Product_cost INTEGER,
    Product_price INTEGER,
    Total_Price INTEGER,
    Dollar_exchange_rate FLOAT,
    FOREIGN KEY(Product_ID) REFERENCES products(Product_ID),
    FOREIGN KEY(Customer_ID) REFERENCES customers(Customer_ID),
    FOREIGN KEY(Date_ID) REFERENCES date(Date_ID)
);
")
#4.date table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS date (
    Date_ID INTEGER PRIMARY KEY,
    Date TEXT
);
") 
#5.marketing table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS marketing (
    Date_ID INTEGER,
    Content_type TEXT,
    Post_type TEXT,
    likes INTEGER,
    comments INTEGER,
    shares INTEGER,
    views INTEGER,
    Platform_ID INTEGER,
    FOREIGN KEY(Date_ID) REFERENCES date(Date_ID),
    FOREIGN KEY(Platform_ID) REFERENCES platforms(Platform_ID)
);
")
#7.cities table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS cities (
    Platform_ID INTEGER,
    City TEXT,
    Percentage FLOAT,
    FOREIGN KEY(Platform_ID) REFERENCES platforms(Platform_ID)
);
")

#8.countries table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS countries (
    Platform_ID INTEGER,
    Country TEXT,
    Percentage FLOAT,
    FOREIGN KEY(Platform_ID) REFERENCES platforms(Platform_ID)
);
") 
 

#9.gender table 

dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS gender (
    Platform_ID INTEGER,
    Gender TEXT,
    Percentage FLOAT,
    FOREIGN KEY(Platform_ID) REFERENCES platforms(Platform_ID)
);
")

#10.age table 
dbSendQuery(conn, "
CREATE TABLE IF NOT EXISTS age (
    Platform_ID INTEGER,
    Age TEXT,
    Percentage FLOAT,
    FOREIGN KEY(Platform_ID) REFERENCES platforms(Platform_ID)
);
") 
#close the connection 
# Close the connection
dbDisconnect(conn)


#loading the data


# Read CSV file into a data frame
df_customers <- read_csv("Customers.csv")

# Connect to SQLite database
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")

# Insert the data into the 'customers' table, appending it
dbWriteTable(conn, "customers", df_customers, append = TRUE, row.names = FALSE)

# Close the connection
dbDisconnect(conn)

#inserting data into table , loading data 



# Read CSV file into a data frame 
#customer table 
df_customers <- read_csv("Customers.csv")
# Connect to  database
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'customers' table, appending it
dbWriteTable(conn, "customers", df_customers, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn)

#Product table 
df_Products <- read_csv("Products.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Products' table, appending it
dbWriteTable(conn, "Products", df_Products, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 

#Marketing table 
df_Marketing <- read_csv("Marketing.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Marketing' table, appending it
dbWriteTable(conn, "Marketing", df_Marketing, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 

#Age table 
df_Age <- read_csv("Age.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Age' table, appending it
dbWriteTable(conn, "Age", df_Age, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 

#cities table 
df_Cities <- read_csv("Cities.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Cities' table, appending it
dbWriteTable(conn, "Cities", df_Cities, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 

#countries table 
df_Countries <- read_csv("Countries.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Countries' table, appending it
dbWriteTable(conn, "Countries", df_Countries, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn)  

#Date table 
df_Date <- read_csv("Date.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Countries' table, appending it
dbWriteTable(conn, "Date", df_Date, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn)  


#Gender table 
df_Gender <- read_csv("Gender.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Gender' table, appending it
dbWriteTable(conn, "Gender", df_Gender, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 


#plateforms table 
df_Plateforms <- read_csv("Gender.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Plateforms' table, appending it
dbWriteTable(conn, "Plateforms", df_Plateforms, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 

#Orders table 
df_Orders <- read_csv("Orders.csv")
conn <- dbConnect(SQLite(), dbname = "InsideOutt_Projectt.db")
# Insert the data into the 'Orders' table, appending it
dbWriteTable(conn, "Orders", df_Orders, append = TRUE, row.names = FALSE)
# Close the connection
dbDisconnect(conn) 

#pre processing

#display the 6 rows of each table 
head(df_Age)
head(df_Cities)
head(df_Countries)
head(df_customers)
head(df_Date)
head(df_Gender)
head(df_Marketing)
head(df_Orders)
head(df_Plateforms)
head(df_Products)

#get structure of our data frames 
str(df_Age)
str(df_Cities) 
str(df_Countries) 
str(df_customers) 
str(df_Date) 
str(df_Gender) 
str(df_Marketing) 
str(df_Orders) 
str(df_Products) 
str(df_Products)
# Get summary statistics of the data frame
summary(df_Age) 
summary(df_Cities)
summary(df_Countries)
summary(df_customers)
summary(df_Date) 
summary(df_Gender)
summary(df_Marketing)
summary(df_Orders)
summary(df_Plateforms)
summary(df_Products)

#checking missing values into customer table 
# Sum of missing values (NA) per column
colSums(is.na(df_customers)) 
#filling location's missing values 
# Replace NA values in the 'Location' column with "Cairo"
df_customers$Location[is.na(df_customers$Location)] <- "Cairo" 

#checking missing into orders table 
colSums(is.na(df_Orders)) 
#filling No_of_products missing values 
df_Orders$No_of_products[is.na(df_Orders$No_of_products)] <- "0" 

#wrong format
#changing data type 
# Change 'No_of_products' column into Orders table to integer
df_Orders$No_of_products <- as.integer(df_Orders$No_of_products)

# Check data type of 'No_of_products'
str(df_Orders$No_of_products)   

# Convert the 'Date' column into Date table  to Date format
df_Date$Date <- as.Date(df_Date$Date, format = "%m/%d/%Y")

# Check the data type of the 'Date' column
str(df_Date$Date)  
#Change percentage data type into Gender table 
# Remove '%' and convert to numeric, then divide by 100
df_Gender$Percentage <- as.numeric(gsub("%", "", df_Gender$Percentage)) / 100

# Check the data type of 'Percentage' into gender table 
str(df_Gender$Percentage)  

# change percentage data type of Percentage into Cities table 
# Remove '%' and convert to numeric, then divide by 100
df_Cities$Percentage <- as.numeric(gsub("%", "", df_Cities$Percentage)) / 100

# Check the data type of 'Percentage' column
str(df_Cities$Percentage)  

#change data of percentage into Countries table 
# Remove '%' and convert to numeric, then divide by 100
df_Countries$Percentage <- as.numeric(gsub("%", "", df_Countries$Percentage)) / 100

# Check the data type of 'Percentage' column
str(df_Countries$Percentage)  

#change data type of percentage into Age Table 
# Remove '%' and convert to numeric, then divide by 100
df_Age$Percentage <- as.numeric(gsub("%", "", df_Age$Percentage)) / 100

# Check the data type of 'Percentage' column
str(df_Age$Percentage)   

#Trim spaces in Order status column into Order table 
# Trim spaces in the 'Order_Status' column
stripped_Orders <- trimws(df_Orders$Order_Status) 
#trim spaces in Gender Column into Gender table 
stripped_Gender <- trimws(df_Gender$Gender) 


#Duplication 


# For each table, check for duplicates and show only the duplicated rows

# Check duplicates in orders and print the result
if(any(duplicated(df_Orders))) {
  print("Duplicated rows in df_Orders:")
  print(df_orders[duplicated(df_Orders), ])
} else {
  print("No duplicates in df_Orders")
}

# Check duplicates in customers and print the duplicated rows
if(any(duplicated(df_customers))) {
  print("Duplicated rows in df_customers:")
  print(df_customers[duplicated(df_customers), ])
} else {
  print("No duplicates in df_customers")
}

# Check duplicates in df_products and print the duplicated rows
if(any(duplicated(df_Products))) {
  print("Duplicated rows in df_Products:")
  print(df_products[duplicated(df_Products), ])
} else {
  print("No duplicates in df_Products")
}

# Check duplicates in platforms and print the duplicated rows
if(any(duplicated(df_Plateforms))) {
  print("Duplicated rows in df_Plateforms:")
  print(df_Plateforms[duplicated(df_Plateforms), ])
} else {
  print("No duplicates in df_Plateforms")
}

# Check duplicates in marketing and print the duplicated rows
if(any(duplicated(df_Marketing))) {
  print("Duplicated rows in df_Marketing:")
  print(df_Marketing[duplicated(df_Marketing), ])
} else {
  print("No duplicates in df_Marketing")
} 

# Aggregate the duplicated rows by summing 'likes', 'comments', 'shares', 'views'
# Group by relevant columns and aggregate by summing numeric columns 

df_Marketing <- df_Marketing %>%
  group_by(Date_ID, Content_type, Post_type, Platform_ID) %>%
  summarise(
    likes = sum(likes, na.rm = TRUE),
    comments = sum(comments, na.rm = TRUE),
    shares = sum(shares, na.rm = TRUE),
    views = sum(views, na.rm = TRUE),
    .groups = 'drop'  # Un group after summerization
  )
# Check if duplicates remain
any(duplicated(df_Marketing))  # Should return FALSE


# Check if duplicates remain
print(duplicated(df_Marketing))  # Should return all FALSE


# Check duplicates in df_date and print the duplicated rows
if(any(duplicated(df_Date))) {
  print("Duplicated rows in df_Date:")
  print(df_Date[duplicated(df_Date), ])
} else {
  print("No duplicates in df_date")
}

# Check duplicates in cities and print the duplicated rows
if(any(duplicated(df_Cities))) {
  print("Duplicated rows in df_cities:")
  print(df_cities[duplicated(df_Cities), ])
} else {
  print("No duplicates in df_Cities")
}

# Check duplicates in age and print the duplicated rows
if(any(duplicated(df_Age))) {
  print("Duplicated rows in df_Age:")
  print(df_Age[duplicated(df_Age), ])
} else {
  print("No duplicates in df_age")
}

# Check duplicates in countries and print the duplicated rows
if(any(duplicated(df_Countries))) {
  print("Duplicated rows in df_Countries:")
  print(df_Countries[duplicated(df_Countries), ])
} else {
  print("No duplicates in df_countries")
}

# Check duplicates in df_gender and print the duplicated rows
if(any(duplicated(df_Gender))) {
  print("Duplicated rows in df_Gender:")
  print(df_Gender[duplicated(df_Gender), ])
} else {
  print("No duplicates in df_gender")
} 

#Outiers 
#We need to know facebook views outlier

# Assuming marketing is your data frame and 'Platform_ID' is a column

# Filter the data for Platform_ID == 111 (e.g., Facebook)
facebook_data <- df_Marketing %>% filter(Platform_ID == 111)

# Calculate Q1 (25th percentile) and Q3 (75th percentile) for 'views'
Q1 <- quantile(facebook_data$views, 0.25, na.rm = TRUE)
Q3 <- quantile(facebook_data$views, 0.75, na.rm = TRUE)

# Calculate IQR (Interquartile Range)
IQR <- Q3 - Q1

# Determine outliers: values below Q1 - 1.5*IQR or above Q3 + 1.5*IQR
outliers <- facebook_data %>%
  filter(views < (Q1 - 1.5 * IQR) | views > (Q3 + 1.5 * IQR))

# Display results
print(outliers) 

#we need to know instagram views outliers 
Instagram_data <- df_Marketing %>% filter(Platform_ID == 222)

# Calculate Q1 (25th percentile) and Q3 (75th percentile) for 'views'
Q1 <- quantile(Instagram_data$views, 0.25, na.rm = TRUE)
Q3 <- quantile(Instagram_data$views, 0.75, na.rm = TRUE)

# Calculate IQR (Interquartile Range)
IQR <- Q3 - Q1

# Determine outliers: values below Q1 - 1.5*IQR or above Q3 + 1.5*IQR
outliers_2 <- facebook_data %>%
  filter(views < (Q1 - 1.5 * IQR) | views > (Q3 + 1.5 * IQR)) 
print(outliers_2)


# we need to know tiktok viewrs outliers 
TikTok_data <- df_Marketing %>% filter(Platform_ID == 333)

# Calculate Q1 (25th percentile) and Q3 (75th percentile) for 'views'
Q1 <- quantile(TikTok_data$views, 0.25, na.rm = TRUE)
Q3 <- quantile(TikTok_data$views, 0.75, na.rm = TRUE)

# Calculate IQR (Interquartile Range)
IQR <- Q3 - Q1

# Determine outliers: values below Q1 - 1.5*IQR or above Q3 + 1.5*IQR
outliers_3 <- TikTok_data %>%
  filter(views < (Q1 - 1.5 * IQR) | views > (Q3 + 1.5 * IQR)) 
print(outliers)
outliers 
#---------------------------------------------------------------------------------
#Exploratory Data Analysis
#Marketing analysis 
#1. The percentage of followers' cities in all platfroms (visualization)

# SQL Query
Cities_query <- "
SELECT DISTINCT
    platforms.Platform_name, 
    Cities.City,
    Cities.Percentage AS City_Percentage
FROM 
    Cities
JOIN 
    platforms ON Cities.Platform_ID = platforms.Platform_ID
"
rm(Cities_sql)

# Create pivot table
Cities_Pivot <- cities_sql %>%
  pivot_wider(names_from = Platform_name, values_from = city_Percentage   )

# Print the pivot table
print(Cities_Pivot)

#-------------------------------------------------------------------- 
#1. The percentage of followers' cities in all platfroms (visualization)

# Sample data (based on the data you provided)
cities_sql <- data.frame(
  Platform_name = c("Instagram", "Instagram", "Facebook", "Facebook"),
  City = c("Cairo", "Alex", "Cairo", "Alex"),
  city_Percentage = c("40%", "10%", "21%", "9%")
)

# Clean the 'city_Percentage' column by removing '%' and converting to numeric
cities_sql <- cities_sql %>%
  mutate(city_Percentage = as.numeric(gsub("%", "", city_Percentage)))

# Create a ggplot object to visualize city percentages by platform
plotly_bar <- ggplot(cities_sql, aes(x = City, y = city_Percentage, fill = Platform_name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "City Percentages by Platform",
    x = "City",
    y = "City Percentage (%)"
  ) +
  scale_y_continuous(labels = scales::percent_format(scale = 1)) +  # Show y-axis as percentages
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels

# Convert ggplot to an interactive plotly plot
ggplotly(plotly_bar)

#------------------------------------------------------------------------ 

#--------------------------------------------------------------------------- 
# 2. The percentage of followers' countries in all platfroms
# Load necessary libraries 
#inner join

# Connect to the SQLite database
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# Define the SQL query to get distinct platform names, countries, and percentages
countries_query <- "
SELECT DISTINCT
    platforms.Platform_name, 
    countries.Country,
    countries.Percentage AS Country_Percentage
FROM 
    countries
JOIN 
    platforms ON countries.Platform_ID = platforms.Platform_ID
"

# Execute the query and store the result in a data frame
Countries_sql <- dbGetQuery(conn, countries_query)

# Print the result
print(Countries_sql)

# Close the database connection
dbDisconnect(conn) 

#pivot and visualization 


# Example data (replace with your actual data)
Countries_sql <- data.frame(
  Platform_name = c("Instagram", "Instagram", "Instagram", "Instagram", "Instagram", "Facebook", "Facebook", "Facebook", "Facebook", "Facebook", "Instagram"),
  Country = c("Egypt", "Saudi Arabia", "Algeria", "Morocco", "Kuwait", "Libya", "Tunisia", "Egypt", "Saudi Arabia", "Algeria", "Morocco"),
  Country_Percentage = c(94.9, 1.0, 0.6, 0.3, 0.3, 1.0, 1.0, 93.0, 1.0, 1.0, 0.3)  # Assuming this is in numeric form (e.g., 94.9 instead of "94.9%")
)

# Pivot the data by Country and Platform_name, summing the percentages
Countries_Pivot <- Countries_sql %>%
  pivot_wider(names_from = Platform_name, values_from = Country_Percentage, values_fn = sum, values_fill = list(Country_Percentage = 0))

# Print the pivoted data to check
print(Countries_Pivot)

# Visualize the result using ggplot2 
fig <- plot_ly(Countries_Pivot, x = ~Country, type = 'bar', 
               y = ~Instagram, name = 'Instagram', marker = list(color = 'salmon')) %>%
  add_trace(y = ~Facebook, name = 'Facebook', marker = list(color = 'lightblue')) %>%
  layout(title = 'Percentage of Followers by Country and Platform',
         xaxis = list(title = 'Country'),
         yaxis = list(title = 'Percentage'),
         barmode = 'group')

# Show the plot
fig


#-----------------------------------------------------------------------------------------
#3-The percentage of followers' ages in all platfroms 
#inner join 



# Assuming you've already connected to the database and retrieved the data
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# SQL query to get distinct platform names, ages, and percentages
Ages_query <- "
SELECT DISTINCT
    platforms.Platform_name, 
    age.Age,
    age.Percentage AS Age_Percentage
FROM 
    age
JOIN 
    platforms ON age.Platform_ID = platforms.Platform_ID
"

# Execute the query and store the result in a data frame
Ages_sql <- dbGetQuery(conn, Ages_query)

# Pivot the percentage values for age for each platform
Ages_Pivot <- Ages_sql %>%
  pivot_wider(names_from = Platform_name, values_from = Age_Percentage, values_fn = list) %>%
  unnest(cols = everything())

# Print the pivoted data
print(Ages_Pivot)

# Visualize the result using Plotly
# Load necessary libraries
library(dplyr)
library(plotly)

# Sample data as provided
Age_sql <- data.frame(
  Age = c("13-17", "18-24", "25-34", "35-44", "45-54", "55-64", "65-"),
  Instagram = c(0.22, 0.53, 0.18, 0.05, 0.01, 0, 0),
  Facebook = c(NA, 0.6, 0.3, 0.1, 0.01, 0.01, NA)
)

# Convert the numeric columns to percentage by multiplying by 100
Age_sql <- Age_sql %>%
  mutate(
    Instagram = Instagram * 100,
    Facebook = Facebook * 100
  )

# Print the updated data with percentages
print(Age_sql)

# Create a plotly bar plot with percentages
plotly_bar <- plot_ly(Age_sql, x = ~Age, y = ~Instagram, type = 'bar', name = 'Instagram', marker = list(color = 'lightblue')) %>%
  add_trace(y = ~Facebook, name = 'Facebook', marker = list(color = 'salmon')) %>%
  layout(
    title = "Age Distribution by Platform",
    xaxis = list(title = "Age Group"),
    yaxis = list(title = "Percentage (%)", range = c(0, 100)),  # Set y-axis range from 0 to 100%
    barmode = 'group'
  )

# Show the plot
plotly_bar

#----------------------------------------------------------------------------------- 
#---------------------------------------------------------------------------------- 
#4.The percentage of followers' gender in all platfroms 


#inner join 
# Connect to the database
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# SQL query to get distinct platform names, genders, and percentages
Gender_query <- "
SELECT DISTINCT
    platforms.Platform_name, 
    gender.Gender,
    gender.Percentage AS Gender_Percentage
FROM 
    gender
JOIN 
    platforms ON gender.Platform_ID = platforms.Platform_ID
"

# Execute the query and store the result in a data frame
Gender_sql <- dbGetQuery(conn, Gender_query)

# Print the result
print(Gender_sql)

# Pivot the percentage values for gender for each platform
Gender_Pivot <- Gender_sql %>%
  pivot_wider(names_from = Platform_name, values_from = Gender_Percentage, values_fn = list) %>%
  unnest(cols = everything())

# Print the pivoted data
print(Gender_Pivot)

# Visualize the result using Plotly

# Sample data as provided
Gender_sql <- data.frame(
  Gender = c("Male", "Female"),
  Instagram = c("6.90%", "93.00%"),
  Facebook = c("13.40%", "87.00%")
)

# Convert percentage columns to numeric format
Gender_sql <- Gender_sql %>%
  mutate(
    Instagram = as.numeric(gsub("%", "", Instagram)),
    Facebook = as.numeric(gsub("%", "", Facebook))
  )

# Print the cleaned data
print(Gender_sql)

# Create the bar plot using plotly
plotly_bar <- plot_ly(Gender_sql, x = ~Gender, y = ~Instagram, type = 'bar', name = 'Instagram', marker = list(color = 'lightblue')) %>%
  add_trace(y = ~Facebook, name = 'Facebook', marker = list(color = 'salmon')) %>%
  layout(
    title = "Gender Distribution by Platform",
    xaxis = list(title = "Gender"),
    yaxis = list(title = "Percentage"),
    barmode = 'group'
  )

# Show the plot
plotly_bar 
#----------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------- 
#Sales Analysis 
#1. Count how many customers are present in each location. 
# Load necessary libraries


# Assuming customers is your data frame, and it contains 'Location' and 'Customer_ID' columns
# Group and summarize the data to count customers per location
Locations_Pivot <- df_customers %>%
  group_by(Location) %>%
  summarise(Number_of_Customers = n())  # Count the number of customers 
print(Locations_Pivot)

# Create an interactive bar plot using plotly
plotly_bar <- plot_ly(
  Locations_Pivot, 
  x = ~Location, 
  y = ~Number_of_Customers, 
  type = 'bar',
  marker = list(color = 'skyblue')
) %>%
  layout(
    title = "Number of Customers per Location",
    xaxis = list(title = "Location"),
    yaxis = list(title = "Number of Customers"),
    barmode = 'stack'
  )

# Display the plot
plotly_bar        #bar chart
#----------------------------------------------------------------------------- 
#2.Which Gender Buys More? 



# Connect to your SQLite database
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# SQL query to link customers and orders
query <- "
SELECT DISTINCT customers.Gender, orders.Order_ID
FROM orders
JOIN customers ON orders.Customer_ID = customers.Customer_ID;
"

# Execute the query and store the result in a data frame
orders_by_gender <- dbGetQuery(conn, query)

# View the query result
print(orders_by_gender)   

# Clean the Gender column by removing leading and trailing spaces
orders_by_gender$Gender <- trimws(orders_by_gender$Gender)

# Check if the problem is fixed
print(orders_by_gender)


# Pivot the data to count the number of orders by gender
orders_pivot <- orders_by_gender %>%
  group_by(Gender) %>%
  summarise(Number_of_Orders = n())  # Count the number of orders per gender

# View the pivoted data
print(orders_pivot) 

# Create an interactive bar plot using plotly
plotly_bar <- plot_ly(
  orders_pivot, 
  x = ~Gender, 
  y = ~Number_of_Orders, 
  type = 'bar',
  marker = list(color = 'coral')
) %>%
  layout(
    title = "Number of Orders by Gender",
    xaxis = list(title = "Gender"),
    yaxis = list(title = "Number of Orders"),
    barmode = 'stack'
  )

# Display the plot
plotly_bar  #bar chart
#---------------------------------------------------------------------------- 
#3. Number of Cancelled Orders by Month 

# Establish database connection (assuming SQLite)
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# SQL query to link the 'date' and 'orders' tables
query <- "
SELECT DISTINCT
    date.Date,
    orders.Order_ID
FROM orders
JOIN date ON orders.Date_ID = date.Date_ID;
"

# Execute the query and store the result in a data frame
cancelled_orders <- dbGetQuery(conn, query)

# Print the result
print(cancelled_orders)

# Pivot the data to count the number of orders per date
orders_pivot <- cancelled_orders %>%
  group_by(Date) %>%
  summarise(Number_of_Orders = n())  # Count the number of orders per date

# View the pivoted data
print(orders_pivot)


# Load necessary libraries for plotting
library(plotly)

# Create an interactive line plot using plotly
plotly_line <- plot_ly(
  orders_pivot, 
  x = ~Date, 
  y = ~Number_of_Orders, 
  type = 'scatter',
  mode = 'lines+markers',
  marker = list(color = 'blue')
) %>%
  layout(
    title = "Number of Orders Over Time",
    xaxis = list(title = "Date"),
    yaxis = list(title = "Number of Orders")
  )

# Display the plot
plotly_line  #time series 
#-----------------------------------------------------------------------------
#4. Total number of Orders for each product Types 


# Establish database connection (assuming SQLite)
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# SQL query to link the 'orders' and 'products' tables
query <- "
SELECT DISTINCT 
    products.Product_Type, 
    orders.Order_ID
FROM orders
JOIN products ON orders.Product_ID = products.Product_ID;
"

# Execute the query and store the result in a data frame
orders_by_product_type <- dbGetQuery(conn, query)

# Print the result
print(orders_by_product_type)

# Pivot the data to count the number of orders per product type
product_pivot <- orders_by_product_type %>%
  group_by(Product_Type) %>%
  summarise(Number_of_Orders = n())  # Count the number of orders per product type

# View the pivoted data
print(product_pivot)


# Load necessary libraries for plotting
library(plotly)

# Create an interactive bar plot using plotly
plotly_bar <- plot_ly(
  product_pivot, 
  x = ~Product_Type, 
  y = ~Number_of_Orders, 
  type = 'bar',
  marker = list(color = 'yellow')
) %>%
  layout(
    title = "Number of Orders by Product Type",
    xaxis = list(title = "Product Type"),
    yaxis = list(title = "Number of Orders")
  )

# Display the plot
plotly_bar   #barchart 
#--------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------- 
#5.  Relationship Between Product Cost and Dollar Price


# Connect to the SQLite database
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# Example of the query to get orders data (replace with actual query if necessary)
query <- "
SELECT Product_cost, Dollar_exchange_rate
FROM orders
"

# Execute the query and store the result in a data frame
df_orders <- dbGetQuery(conn, query)

# Close the database connection
dbDisconnect(conn)

# Print the data to verify
print(head(df_orders))



# Pivot the data (calculate mean of Dollar_exchange_rate by Product_cost)
Cost_Dollar <- df_orders %>%
  group_by(Product_cost) %>%
  summarise(Mean_Dollar_Rate = mean(Dollar_exchange_rate, na.rm = TRUE)) %>%
  ungroup()

# Print pivoted data to check
print(Cost_Dollar)


# Create a bar chart with Plotly

my_plot <- plot_ly(
  data = Cost_Dollar, 
  x = ~Product_cost, 
  y = ~Mean_Dollar_Rate, 
  type = 'bar', 
  name = 'Mean Dollar Exchange Rate',
  marker = list(color = 'lightgreen')
) %>%
  layout(
    title = "Mean Dollar Exchange Rate by Product Cost",
    xaxis = list(title = "Product Cost"),
    yaxis = list(title = "Mean Dollar Exchange Rate"),
    showlegend = FALSE
  )

# Call the plot by typing the object's name
my_plot


#-----------------------------------------------------------------------------------------
 #6. Relationship Between Number of Orders and Dollar Price 


# Connect to the SQLite database
conn <- dbConnect(RSQLite::SQLite(), "InsideOutt_Projectt.db")

# SQL query to link Date table with Dollar table
query <- '
SELECT DISTINCT date.Date, orders.Order_ID, orders.Dollar_exchange_rate
FROM orders
JOIN date ON orders.Date_ID = date.Date_ID
'

# Execute the query and load the result into a data frame
dollar_by_product <- dbGetQuery(conn, query)

# Disconnect from the database
dbDisconnect(conn)

# Print the data frame to check the results
print(dollar_by_product)

# Aggregate total orders by Date and Dollar_exchange_rate
Products_dollar <- dollar_by_product %>%
  group_by(Date, Dollar_exchange_rate) %>%
  summarise(total_orders = n()) %>%
  ungroup()

# Sort by Date in descending order
Products_dollar_sorted <- Products_dollar %>%
  arrange(desc(Date))

# Print the sorted data
print(Products_dollar_sorted)

# Pivot data (if needed)
# If you want to pivot it to make Dollar_exchange_rate as columns, you can use spread (pivot_wider)
Products_dollar_pivot <- Products_dollar_sorted %>%
  pivot_wider(names_from = Dollar_exchange_rate, values_from = total_orders, values_fill = list(total_orders = 0))

# Print pivoted data to check
print(Products_dollar_pivot)

# Plot using Plotly - Creating a bar chart to visualize total orders by Date and Dollar exchange rate

my_plot2 <- plot_ly(
  data = Products_dollar_sorted, 
  x = ~Date, 
  y = ~total_orders, 
  color = ~Dollar_exchange_rate, 
  type = 'bar'
) %>%
  layout(
    title = "Total Orders by Date and Dollar Exchange Rate",
    xaxis = list(title = "Date"),
    yaxis = list(title = "Total Orders"),
    barmode = "group"
  )

# Call the plot by typing the object's name
my_plot2
