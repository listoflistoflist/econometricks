clear
set seed 0
*set trace on
set more off
set obs 100

gen epsilon = rnormal(0,10)

gen x_star = 2+int((50-2+1)*runiform())

gen y_star =  -3 + 0.5*x_star+epsilon

gen Ey_star = -3 + 0.5*x_star

gen y = .
replace y = y_star if y_star > 15

gen x = .
replace x = x_star if y_star > 15

twoway (histogram y_star, fcolor(none) lcolor(black) width(2) discrete) ///
       (histogram y, color(orange_red%50) width(2) discrete )  ///
				,  legend(order(1 "Latent Distribution" 2 "Truncated Distribution" ))  xtitle("y*, y") legend(cols(1)) name(panela, replace) nodraw
twoway (histogram x_star, fcolor(none) lcolor(black) width(2) discrete ) ///
       (histogram x, fcolor(orange_red%50) lcolor(red%50) width(2) discrete )  ///
				,  legend(order(1 "Latent Distribution" 2 "Truncated Distribution" ))  xtitle("x*, x") legend(cols(1)) name(panelb, replace) nodraw

				
graph combine panela panelb, cols(2)

graph export "..\figures\Trunc1.png", replace width(1280)

reg y x
predict y_ols

truncreg y x, ll(15)
predict Ey, ystar(15,.)
predict y_truncated, xb

twoway (scatter y_star x_star, sort(x_star) mcolor(gs11) m(Oh)) ///
       (scatter y x, sort(x) mcolor(red) m(O)) ///
	   (line Ey_star x, sort(x) lpattern(solid) lcolor(blue)) ///
	   (line Ey x, sort(x) lpattern(-.) lcolor(black)) ///
	   (line y_ols x, sort(x) lpattern(--) lcolor(green)) ///
	   (line y_truncated x, sort(x) lpattern(dash) lcolor(red)), ///
	   ylabel(#6,grid labsize(vlarge)) xlabel(#8,grid labsize(vlarge)) ///
	   ytitle(,size(vlarge)) xtitle(,size(vlarge)) xline(0, lpattern(dash) lc(black)) yline(15, lpattern(dash) lc(black)) yline(0, lpattern(dash) lc(black)) ytitle("y*, y")  ///
	   ylabel(#6,grid) xtitle("x*, x") legend(pos(5) ring(0) col(1) lab(1 "Latent") lab(2 "Observed") lab(3 "E(y*)") lab(4 "E(y)") lab(5 "OLS") lab(6 "Truncated Regression"))

	   

graph export "..\figures\Trunc2.eps", as(eps) preview(on) replace
