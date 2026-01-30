# Conceptual illustration of spatial synchrony

rm(list=ls())

library(RColorBrewer)
options(rgl.useNULL = TRUE)
library(rgl)
library(OCNet)
library(MASS)


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Generate simulated river network and sampling sites ----------------------------------------------

set.seed(11)
ocn <- create_OCN(dimX=40, dimY=60, nOutlet=1, outletSide="S", outletPos=10)
#draw_simple_OCN(ocn, thrADraw=25, easyDraw = TRUE)

coordX <- c(11,7,20,25,31.5)
coordY <- c(2,30,38,9,50)
#points(coordX, coordY, pch=16, col="black", cex=1.5)



#Generate synthetic time series -------------------------------------------------------------------

n <- 5 #number of populations
tmax <- 50 #number of time steps
tt <- 1:tmax #vector of times

sigma.sync <- matrix(0.8, nrow=n, ncol=n)
diag(sigma.sync) <- 1
syncts <- mvrnorm(n=tmax, mu=rep(1.5,n), Sigma=sigma.sync)

sigma.async <- matrix(0, nrow=n, ncol=n)
diag(sigma.async) <- 1
asyncts <- mvrnorm(n=tmax, mu=rep(1.5,n), Sigma=sigma.async)
asyncts[asyncts < -1] <- -1


#Plotting -----------------------------------------------------------------------------------------

pal <- brewer.pal(5,"Dark2")
laymat <- matrix(c(1,2,2,
                   1,3,3), 
                 nrow=2, byrow=TRUE)

pdf("./conceptualFigure.pdf", width=8.5, height=3.75)

layout(laymat)

#left panel: map
par(mar=rep(0.05,4))
draw_simple_OCN(ocn, thrADraw=25, easyDraw = TRUE)
points(coordX, coordY, pch=21, bg=pal, cex=2)
rect(0,0,40,60)
text(2,58,"a)", cex=1.5)

#top right: synchronized time series
par(mar=c(2,2,1.5,1), mgp=c(1,1,0))
plot(NA,NA, xlim=c(1,tmax), ylim=c(-1.1,18), xaxt="n", yaxt="n", ylab="Measure", xlab="Time", cex.lab=1.5)
axis(1, at=pretty(1:tmax), labels=FALSE)
axis(2, at=pretty(-1:18), labels=FALSE)
for(ii in 1:ncol(syncts)){
  lines(tt, syncts[,ii], lwd=2, col=pal[ii])
}
lines(tt, rowSums(syncts), lwd=3)
text(par("usr")[1]+0.025*diff(par("usr")[1:2]), 
     par("usr")[4]-0.08*diff(par("usr")[3:4]), "b)", cex=1.5)
mtext("Synchrony", line=0.1)

#right panel: asynchronous time series
plot(NA,NA, xlim=c(1,tmax), ylim=c(-1.1,18), xaxt="n", yaxt="n", ylab="Measure", xlab="Time", cex.lab=1.5)
axis(1, at=pretty(1:tmax), labels=FALSE)
axis(2, at=pretty(-1:18), labels=FALSE)
for(ii in 1:ncol(asyncts)){
  lines(tt, asyncts[,ii], lwd=2, col=pal[ii])
}
lines(tt, rowSums(asyncts), lwd=3)
text(par("usr")[1]+0.025*diff(par("usr")[1:2]), 
     par("usr")[4]-0.08*diff(par("usr")[3:4]), "c)", cex=1.5)
mtext("Asynchrony", line=0.1)

dev.off()
