
# PAPER describing the matrix algebra behind portfolio optimization
# http://faculty.washington.edu/ezivot/econ424/portfolioTheoryMatrix.pdf
#
#
# Notes on quadprog :: solve.QP
# ----------------------------
# solve.QP:
# 
# Solving the quadratic programming problem: min(-d^T b + 1/2 b^T D b) with the constraints A^T b >= b_0. 
# 
# solve.QP(Dmat, dvec, Amat, bvec, meq=0, factorized=FALSE)
# 
# Arguments
# Dmat 	matrix appearing in the quadratic function to be minimized.
# dvec 	vector appearing in the quadratic function to be minimized.
# Amat 	matrix defining the constraints under which we want to minimize the quadratic function.
# bvec 	vector holding the values of b_0 (defaults to zero).
# meq 	the first meq constraints are treated as equality constraints, all further as inequality constraints (defaults to 0).
# factorized 	logical flag: if TRUE, then we are passing R^(-1) (where D = R^T R) instead of the matrix D in the argument Dmat. 
# 
# 
# 
# ---------------------------
# D - covariance matrix
# b - weight vector (w1, w2, w3, ...)
# d - return rates?  min port variance when this is set to 0 ?  seems true based on the equation: min(-d^T b + 1/2 b^T D b) 
# 
# min(-d^T b + 1/2 b^T D b)
# 
#     b^T D b  <- portfolio variance (go ahead and verify against the full var equation)
#     -d^T b   <- portfolio return (negated): rates * weights
# 
# so we're minimizing (port var) MINUS (port return).
# which means we're mnimizing (port var) while simultaneously maximizing (port return)
# typically, (port return) < (port var), so by maximizing (port return) we push up (port var)
# the quadratic solution gives us min (port var) for a given desired (port return).
# 
# 
# so for min (port var), set -d^T (port return) to 0.
# 
# min(port var - port return)
# min(port var - 0)
# min(port var)
# 
# for min (port var) when (port return) is NOT 0
# min(port var - port return)
# min(port var - 5%)
#     - port var > port return
#     - so min(port var - 5% ) will be some positive number (10% say)
#     - the difference between port var and port return is "risk premium" 
#         - not really. risk prem is diff between port return and risk-free return
#         - but in this context, it means diff between (port return) and (port return at min port var)
#     - min(port var)
# 
# d^T b - (port return)
#     # dvec:  This is a vector of the average returns for each security.  
#     # To find the minimium portfolio variance, we set these all to zero.  
#     # To find points along the efficient frontier, we use a for loop to 
#     # allow these returns to vary.
#     dvec <- colMeans(returns) * i # This moves the solution up along the efficient frontier
# 
#     expected returns * weights = (port return)
#     var expected returns from 0 to expected return, proportionally
#
# -------------------------------------
# constraints A^T b >= b_0. 
#


# ------------------------------------
# 
# EXAMPLE:
# http://www.akiti.ca/QuadProgEx0Constr.html
# H <- matrix(c(5,-2,-1,-2,4,3,-1,3,5), nrow=3)
# c <- c(2,-35,-47)
# A <- matrix(1,nrow=3)
# solve.QP(Dmat=H,dvec=-c,Amat=A)


library(quadprog)

#
# source: http://economistatlarge.com/portfolio-theory/r-optimized-portfolio
#
# solve.QP args:
# Dmat:  The covariance table (matrix).  We will calculate this based on the data frame of returns.
# dvec:  This is a vector of the average returns for each security.  To find the
#        minimium portfolio variance, we set these all to zero.  To find points along
#        the efficient frontier, we use a for loop to allow these returns to vary.
# Amat:  This is the matrix of constraints.  This can be a bit complicated–hang
#        in there as we explain a little behind creating a matrix that imposes
#        constraints.  For those not steeped in algebraic matrix math, it may be easiest
#        to learn by examing the examples.  In the example, we use Amat to impose three
#        distinct constraints: the portfolio weights must sum to 1, whether we allow any
#        weights to be negative (implying short-selling and leverage), and whether there
#        is a limit to any individual weight (to avoid high concentrations in just one
#        security).
# bvec:  Think of this as the legend to the Amat.  This is a vector of values
#        that is matched up against the Amat matrix to enforce our constraints.  Again,
#        if you are not familiar with matrix math, it may be easiest to learn by
#        looking at the example and playing around with the code.
# meq:   This simply tells the solve.QP function which columns in the Amat matrix
#        to treat as equality constraints.  In our example, we only have one (the
#        weights must sum to 1).  The others are all inequality constraints (for
#        example, weight must be > 0).  We simply assign 1 to meq.
# factorized:  We do not use this argument, you can ignore it.
#
#
# @param covariance - the covar matrix
# @param expected.returns - 1 x n matrix containing expected returns for all securities (column names copied to output)
# @param short - "yes" or "no", whether short-selling is allowed (default="no") 
# @param min.allocation - vector, minimum % allowed per security
# @param max.allocation - vector, maximum % allowed per security (reduces concentration)
# @param risk.premium.up - the upper limit of the risk premium modeled (default = 1)
# @param risk.increment - the increment (by) value used in the for loop (default = 0.0001)
# @param risk.free.rate - for computing the sharpe ratio (default = 0)
#
# @return the efficient frontier matrix
#
eff.frontier <- function (covariance, 
                          expected.returns, 
                          short="no", 
                          min.allocation=NULL,
                          max.allocation=NULL, 
                          risk.premium.up=1, 
                          risk.increment=.0001,
                          risk.free.rate=0) {
 
    # -rx- print(covariance)
    n <- ncol(covariance)
     
    # Create initial Amat and bvec assuming only equality constraint (short-selling is allowed, no allocation constraints)
    Amat <- matrix (1, nrow=n)
    bvec <- 1
    meq <- 1
     
    # Modify Amat and bvec if min allocation is specified
    if(!is.null(min.allocation)){
        Amat <- cbind(1, diag(n))
        bvec <- c(bvec, min.allocation)
    } 

    # Then modify the Amat and bvec if short-selling is prohibited
    else if(short=="no"){
        Amat <- cbind(1, diag(n))
        bvec <- c(bvec, rep(0, n))
    }

    # And modify Amat and bvec if max allocation (concentration) is specified
    if(!is.null(max.allocation)){
        # -rx- if(max.allocation > 1 | max.allocation <0){
        # -rx-    stop("max.allocation must be greater than 0 and less than 1")
        # -rx- }
        # if(max.allocation * n < 1){
        if(sum(max.allocation) < 1){
            stop("Need to set max.allocation higher; not enough to sum to 1")
        }
        Amat <- cbind(Amat, -diag(n))
        # TODO: max.allocation is currently a scalar (applies to all securities).
        #       change it to a vector (per security).  get rid of the rep().
        # -rx- bvec <- c(bvec, rep(-max.allocation, n))
        bvec <- c(bvec, -max.allocation)
    }

    # -rx- print(Amat)
    # -rx- print(bvec)
     
    # Calculate the number of loops based on how high to vary the risk premium and by what increment
    loops <- risk.premium.up / risk.increment + 1
    loop <- 1
     
    # Initialize a matrix to contain allocation and statistics
    # This is not necessary, but speeds up processing and uses less memory
    eff <- matrix(nrow=loops, ncol=n+3)
    # Now I need to give the matrix column names
    colnames(eff) <- c(colnames(expected.returns), "Std.Dev", "Exp.Return", "sharpe")
     
    # Loop through the quadratic program solver
    for (i in seq(from=0, to=risk.premium.up, by=risk.increment)){
        # -rx- dvec <- colMeans(returns) * i # This moves the solution up along the efficient frontier
        dvec <- expected.returns * i # This moves the solution up along the efficient frontier
        sol <- solve.QP(covariance, dvec=dvec, Amat=Amat, bvec=bvec, meq=meq)
        eff[loop,"Std.Dev"] <- sqrt(sum(sol$solution *colSums((covariance * sol$solution))))
        # -rx- eff[loop,"Exp.Return"] <- as.numeric(sol$solution %*% colMeans(returns))
        eff[loop,"Exp.Return"] <- as.numeric(sol$solution %*% t(expected.returns))
        eff[loop,"sharpe"] <- (eff[loop,"Exp.Return"] - risk.free.rate) / eff[loop,"Std.Dev"]
        eff[loop,1:n] <- sol$solution
        loop <- loop+1
    }
     
    return(as.data.frame(eff))
}

#
# @param returns - data frame returned by stockPortfolio::getReturns()$R
#
# @return the efficient frontier matrix
#
eff.frontier2 <- function(returns, ...) {

    covariance <- cov(returns)
    expected.returns <- colMeans(returns) 
    colnames(expected.returns) <- colnames(returns)

    return(eff.frontier(covariance, expected.returns, ...))
}

#
# @param eff - returned from eff.frontier
# @return record(s) in eff with min Std.Dev
#
eff.minVariance <- function(eff) {
    return(eff[ which(eff$Std.Dev == min(eff$Std.Dev)), ])
}

#
# @param eff - returned from eff.frontier
# @return record(s) in eff with max sharpe 
#
eff.maxSharpe <- function(eff) {
    return(eff[ which(eff$sharpe == max(eff$sharpe)), ])
}

#
#
# @param eff - returned from eff.frontier
# @param sd - target std dev
# @param tolerance - +/- std dev range (default=0.0001)
#
# @return record(s) in eff with Std.Dev within sd +/- tolerance
#
eff.varEquals <- function(eff, sd, tolerance=0.0001) {
    return(eff[ which(sd - tolerance <= eff$Std.Dev & eff$Std.Dev <= sd + tolerance), ])
}

#
# @param assets.cor - correlation matrix
# @param assets.sd - vector, asset std devs.
#
# @return covariance matrix
eff.cor2cov <- function(assets.cor, assets.sd) {
    return( (assets.sd %*% t(assets.sd)) * assets.cor )
}

