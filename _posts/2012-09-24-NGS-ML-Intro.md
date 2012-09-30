---
layout: post
title:  An Introduction to Machine Learning for Biologists
description: 
tags: [ML, NGS]
comments: true
analytics: true
TNTitle: 2012-09-24-NGS-ML-Intro
---

<!--
>%hdrrelated%
># Related
> * [[wiki0:Blog_Pathology]]
> * [[../Blog]]
> * -
> * [[wiki0:Polyphen2]]
> * -
> * [vfile: stuartjandrews.com/2012/09/24/VCS.sh][vfile:///Users/stu/Desktop/Dropbox/Documents/TrunkNotes/stuartjandrews.com/2012/09/24/VCS.sh]
> * -

# 2012-09-24 

 * "elements of statistical learning" kind:pdf

 * Fix [TrunkNotes style-combined.css](vfile:///Users/stu/Desktop/Dropbox/Documents/TrunkNotes/Html/style-combined.css)

Figure 1: ![Figure_1][]

# IMAGES
[SPACER]: spacer-r0.gif "Figure 0"
# NGS Journal Club 
-->

[Figure_1]: microarray.jpg "Figure 1"
[Figure_2]: netflix-top10.jpg "Figure 2"
[Figure_3]: Netflix-latentfactors-r0.jpg "Figure 3"
[Figure_4]: polyphen2-r0.jpg "Figure 4"
[Figure_5]: polyphen2-sunyaev-r0.jpg "Figure 5"
[Figure_6]: polyphen-r0.jpg "Figure 6"
[Figure_7]: array-cgh-r0.jpg "Figure 7"
[Figure_8]: splicing1-r0.jpg "Figure_8"
[Figure_9]: bioinformatics2-r0.jpg "Figure_9"
[Figure_10]: bioinformatics1-r0.jpg "Figure_10"
[Figure_11]: haplotypes1-r0.jpg "Figure_11"
[Figure_12]: protein-struct1-r0.jpg "Figure_12"
[Figure_13]: google-r0.jpg "Figure_13"

[Figure_23]: knn15-r0.jpg "Figure_23"
[Figure_24]: knn1-r0.jpg "Figure_24"

[Figure_18]: mxn-matrix-r0.jpg "Figure_18"
[Figure_19]: svm-nonlinear-r0.jpg "Figure_19"
[Figure_20]: svm-linear-r0.jpg "Figure_20"

[Figure_32]: regression-r0.jpg "Figure_32"

[Figure_42]: linear-svm-r0.jpg "Figure_42"
[Figure_43]: nonlinear-svm-r0.jpg "Figure_43"

[Figure_52]: decision-tree-r0.jpg "Figure_52"

<!-- <img src="spacer.gif" alt="Spacer" height="520"/> -->

## Introduction to Machine Learning
### September 25, 2012

 * A Brief Introduction To Machine Learning, Gunnar Rätsch
   [http://events.ccc.de/congress/2004/fahrplan/files/105-machine-learning-paper.pdf](http://events.ccc.de/congress/2004/fahrplan/files/105-machine-learning-paper.pdf)

 * ML Bioinformatics Summer Course, Gunnar Rätsch
   [http://www.raetschlab.org/lectures/MLBioinformatics](http://www.raetschlab.org/lectures/MLBioinformatics)

 * **E**lement of **S**tatistical **L**earning, T. Hastie, R. Tibshirani, J. Friedman 
   [http://www.stanford.edu/~hastie/local.ftp/Springer/ESLII_print5.pdf](http://www.stanford.edu/~hastie/local.ftp/Springer/ESLII_print5.pdf)

<!-- <img src="spacer.gif" alt="Spacer" height="200"/> -->

# Machine Learning

### "Aims to mimic intelligent abilities of humans by machines"



<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

# Machine Learning

### What is it used for?


<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

# Examples

## It's what Google does

![Figure_13][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Netflix Prize

![Figure_2][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Bioinformatics

![Figure_9][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Bioinformatics

![Figure_10][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Microarray Analysis

1. which samples are most similar
1. which genes are most similar
1. which expression variations correlate with specific diseases

![Figure_1][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Polyphen2

Predicts possible impact of an amino acid substitution

 * SVM, Naive Bayes (Sunyaev)

![Figure_4][]

<!--
## Polyphen2

SVM's, Naive Bayes

![Figure_5][]

## Polyphen2

SVM's, Naive Bayes

![Figure_6][]
-->

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## ArrayCGH

Predict copy number

 * Fused Lasso (ESL)

![Figure_7][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Splicing Code

Predict splicing

 * SVM, Graphical Model, ...

![Figure_8][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Protein Structure

![Figure_12][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


# Machine Learning

### A Closer Look ...

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Machine Learning is ...
### Concerned with how to make a machines learn from data

 * Observe examples that represent incomplete information about some "statistical phenomenon"

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Learning Algorithms
### Generate rules for making predictions

 * INPUT: Training Data
 * OUTPUT: Classifier, Probabilistic Model, Clusters ...

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Learning Algorithms
### Two Types

 1. Unsupervised learning
 1. Supervised learning

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


## Unsupervised Learning
### Uncover hidden regularities or detect anomolies

 * Input training data $D$
 * Learn model $P(D)$

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


## Supervised Learning
### Learn function that predicts label $Y$ associated with each example $X$

 * Input training data $D$
 * Learn prediction function $Y = F_D(X)$

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


## Supervised Learning

### Binary $Y$ == "Classification" 
### Real-valued $Y$ == "Regression" 

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


## Learning Algorithms

### Many varieties
### Very accurate and efficient
### Easy to use
### Surpass human's ability to process large quantities of complex data

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->



# An Aside About Training Data ...

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Data Collection and Representation
### Input $X$

"Pattern", "Features", "Predictors"

 * Invariant to undetermined transformations
 * Sensitive to differences between examples

### Output $Y$

"Response", "Target", "Class / Categorical label"

 * Represents the **Truth**
 * Typically difficult and/or expensive to collect

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


## Training Data
### Inputs

 * $n$ examples
 * $m$ features
 * $n x m$ matrix

![Figure_18][]

### Outputs

 * $Y_1, \ldots, Y_n$

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


# Classification Algorithms

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## k - Nearest Neighbors
### Prediction is majority vote between the k closest training points

 * Distance measured in $m$ dimensional features space

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## k=15 - Nearest Neighbors

 * 2-dimensional features
 * Color indicates class
 * Line depicts decision boundary

![Figure_23][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## k=1 - Nearest Neighbors

 * Different solutions are possible with different $k$

![Figure_24][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Decision Trees

### Partition data into a tree

 * Prediction is a majority vote of training labels within a leaf node

![Figure_52][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Support Vector Machines

 * Separating hyperplane

![Figure_20][]

## Support Vector Machines

 * SVM's can find non-linear decision boundaries efficiently
 * A linear decision boundary in the high-dimensional transformed space corresponds to a non-linear boundary in the original space

![Figure_19][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## Support Vector Machines

 * Comparison of linear and non-linear classification performance

![Figure_42][] ![Figure_43][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

## More Classification Algorithms

### Linear Discriminant Analysis
### Boosting
### Neural Networks



<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

# Regression Algorithms
### Learning to predict real-valued outputs

 * Linear Regression
 * Logistic Regression
 * Regression Trees


![Figure_32][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

# Feature Selection & Dimensionality Reduction
### Techniques used before and/or during learning

Characterize inputs in low-dimensional space

 * False Discovery Rate
 * PCA
 * Multi Dimensional Scaling
 * Latent Factor Analysis

![Figure_3][]

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->


# Not Covered ...

### Learning theory
### Bias & variance (overfitting)
### Cross validation

<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->

# Fin.


<!-- <img src="spacer.gif" alt="Spacer" height="300"/> -->



<!--
## Theory
### Generalization

### Learnability

### Learning Rate

### Overfitting, Variance

### Cross Validation

### Bias - Variance Trade Off

### Specificity, Sensitivity Trade-off

-->




