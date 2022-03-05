
###############################################################################################################################################
################################################ merging the start and stop timestamps ########################################################
###############################################################################################################################################

get.all.event.times = function(application.check) {
  

#################################################### Working on the "tiling" events ###########################################################


#Extracting only the rows that correspond to events with name "tiling" and have an event type of "START"
tiling.set.start = application.check[(application.check$eventName=="Tiling" & application.check$eventType == "START"),]
tiling.set.stop = application.check[(application.check$eventName=="Tiling" & application.check$eventType == "STOP"),]
#Reordering the resulting sets so that they are ordered according to the taskID.
#This reordering allows us to see both the start and stop event types for each task and will help in merging the two sets
#so that we can have one line for "START" and "STOP" of each event for each task
tiling.set.start = tiling.set.start[order(tiling.set.start$taskId, decreasing = TRUE),]
tiling.set.stop = tiling.set.stop[order(tiling.set.stop$taskId, decreasing = TRUE),]

#mergin the start and stop timestamps of the two sets so that we can have one line for "START" and "STOP" of each event for each task
tiling.times = data.frame(
  start.time = tiling.set.start$timestamp,
  stop.time = tiling.set.stop$timestamp,
  tiling.set.start[,2:3],
  tiling.set.start[,5:6]
)

################################################ Working on the "Saving Config" events ########################################################


saving.set.start = application.check[(application.check$eventName=="Saving Config" & application.check$eventType == "START"),]
saving.set.stop = application.check[(application.check$eventName=="Saving Config" & application.check$eventType == "STOP"),]
#Reordering the resulting sets so that they are ordered according to the taskID.
#This reordering allows us to see both the start and stop event types for each task and will help in merging the two sets
#so that we can have one line for "START" and "STOP" of each event for each task
saving.set.start = saving.set.start[order(saving.set.start$taskId, decreasing = TRUE),]
saving.set.stop = saving.set.stop[order(saving.set.stop$taskId, decreasing = TRUE),]

#mergin the start and stop timestamps of the two sets so that we can have one line for "START" and "STOP" of each event for each task
saving.times = data.frame(
  start.time = saving.set.start$timestamp,
  stop.time = saving.set.stop$timestamp,
  saving.set.start[,2:3],
  saving.set.start[,5:6]
)


################################################ Working on the "Render" events ########################################################


render.set.start = application.check[(application.check$eventName=="Render" & application.check$eventType == "START"),]
render.set.stop = application.check[(application.check$eventName=="Render" & application.check$eventType == "STOP"),]
#Reordering the resulting sets so that they are ordered according to the taskID.
#This reordering allows us to see both the start and stop event types for each task and will help in merging the two sets
#so that we can have one line for "START" and "STOP" of each event for each task
render.set.start = render.set.start[order(render.set.start$taskId, decreasing = TRUE),]
render.set.stop = render.set.stop[order(render.set.stop$taskId, decreasing = TRUE),]

#mergin the start and stop timestamps of the two sets so that we can have one line for "START" and "STOP" of each event for each task
render.times = data.frame(
  start.time = render.set.start$timestamp,
  stop.time = render.set.stop$timestamp,
  render.set.start[,2:3],
  render.set.start[,5:6]
)

################################################ Working on the "TotalRender" events ########################################################


totalrender.set.start = application.check[(application.check$eventName=="TotalRender" & application.check$eventType == "START"),]
totalrender.set.stop = application.check[(application.check$eventName=="TotalRender" & application.check$eventType == "STOP"),]
#Reordering the resulting sets so that they are ordered according to the taskID.
#This reordering allows us to see both the start and stop event types for each task and will help in merging the two sets
#so that we can have one line for "START" and "STOP" of each event for each task
totalrender.set.start = totalrender.set.start[order(totalrender.set.start$taskId, decreasing = TRUE),]
totalrender.set.stop = totalrender.set.stop[order(totalrender.set.stop$taskId, decreasing = TRUE),]

#mergin the start and stop timestamps of the two sets so that we can have one line for "START" and "STOP" of each event for each task
totalrender.times = data.frame(
  start.time = totalrender.set.start$timestamp,
  stop.time = totalrender.set.stop$timestamp,
  totalrender.set.start[,2:3],
  totalrender.set.start[,5:6]
)

################################################ Working on the "Uploading" events ########################################################


uploading.set.start = application.check[(application.check$eventName=="Uploading" & application.check$eventType == "START"),]
uploading.set.stop = application.check[(application.check$eventName=="Uploading" & application.check$eventType == "STOP"),]
#Reordering the resulting sets so that they are ordered according to the taskID.
#This reordering allows us to see both the start and stop event types for each task and will help in merging the two sets
#so that we can have one line for "START" and "STOP" of each event for each task
uploading.set.start = uploading.set.start[order(uploading.set.start$taskId, decreasing = TRUE),]
uploading.set.stop = uploading.set.stop[order(uploading.set.stop$taskId, decreasing = TRUE),]

#mergin the start and stop timestamps of the two sets so that we can have one line for "START" and "STOP" of each event for each task
uploading.times = data.frame(
  start.time = uploading.set.start$timestamp,
  stop.time = uploading.set.stop$timestamp,
  uploading.set.start[,2:3],
  uploading.set.start[,5:6]
)

################################### Merging the start and stop timestamps of all events in one set #########################################


all.event.times = rbind(tiling.times, saving.times, render.times, totalrender.times, uploading.times)



###############################################################################################################################################
##################################################### Runtime extraction for events ###########################################################
###############################################################################################################################################

#converting the pre-formatted timestamps to POSIXct object with 3 decimal places to represent the milliseconds
options(digits.secs =3)
all.event.times = all.event.times %>%  mutate(start.time = lubridate::ymd_hms(all.event.times$start.time)) %>% 
  mutate(stop.time = lubridate::ymd_hms(all.event.times$stop.time))
#finding the difference between the stop and start timestamps for all instances of all events
test = as.numeric(difftime(all.event.times$stop.time,all.event.times$start.time))

#adding the new column of the time taken to complete each instance of a task inside my pre-existing dataset
all.event.times = data.frame(
  seconds.taken = test,
  all.event.times[,3:6]
)

return(all.event.times)

}
all.event.times = get.all.event.times(application.checkpoints)
