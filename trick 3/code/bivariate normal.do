clear
set seed 0
local obs = 1000
set obs `obs'

/* Correlated unobservable characteristics*/
scalar rho = .8
matrix C = (1, scalar(rho) \ scalar(rho), 1)
drawnorm epsilon_1 epsilon_2, n(`obs') corr(C)

corr epsilon_1 epsilon_2

gen pdfbivnormal = 1/(2*_pi*sqrt(1-scalar(rho)^2))*exp(-1/(2*(1-scalar(rho)^2))*(epsilon_1^2-2*scalar(rho)*epsilon_1*epsilon_2+epsilon_2^2))

graph3d epsilon_1 epsilon_2 pdfbivnormal, zang(-15) xang(92) yang(180) cuboid perspective innergrid blv scale(0.1) xlab("{&epsilon}{sub:x}") ylab("{&epsilon}{sub:y}") zlab("PDF bivariate normal: {&phi}(x,y)") xlpos(10) ylpos(2) zlpos(7) xlang(80) ylang(-10) zlang(-6) colorscheme(cr) 

graph export "..\figures\bivariate_normal_pdf.png",  replace

sample 10

label variable epsilon_1 "{&epsilon}{sub:x}"
label variable epsilon_2 "{&epsilon}{sub:y}"
label variable pdfbivnormal "{&phi}(x,y)"

 twoway (contour pdfbivnormal epsilon_1 epsilon_2)
 
 graph export "..\figures\bivariate_normal_pdf_contour.png",  replace
