
twoway (function y = gammaden(1,2,0,x), range(0.3 20) pstyle(p1) lwidth(medthick)) ///
       (function y = gammaden(2,2,0,x), range(0 20) pstyle(p2)lwidth(medthick)) ///
	   (function y = gammaden(3,2,0,x), range(0 20) pstyle(p3)lwidth(medthick)) ///
	   (function y = gammaden(5,1,0,x), range(0 20) pstyle(p4) lwidth(medthick)) ///
	   (function y = gammaden(9,0.5,0,x), range(0 20) pstyle(p5) lwidth(medthick)) ///
	   (function y = gammaden(7.5,1,0,x), range(0 20) pstyle(p6) lwidth(medthick)) ///
	   (function y = gammaden(0.5,1,0,x), range(0.5 20) pstyle(p7) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle({&Gamma}(k,{&theta},m=0) densities) ylabel(#6,grid) xtitle(x) legend(label(1 "(k,{&theta})=1,2") label(2 "(k,{&theta})=2,2") label(3 "(k,{&theta})=3,2") label(4 "(k,{&theta})=5,1") label(5 "(k,{&theta})=9,5") label(6 "(k,{&theta})=7.5,1") label(7 "(k,{&theta})=0.5,1")) 


graph export "..\figures\gamma_pdf.png",  replace
	   

twoway (function y = gammap(1,x/2), range(0 20) pstyle(p1) lwidth(medthick)) ///
       (function y = gammap(2,x/2), range(0 20) pstyle(p2)lwidth(medthick)) ///
	   (function y = gammap(3,x/2), range(0 20) pstyle(p3)lwidth(medthick)) ///
	   (function y = gammap(5,x), range(0 20) pstyle(p4) lwidth(medthick)) ///
	   (function y = gammap(9,2*x), range(0 20) pstyle(p5) lwidth(medthick)) ///
	   (function y = gammap(7.5,x), range(0 20) pstyle(p6) lwidth(medthick)) ///
	   (function y = gammap(0.5,x), range(0 20) pstyle(p7) lwidth(medthick)), ///
	    yline(0, lpattern(dot) lc(black)) ///
	   ytitle({&Gamma}(k,{&theta},m=0) cum densities) ylabel(#6,grid) xtitle(x) legend(label(1 "(k,{&theta})=1,2") label(2 "(k,{&theta})=2,2") label(3 "(k,{&theta})=3,2") label(4 "(k,{&theta})=5,1") label(5 "(k,{&theta})=9,5") label(6 "(k,{&theta})=7.5,1") label(7 "(k,{&theta})=0.5,1")) 

graph export "..\figures\gamma_cdf.png",  replace

