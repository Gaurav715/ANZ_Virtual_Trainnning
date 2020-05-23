#DesicionTREE


getwd()
setwd("C:\\Users\\gaura\\Desktop\\ANZ\\TASK2\\PythonDataPreprocessing")
dataset = read.csv('Data.csv')


#install the package for decision tree
#installed.packages('rpart')
library(rpart)
regressor = rpart(formula = SalaryPerAnnum ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 1))


# Predicting a new result with Decision Tree Regression
y_pred = predict(regressor, data.frame(Age = 40))




# Visualizing the Decision Tree Regression results (higher resolution)
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Age), max(dataset$Age), 0.01)
ggplot() +
    geom_point(aes(x = dataset$Age, y = dataset$SalaryPerAnnum),
               colour = 'red') +
    geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Age = x_grid))),
              colour = 'blue') +
    ggtitle('age versus salary (Decision Tree Regression)') +
    xlab('Level') +
    ylab('Salary')


