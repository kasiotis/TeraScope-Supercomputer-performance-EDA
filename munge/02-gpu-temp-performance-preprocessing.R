
#extracting all of the unique temperatures that were recorded
temps = sort(unique(gpu$gpuTempC))


corePercentages = 1:length(temps)
memPercentages = 1:length(temps)
#iterating through the number of unique individual temperatures
for (i in 1:length(temps)) {
  #averaging the core and memory utilization percentages for each specific temperature value
  corePercentages[i] = mean(gpu$gpuUtilPerc[gpu$gpuTempC==temps[i]])
  memPercentages[i] = mean(gpu$gpuMemUtilPerc[gpu$gpuTempC==temps[i]])
}

#creating a dataset with the average core and memory utilization percentages for every GPU temperature
interplay.temp.performance = data.frame(
  gpuTempC = temps,
  gpuUtilPercent = corePercentages,
  gpuMemUtilPercent = memPercentages
)