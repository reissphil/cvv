##' Synchronized 3D motion for a dyad
##'
##' Times and positions for two individuals moving synchronously during sham 
##' brain stimulation.
##'
##' @name syncsham
##' @docType data
##' @format This data set consists of three objects:
##' \describe{\item{\code{tvec.}}{A vector of 41510 time points} 
##' \item{\code{p0.},\code{p1.}}{Two 41510 x 3 matrices, giving 3D positions 
##'	for two individuals at the times given by \code{tvec.}}}
##' @seealso \code{\link{make.fd}} converts these data to \code{\link{sync.fd}}, which is in the required format for computing CVV via function \code{\link{cosfunc}}
##' @examples
##' \dontrun{
##'	data(syncsham)
##' tmp <- make.fd(tvec., p0., p1.)   # may take a while...
##' data(sync.fd)
##' all.equal(tmp, sync.fd)
##' }
##' @keywords datasets
NULL