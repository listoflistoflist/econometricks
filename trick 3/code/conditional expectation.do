use "C:\Users\drostam\Dropbox\Teaching\Mannheim\2023 Fall\adv ec\02 Review of Probability and Distribution Theory\dofiles\bivariate.dta", clear

bys x: egen cm=mean(y)

tw (scatter y x, color(green%30) jitter(3)) (lfit y x) (connected cm x), xlabel(1(1)3) ylabel(1(1)2) legend(row(1) label(1 "data") label(2 "OLS") label(3 "Conditional Expectation"))
 
 graph export "..\figures\conditional_expectation.png",  replace

 
 bys x: egen ey=mean(y)
 
 gen ey_2= ey^2
 
 gen y2=y^2
 
 bys x: egen ey2=mean(y2)

 gen var= ey2-ey_2
 
*gen c1 = cm-1.96*sqrt(var)
*gen c2 = cm+1.96*sqrt(var) 
gen c1 = cm-1.645*sqrt(var)
gen c2 = cm+1.645*sqrt(var) 


tw (rcap c1 c2 x, color(gray%10))  (scatter y x, color(green%30) jitter(3)) (lfit y x) (scatter cm x, m(S)), xlabel(1(1)3) ylabel(1(1)2) legend(order(2 3 4 1) row(2) label(1 "90% Confidence from Conditional Variance") label(2 "Data") label(3 "OLS") label(4 "Conditional Expectation"))

 
 graph export "..\figures\conditional_expectation.png",  replace
