
twoway (function y = 1/x^2, range(1 10) pstyle(p1) lwidth(medthick)) ///
	   (function y = 1-(2*normal(x)-1), range(1 10) pstyle(p5) lpattern(dash) lwidth(medthick)), ///
	   yline(0.05, lpattern(dot) lc(black)) ///
	   xline(1.959963984540, lpattern(dot) lc(black))  ///
	   xline(4.47214, lpattern(dot) lc(black))  ///
   	   text(1 2 "1.96", place(e)) ///
   	   text(1 4.50 "4.47", place(e)) ///
   	   text(0.08 0.10 "0.05", place(e)) ///
	   ytitle("Share of values drawn outside k" "standard deviations away from the mean") ylabel(#6,grid) xtitle(k) legend(label(1 "Chebyshev inequality: any distribution") label(2 "Normal distribution") pos(6)) 


graph export "..\figures\chebyshev_inequality_pdf.png",  replace
	   