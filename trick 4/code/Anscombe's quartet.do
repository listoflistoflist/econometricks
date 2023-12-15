use "Anscombe's quartet.dta", clear

su x*
su y*

reg x1 y1
reg x2 y2
reg x3 y3
reg x4 y4


tw (scatter y1 x1, mlc(red%70) mfc(red%70) msize(large)) (function y = 3 + 0.5 * x, range(3 19) lcolor(black) lwidth(medthick)), xlabel(4(2)18) yscale(range(3 13)) ytitle(y{sub:1}, size(large) margin(medsmall)) xtitle(x{sub:1}, size(large) margin(medsmall)) legend(off)

graph export "..\figures\Anscombe_data1.png", replace width(1280)

tw (scatter y2 x2, mlc(red%70) mfc(red%70) msize(large)) (function y = 3 + 0.5 * x, range(3 19) lcolor(black) lwidth(medthick)), xlabel(4(2)18) yscale(range(3 13)) ytitle(y{sub:2}, size(large) margin(medsmall)) xtitle(x{sub:2}, size(large) margin(medsmall)) legend(off)

graph export "..\figures\Anscombe_data2.png", replace width(1280)

tw (scatter y3 x3, mlc(red%70) mfc(red%70) msize(large)) (function y = 3 + 0.5 * x, range(3 19) lcolor(black) lwidth(medthick)), xlabel(4(2)18) yscale(range(3 13)) ytitle(y{sub:3}, size(large) margin(medsmall)) xtitle(x{sub:3}, size(large) margin(medsmall)) legend(off)

graph export "..\figures\Anscombe_data3.png", replace width(1280)

tw (scatter y4 x4, mlc(red%70) mfc(red%70) msize(large)) (function y = 3 + 0.5 * x, range(3 19) lcolor(black) lwidth(medthick)), xlabel(4(2)18) yscale(range(3 13)) ytitle(y{sub:4}, size(large) margin(medsmall)) xtitle(x{sub:4}, size(large) margin(medsmall)) legend(off)

graph export "..\figures\Anscombe_data4.png", replace width(1280)
