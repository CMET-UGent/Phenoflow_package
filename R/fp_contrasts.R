#' Returns contrasts between fingerprints
#'
#' This function returns contrasts between fingerprints generated by flowBasis() which
#' can be visualized with ggplot2.
#' @param x flowbasis object generated by flowBasis()
#' @param comp1 A vector of factors/indices indicating the groups to be compared. 
#' This group will be compared to comp2. Negative density values indicate that
#' comp1 had a higher density at that specific bin/area.
#' @param comp2 A vector of factors/indices indicating the groups to be compared.
#' This group will be compared to comp1. Negative density values indicate that
#' comp1 had a higher density at that specific bin/area.
#' @param d Round value for density values, defaults at 3.
#' @param param A vector of the two parameters to be compared. Please adhere to the 
#' order defined in @param of the flowBasis object. See below for example.
#' @param thresh threshold required to return the density values. Values lower than
#' this threshold will be removed.
#' @keywords contrasts, fcm
#' @examples
#' 
#' data(CoolingTower)
#' 
#' ### Check which parameters are in the fingerprint
#' CoolingTower@param
#' 
#' ### Lets run with the standard c("FL1-H","FL3-H") and lets evaluate how the 
#' ### microbial community compares between the start-up and control phase of the
#' ### cooling water system.
#' comp <- fp_contrasts(CoolingTower, comp1 = c(5:9), comp2 = c(1:4), 
#' param=c("FL1-H","FL3-H"), thresh=0.01)
#' 
#' ### Plot
#' v <- ggplot2::ggplot(comp, ggplot2::aes(`FL1-H`, `FL3-H`, z = Density))+
#'   ggplot2::geom_tile(ggplot2::aes(fill=Density)) + 
#'   ggplot2::geom_point(colour="gray", alpha=0.4)+
#'   ggplot2::scale_fill_distiller(palette="RdBu", na.value="white") + 
#'   ggplot2::stat_contour(ggplot2::aes(fill=..level..), geom="polygon", binwidth=0.1)+
#'   ggplot2::theme_bw()+
#'   ggplot2::geom_contour(color = "white", alpha = 1)
#'  
#'  ### Red/positive values indicate higher density for the reactor start-up.
#'  ### blue/negative values indicate lower density during start-up.
#'  print(v)
#'  
#' @export

fp_contrasts <- function(x, comp1, comp2, param = c("FL1-H", "FL3-H"), 
                         d = 3, thresh = 0.1) {
  nbin <- x@nbin
  Y <- c()
  for (i in 1:nbin) Y <- c(Y, rep(i, nbin))
  
  ### Calculate max. density over total data
  max.total <- max(x@basis)
  
  ### Make contrasts
  if (length(comp1) == 1 & length(comp2) == 1) 
    tmp <- (x@basis[comp1, ] - x@basis[comp2, ])
  if (length(comp1) == 1 & length(comp2) != 1) 
    tmp <- x@basis[comp1, ] - colMeans(x@basis[comp2, ])
  if (length(comp1) != 1 & length(comp2) == 1) 
    tmp <- colMeans(x@basis[comp1, ]) - x@basis[comp2, ]
  if (length(comp1) != 1 & length(comp2) != 1) 
    tmp <- colMeans(x@basis[comp1, ]) - colMeans(x@basis[comp2, ])
  
  ### Normalize
  tmp <- tmp/max.total
  
  ### Position of data in @basis
  npos <- seq(1:nrow(x@param))[x@param[, 1] == param[1] & x@param[, 2] == 
                                 param[2]]
  region <- ((npos - 1) * nbin * nbin + 1):(npos * nbin * nbin)
  cat(paste0("\tRegion used for contrasts ", min(region), " ", max(region), 
             "\n"))
  
  ### Convert to data.frame
  df <- data.frame(Density = tmp[region], X = rep(1:nbin, nbin), Y = Y)
  colnames(df)[2:3] <- param
  
  ### Filter out low density values
  df <- df[abs(round(df$Density, d)) > thresh, ]
  
  ### Message
  cat(paste0("\tReturning contrasts for ", rownames(x@basis)[comp1], 
             " ", rownames(x@basis)[comp2], "\n"))
  
  return(df)
}