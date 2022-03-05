
###############################################################################################################################################
#################################### importing the gpuSeries column into application.checkpoints dataset ######################################
###############################################################################################################################################


#finding the number of times that each gpuSerial and the hostname were in the same row in the application.checkpoint sataset
hostname.gpu.matches = as.data.frame(table(gpu$gpuSerial,gpu$hostname, dnn=c("gpuSerial","hostname")),stringsAsFactors = FALSE)
#removing the matches with frequency equal to zero as they are irrelevant to my data exploration.
hostname.gpu.matches = hostname.gpu.matches[hostname.gpu.matches$Freq!=0,]
#checking if the number of unique gpuSerials and hostnames is equal.

#This finding allows me to proceed with importing the gpuSerial data from the "gpu" dataset into the "application.checkpoints" dataset by taking
#advantage of their common variable, namely the "hostname" column. Once that is complete, I will then enumerate the performance of each card.


#to take advantage of already preprocessed timestamps, I am using the "all.event.times" dataset which holds the times taken to complete each event.
gpu.card.application.checkpoints = all.event.times
#taking the original dataset with the event runtimes and incorporating the gpuSerial numbers based on their corresponding hostnames found in the 
#"hostname.gpu.matched" data frame
gpu.card.application.checkpoints = merge(gpu.card.application.checkpoints, hostname.gpu.matches, by.x = "hostname", by.y = "hostname", all.x = TRUE)

#restructuring the data frame to make it more visually appealing
gpu.card.application.checkpoints = data.frame(
  gpu.card.application.checkpoints[1],
  gpu.card.application.checkpoints[6],
  gpu.card.application.checkpoints[,2:5]
)


###############################################################################################################################################
############################################################ GPU card pre-processing ##########################################################
###############################################################################################################################################


#getting the serial numbers of the GPU cards from my dataset
gpu.cards = unique(gpu.card.application.checkpoints$gpuSerial)
#initializing a vector to hold the average runtimes of each GPU card
gpu.runtimes = 1:length(gpu.cards)

#iterating through all of the available GPU cards
for (i in 1:length(gpu.cards)) {
  #for each card I take the times it has taken to complete all associated events and calculate the mean of all of the event times
  gpu.runtimes[i] = mean(gpu.card.application.checkpoints$seconds.taken[gpu.card.application.checkpoints$gpuSerial == gpu.cards[i] &
                                                                          gpu.card.application.checkpoints$eventName=="TotalRender"])
}


#This function takes in a string that represents an event type and plots the average runtimes of all GPU cards for that event type
get.gpu.event.performance = function(event) {
  #getting the serial numbers of the GPU cards from my dataset
  gpu.cards = unique(gpu.card.application.checkpoints$gpuSerial)
  #extracting a new version of the dataset that only holds rows with the given event as the event types variable
  gpu.event = gpu.card.application.checkpoints[gpu.card.application.checkpoints$eventName==event,]
  #initializing a vector to hold the average runtimes of each GPU card for the given event type
  gpu.event.runtimes = 1:length(gpu.cards)
  
  #iterating through all GPU cards
  for (i in 1:length(gpu.cards)) {
    #extracting the average runtime of each GPU card for the given event type
    gpu.event.runtimes[i] = mean(gpu.event$seconds.taken[gpu.event$gpuSerial == gpu.cards[i]])
  }
  #plotting to spot the any outliers and/or patterns
  plot(gpu.event.runtimes, xlab=event, ylab="Average Time (seconds)", xaxt = "n")
  
}
