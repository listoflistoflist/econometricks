
local degrees 30

twoway (function y = chi2(`degrees',x), range(0 80) pstyle(p1) lwidth(medthick)) ///
       (function y = normal((2*x)^(1/2)-(2*`degrees'-1)^(1/2)), range(0 80) pstyle(p2)lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle({&chi}{sup:2}(n) approx. density) ylabel(#6,grid) xtitle(x) legend(label(1 "{&chi}{sup:2}[`degrees']") label(2 "{&Phi}[(2*x){sup:1/2}-(2*`degrees'-1){sup:1/2}]") pos(6)) 


graph export "..\figures\chi2_cdf_approx.png",  replace
	   
