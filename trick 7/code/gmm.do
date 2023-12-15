*This post was written jointly with Enrique Pinzon, Senior Econometrician, StataCorp. https://blog.stata.com/2015/12/03/understanding-the-generalized-method-of-moments-gmm-a-simple-example/

*The generalized method of moments (GMM) is a method for constructing estimators, analogous to maximum likelihood (ML). GMM uses assumptions about specific moments of the random variables instead of assumptions about the entire distribution, which makes GMM more robust than ML, at the cost of some efficiency. The assumptions are called moment conditions.

*GMM generalizes the method of moments (MM) by allowing the number of moment conditions to be greater than the number of parameters. Using these extra moment conditions makes GMM more efficient than MM. When there are more moment conditions than parameters, the estimator is said to be overidentified. GMM can efficiently combine the moment conditions when the estimator is overidentified.

*We illustrate these points by estimating the mean of a χ2(1)=1 by MM, ML, a simple GMM estimator, and an efficient GMM estimator. This example builds on efficiency comparisons by Monte Carlo simulation and is similar in spirit to the example in Wooldridge (2001).

*GMM weights and efficiency

*GMM builds on the ideas of expected values and sample averages. Moment conditions are expected values that specify the model parameters in terms of the true moments. The sample moment conditions are the sample equivalents to the moment conditions. GMM finds the parameter values that are closest to satisfying the sample moment conditions.

*The mean of a χ2 random variable with d degree of freedom is d, and its variance is 2d. Two moment conditions for the mean are thus

*E[Y–d]=0
*E[(Y–d)^2–2d]==0

*The sample moment equivalents are

*1/N∑(y_i–d_hat)=0              (1)
*1/N∑[(y_i–d_hat)^2–2d_hat]=0   (2)

*We could use either sample moment condition (1) or sample moment condition (2) to estimate d. In fact, below we use each one and show that (1) provides a much more efficient estimator.

*When we use both (1) and (2), there are two sample moment conditions and only one parameter, so we cannot solve this system of equations. GMM finds the parameters that get as close as possible to solving weighted sample moment conditions.

*Uniform weights and optimal weights are two ways of weighting the sample moment conditions.
* - The uniform weights use an identity matrix to weight the moment conditions.
* - The optimal weights use the inverse of the covariance matrix of the moment conditions.

*We begin by drawing a sample of a size 500 and use gmm to estimate the parameters using sample moment condition (1), which we illustrate is the sample moment as the sample average.

drop _all
set obs 500
set seed 12345

generate double y = rchi2(1)

gmm (y - {d})  , instruments( ) onestep

mean y

*The sample moment condition is the product of an observation-level error function that is specified inside the parentheses and an instrument, which is a vector of ones in this case. The parameter d is enclosed in curly braces {}. We specify the onestep option because the number of parameters is the same as the number of moment conditions, which is to say that the estimator is exactly identified. When it is, each sample moment condition can be solved exactly, and there are no efficiency gains in optimally weighting the moment conditions.

*We now illustrate that we could use the sample moment condition obtained from the variance to estimate d.

gmm ((y-{d})^2 - 2*{d})  , instruments( ) onestep

*While we cannot say anything definitive from only one draw, we note that this estimate is further from the truth and that the standard error is much larger than those based on the sample average.

*Now, we use gmm to estimate the parameters using uniform weights.

matrix I = I(2)

gmm (y - {d})            ///
    ((y-{d})^2 - 2*{d})  ///
	, instruments( ) winitial(I) onestep

*The first set of parentheses specifies the first sample moment condition, and the second set of parentheses specifies the second sample moment condition. The options winitial(I) and onestep specify uniform weights.

*Finally, we use gmm to estimate the parameters using two-step optimal weights. The weights are calculated using first-step consistent estimates.

gmm (y - {d})            ///
    ((y-{d})^2 - 2*{d})  ///
	, instruments( ) winitial(I)


*The GMM estimator that places equal weights on the efficient and the inefficient estimator is much less efficient than a GMM estimator that places much less weight on the less efficient moment conditions.

*We display the weight matrix from our optimal GMM estimator to see how the sample moments were weighted.

matlist e(W), border(rows)

*The diagonal elements show that the sample-mean moment condition receives more weight than the less efficient sample-variance moment condition.


	
*All four estimators are consistent. Below we run a Monte Carlo simulation to see their relative efficiencies. We are most interested in the efficiency gains afforded by optimal GMM. We include the sample average, the sample variance, and the ML estimator discussed in Efficiency comparisons by Monte Carlo simulation. Theory tells us that the optimally weighted GMM estimator should be more efficient than the sample average but less efficient than the ML estimator.

clear all
set seed 12345
matrix I = I(2)
postfile sim  d_a d_v d_ml d_gmm d_gmme using efcomp, replace
forvalues i = 1/100 {
     quietly drop _all
     quietly set obs 500
     quietly generate double y = rchi2(1)
 
     quietly mean y 
     local d_a         =  _b[y]
 
     quietly gmm ((y-{d=`d_a'})^2 - 2*{d}) , instruments( )  ///
       winitial(unadjusted) onestep conv_maxiter(200) 
     if e(converged)==1 {
             local d_v = _b[d:_cons]
     }
     else {
             local d_v = .
     }
 
    quietly mlexp (ln(chi2den({d=`d_a'},y)))
     if e(converged)==1 {
             local d_ml  =  _b[d:_cons]
     }
     else {
             local d_ml  = .
     }
 
    quietly gmm (y - {d=`d_a'}) ((y-{d})^2 - 2*{d}) , instruments( )  ///
        winitial(I) onestep conv_maxiter(200) 
     if e(converged)==1 {
             local d_gmm = _b[d:_cons]
     }
     else {
             local d_gmm = .
     }
 
   quietly gmm (y - {d=`d_a'}) ((y-{d})^2 - 2*{d}) , instruments( )  ///
       winitial(unadjusted, independent) conv_maxiter(200) 
     if e(converged)==1 {
             local d_gmme = _b[d:_cons]
     }
     else {
             local d_gmme = .
     }
 
   post sim (`d_a') (`d_v') (`d_ml') (`d_gmm') (`d_gmme') 
 
}
postclose sim
use efcomp, clear 
summarize


*The simulation results indicate that the ML estimator is the most efficient (d_ml, std. dev. 0.0395), followed by the efficient GMM estimator (d_gmme}, std. dev. 0.0541), followed by the sample average (d_a, std. dev. 0.0625), followed by the uniformly-weighted GMM estimator (d_gmm, std. dev. 0.1415), and finally followed by the sample-variance moment condition (d_v, std. dev. 0.1732).

*The estimator based on the sample-variance moment condition does not converge for 4 of 2,000 draws; this is why there are only 1,996 observations on d_v when there are 2,000 observations for the other estimators. These convergence failures occurred even though we used the sample average as the starting value of the nonlinear solver.


*For a better idea about the distributions of these estimators, we graph the densities of their estimates.

use efcomp
local N = _N
kdensity d_a,     n(`N') generate(x_a    den_a)    nograph
kdensity d_v,     n(`N') generate(x_v    den_v)    nograph
kdensity d_ml,    n(`N') generate(x_ml   den_ml)   nograph
kdensity d_gmm,   n(`N') generate(x_gmm  den_gmm)  nograph
kdensity d_gmme,  n(`N') generate(x_gmme den_gmme) nograph


replace x_a = x_a-1
replace x_v = x_v-1
replace x_gmm = x_gmm-1
replace x_gmme = x_gmme-1
twoway (line den_a x_a,       lpattern(solid))        ///
       (line den_v x_v,       lpattern(dash))         ///
       (line den_gmm x_gmm,   lpattern(dash_dot))     ///
       (line den_gmme x_gmme, lpattern(shortdash)), xline(0, lpattern(solid) lcolor(gs12)) legend(label(1 "First moment") label(2 "Second moment") label(3 "Minimum Distance") label(4 "Efficient GMM"))

graph export "..\figures\efficiency.png",  replace
	   
tw (function y=3*(x-0.5)^2, range(0 1)) ///
(function y=(x-0.5)^2, range(0 1)) ,  legend(label(1 "Large {&Gamma}") label(2 "Small {&Gamma}")) ytitle(q{subscript:n}({&theta})) xtitle({&theta})  xline(0.5, lpattern(solid) lcolor(gs12))

graph export "..\figures\gamma.png",  replace

*The density plots illustrate the efficiency ranking that we found from the standard deviations of the estimates.

*The uniformly weighted GMM estimator is less efficient than the sample average because it places the same weight on the sample average as on the much less efficient estimator based on the sample variance.

*In each of the overidentified cases, the GMM estimator uses a weighted average of two sample moment conditions to estimate the mean. The first sample moment condition is the sample average. The second moment condition is the sample variance. As the Monte Carlo results showed, the sample variance provides a much less efficient estimator for the mean than the sample average.

