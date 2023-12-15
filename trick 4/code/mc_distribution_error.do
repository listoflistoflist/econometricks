* Monte Carlo Simulation
clear all
set seed 0

 * Set the values of the parameters
 scalar constant = 2
 scalar slope = .5
 scalar sigma = 1

*foreach number in 3 {
foreach number in 3 5 10 25 100 1000 {
postfile sim y_hat beta1 se1 using efcomp, replace
forvalues i = 1/1000 {
     quietly drop _all
     quietly set obs `number'
	 gen x = int(runiform(1,20))
 
     quietly generate double y = constant + slope * x + rnormal(0,sigma)
	 
	 su y
	 local y_hat =  r(mean)

 
 
     quietly reg y x
             local beta1 = _b[x]
             local se1 = _se[x]
 
   post sim (`y_hat') (`beta1') (`se1')
 
}
postclose sim
use efcomp, clear 
summarize


*For a better idea about the distributions of these estimators, we graph the densities of their estimates.

use efcomp
local N = _N

gen sampling_error = (slope-beta1)/se



quietly summarize beta1
local var1mean: display %6.2f r(mean)
local var1sd: display %6.2f r(sd)
local var1min: display %6.2f 0
local var1max: display %6.2f 1


tw (histogram beta1 if beta1>=0 & beta1<=1, color("64 105 166%40") width(0.02) ) ///
  (function y=normalden(x, `var1mean', `var1sd') , range(`var1min' `var1max') lcolor(navy)) ///
  ,  ytitle("Density", margin(medium)) xtitle("{&beta}{subscript:1}", margin(medium)) legend(off) ///
  title("", margin(medium))  xlabel(0(0.2)1)  plotregion(margin(0 0 0 5)) graphregion(margin(0 10 0 10))

graph export "..\figures\distribution_beta1_`number'.png", replace width(1280)




local var1mean: display %6.2f 0
local var1sd: display %6.2f sigma
local var1min: display %6.2f -4
local var1max: display %6.2f 4



tw (histogram sampling_error if sampling_error>=-4 & sampling_error<=4, color("64 105 166%40") width(0.25)) ///
  (function y=normalden(x, `var1mean', `var1sd') , range(`var1min' `var1max') lcolor(navy%`=min(`number'0,100)')) ///
  (function y=tden(`=`number'-2', x) , range(`var1min' `var1max') lcolor(navy%`=100-min(`number'0,100)')) ///
  ,  ytitle("Density", margin(medium)) xtitle("Standardized Slope Coefficient", margin(medium)) legend(off) ///
  title("", margin(medium))  xlabel(-4(1)4)  plotregion(margin(0 0 0 5)) graphregion(margin(0 10 0 10))

graph export "..\figures\sampling_error_beta1_`number'.png", replace width(1280)


}

