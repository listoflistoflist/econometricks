clear
use "connected_firms_graph3d.dta"



gen y = 4000 + 0.5 * employees + 0.05 * connections - 0.0004 * employees * connections + rnormal(0,700)

reg y c.employees##c.connections 

predict xb, xb

graph3d employees y connections, cuboid innergrid wire colorscheme(cr) xlab("Political Connections") ylab("Profit Margin") zlab("Employees") xlang(355) ylang(90) zlang(28) xlpos(2) ylpos(2) zlpos(12) xang(24) yang(292) blv coord(4 5 7 8) format("%12.0fc")  equi markeroptions(msize(medsmall) m(o)) 
graph export "..\figures\3d_cloud1.png", replace width(1280)


graph3d employees xb connections, cuboid innergrid wire colorscheme(cr) xlab("Political Connections") ylab("Profit Margin") zlab("Employees") xlang(355) ylang(90) zlang(28) xlpos(2) ylpos(2) zlpos(12) xang(24) yang(292) blv coord(4 5 7 8) format("%12.0fc")  equi markeroptions(msize(vsmall) m(o)) 
graph export "..\figures\3d_cloud2.png", replace width(1280)
