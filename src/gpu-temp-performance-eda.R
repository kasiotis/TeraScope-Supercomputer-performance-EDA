

###############################################################################################################################################
########################################################### Data Exploration ##################################################################
###############################################################################################################################################

#pairs(gpu[,5:8])
#plot(gpu$gpuTempC, gpu$gpuUtilPerc)


###############################################################################################################################################
################################################# EDA on Temperature and Performance of GPUs ##################################################
###############################################################################################################################################

#plotting the core and memory utilization versus the gpu temperature
plot.gpu.temp = function() {
  
  plot(interplay.temp.performance$gpuTempC, interplay.temp.performance$gpuUtilPercent,
       xlab="GPU temperature", ylab="Utilisation Percentage", type="l", col=1)
  lines(interplay.temp.performance$gpuTempC,interplay.temp.performance$gpuMemUtilPercent, col=2)
  legend("topleft", legend = c("GPU Core(s)","GPU Memory"), cex = 0.90, fill=1:2, text.font = 4)
  
}

