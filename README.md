# atrioventricular-sim
numerical modelling of the atrioventricular node of the heart.
The algorithm uses an attenuated exponential decay model for the depolarization of the 
cardiac action potential described by the coupled differential equations:
<p align="center">
  [Eq1]
</p>


[Eq1]:https://latex.codecogs.com/gif.latex?%5Cinline%20%5Cbegin%7Balign*%7D%20%26%5Cfrac%7Bdv%7D%7Bdt%7D%3D-%5Calpha%5Cleft%281-%5Cfrac%7Bw%7D%7Bw&plus;1%7D%5Cright%29v%5C%5C%20%26%5Cfrac%7Bdw%7D%7Bdt%7D%3D%5Cbeta%20v-%5Cgamma%20w%20%5Cend%7Balign*%7D "Logo Title Text 2"
