* Monte Carlo Simulation
clear all
set seed 0

 * Set the values of the parameters
 scalar p = 0.6

*foreach number in 3 {
foreach number in /**/3 5 10 25 100 200 500 {
postfile sim sum_hits sum_misses hit_hat using efcomp, replace
forvalues i = 1/1000 {
     quietly drop _all
     quietly set obs `number'
	
	local N = _N
	
	gen hit= rbinomial(1,p)

	gen miss = 1-hit 

	gen sum_hits= sum(hit)
	gen sum_misses= sum(miss)

	local sum_hits = sum_hits in `=_N'
	local sum_misses = sum_misses in `=_N'

	su hit
 	 local hit_hat =  r(mean)

   post sim (`sum_hits') (`sum_misses') (`hit_hat') 
 
}
postclose sim
use efcomp, clear 
summarize


*For a better idea about the distributions of these estimators, we graph the densities of their estimates.

use efcomp
local N = _N

di "`sum_hits'" "`sum_misses'"

collapse sum_hits sum_misses hit_hat

tw (function y = `sum_hits'*log(x) + `sum_misses'*log(1-x), range(0 1)) ///
   (function y = x^`sum_hits' * (1-x)^`sum_misses', range(0 1) yaxis(2)) ///
   (function y = `sum_hits'*log(`hit_hat') + `sum_misses'*log(1-`hit_hat'), range(`=`hit_hat'-.1' `=`hit_hat'+.1')), ///
   ytitle("Log-Likelihood", axis(1)) ytitle("Likelihood", axis(2)) xlabel(0(0.1)1,nogrid) ylabel(,nogrid) xtitle("Probability of Success") xline(`=scalar(p)', lpattern(dash)) ///
   legend(pos(6) cols(3) label(1 "Log-Likelihood") label(2 "Efficient Score") label(3 "Likelihood"))

graph export "../figures/ll_`number'.png", replace width(1280)


save ll_`number', replace
}

use ll_3, clear
gen batch = 3
foreach number in 5 10 25 100 200 500 {
append using ll_`number'
replace batch = `number' if batch ==.
}

set obs 101
gen x =.
local count2 0
foreach number in 3 5 10 25 100 200 500 {
gen l_`number' = .
gen ll_`number' = .

local ++count2
local count 0
forv x=0(0.01)1 {
	local ++count
	replace ll_`number' = sum_hits[`=`count2'']*log(`x') + sum_misses[`=`count2'']*log(1-`x') in `count'
	replace l_`number' = `x'^sum_hits[`=`count2''] * (1-`x')^sum_misses[`=`count2''] in `count'

	replace x = `x' in `count'
}
	egen max_l_`number' = max(l_`number')
	replace l_`number' = l_`number'/max_l_`number'
}



tw  (line ll_3 x, lcolor("26 133 255*.40") lp(shortdash)) ///
    (line ll_5 x, lcolor("26 133 255*.50") lp(shortdash_dot)) ///  
    (line ll_10 x, lcolor("26 133 255*.60") lp(dash_dot)) ///  
    (line ll_25 x, lcolor("26 133 255*.70") lp(dash)) ///
    (line ll_100 x, lcolor("26 133 255*.80") lp(longdash_dot)) ///
    (line ll_200 x, lcolor("26 133 255*.90")  lp(longdash)) ///
    (line ll_500 x, lcolor("26 133 255")) ///
	(line l_3 x, yaxis(2) lcolor("212 17 89*.4") lp(shortdash)) ///
	(line l_5 x, yaxis(2) lcolor("212 17 89*.5") lp(shortdash_dot)) ///
	(line l_10 x, yaxis(2) lcolor("212 17 89*.6") lp(dash_dot)) ///
	(line l_25 x, yaxis(2) lcolor("212 17 89*.7") lp(dash)) ///
	(line l_100 x, yaxis(2) lcolor("212 17 89*.8") lp(longdash_dot)) ///
	(line l_200 x, yaxis(2) lcolor("212 17 89*.9")  lp(longdash)) ///
	(line l_500 x, yaxis(2) lcolor("212 17 89")) ///
, legend(order(1 2 3 4 5 6 8 9 10 11 12) rows(2) pos(6) cols(4) ///
label(1 "LL 3") ///
label(2 "LL 5")  ///
label(3 "LL 10") ///
label(4 "LL 25") ///
label(5 "LL 100") ///
label(6 "LL 200")   ///
label(7 "LL 500")  ///
label(8 "L 3")   ///
label(9 "L 5")  ///
label(10 "L 10") ///
label(11 "L 25") ///
label(12 "L 100") ///
label(13 "L 200") ///
label(14 "L 500") ///
)  ytitle("Log-Likelihood", axis(1)) ytitle("Normalized Likelihood", axis(2)) xlabel(0(0.1)1,nogrid) ylabel(,nogrid) xtitle("Probability of Success") xline(`=scalar(p)', lpattern(dash))

graph export "../figures/ll_l.png", replace width(1280)

su ll_500

tw 	(area ll_3 x, color("26 133 255*.10")  base(`=r(min)') )   ///
    (area ll_5 x, color("26 133 255*.20")  base(`=r(min)') )   ///
    (area ll_10 x, color("26 133 255*.30")  base(`=r(min)') )  ///
    (area ll_25 x, color("26 133 255*.40")  base(`=r(min)') )  ///
	(area ll_100 x, color("26 133 255*.50")  base(`=r(min)') ) ///
    (area ll_200 x, color("26 133 255*.60")  base(`=r(min)') ) ///
    (area ll_500 x, color("26 133 255*.80")  base(`=r(min)') ) ///
	(scatteri 10 `=scalar(p)' `=r(min)' `=scalar(p)', recast(line)) ///
, legend(order(1 2 3 4 5 6 ) pos(6) rows(2) label(1 "LL 3")  ///
label(2 "LL 5")            ///
label(3 "LL 10")           ///
label(4 "LL 25")           ///
label(5 "LL 100")          ///
label(6 "LL 200")         ///
label(7 "LL 500")         ///
)  ytitle("Log-Likelihood", axis(1)) xlabel(0(0.1)1,nogrid) ylabel(,nogrid) xtitle("Probability of Success") plotregion(margin(0 0 0 0 0))

graph export "../figures/ll.png", replace width(1280)

su l_100

tw  (area  l_3 x, color("212 17 89*.4")   )  ///
    (area l_5 x, color("212 17 89*.5")   )  ///
    (area l_10 x, color("212 17 89*.6")  )  ///
    (area l_25 x, color("212 17 89*.7")  )  ///
	(area l_100 x, color("212 17 89*.8") )  ///
    (area l_200 x, color("212 17 89*.9") )  ///
    (area l_500 x, color("212 17 89")    )  ///
	///(function y = normalden(x,`=scalar(p)',`=scalar(p)*(1-scalar(p))/100'), range(0 1) pstyle(p2)  lwidth(medthick)) ///
	(scatteri `=r(max)' `=scalar(p)' `=r(min)' `=scalar(p)', recast(line)) ///
, legend(order(1 2 3 4 5 ) pos(6) rows(1) label(1 "L 3")  ///
label(2 "L 5")            ///
label(3 "L 10")           ///
label(4 "L 25")           ///
label(5 "L 100")          ///
label(6 "L 200")         ///
label(7 "L 500")         ///
)  ytitle("Normalized Likelihood", axis(1)) xlabel(0(0.1)1,nogrid) ylabel(,nogrid) xtitle("Probability of Success") plotregion(margin(0 0 0 0 0))

graph export "../figures/l.png", replace width(1280)

