##' Synchronized 3D motion in "fd" object format
##'
##' 3D motion for two individuals moving synchronously, given as a functional 
##' data object.
##'
##' @name sync.fd
##' @docType data
##' @format An object of class "\code{\link{fd}}", created by applying
##' function \code{\link{make.fd}} to data set \code{\link{syncsham}}.
##' @seealso [syncsham]
##' @examples
##' # Reproduce x-, y- and z-coordinate plots (Fig. 5 of Reiss, Gvirts et al.)
##' data(sync.fd)
##' require(fda)
##' rnge <- c(61,62.2)  
##' par(mfrow = c(3,1))
##' par(mar=c(4, 4, 0, 2))
##' times <- seq(sync.fd$bsb$rangeval[1], sync.fd$bsb$rangeval[2], , 1000)
##' x0 <- eval.basis(times, sync.fd$bsb) %*% sync.fd$x0$coefs
##' x1 <- eval.basis(times, sync.fd$bsb) %*% sync.fd$x1$coefs
##' matplot(times, cbind(x0,x1), type='l', lty=c(3,1), col=1, xlab="", ylab="x-coordinate")
##' abline(v=rnge[1], col="red")
##' abline(v=rnge[2], col="red")
##' y0 <- eval.basis(times, sync.fd$bsb) %*% sync.fd$y0$coefs
##' y1 <- eval.basis(times, sync.fd$bsb) %*% sync.fd$y1$coefs
##' matplot(times, cbind(y0,y1), type='l', lty=c(3,1), col=1, xlab="", ylab="y-coordinate")
##' abline(v=rnge[1], col="red")
##' abline(v=rnge[2], col="red")
##' z0 <- eval.basis(times, sync.fd$bsb) %*% sync.fd$z0$coefs
##' z1 <- eval.basis(times, sync.fd$bsb) %*% sync.fd$z1$coefs
##' matplot(times, cbind(z0,z1), type='l', lty=c(3,1), col=1, xlab="Time", ylab="z-coordinate")
##' abline(v=rnge[1], col="red")
##' abline(v=rnge[2], col="red")
##' @keywords datasets
NULL