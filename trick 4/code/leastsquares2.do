version 16.1
clear
set obs 9
set seed 25

local xrange range(-2 15)
local yrange range(2.6512 13.5)
local xlabel xlabel(0(5)15)
local ylabel ylabel(4(2)12)


gen x1 = runiform(0, 13)


scalar beta0=4
scalar beta1=2/3

gen y1 = beta0 + beta1 * x1 + rnormal(0,4)
gen e_y1 = beta0 + beta1 * x1 

reg y1 x1
scalar b0=_b[_cons]
scalar b1=_b[x1]
predict y, xb

predict res, res
gen x = x1 + abs(res)


su x1
scalar minx1 = r(min)
scalar maxx1 = r(max)
su x
scalar minx = r(min)
scalar maxx = r(max)
scalar minxx = min(minx1, minx)
scalar maxxx = max(maxx1, maxx)

su y1

local xrange  range(`=minxx-2' `=maxxx')
local yrange  range(`=r(min)-2' `=r(max)+2')
local xlabel 
local ylabel 


tw (scatter y1 x1, mlc(black) mfc(black) msize(medlarge)), `xlabel' `ylabel' xscale(`xrange') yscale(`yrange') ytitle(y, margin(medium)) xtitle(x, margin(medium)) legend(off) plotregion(margin(0 0 0 0)) graphregion(margin(0 10 0 10)) 

graph export "..\figures\OLS1.png", replace width(1280)




local arrows
forv i=1/`=_N' {
local arrows `arrows' (pcarrowi `=y1[`i']' `=x1[`i']' `=y[`i']' `=x1[`i']' , mlabcolor(red%70) lcolor(red%70) mc(red%70)) 
}

tw (scatter y1 x1, mlc(black) mfc(black) msize(medlarge)) `arrows' , `xlabel' `ylabel' xscale(`xrange') yscale(`yrange') ytitle(y, margin(medium)) xtitle(x, margin(medium)) legend(off)  plotregion(margin(0 0 0 0)) graphregion(margin(0 10 0 10)) 

graph export "..\figures\OLS2.png", replace width(1280)

tw (scatter y1 x1, mlc(black) mfc(black) msize(medlarge)) `arrows'  ///
 (function y = b0 + b1 * x, `xrange' lcolor(black) lwidth(medthick)) ///
 , `xlabel' `ylabel' xscale(`xrange') yscale(`yrange') ytitle(y, margin(medium)) xtitle(x, margin(medium)) legend(off)  plotregion(margin(0 0 0 0)) graphregion(margin(0 10 0 10)) 


graph export "..\figures\OLS3.png", replace width(1280)



local squares
forv i=1/`=_N' {
local squares `squares' (scatteri `=y1[`i']' `=x1[`i']' `=y[`i']' `=x1[`i']' `=y[`i']' `=x[`i']' `=y1[`i']' `=x[`i']', recast(area) nodropbase color(red%60) lwidth(0) lcolor(red%50)) 
}

tw  `squares' (scatter y1 x1, mlc(black) mfc(black) msize(medlarge)) (function y = b0 + b1 * x, `xrange' lcolor(black) lwidth(medthick)) ///
, `xlabel' `ylabel' xscale(`xrange') yscale(`yrange') ytitle(y, margin(medium)) xtitle(x, margin(medium)) legend(off)  plotregion(margin(0 0 0 0)) graphregion(margin(0 10 0 10)) 


graph export "..\figures\OLS4.png", replace width(1280)


tw  `squares' (scatter y1 x1, mlc(black) mfc(black) msize(medlarge)) (function y = b0 + b1 * x, `xrange' lcolor(black) lwidth(medthick)) (function y = beta0 + beta1 * x, `xrange' lpattern(dash) lcolor(black) lwidth(medthick)) ///
, `xlabel' `ylabel' xscale(`xrange') yscale(`yrange') ytitle(y, margin(medium)) xtitle(x, margin(medium)) legend(off)  plotregion(margin(0 0 0 0)) graphregion(margin(0 10 0 10)) 


graph export "..\figures\OLS5.png", replace width(1280)

