
##### Link for millisecond datetime conversion
#https://community.rstudio.com/t/convert-timestamp-by-milliseconds/22470


###############################################################################################################################################
########################################################### Data Exploration ##################################################################
###############################################################################################################################################

#finding the frequencies of each event name
table(application.checkpoints$eventType)

#Looking at some general inforamtion about the Application.checkpoints dataset
length(unique(application.checkpoints$hostname))
length(unique(application.checkpoints$jobId))
length(unique(application.checkpoints$taskId))


###############################################################################################################################################
################################################## EDA on time taken for each event ###########################################################
###############################################################################################################################################

#plotting box plots of the time it took each event type to commence
plot.event.runtimes = function() {
  par(mfrow=c(1,5))
  boxplot(all.event.times$seconds.taken[all.event.times$eventName=="Tiling"], ylab="Time (seconds)", xlab = "Tiling")
  boxplot(all.event.times$seconds.taken[all.event.times$eventName=="Saving Config"], xlab = "Saving Config")
  boxplot(all.event.times$seconds.taken[all.event.times$eventName=="Render"], xlab = "Render", ylim=c(20,90))
  boxplot(all.event.times$seconds.taken[all.event.times$eventName=="TotalRender"], xlab = "TotalRender",ylim=c(20,90))
  boxplot(all.event.times$seconds.taken[all.event.times$eventName=="Uploading"], xlab = "Uploading")
  mtext("Event type runtimes",                   # Add main title
        side = 3,
        line = - 1.5,
        outer = TRUE)
}



par(mfrow=c(1,1))
barplot(c(mean(all.event.times$seconds.taken[all.event.times$eventName=="Tiling"]),
          mean(all.event.times$seconds.taken[all.event.times$eventName=="Saving Config"]),
          mean(all.event.times$seconds.taken[all.event.times$eventName=="Render"]),
          mean(all.event.times$seconds.taken[all.event.times$eventName=="TotalRender"]),
          mean(all.event.times$seconds.taken[all.event.times$eventName=="Uploading"])),
        ylim=c(0,50), names=c("Tiling","Saving Config","Render","Total Render","Uploading"), col = rainbow(5),
        ylab = "Time to complete (seconds)", xlab = "Event names", main = "Average time to complete each type of event"
        )


