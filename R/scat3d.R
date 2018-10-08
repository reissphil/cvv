#' 3D plotting of motion data
#' 
#' Inputs a dyadic motion data produced by \code{\link{make.fd}}, and creates a 3D plot of the data for one member of the dyad.
#' 
#' @param obj A dyadic motion object outputted by \code{\link{make.fd}}
#' @param person Which person's data should be plotted: 0 or 1
#' @param npoints Number of (equally spaced) points to include in the plot
#' @param deriv Derivative to plot (e.g., 1 for velocity, 2 for acceleration); the default, 0, plots the positions  
#' @param tmin,tmax Lower and upper ends of the time range
#' @param cex Magnification factor for the points
#' @param col Color; the default gives a rainbow plot
#' @param plotter Character vector describing the plotting function to use: either "\code{\link[rgl]{plot3d}}" or "\code{\link[scatterplot3d]{scatterplot3d}}"
#' @param common.width Logical: Should the plotting interval along each of the 3 dimensions be of equal width?
#' @param \dots Arguments passed to the plotting function.
#' @return A list with components
#' \item{tseq}{Sequence of times} \item{xfd,yfd,zfd}{Functional data objects (see \code{\link[fda]{fd}}) for the x, y, and z-coordinates}  
#' 
#' @examples
#' # 3D plots as in Fig. 6 of Reiss, Gvirts et al.
#' data(sync.fd)
#' rnge <- c(61,62.2)  
#' par(mfrow=1:2)
#' pers0 <- scat3d(sync.fd, person=0, tmin=rnge[1], tmax=rnge[2], 
#'            plotter="scatterplot3d", main="Leader", xlab='x', ylab='y', zlab='z')
#' pers1 <- scat3d(sync.fd, person=1, tmin=rnge[1], tmax=rnge[2], 
#'            plotter="scatterplot3d", main="Follower", xlab='x', ylab='y', zlab='z')

#' @export
#' @importFrom fda eval.fd
#' @importFrom rgl plot3d
#' @importFrom grDevices rainbow
#' @importFrom scatterplot3d scatterplot3d
scat3d <-
function(obj, person, npoints=1001, deriv=0, tmin=NULL, tmax=NULL, cex=.5, col=rainbow(npoints, end=5/6), plotter="rgl", common.width=FALSE, ...) {
	t.all = obj$bsb$rangeval
	if (person==0) {
		xfd = obj$x0; yfd = obj$y0; zfd= obj$z0
	} else if (person==1) {
		xfd = obj$x1; yfd = obj$y1; zfd= obj$z1		
	}
	if (is.null(tmin)) trange = t.all
	else {
		if (tmin<t.all[1]) stop("tmin too low")
		if (tmax>t.all[2]) stop("tmax too high")
		trange <- c(tmin, tmax)
	}
	tseq <- seq(trange[1], trange[2], , npoints)
	xvec <- eval.fd(tseq, xfd, Lfdobj=deriv)
	yvec <- eval.fd(tseq, yfd, Lfdobj=deriv)
	zvec <- eval.fd(tseq, zfd, Lfdobj=deriv)
	if (common.width) {
		range.x <- range(xvec)
		range.y <- range(yvec)
		range.z <- range(zvec)
		max.radius <- max(c(diff(range.x), diff(range.y), diff(range.z))) / 2
		xlim. <- c(mean(range.x)-max.radius, mean(range.x)+max.radius)
		ylim. <- c(mean(range.y)-max.radius, mean(range.y)+max.radius)
		zlim. <- c(mean(range.z)-max.radius, mean(range.z)+max.radius)
	} else xlim. <- ylim. <- zlim. <- NULL
	if (plotter=="scatterplot3d") {
		scatterplot3d(xvec, yvec, zvec, color=col, pch=15, cex.symbols=cex, xlim=xlim., ylim=ylim., zlim=zlim., ...)
	} else if (plotter=="rgl") {
		plot3d(xvec, yvec, zvec, col=col, cex=cex, xlim=xlim., ylim=ylim., zlim=zlim., ...)
	} 
	list(tseq=tseq, xfd=xfd, yfd=yfd, zfd=zfd)
}
