
twoway (function y = poissonp(3,x), range(0 11) pstyle(p1)  lwidth(medthick)) , ///
	   xline(0, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black))  xtitle(x) ytitle("P{sub: {&lambda}=3}(x)={&lambda}{sup:x}/x! e{sup:{&lambda}}") xlabel(0(1)11)

graph export "..\figures\poisson_pdf.png",  replace
	   
