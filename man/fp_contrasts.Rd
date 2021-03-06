% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fp_contrasts.R
\name{fp_contrasts}
\alias{fp_contrasts}
\title{Returns contrasts between fingerprints}
\usage{
fp_contrasts(x, comp1, comp2, param = c("FL1-H", "FL3-H"), d = 3, thresh = 0.1)
}
\arguments{
\item{x}{flowbasis object generated by flowBasis()}

\item{comp1}{A vector of factors/indices indicating the groups to be compared. 
This group will be compared to comp2. Negative density values indicate that
comp1 had a higher density at that specific bin/area.}

\item{comp2}{A vector of factors/indices indicating the groups to be compared.
This group will be compared to comp1. Negative density values indicate that
comp1 had a higher density at that specific bin/area.}

\item{param}{A vector of the two parameters to be compared. Please adhere to the 
order defined in @param of the flowBasis object. See below for example.}

\item{d}{Round value for density values, defaults at 3.}

\item{thresh}{threshold required to return the density values. Values lower than
this threshold will be removed.}
}
\description{
This function returns contrasts between fingerprints generated by flowBasis() which
can be visualized with ggplot2.
}
\examples{

data(CoolingTower)

### Check which parameters are in the fingerprint
CoolingTower@param

### Lets run with the standard c("FL1-H","FL3-H") and lets evaluate how the 
### microbial community compares between the start-up and control phase of the
### cooling water system.
comp <- fp_contrasts(CoolingTower, comp1 = c(5:9), comp2 = c(1:4), 
param=c("FL1-H","FL3-H"), thresh=0.01)

### Plot
v <- ggplot2::ggplot(comp, ggplot2::aes(`FL1-H`, `FL3-H`, z = Density))+
  ggplot2::geom_tile(ggplot2::aes(fill=Density)) + 
  ggplot2::geom_point(colour="gray", alpha=0.4)+
  ggplot2::scale_fill_distiller(palette="RdBu", na.value="white") + 
  ggplot2::stat_contour(ggplot2::aes(fill=..level..), geom="polygon", binwidth=0.1)+
  ggplot2::theme_bw()+
  ggplot2::geom_contour(color = "white", alpha = 1)
 
 ### Red/positive values indicate higher density for the reactor start-up.
 ### blue/negative values indicate lower density during start-up.
 print(v)
 
}
\keyword{contrasts,}
\keyword{fcm}
