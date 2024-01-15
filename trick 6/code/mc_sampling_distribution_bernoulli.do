* Monte Carlo Simulation
clear all
set seed 0

 * Set the values of the parameters
 scalar p = 0.6

*foreach number in 3 {
foreach number in 3 5 10 25 100 1000 {
postfile sim y_hat  using efcomp, replace
forvalues i = 1/1000 {
     quietly drop _all
     quietly set obs `number'
 
     quietly generate double y = rbinomial(1,p)
	 
	 su y
	 local y_hat =  r(mean)

 
 
   post sim (`y_hat') 
 
}
postclose sim
use efcomp, clear 
summarize


*For a better idea about the distributions of these estimators, we graph the densities of their estimates.

use efcomp
local N = _N



quietly summarize y_hat
local var1mean: display %6.2f r(mean)
local var1sd: display %6.2f r(sd)
local var1min: display %6.2f 0
local var1max: display %6.2f 1


tw (histogram y_hat if y_hat>=0 & y_hat<=1, color("64 105 166%40") width(0.02) ) ///
  (function y=normalden(x, `var1mean', `var1sd') , range(`var1min' `var1max') lcolor(navy)) ///
  ,  ytitle("Density", margin(medium)) xtitle("p", margin(medium)) legend(off) ///
  title("", margin(medium))  xlabel(0(0.2)1)  plotregion(margin(0 0 0 5)) graphregion(margin(0 10 0 10))

graph export "../figures/distribution_p_`number'.png", replace width(1280)


}

