
twoway (function y = tden(1,x), range(-5 5) pstyle(p1) lwidth(medthick)) ///
       (function y = tden(2,x), range(-5 5) pstyle(p2)lwidth(medthick)) ///
	   (function y = tden(5,x), range(-5 5) pstyle(p3)lwidth(medthick)) ///
	   (function y = tden(30,x), range(-5 5) pstyle(p6)lwidth(medthick)) ///
	   (function y = tden(9999,x), range(-5 5) pstyle(p4)lwidth(medthick)) ///
	   (function y = normalden(x), range(-5 5) pstyle(p5) lpattern(dash) lwidth(medthick)), ///
	   yline(0, lpattern(dot) lc(black)) ///
	   ytitle(student-t(n) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "n=1") label(2 "n=2") label(3 "n=5") label(4 "n=30") label(5 "n={&infin}") label(6 "standard normal") pos(6) row(2)) 


graph export "..\figures\t_pdf.png",  replace
	   


twoway (function y = t(1,x), range(-5 5) pstyle(p1) lwidth(medthick)) ///
       (function y = t(2,x), range(-5 5) pstyle(p2)lwidth(medthick)) ///
	   (function y = t(5,x), range(-5 5) pstyle(p3)lwidth(medthick)) ///
	   (function y = t(30,x), range(-5 5) pstyle(p6)lwidth(medthick)) ///
	   (function y = t(9999,x), range(-5 5) pstyle(p4)lwidth(medthick)) ///
	   (function y = normal(x), range(-5 5) pstyle(p5) lpattern(dash) lwidth(medthick)), ///
	   yline(0, lpattern(dot) lc(black)) ///
	   ytitle(student-t(n) cum. densities) ylabel(#6,grid) xtitle(x) legend(label(1 "n=1") label(2 "n=2") label(3 "n=5") label(4 "n=30") label(5 "n={&infin}") label(6 "standard normal") pos(6) row(2)) 



graph export "..\figures\t_cdf.png",  replace

