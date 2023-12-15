
use "lobbying2.dta", clear

tw (scatter profitmargin lobbying, mlc(red%70) mfc(red%70) msize(medlarge)) , xlabel(50(100)550) ylabel(0(2)10) ytitle("Profit Margin" "(Income in Percent of Total Revenues)", margin(medium)) xtitle(Political Connections (Lobbying Expenditure Thousand Euro), margin(medium)) legend(off) title(Political Connections and Profit Margin, margin(medium)) plotregion(margin(0 0 5 0)) graphregion(margin(0 10 0 0))


graph export "..\figures\politicallyconnected1.png", replace width(1280)


tw (scatter profitmargin lobbying, mlc(red%70) mfc(red%70) msize(medlarge)) (function y = 4, range(50 550) lcolor(black) lwidth(medthick)), xlabel(50(100)550) ylabel(0(2)10) ytitle("Profit Margin" "(Income in Percent of Total Revenues)", margin(medium)) xtitle(Political Connections (Lobbying Expenditure in Thousand Euro), margin(medium)) legend(off) title(Political Connections and Profit Margin, margin(medium)) plotregion(margin(0 0 5 0)) graphregion(margin(0 10 0 0))

graph export "..\figures\politicallyconnected2.png", replace width(1280)


tw (scatter profitmargin lobbying, mlc(red%70) mfc(red%70) msize(medlarge)) (function y = 1.7 + .013108 * x, range(50 550) lcolor(black) lwidth(medthick)), xlabel(50(100)550) ylabel(0(2)10) ytitle("Profit Margin" "(Income in Percent of Total Revenues)", margin(medium)) xtitle(Political Connections (Lobbying Expenditure in Thousand Euro), margin(medium)) legend(off) title(Political Connections and Profit Margin, margin(medium)) plotregion(margin(0 0 5 0)) graphregion(margin(0 10 0 0))


graph export "..\figures\politicallyconnected3.png", replace width(1280)




tw (scatter profitmargin lobbying, mlc(red%70) mfc(red%70) msize(medlarge) ) (scatter profitmargin lobbying if lobbying>180 & lobbying<350, mlc(blue%70) mfc(blue%70) msize(medlarge)) , xlabel(50(100)550) ylabel(0(2)10) ytitle("Profit Margin" "(Income in Percent of Total Revenues)", margin(medium)) xtitle(Political Connections (Lobbying Expenditure in Thousand Euro), margin(medium)) legend(off) title(Political Connections and Profit Margin, margin(medium)) plotregion(margin(0 0 5 0)) graphregion(margin(0 10 0 0))


graph export "..\figures\identifiability.png", replace width(1280)




tw (scatter profitmargin lobbying, mlc(red%70) mfc(red%70) msize(medlarge)) ///
 (lfit profitmargin lobbying, lcolor(black) lwidth(medthick)) ///
 /// (qfit profitmargin lobbying, lcolor(black) lwidth(medthick)) ///
, xlabel(50(100)550) ylabel(0(2)10) ytitle("Profit Margin" "(Income in Percent of Total Revenues)", margin(medium)) xtitle(Political Connections (Lobbying Expenditure in Thousand Euro), margin(medium)) legend(off) title(Political Connections and Profit Margin, margin(medium)) plotregion(margin(0 0 5 0)) graphregion(margin(0 10 0 0))


graph export "..\figures\politicallyconnected4.png", replace width(1280)

