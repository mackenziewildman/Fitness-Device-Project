<html>
<body>

<h1>Machine Learning Course Project</h1>

<p>Mackenzie Wildman<br>2/26/17</p>

<h2>Data</h2>
<p>The training and testing data sets are imported using the option na.strings=c('#DIV/0','','NA') to convert #DIV/0 values into NA values. Next all columns containing a significant number of NA values are removed.</p>
<p>Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th International Conference in Cooperation with SIGCHI (Augmented Human '13) . Stuttgart, Germany: ACM SIGCHI, 2013.

Read more: http://groupware.les.inf.puc-rio.br/har#wle_paper_section#ixzz4Zpw7sGI3</p>

<h2>Preprocessing</h2>

<p>
Based on a boxplot of the classe variable, the outcome variable is not significantly skewed and the standard deviation is low (1.5) so no standardizing is applied to the classe variable. Results of Principle Component Analysis show that there is a high correlation among variables, for example, there is a clustering of the variables accel_belt_y and accel_belt_z that is explained by the variable roll_belt. Therefore, preprocessing with Principal Component Analysis is implemented into the model. 
</p>

<img src="https://github.com/mackenziewildman/Fitness-Device-Project/blob/master/analysisCompiled_files/classe_barplot.jpg" alt="Figure" style="width:50px;height:50px;">
<br>
<img src="https://github.com/mackenziewildman/Fitness-Device-Project/blob/master/analysisCompiled_files/belt_accel_plot.jpg" alt="Figure" style="width:448px;height:454px;">

<h2>Cross validation</h2>
<p>
Training data set is split into two data sets - 80% to be used for training, 20% to be used for testing and cross validation. On the training data set, compared the accuracy of a tree-based model with multi-class linear model. The tree model was built using the "rpart" method in caret package. The linear model was built using the function multinom() in the nnet package. Considered omission of various columns in both models. After recognizing significant clustering of the data according to the user_name variable, combined both methods to classify data according to user_name, then applying a linear model to each subset of observations.
</p>

<img src="https://github.com/mackenziewildman/Fitness-Device-Project/blob/master/analysisCompiled_files/cluster_user_name.jpg" alt="Figure" style="width:451px;height:453.5px;">

<h2>Final model</h2>
<p>
First, a decision tree is applied according to the user_name predictor. Next, a multinomial log-linear model is applied to the corresponding user_name. All variables are used as predictors with the exception of X, td_timestamp, raw_timestamp_part_1, raw_timestamp_part_2, and new_window. This model is applied to pre-processed data, using the preProc="pca" method. The accuracy as tested on the testing data set is 87.6%.
</p>

</body>
</html>
