# kMeans Portfolio Selection
---
A security screening technique with simple K-Means Clustering.  Ensure all variables inputted are scaled such that high values are preferential to low values.  Ex: P/B ratios should be B/P for a value stock screen.  Optimal K is determined through a simple heuristic rule and from an average number of asset constraint (See below).  Values in the X data set are automatically scaled to have 0 mean and 1 variance.

###Usage
---
Simply run the function __kPortfolio()__ in Matlab with your dataset.  The file _NCheck.m_ (along with __NCheck()__ function) is an accessory file in assisting to find optimal K

###Input
---
* __x__ - an N (assets) by M (variables) matrix
* __avgN__ - Required Average number of Assets per clustered portfolio.  This rule is used to screen out undiversified, concentrated portfolios. _Default: 25_
* __avgRange__ - Range that average number of assets may fall within ex: [avgN - 2, avgN + 2].  This input guarantees that the final portfolio will have atleast N=avgN-avgRange securities in the portfolio.  _Default: 2_

###Output
---
* __pIndex__ - Vector of Index of assets in the portfolio. ex: [1st security, 5th security ... ]
* __C__ - Re-scaled mean of the centroid
* __sse__ - Total Sum of Squares of cluster error

###Resources
---
[Using K-Means for Value Investors](http://kpei.me/blog/?p=350)  
[k-means clustering Matlab function](http://www.mathworks.com/help/stats/kmeans.html)   
[k-means clustering Wikipedia](http://en.wikipedia.org/wiki/K-means_clustering)
