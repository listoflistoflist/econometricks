

twoway (function y = binomialp(15,x,0.5), range(0 15) lcolor(red) lwidth(medthick)), ///
	   xline(8, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   ytitle("P(X=x)") ylabel(#6,grid) xtitle(k) 


graph export "..\figures\binomial_pdf.png",  replace

twoway (function y = binomialp(15,x,0.5), range(0 15) lcolor(red) lwidth(medthick)), ///
	   xline(8, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   ytitle("P(X=n/2-x)=P(X=n/2+x)=1/2") ylabel(#6,grid) xtitle(k) 


graph export "..\figures\binomial_pdf_sym.png",  replace
	   
twoway (function y = binomial(15,x,0.5), range(0 15) lcolor(red) lwidth(medthick)), ///
	   xline(0, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   yline(0.5, lpattern(dash_dot) lc(gs11)) ///
	   ytitle(1-F(n/2-x)=F(n/2+x)) ylabel(#6,grid) xtitle(k) 

graph export "..\figures\binomial_cdf.png",  replace


twoway (function y = normalden(x), range(-3 3) lcolor(red) lwidth(medthick)), ///
	   xlabel(none,grid) ///
	   xline(0, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   ytitle({&phi}(x)) ylabel(#6,grid) xtitle(x) 

graph export "..\figures\normal_pdf.png",  replace

twoway (function y = normalden(x), range(-3 3) lcolor(red) lwidth(medthick)), ///
       ylabel(#6,grid) ///
	   xlabel(none,grid) ///
	   xline(0, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   xline(-1.66, lpattern(dash) lc(red)) ///
	   xline(1.66, lpattern(dash) lc(red)) ///
	   yline(0.1, lpattern(dash) lc(red)) ///
	   ytitle({&phi}({&epsilon})={&phi}(-{&epsilon})) ylabel(#6,grid) xtitle({&epsilon}) ///
	   text(-0.025 -1.9 "-1.66", place(e)) ///
	   text(-0.025 1.45 "1.66", place(e)) 


graph export "..\figures\normal_pdf_sym.png",  replace
	   
twoway (function y = normal(x), range(-3 3) lcolor(red) lwidth(medthick)), ///
       ylabel(#6,grid) ///
	   xlabel(none,grid) ///
	   xline(0, lpattern(dot) lc(black)) yline(0, lpattern(dot) lc(black)) ///
	   xline(-1.28, lpattern(dash) lc(red)) ///
	   xline(1.28, lpattern(longdash) lc(red)) ///
	   yline(0.1, lpattern(dash) lc(red)) ///
	   yline(0.9, lpattern(longdash) lc(red)) ///
	   yline(0.5, lpattern(dash_dot) lc(gs11)) ///
	   ytitle(1-{&Phi}({&epsilon})={&Phi}(-{&epsilon})) ylabel(#6,grid) xtitle({&epsilon}) ///
	   text(-0.05 -1.55 "-1.28", place(e)) ///
	   text(-0.05 1.1 "1.28", place(e)) 


graph export "..\figures\normal_cdf_sym.png",  replace


