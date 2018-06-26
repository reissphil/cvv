#' Processing of dyadic 3D motion data
#' 
#' Inputs times and corresponding positions in 3D space for two individuals,
#' and uses the \pkg{fda} package to create functional data objects representing both persons' data with respect to a B-spline basis.
#' 
#' @param tvec Vector of times
#' @param p0,p1 Vectors of positions for persons 0 and 1; each should be of same length as \code{tvec}
#' @param nbasis Dimension of B-spline basis used to represent each person's data along each dimension
#' @param lambda Tuning parameter for penalized smoothing with respect to the given B-spline basis.
#' @return A list with elements
#' \item{x0,y0,z0}{Functional data objects (see \code{\link[fda]{fd}}) representing the three coordinates for person 0} \item{x1,y1,z1}{Same, for person 1}  \item{bsb}{B-spline basis object (see \code{\link[fda]{create.bspline.basis}})} %% ...
#' 
#' @export
#' @importFrom fda create.bspline.basis Data2fd
make.fd <-
function(tvec, p0, p1, nbasis=300, lambda=NULL) {
	if (is.null(lambda)) lambda <- 1e-9/diff(range(tvec))
	bsb = create.bspline.basis(range(tvec), nbasis)   
    ll <- list()
    ll$x0 = Data2fd(tvec, as.vector(p0[,1]), bsb, lambda=lambda)  
    ll$y0 = Data2fd(tvec, as.vector(p0[,2]), bsb, lambda=lambda)  
    ll$z0 = Data2fd(tvec, as.vector(p0[,3]), bsb, lambda=lambda)  
    ll$x1 = Data2fd(tvec, as.vector(p1[,1]), bsb, lambda=lambda)  
    ll$y1 = Data2fd(tvec, as.vector(p1[,2]), bsb, lambda=lambda)  
    ll$z1 = Data2fd(tvec, as.vector(p1[,3]), bsb, lambda=lambda)  
    ll$bsb = bsb
    ll
}
