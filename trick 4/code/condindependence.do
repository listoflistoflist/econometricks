clear

set obs 10000
set seed 0

gen x = int(runiform(0,20))

scalar beta_0 = 2
scalar beta_1 = .2
scalar beta_2 = .3
scalar beta_3 = 0.1
scalar beta_4 = .3
scalar beta_5 = .6
scalar beta_6 = .1
scalar beta_7 = .3
scalar beta_8 = .5
scalar beta_9 = .4
scalar beta_10 = .5
scalar beta_11 = -.3
scalar beta_12 = .1
scalar beta_13 = .6
scalar beta_14 = .5
scalar beta_15 = -.1
scalar beta_16 = .8
scalar beta_17 = .15
scalar beta_18 = .5
scalar beta_19 = .8


mkspline s1 1 s2 2 s3 3 s4 4 s5 5 s6 6 s7 7 s8 8 s9 9 s10 10 s11 11 s12 12 s13 13 s14 14 s15 15 s16 16 s17 17 s18 18 s19 19 s20 = x


local reg
forv i=1(1)19 {
local reg `reg' + beta_`i' * s`i'
}

*gen y = beta_0 + beta_1 * x + beta_2 * d1 * (x - s1) + beta_3 * d2* (x - s2) + rnormal(0,0.2)
*gen y = beta_0 + beta_1 * x `reg' + rnormal(0,1.5)
gen y = beta_0  `reg' + rnormal(0,2.5)


reg y s1-s19

predict res, res
predict xb, xb


gen x_=.
gen den = .
levelsof x, local(levels)
foreach l of local levels {
kdensity res if x == `l', generate(x_`l' den_`l') n(10000)
replace x_ = x_`l' + xb if x == `l'
replace den = den_`l'*18 + x/**/ if x == `l' /*for graph3d comment + x, for tw uncomment it*/
}




su xb if x==4
scalar mean_x4 = r(mean)
su xb if x==8
scalar mean_x8 = r(mean)
su xb if x==12
scalar mean_x12 = r(mean)
su xb if x==16
scalar mean_x16 = r(mean)


su den if x==4
scalar max_den4 = r(max)
su x_ if x==8 
su den if x==8
scalar max_den8 = r(max)
su den if x==12
scalar max_den12 = r(max)
su den if x==16
scalar max_den16 = r(max)

tw (line x_ den if x==4, recast(area) lwidth(medsmall) nodropbase color("64 105 166%40") lwidth(small) lcolor(black%80)) ///
 (line x_ den if x==8, recast(area) lwidth(medsmall) nodropbase color("64 105 166%40") lwidth(small) lcolor(black%80)) ///
 (line x_ den if x==12, recast(area) lwidth(medsmall) nodropbase color("64 105 166%40") lwidth(small) lcolor(black%80)) ///
 (line x_ den if x==16, recast(area) lwidth(medsmall) nodropbase color("64 105 166%40") lwidth(small) lcolor(black%80)) ///
 (scatteri `=scalar(mean_x4)' 4  `=scalar(mean_x4)' `=scalar(max_den4)' , recast(line) lpattern(dash) lcolor("64 105 166%80"))  ///
 (scatteri `=scalar(mean_x8)' 8  `=scalar(mean_x8)' `=scalar(max_den8)' , recast(line) lpattern(dash) lcolor("64 105 166%80"))  ///
 (scatteri `=scalar(mean_x12)' 12 `=scalar(mean_x12)' `=scalar(max_den12)', recast(line) lpattern(dash) lcolor("64 105 166%80"))  ///
 (scatteri `=scalar(mean_x16)' 16 `=scalar(mean_x16)' `=scalar(max_den16)', recast(line) lpattern(dash) lcolor("64 105 166%80"))  ///
  (connected xb x, sort(x) lwidth(medlarge) lcolor(black) mcolor(black) msize(small)) ///
  , ///
   ytitle("Profit Margin" "(Income in Percent of Total Revenues)", margin(medium)) xtitle(Political Connections (Lobbying Expenditure in Thousand Euro), margin(medium)) xlabel(3 "50" 6 "150" 9 "250" 12 "350" 15 "450" 18 "550") legend(off) title(Political Connections and Profit Margin, margin(medium)) plotregion(margin(0 0 0 0)) graphregion(margin(0 10 0 0))
 

graph export "..\figures\meanindependence.png", replace width(1280)

 
 

preserve
keep if x==0 | x==4 | x==8 | x==12 | x==16 | x==19
replace den = . if x==0 | x==19

graph3d den x x_ , cuboid innergrid /*wire*/ colorscheme(cr) xlab("Primary") ylab("f(y|x)") zlab("Secondary") zangle(90) yangle(205) xangle(10)   ycam(-3) zcam(-18)   blv  format("%12.0fc") mark equi markeroptions(msize(1))
graph export "..\figures\homo_hetero.png", replace width(1280)
restore