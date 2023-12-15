
twoway (function y = betaden(0.5,0.5,x), range(0.01 0.99) pstyle(p1) lwidth(medthick)) ///
       (function y = betaden(5,1,x), range(0 0.9) pstyle(p2)lwidth(medthick)) ///
	   (function y = betaden(1,3,x), range(0 1) pstyle(p3)lwidth(medthick)) ///
	   (function y = betaden(2,2,x), range(0 1) pstyle(p4) lwidth(medthick)) ///
	   (function y = betaden(2,5,x), range(0 1) pstyle(p6) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle(B({&alpha},{&beta}) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "({&alpha},{&beta})=0.5,0.5") label(2 "({&alpha},{&beta})=5,1") label(3 "({&alpha},{&beta})=1,3") label(4 "({&alpha},{&beta})=2,2") label(5 "({&alpha},{&beta})=2,5") ) 


graph export "..\figures\beta_pdf.png",  replace
	   

twoway (function y = ibeta(0.5,0.5,x), range(0 1) pstyle(p1) lwidth(medthick)) ///
       (function y = ibeta(5,1,x), range(0 1) pstyle(p2)lwidth(medthick)) ///
	   (function y = ibeta(1,3,x), range(0 1) pstyle(p3)lwidth(medthick)) ///
	   (function y = ibeta(2,2,x), range(0 1) pstyle(p4) lwidth(medthick)) ///
	   (function y = ibeta(2,5,x), range(0 1) pstyle(p6) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle(B({&alpha},{&beta}) cum. densities) ylabel(#6,grid) xtitle(x) legend(label(1 "({&alpha},{&beta})=0.5,0.5") label(2 "({&alpha},{&beta})=5,1") label(3 "({&alpha},{&beta})=1,3") label(4 "({&alpha},{&beta})=2,2") label(5 "({&alpha},{&beta})=2,5") ) 


graph export "..\figures\beta_cdf.png",  replace

