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
*gen y = beta_0  `reg' + rnormal(0,2.5*x/10)


reg y s1-s19

predict res, res
predict xb, xb


gen x_=.
gen den = .
levelsof x, local(levels)
foreach l of local levels {
kdensity res if x == `l', generate(x_`l' den_`l') n(10000) nograph
replace x_ = x_`l' + xb if x == `l'
replace den = den_`l' * 1.5 /*+ x*/ if x == `l' /*for graph3d comment + x, for tw uncomment it*/
}




 

preserve
*keep if x==0 | x==4 | x==8 | x==12 | x==16 | x==19
*keep if x==0 | x==4 | x==2 
replace den = . if x==0 | x==19

/*
replace den = 0 if x==2
replace x_ = xb if x==2
*/

levelsof x, local(levels)
foreach l of local levels {
	if !(`l'==0 | `l'==4 | `l'==8 | `l'==12 | `l'==16 | `l'==19) {
replace den = 0 if x==`l'
replace x_ = xb if x==`l'
}
}


replace x=x*2
sample 5000, count
graph3d x_ den x, cuboid innergrid /*wire*/ colorscheme(cr) zlab("profits") ylab("f(profits|lobbying)") xlab("lobbying") xlang(348) ylang(90) zlang(50) scale(0.7) xlpos(2) ylpos(2) zlpos(12) xang(2) yang(292) blv coord() format("%12.0fc")  equi markeroptions(msize(medsmall) m(o)) 
graph export "..\figures\homo_hetero.png", replace width(1280)
restore


