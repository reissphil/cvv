#' Compute and plot cosine of velocity vectors at each of a set of lags
#' 
#' Inputs a dyadic motion object outputted by \code{\link{make.fd}}, computes cosine of the two individuals' velocity vectors at each of the provided lag values, and makes a plot.
#' 
#' @param obj A dyadic motion object outputted by \code{\link{make.fd}}.
#' @param timerange Time range to include in the plot. If \code{NULL}, the entire recorded time range.
#' @param lagvec Vector of lag values.
#' @param npoints Number of time points, within \code{timerange}, to include in the plots.
#' @param power Power to which the computed cosine is raised.
#' @param power.plot Power to which the plotted cosine is raised.
#' @param plot Either \code{"fields"}, to use \code{\link[fields]{image.plot}} for a color plot of the cosine matrix; or \code{"ggplot"}, to use \code{\link[ggplot2]{ggplot}} to plot the cosines as a function of time for each lag.
#' @param legend.args,horizontal Passed to \code{\link[fields]{image.plot}}.
#' @param xlab,ylab x- and y-axis labels.
#' @param \dots Other arguments to the plotting function.
#' @return A list with components
#' \item{data.frame}{Data frame used to make the plot} \item{cosmat}{Matrix of cosines} \item{timerange}{The time range supplied}
#' 
#' @export
#' @importFrom fields image.plot
#' @importFrom graphics abline
#' @importFrom viridis viridis
#' @importFrom ggplot2 aes ggplot geom_line scale_colour_brewer labs
#'
#' @examples
#' # Two types of lag plots, as in Figs. 5 and 6 of Reiss, Gvirts et al.
#' data(sync.fd)
#' rnge <- c(61,62.2)  
#' 
#' fig5 <- multilag(sync.fd, lagvec=seq(-.4,.4,,31), npoints=801, horizontal=TRUE)
#' abline(v=rnge[1], col="red")
#' abline(v=rnge[2], col="red")
#' 
#' fig6 <- multilag(sync.fd, rnge, plot="ggplot")

multilag <-
function(obj, timerange=NULL, lagvec=-2:2/10, npoints=701, power=1, power.plot=1, plot="fields", legend.args=list(text="", side=3), horizontal=FALSE, xlab="Time", ylab="Lag", ...) {
	x0 <- obj$x0
	y0 <- obj$y0
	z0 <- obj$z0
	x1 <- obj$x1
	y1 <- obj$y1
	z1 <- obj$z1

	if (is.null(timerange)) timerange <- c(obj$bsb$rangeval[1]+max(0,max(lagvec)), obj$bsb$rangeval[2]+min(0,min(lagvec)))
	
	time <- seq(timerange[1], timerange[2], , npoints)
            
    mm <- NULL
    for (lagg in lagvec) mm <- rbind(mm, cbind(lagg, time, cosfunc(obj, lag=lagg)(time)^power))
    mm <- as.data.frame(mm)
    names(mm)[3] <- "cosine"
    mm$lag <- factor(mm$lagg)
    cosmat <- NULL
    for (k in unique(mm$lag)) cosmat <- cbind(cosmat, mm$cosine[mm$lag==k])
    rownames(cosmat) <- unique(mm$time)
    colnames(cosmat) <- sort(unique(mm$lagg))

    if (plot=="ggplot") {
        print(ggplot(mm, aes(time,cosine^power.plot)) + geom_line(aes(colour=lag, group=lag)) + scale_colour_brewer(palette="RdBu") + labs(x="Time", y="Cosine"))
    } else if (plot=="fields") {   
        image.plot(unique(mm$time), sort(unique(mm$lagg)), cosmat^power.plot, xlab=xlab, ylab=ylab, col=viridis(40), legend.args=legend.args, horizontal=horizontal, ...)
        abline(h=0, col='grey')
    }
    
    list(data.frame=mm, cosmat=cosmat, timerange=timerange)
}
