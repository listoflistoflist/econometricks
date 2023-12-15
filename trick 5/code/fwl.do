use http://fmwww.bc.edu/ec-p/data/hayashi/griliches76.dta, clear

* multivariate regression (three regressors)
reg lw tenure expr s
predict res,res //residuals of multivariate regression
scalar b_s = _b[s] //coefficient of interest
scalar b_0 = _b[_cons] //constant

* detrend/partial out s
reg s tenure expr
scalar gamma_0 = _b[_cons] //constant
predict res_s,res

* detrend/partial out lw
reg lw tenure expr
scalar delta_0 = _b[_cons] //constant
scalar delta_1a = _b[tenure] //
scalar delta_1b = _b[expr] //
predict res_lw,res

* bivariate regression (one regressors)
reg res_lw res_s
predict res_star,res
di "coefficient of interest from multivariate " b_s " and from bivariate " _b[res_s] " are identical" //coefficient of interest


li res res_star in 1/100 // residuals of multivariate and bivariate regressions are identical


***************
* partial out s
gen s_star = gamma_0 + res_s

* partial out lw
gen lw_star = delta_0 + res_lw

reg lw_star s_star //coefficient of interest identical, again!
di "the constant " _b[_cons] " is " b_0

reg lw s_star //coefficient of interest identical, but constant and standard errors differ!
su tenure
scalar m_tenure = r(mean)
su expr
scalar m_expr = r(mean)
di "The new constant is " b_0 + delta_1a * m_tenure + delta_1b * m_expr