# https://www.analyticsvidhya.com/blog/2015/09/full-cheatsheet-machine-learning-algorithms/?utm_content=bufferf18d3&utm_medium=social&utm_source=linkedin.com&utm_campaign=buffer
# C�digos de Python y R para Machine Learning

"""
Se dieron funciones para:

	Regresi�n Lineal
	Regresi�n Log�stica
	Arbol de decision
	Support Vector Machine (SVM)
	Naive Bayes
	kNN (k - Nearest Neighbors)
	k-Means
	Random Forest 
	Componentes Principales (PCA)
	Gradient Boosting

XGBoost: https://www.analyticsvidhya.com/blog/2016/01/xgboost-algorithm-easy-steps/?utm_content=buffer32c71
Faltaria saber como hacer lo que haciamos en SAS: Ensembles de others �rboles
	
Aprendizaje supervisado:
	Regresi�n Log�stica
	Arbol de decision
	Random Forest 
	kNN (k - Nearest Neighbors) - �Esto ser� khonen?

Aprendizaje NO supervisado (sin variable target):
	K-means
	Clustering jer�rquico (dendograma)
	Algoritmo de a-priori

Aprendizaje reforzado (Reinforcement Learing) �?:
	Proceso de decisi�n de Markov
	Q Learning
"""

# ---------------- Regresi�n Lineal - Python ----------------------------
#Import Library
#Import pandas, numpy,
#Otras librerias: scipy, scikit-learn (machine learning), matplotlib (para graficos)
# Natural language processing: Libreria NLTK

from sklearn import linear_model
#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train=input_variables_values_training_datasets
y_train=target_variables_values_training_datasets
x_test=input_variables_values_test_datasets

# Create linear regression object
linear = linear_model.LinearRegression()

#Train the model using the training sets and check score
linear.fit(x_train,y_train)
linear.score(x-train,y_train)

#Equation coefficient and Intercept
print('Coefficient: \n', linear.coef_)
print('Intercept: \n', linear.intercept_)

#Predict Outpu
predicted = linear.predict(x_test)

# ---------------- Regresi�n Lineal - R ----------------------------------

#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays

x_train <- input_variables_values_training_datasets
y_train <- target_variables_values_training_datasets
x_test <- input_variables_values_test_datasets

# Train the model using the training sets and check score
linear <- lm(y_train ~ .,data = x)
summary(linear)
#Predict Output
predicted = predict(linear,x_test)

# ---------------- Regresi�n Log�stica - Python ----------------------------
#Import Library
#Import pandas, numpy

from sklearn.linear_model import LogisticRegression
#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train=input_variables_values_training_datasets
y_train=target_variables_values_training_datasets
x_test=input_variables_values_test_datasets

# Create logistic regression object
model = LogisticRegression()

#Train the model using the training sets and check score
model.fit(x_train,y_train)
model.score(x-train,y_train)

#Equation coefficient and Intercept
print('Coefficient: \n', model.coef_)
print('Intercept: \n', model.intercept_)

#Predict Outpu
predicted = model.predict(x_test)

# ---------------- Regresi�n Log�stica - R ----------------------------------
x <- cbind(x_train,y_train)
logistic <- glm(y_train ~ .,data = x,family='binomial')

summary(logistic)

#Predict Output
predicted = predict(logistic,x_test)


# ---------------- Arbol de decision - Python -------------------------------
#Import Library
Import pandas, numpy

from sklearn import tree
#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train=input_variables_values_training_datasets
y_train=target_variables_values_training_datasets
x_test=input_variables_values_test_datasets

# Create tree object
#Para clasificaci�n, se puede usar 'gini' o 'entropy'. Default = gini
model = tree.DecisionTreeClassifier(criterion='gini')

#Para resolver problemas de regresi�n (variable target continua) 
#model = tree.DecisionTreeRegression()


#Train the model using the training sets and check score
model.fit(x_train,y_train)
model.score(x-train,y_train)

#Equation coefficient and Intercept
print('Coefficient: \n', model.coef_)
print('Intercept: \n', model.intercept_)

#Predict Outpu
predicted = model.predict(x_test)

# ---------------- Arbol de decision - R ------------------------------------
library(rpart)

x <- cbind(x_train,y_train)
fit <- rpart(y_train ~ .,data = x,method="class")

summary(fit)

#Predict Output
predicted = predict(fit,x_test)

# ------------- Support Vector Machine (SVM) - Python -----------------------
#Import Library
#Import pandas, numpy

from sklearn import svm
#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train=input_variables_values_training_datasets
y_train=target_variables_values_training_datasets
x_test=input_variables_values_test_datasets

# Create tree object
#Para clasificaci�n, se puede usar 'gini' o 'entropy'. Default = gini
model = svm.svc()

#Train the model using the training sets and check score
model.fit(x_train,y_train)
model.score(x-train,y_train)

#Equation coefficient and Intercept
print('Coefficient: \n', model.coef_)
print('Intercept: \n', model.intercept_)

#Predict Outpu
predicted = model.predict(x_test)


# ------------- Support Vector Machine (SVM) - R ----------------------------
library(e1071)

x <- cbind(x_train,y_train)

fit <- svm(y_train ~ .,data = x)

summary(fit)

#Predict Output
predicted = predict(fit,x_test)


# ------------------- Naive Bayes - Python -----------------------------------
#Import Library

from sklearn.naive_bayes import GaussianNB
#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train=input_variables_values_training_datasets
y_train=target_variables_values_training_datasets
x_test=input_variables_values_test_datasets

#Create SVM classification object. Hay otras distribuciones para clases multinomiales como Bernoulli Naive Bayes
model = GaussianNB()

#Train the model using the training sets and check score
model.fit(x_train,y_train)
model.score(x-train,y_train)

#Equation coefficient and Intercept
print('Coefficient: \n', model.coef_)
print('Intercept: \n', model.intercept_)

#Predict Outpu
predicted = model.predict(x_test)

# ------------------- Naive Bayes - R ----------------------------------------
library(e1071)

x <- cbind(x_train,y_train)

fit <- naiveBayes(y_train ~ .,data = x)
summary(fit)

#Predict Output
predicted = predict(fit,x_test)

# ------------------- kNN (k - Nearest Neighbors) - Python -------------------
#Import Library

from sklearn.neighbors import KNeighborsClassifier
#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train=input_variables_values_training_datasets
y_train=target_variables_values_training_datasets
x_test=input_variables_values_test_datasets

#Crear model de clasificaci�n KNeighbors
model = KNeighborsClassifier(n_neighbors=6)          #Default para n_neighbors = 5

#Train the model using the training sets and check score
model.fit(x_train,y_train)
model.score(x-train,y_train)

#Equation coefficient and Intercept
print('Coefficient: \n', model.coef_)
print('Intercept: \n', model.intercept_)

#Predict Outpu
predicted = model.predict(x_test)

# ------------------- kNN (k - Nearest Neighbors) - R ------------------------
library(knn)

x <- cbind(x_train,y_train)

fit <- knn(y_train ~ .,data = x, k=5)
summary(fit)

#Predict Output
predicted = predict(fit,x_test)

# ------------------------ k-Means - Python ----------------------------------
from sklearn.cluster import KMeans
....
model = kMeans(n_clusters=3,random_state=0) 
....
# ------------------------ k-Means - R ---------------------------------------
library(cluster)
fit <- kmeans(X, 3)

# --------------------- Random Forest - Python -------------------------------
from sklearn.ensemble import RandomForestClassifier
....
model = RandomForestClassifier()
....
# --------------------- Random Forest - R ------------------------------------
library(randomForest)
fit <- randomForest(Species ~ ., x.ntree=500)

# ------------------ Componentes Principales (PCA) - Python ------------------
from sklearn import decomposition
....
#Objeto PCA
pca = deomposition.PCA(n_components=k)  #Valor default de k = min(n_sample, n_features)

#Para an�lisis de factor
#fa = decomposition.FactorAnalysis()

#Reducir la dimensi�n del dataset de entrenamiento usando PCA
train_reduced = pca.fit_transform(train)

#Reducir la dimensi�n del dataset de test
test_reduced = pca.fit_transform(test)
# ------------------ Componentes Principales (PCA) - R -----------------------
library(stats)
pca <- princomp(train, cor = TRUE)

train_reduced <- predict(pca,train)
test_reduced <- predict(pca,test)

# ------------------- Gradient Boosting - Python -----------------------------
from sklearn.ensemble import GradientBoostingClassifier
....
model = GradientBoostingClassifier(n_estimators = 100, learning_rate=1.0, max_depth=1, random_state=0)
....

# ---------------------- Gradient Boosting - R -------------------------------
library(caret)


fitControl <- trainControl(method = "repeatedcv",number =4,prepeats =4)

fit <- train(y ~., data = x, method = "gbm", trControl = fitControl, verboes = FALSE )

predicted = predict(fit,x_test,type ="prob")[,2]