
###############################################################################################################################################
########################################################### Data Exploration ##################################################################
###############################################################################################################################################

#This is done to verify that the relationship of the two variables is one to one.
length(unique(hostname.gpu.matches$gpuSerial)) == length(unique(hostname.gpu.matches$hostname)) #TRUE confirms that for each hostname there is always only one corresponding gpuSerial


###############################################################################################################################################
####################################################### EDA on general GPU performance ########################################################
###############################################################################################################################################

plot.gpu.card.general = function() {
  
  par(mfrow=c(3,1))
  #plotting the runtimes of all the GPU cards
  plot(gpu.runtimes, xaxt="n", xlab = "GPU cards", ylab = "Average runtimes (seconds)", main = "The average runtime of each GPU")
  
  #plotting the runtimes of the 3 GPU cards that were the slowest
  plot(gpu.runtimes[gpu.runtimes>46.9], xaxt="n", xlab = "GPU cards", ylab = "Average runtimes (seconds)", main = "The average runtime of the three slowest GPUs")
  axis(side=1, at= 1:length(gpu.cards[gpu.runtimes>46.9]), labels = gpu.cards[gpu.runtimes>46.9])
  
  #plotting the runtimes of the 3 GPU cards that were the fastest
  plot(gpu.runtimes[gpu.runtimes<=39], xaxt="n", xlab = "GPU cards", ylab = "Average runtimes (seconds)", main = "The average runtime of the three fastest GPUs")
  axis(side=1, at= 1:length(gpu.cards[gpu.runtimes<=39]), labels = gpu.cards[gpu.runtimes<39])
  
}


#plotting to spot the any outliers and/or patterns
summary(gpu.runtimes)
boxplot(gpu.runtimes)

length(gpu.cards[gpu.runtimes>17.28])
length(gpu.cards[gpu.runtimes<=17.28])

###############################################################################################################################################
################################################### EDA on GPU performance per event type #####################################################
###############################################################################################################################################

plot.gpu.card.per.event = function() {
  
  #calling the function to display the plots of the runtimes for all existing event types
  par(mfrow=c(1,length(unique(gpu.card.application.checkpoints$eventName))))
  for (i in unique(gpu.card.application.checkpoints$eventName)) {
    get.gpu.event.performance(i)
  }
  mtext("GPU average runtimes per event type",                   # Add main title
        side = 3,
        line = - 1.5,
        outer = TRUE)
  
}
