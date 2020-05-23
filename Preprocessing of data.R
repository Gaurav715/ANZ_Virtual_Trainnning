# Data Preprocessing

# Importing the dataset
getwd()
setwd("C:\\Users\\gaura\\Desktop\\ANZ\\TASK2\\PythonDataPreprocessing")
dataset = read.csv('Data.csv')



library(caTools)
set.seed(123)
split = sample.split(dataset$SalaryPerAnnum, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


#Encoding categorical data
dataset$ï..status = factor(dataset$ï..status,
                         levels = c('authorized', 'posted'),
                         labels = c(1, 2))

dataset$txn_description = factor(dataset$txn_description,
                           levels = c('SALES-POS', 'PAYMENT',
                                      'POS' ,'INTER BANK',
                                      'PAY/SALARY','PHONE BANK'),
                           labels = c(0, 1,2,3,4,5))
dataset$gender = factor(dataset$gender,
                           levels = c('F', 'M'),
                           labels = c(1, 2))
dataset$movement = factor(dataset$movement,
                        levels = c('debit', 'credit'),
                        labels = c(0, 1))


dataset$State = factor(dataset$State,
                          levels = c('QLD', 'VIC','NSW','SA','WA','TAS',
                                     'NT','ACT'),
                          labels = c(0, 1,2,3,4,5,6,7))



#take care of missing data
dataset$card_present_flag = ifelse(is.na(dataset$card_present),
                     ave(dataset$card_present, FUN = function(x) mode(x, na.rm = TRUE)),
                     dataset$card_present)

dataset$merchant_state = ifelse(is.na(dataset$State),
                                   ave(dataset$State, FUN = function(x) mode(x, na.rm = FALSE)),
                                   dataset$State)
dataset$merchant_state = ifelse(is.na(dataset$merchant_state),
                                ave(dataset$merchant_state, FUN = function(x) mode(x, na.rm = TRUE)),
                                dataset$merchant_state)


#To export the final file
write.table(dataset,file ='new_data.csv',sep= ",")

#install the package for decision tree
#installed.packages('rpart')
library(rpart)
library(rpart)
regressor = rpart(formula = SalaryPerAnnum ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 1))

# Visualising the Decision Tree Regression results (higher resolution)
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$age), max(dataset$Level), 0.01)
ggplot() +
    geom_point(aes(x = dataset$Level, y = dataset$Salary),
               colour = 'red') +
    geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
              colour = 'blue') +
    ggtitle('Truth or Bluff (Decision Tree Regression)') +
    xlab('Level') +
    ylab('Salary')

# Plotting the tree
plot(regressor)
text(regressor)












