
###############################################################################################################################################
############################################ preprocessing on tile computational requirements #################################################
###############################################################################################################################################

#merging the data sets that hold information about task runtimes and those with information about the tiles corresponding to each task.
#To match the two data frames i used the common column of "taskId".
new.tile.checkpoints = merge(all.event.times, task.x.y, by.x = "taskId", by.y = "taskId", all.x = TRUE)

#reordering the dateframe so that the rows are shown by their x range first and then their y range
new.tile.checkpoints = new.tile.checkpoints[order(new.tile.checkpoints$y),]
new.tile.checkpoints = new.tile.checkpoints[order(new.tile.checkpoints$x),]

#filtering out all rows that do not represent total render events and also narrowing the jobId (image that was rendered) to the biggest one
new.tile.checkpoints = new.tile.checkpoints[new.tile.checkpoints$jobId.x == "1024-lvl12-7e026be3-5fd0-48ee-b7d1-abd61f747705" &
                                              new.tile.checkpoints$eventName=="TotalRender",]

#creating a new dataframe that only keeps the columns that are needed for the exploratory data analysis
new.tile.checkpoints = data.frame(
  x = new.tile.checkpoints$x,
  y = new.tile.checkpoints$y,
  seconds.taken = new.tile.checkpoints$seconds.taken
)

#removing the duplicated rows to clean the dataset
new.tile.checkpoints = unique(new.tile.checkpoints)
