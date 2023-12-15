twoway (function y = normal(x), range(-5 5) pstyle(p1) lwidth(medthick)) ///
(function y = logistic(0.61,x), range(-5 5) pstyle(p2) lwidth(medthick)) ///
       (function y = logistic(x), range(-5 5) pstyle(p3) lwidth(medthick)), ///
	   xlabel(#8,grid ) ///
	   ytitle(,) xtitle(,) ///
	   xline(0, lpattern(dash) lc(black)) yline(0, lpattern(dash) lc(black)) ///
	   ytitle("{&Lambda}(m,s)=exp(-(x-m)/s)/(s[1+exp(-(x-m)/s)]{sup:2}""with sd=s{&pi}/{&sqrt}3") ylabel(#6,grid) xtitle(x) ///
	   legend(pos(10) ring(0) col(1) lab(1 "Standard Normal") lab(2 "Logistic (m=0, s=1))") lab(3 "Rescaled Logit (m=0,s=0.61)"))

graph export "..\figures\normal_logistic_cdf.png",  replace
