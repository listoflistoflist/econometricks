
twoway (function y = chi2den(1,x), range(0.5 15) pstyle(p1) lwidth(medthick)) ///
       (function y = chi2den(2,x), range(0.5 15) pstyle(p2)lwidth(medthick)) ///
	   (function y = chi2den(3,x), range(0 15) pstyle(p3)lwidth(medthick)) ///
	   (function y = chi2den(4,x), range(0 15) pstyle(p4) lwidth(medthick)) ///
	   (function y = chi2den(6,x), range(0 15) pstyle(p5) lwidth(medthick)) ///
	   (function y = chi2den(9,x), range(0 15) pstyle(p6) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle({&chi}{sup:2}(n) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "n=1") label(2 "n=2") label(3 "n=3") label(4 "n=4") label(5 "n=6") label(6 "n=9")) 


graph export "..\figures\chi2_pdf.png",  replace
	   

twoway (function y = chi2(1,x), range(0 15) pstyle(p1) lwidth(medthick)) ///
       (function y = chi2(2,x), range(0 15) pstyle(p2)lwidth(medthick)) ///
	   (function y = chi2(3,x), range(0 15) pstyle(p3)lwidth(medthick)) ///
	   (function y = chi2(4,x), range(0 15) pstyle(p4) lwidth(medthick)) ///
	   (function y = chi2(6,x), range(0 15) pstyle(p5) lwidth(medthick)) ///
	   (function y = chi2(9,x), range(0 15) pstyle(p6) lwidth(medthick)), ///
	   yline(0, lpattern(dot) lc(black)) ///
	   ytitle({&chi}{sup:2}(n) cum. densities) ylabel(#6,grid) xtitle(x) legend(label(1 "n=1") label(2 "n=2") label(3 "n=3") label(4 "n=4") label(5 "n=6") label(6 "n=9")) 


graph export "..\figures\chi2_cdf.png",  replace

