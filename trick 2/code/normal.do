
twoway (function y = normalden(x), range(-4 4) pstyle(p1)  lwidth(medthick)) ///
		(function y = normalden(x,0.5,1.3), range(-4 4) pstyle(p2)  lwidth(medthick)), ///
	   xline(0, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) legend(label(1 "N{&sim}(0,1)") label(2 "N{&sim}(0.5,1.3)"))  ytitle("{&phi}(x)")

graph export "..\figures\normals_pdf.png",  replace
	   
