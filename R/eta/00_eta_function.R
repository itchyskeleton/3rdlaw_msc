#This is a script to define time windows to calculate speciation and extinction rates. It works finding the maximum mean diversification rate, then multiplying it by a given number (cut); every positive number that falls under the result of that operation, and every negative number that falls above it, are considered equilibrium. The positive numbers that fall above the result of the operation are considered rise, and the negative numbers that fall below it are considered decline. This operation can be done only once (considering only the maximum modular mean diversification rate; two=F) or twice (considering the maximum positive diversification rate for rise and the minimum negative diversification rate for decline; two=T, which is the default). 

eta <- function(file, cut, two=TRUE, savePlot=FALSE, path=NULL){
  #defining which part of the pyrate output file we want
  sourcery <- function(file, start=1, end=Inf) {
    file.lines <- scan(file, what=character(), skip=start-1, nlines=end-start+1, sep='\n')
    file.lines.collapsed <- paste(file.lines, collapse='\n')
    source(textConnection(file.lines.collapsed))
  } #Thanks Matthew Plourde @ stackoverflow for this: 
  #https://stackoverflow.com/questions/12214963/source-only-part-of-a-file
  
  new_pyrate <- sourcery(file, start=5, end=20)
  sp_rate <- rate
  
  new_pyrate <- sourcery(file, start=34, end=40)
  time <- time
  net_rate <- net_rate
  
  new_pyrate <- sourcery(file, start=21, end=30)
  ex_rate <- rate
  
  #creating dataframe for PyRate output
  phase <- rep(NA, length(time))
  clade_rates <<- data.frame(time, sp_rate, ex_rate, net_rate, phase)
  
  #function to define the threshold values
  if(two==TRUE){
    define_threshold <- function(x, cut) {
      threshold <<- c(NA, NA)
      threshold[[1]] <<- max(x)*cut
      threshold[[2]] <<- min(x)*cut
      if(threshold[[2]] > 0){threshold[[2]]=NA}
      result <<- as.data.frame(threshold)
      colnames(result) <<- c("Threshold rates")
      rownames(result) <<- c("Rise", "Decline")
      return(result)
    }
  }
  
  #this is the part that changes if this is not two tailed:
  if(two==FALSE){
    define_threshold <- function(x, cut) {
      threshold <<- c(NA, NA)
      threshold[[1]] <<- max(abs(x))*cut
      threshold[[2]] <<- -max(abs(x))*cut
      if(threshold[[2]] > 0){threshold[[2]]=NA}
      result <<- as.data.frame(threshold[[1]])
      colnames(result) <<- c("Threshold rate")
      rownames(result) <<- c(" ")
      return(result)
    }
  }
  
  # function to determine phase according to the diversification value
  create_phases <- function(x) {
    if(x >= threshold[[1]]){"Rise"} 
    else if(x < 0 & x <= threshold[[2]]){"Dec"} 
    else{"Equi"} 
  }
  
  # estimate thresholds
  define_threshold(clade_rates$net_rate, cut)
  
  #define the phases using the cut values
  clade_rates$phase <<- sapply(clade_rates$net_rate, create_phases)
  
  #add phases to data frame
  clade_rates$phase ->> phases
  
  #plotting the data
  library(scales)
  layout(matrix(c(1,2), ncol=1, nrow=2), width=c(0.8,1), height=c(.8,.2))
  par(mar=c(4,4,3,2))
  
  # plot the rates
  plot(
    time,
    time,
    type = 'n', 
    ylim = rev(c((max(net_maxHPD)+1),((min(net_minHPD)-1)))), 
    xlim = c(min(time), max(time)), 
    ylab = 'Net diversification rate', 
    xlab = 'Time',
    lwd=2, 
    main=cut, 
    col= '#504A4B'
  )
  polygon(
    c(time, rev(time)), 
    c(net_maxHPD, rev(net_minHPD)), 
    col = alpha('#504A4B',alpha=0.5), 
    border = NA
  )
  lines(time,net_rate, col = 'black', lwd=2)
  abline(h=0,lty=2)
  
  # plotting the phases
  
#  for (i in 1:length(clade_rates$net_rate)) {	
#    if(clade_rates$phase[[i]]=="Rise"){
#      abline(v=clade_rates$time[[i]], 
#             col=alpha("#1E88E5", 0.4), 
#             lwd=2)
#    }		
#  }
  
#  for (i in 1:length(clade_rates$net_rate)) {	
#    if(clade_rates$phase[[i]]=="Dec"){
#      abline(v=clade_rates$time[[i]], 
#             col=alpha("#D81B60",0.4), 
#             lwd=2)
#    }
#  }
  
#  for (i in 1:length(clade_rates$net_rate)) {	
#    if(clade_rates$phase[[i]]=="Equi"){
#      abline(v=clade_rates$time[[i]], 
#             col=alpha("#FFC107", 0.5), 
#             lwd=2)
#    }	
#  }
  
  
  
  
  for (i in 1:length(clade_rates$net_rate)) {  
    if(clade_rates$phase[[i]]=="Rise") {
      rect(xleft=clade_rates$time[i], 
           xright=clade_rates$time[(i+1)], 
           ybottom=-10, ytop=+10, 
           col=alpha("#1E88E5", 0.2), 
           border=NA
      )}       
  }
  
  for (i in 1:length(clade_rates$net_rate)) {  
    if(clade_rates$phase[[i]]=="Dec")  {
      rect(xleft=clade_rates$time[i], 
           xright=clade_rates$time[(i+1)], 
           ybottom=-10, ytop=+10, 
           col=alpha("#D81B60", 0.2), 
           border=NA
      )}
  }
  
  for (i in 1:length(clade_rates$net_rate)) {  
    if(clade_rates$phase[[i]]=="Equi")  {
      rect(xleft=clade_rates$time[i], 
           xright=clade_rates$time[(i+1)], 
           ybottom=-10, ytop=+10, 
           col=alpha("#FFC107", 0.2), 
           border=NA
      )}   
  }
  
  #legend
  par(mar=c(1,1,1,1))
  plot(
    x=NULL, 
    y=NULL, 
    type="n", 
    main="", 
    xlim=c(0,10), 
    ylim=c(0,10), 
    xaxt="n", 
    yaxt="n", 
    bty="n"
  )
  legend(
    "center",
    bty="n",
    pch=15,
    title="Time windows",
    c("Expansion", "Equilibrium", "Decline"), 
    col=c("#1E88E5", "#FFC107", "#D81B60"), 
    horiz=T, 
    cex=1, 
    xpd=T,
    pt.cex=1.8
  )
  
  eta_plot <<- recordPlot()
  
  if(savePlot==TRUE){
    
    if(is.null(path)==T){warning("Unable to save plot: no path provided")}
    
    if(is.null(path)!=T){
      pdf(file=path, width=8.3, height=5.8)
      print(eta_plot)
      dev.off()
    }
    
  }
  
  eta_plot
  
  return(result)
  
}




#This function calculates the mean speciation and extinction rates per time window. It depends on the results of the previous function.
eta.means <- function(){
  
  sp_rise <<- mean(clade_rates$sp_rate[clade_rates$phase=="Rise"])
  sp_equi <<- mean(clade_rates$sp_rate[clade_rates$phase=="Equi"])
  sp_decl <<- mean(clade_rates$sp_rate[clade_rates$phase=="Dec"])
  
  ex_rise <<- mean(clade_rates$ex_rate[clade_rates$phase=="Rise"])
  ex_equi <<- mean(clade_rates$ex_rate[clade_rates$phase=="Equi"])
  ex_decl <<- mean(clade_rates$ex_rate[clade_rates$phase=="Dec"])
  
  means <- data.frame(
    matrix(
      data=c(sp_rise, sp_equi, sp_decl, ex_rise, ex_equi, ex_decl), 
      ncol=2, 
      byrow=F
      ))
  rownames(means) <- c("Rise", "Equilibrium", "Decline")
  colnames(means) <- c("Speciation", "Extinction")
  return(means)
}