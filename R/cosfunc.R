#' Create a function to compute lagged cosines of velocity vectors
#' 
#' Given a dyadic motion object produced by \code{\link{make.fd}}, along with a fixed lag, outputs a function mapping time points to lagged cosine of velocity vectors.
#' 
#' 
#' @param obj A dyadic motion object outputted by \code{\link{make.fd}}.
#' @param x0,y0,z0,x1,y1,z1 Functional data objects (see \code{\link[fda]{fd}}) representing the three coordinates for persons 0 and 1. These are extracted from \code{obj} if the latter is provided.
#' @param lag Lag for person 1 with respect to person 0. E.g., if lag=0.1, person 1 is assumed to lag behind person 0 by 0.1 second.
#' @return A function that inputs a vector of times, and outputs the cosines between the two 3D velocity vectors at each of these times, at the given lag.
#' 
#' @export
#' @importFrom fda eval.fd
cosfunc <-
function(obj=NULL, x0, y0, z0, x1, y1, z1, lag=0) {
	if (length(lag) > 1) stop("'lag' must be a scalar")
	if (!is.null(obj)) {
		x0 <- obj$x0
		y0 <- obj$y0
		z0 <- obj$z0
		x1 <- obj$x1
		y1 <- obj$y1
		z1 <- obj$z1
	}
    fun <- function(tt) {  # will this work if tt is a scalar?
		m1l <- scale(rbind(as.vector(eval.fd(tt-lag,x1,1)), as.vector(eval.fd(tt-lag,y1,1)), as.vector(eval.fd(tt-lag,z1,1))), FALSE, TRUE) / sqrt(2)
		m0 <- scale(rbind(as.vector(eval.fd(tt,x0,1)), as.vector(eval.fd(tt,y0,1)), as.vector(eval.fd(tt,z0,1))), FALSE, TRUE) / sqrt(2)
		colSums(m1l * m0)
	}
	fun
}
