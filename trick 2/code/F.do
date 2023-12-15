
twoway (function y = Fden(1,1,x), range(0 3) pstyle(p1) lwidth(medthick)) ///
       (function y = Fden(2,1,x), range(0 3) pstyle(p2)lwidth(medthick)) ///
	   (function y = Fden(5,2,x), range(0 3) pstyle(p3)lwidth(medthick)) ///
	   (function y = Fden(10,1,x), range(0 3) pstyle(p4) lwidth(medthick)) ///
	   (function y = Fden(100,100,x), range(0 3) pstyle(p5) lwidth(medthick)), ///
	   xline(8, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   ytitle(F(n{sub:1},n{sub:2}) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "(n{sub:1},n{sub:2})=(1,1)") label(2 "(n{sub:1},n{sub:2})=(2,1)") label(3 "(n{sub:1},n{sub:2})=(5,2)") label(4 "(n{sub:1},n{sub:2})=(10,1)") label(5 "(n{sub:1},n{sub:2})=(100,100)") ) 


graph export "..\figures\F_pdf.png",  replace
	   

twoway (function y = F(1,1,x), range(0 3) pstyle(p1) lwidth(medthick)) ///
       (function y = F(2,1,x), range(0 3) pstyle(p2)lwidth(medthick)) ///
	   (function y = F(5,2,x), range(0 3) pstyle(p3)lwidth(medthick)) ///
	   (function y = F(10,1,x), range(0 3) pstyle(p4) lwidth(medthick)) ///
	   (function y = F(100,100,x), range(0 3) pstyle(p5) lwidth(medthick)), ///
	   xline(8, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   ytitle(F(n{sub:1},n{sub:2}) cum. densities) ylabel(#6,grid) xtitle(x) legend(label(1 "(n{sub:1},n{sub:2})=(1,1)") label(2 "(n{sub:1},n{sub:2})=(2,1)") label(3 "(n{sub:1},n{sub:2})=(5,2)") label(4 "(n{sub:1},n{sub:2})=(10,1)") label(5 "(n{sub:1},n{sub:2})=(100,100)") ) 


graph export "..\figures\F_cdf.png",  replace

