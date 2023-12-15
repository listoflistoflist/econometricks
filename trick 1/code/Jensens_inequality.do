
twoway (function y = ln(x), range(0 120) pstyle(p1) lwidth(medthick)) ///
	   (function y = 0.0255*x + 2.043, range(10 100) pstyle(p3) lwidth(medthick)), ///
	    xline(55, lpattern(dot) lc(black)) ///
	    xline(10, lpattern(dot) lc(black)) ///
	    xline(100, lpattern(dot) lc(black)) ///
	    yline(3.4538776, lpattern(dot) lc(black)) ///
   	   text(-1.28 10  "c{sub: bad}", place(e)) ///
   	   text(2.043 10  "u(c{sub: bad})", place(e)) ///
   	   text(-1.28 50  "E[c]={&mu}", place(e)) ///
   	   text(4.2 50  "u({&mu})", place(e)) ///
   	   text(3.2 50  "E[u(c)]=1/2u(c{sub: bad})+1/2u(c{sub: good})", place(e)) ///
   	   text(-1.28 100.3 "c{sub: good}", place(e)) ///
   	   text(4.5 100.3 "u(c{sub: good})", place(e)) ///
	   ytitle(Lognormal({&mu},{&sigma}{sup:2}) densities) xlabel(0(20)120) ylabel(#6,grid) xtitle(c) ytitle("u(c)=ln(c)") legend(off) 

graph export "..\figures\Jensens_inequality.png",  replace

