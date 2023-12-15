
twoway (function y = 1/x*normalden(ln(x),0,.25), range(0 2.5) pstyle(p1) lwidth(medthick)) ///
       (function y = 1/x*normalden(ln(x),0,0.5), range(0 2.5) pstyle(p2) lwidth(medthick)) ///
	   (function y = 1/x*normalden(ln(x),0,1), range(0 2.5) pstyle(p3) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle(Lognormal({&mu},{&sigma}{sup:2}) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "({&mu},{&sigma}{sup:2})=0,0.25") label(2 "({&mu},{&sigma}{sup:2})=0,0.5") label(3 "({&mu},{&sigma}{sup:2})=0,1") pos(6)) 


graph export "..\figures\lnnormal_pdf.png",  replace
	   


twoway (function y = normal((ln(x)-0)/.25), range(0 3) pstyle(p1) lwidth(medthick)) ///
       (function y = normal((ln(x)-0)/.5), range(0 3) pstyle(p2) lwidth(medthick)) ///
	   (function y = normal((ln(x)-0)/1), range(0 3) pstyle(p3) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle(Lognormal({&mu},{&sigma}{sup:2}) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "({&mu},{&sigma}{sup:2})=0,0.25") label(2 "({&mu},{&sigma}{sup:2})=0,0.5") label(3 "({&mu},{&sigma}{sup:2})=0,1") pos(6)) 

graph export "..\figures\lnnormal_cdf.png",  replace

