# Variance Reduction for SMC

This MATLAB code implements the Variance Reduction for Sequential Monte Carlo, which is built in two different dynamical models: a linear Gaussian state-space (LGSS) model and a stochastic volatility (SV) model. The details of our proposal is described in the paper available at https://openreview.net/pdf?id=3XinbUbSzPq

Note that the MATLAB code in this folder covers the basic implementations in the paper. The notation of the variables has been changed sligthly compared with the tutorial paper to improve readability of the code. However, it should be easy to translate between the two. 

Requirements
--------------
The code is written and tested for MATLAB 2015b and makes use of the statistics toolbox and the Quandl package. See https://github.com/quandl/Matlab for more installation and to download the toolbox. Note that urlread2 is required by the Quandl toolbox and should be installed as detailed in the README file of the Quandl toolbox.

Main script files
--------------
These are the main script files that implement the various algorithms discussed in the tutorial.

**example1_lgss.m** State estimation in a LGSS model using the KM and a fully-adapted PF (faPF). The code is discussed in Section 3.1 and the results are presented in Section 3.2 as Figure 4 and Table 1.

**example2_sv.m** Parameter estimation of three parameters in the SV model using PMH with the bootstrap PF as the likelihood estimator. The code is discussed in Section 5.1 and the results are presented in Section 5.2 as Figure 6. The code takes about an hour to run.

Supporting files
--------------
**generateData.m** Implements data generation for the LGSS model.
**kalmanFilter.m** Implements the Kalman filter for the LGSS model.
**particleFilter.m** Implements the faPF for the LGSS model.
**particleFilterSVmodel.m** Implements the bPF for the SV model.
**particleMetropolisHastings.m** Implements the PMH algorithm for the LGSS model.
**particleMetropolisHastingsSVmodel.m** Implements the PMH algorithm for the SV model.

Adapting the code for another model
--------------
Direct revise the resample schema and then load into the main test script files.

Reference
--------------
Xiongming Dai & Gerald Baumgartner "Variance Reduction for Sequential Monte Carlo",https://openreview.net/pdf?id=3XinbUbSzPq



Copyright information
--------------
Mit license 
```
