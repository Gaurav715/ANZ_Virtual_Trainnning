#Data_PreProcessing
getwd()
setwd("C:\\Users\\gaura\\Desktop\\ANZ\\TASK2\\ORIGINAL DATA")
dataset = read.csv('Data.csv')


df_inc = data.frame(customer_id= unique(df_csmp$customer_id))