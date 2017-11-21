# RF and FFT on Studying re-opened bugs in open source software
Bug fixing accounts for a large amount of the software maintenance resources. Generally, bugs are reported, fixed, verified and closed. However, in some cases bugs have to be re-opened. Re-opened bugs increase maintenance costs, degrade the overall user-perceived quality of the software and lead to unnecessary rework by busy practitioners. The existing paper is a study on the prediction of re-opened bugs through a case study on three large open source project-Eclipse.
We will discuss and compare three machine learning algorithms - FFT, Decision Tree and Random Forest.

## Results

![merge_from_ofoct](https://user-images.githubusercontent.com/17531907/33055625-b3390aee-ce4e-11e7-9ec2-cb3ebdf7322f.png)

## Detailed log info

#### FFT Log:

```
FFT #1 predicts reopened using 3 cues: {product,severity,op_sys}

[1] If product = {others,JDT,PDE}, predict Opened.
[2] If severity != {enhancement,major,minor,critical,blocker,trivial}, predict Not Opened.
[3] If op_sys != {Linux,Linux-GTK,MacOS X,Windows All,Windows 7,Solaris-GTK,Other,Solaris,Windows Server 2003,Mac OS X,Unix All,AIX Motif}, predict Not Opened, otherwise, predict Opened.

                     train    test
cases       :n    33109.00 8278.00
speed       :mcu      1.78    1.79
frugality   :pci      0.70    0.70
accuracy    :acc      0.61    0.62
weighted    :wacc     0.64    0.65
sensitivity :sens     0.69    0.69
specificity :spec     0.60    0.61

pars: algorithm = 'ifan', goal = 'wacc', goal.chase = 'bacc', sens.w = 0.5, max.levels = 4
```

#### DT:
```
n= 99329 

node), split, n, loss, yval, (yprob)
      * denotes terminal node

1) root 99329 7178 0 (0.92773510 0.07226490)  
  2) product=CDT,JDT,PDE,Platform 98017 5866 0 (0.94015324 0.05984676) *
  3) product=others 1312    0 1 (0.00000000 1.00000000) *
```

#### RF:
```
Call:
 randomForest(formula = f, data = trainData, importance = FALSE,      proximity = FALSE) 
               Type of random forest: classification
                     Number of trees: 500
No. of variables tried at each split: 2

        OOB estimate of  error rate: 5.93%
Confusion matrix:
      0   1 class.error
0 30726   0   0.0000000
1  1962 422   0.8229866
```

