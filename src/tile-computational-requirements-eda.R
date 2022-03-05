

#importing a library that will help visualize the runtime of the tiles of the rendered image while not having to restructure my data
library(autoimage)


###############################################################################################################################################
################################################### EDA on tile computational requirements ####################################################
###############################################################################################################################################

plot.tile.runtime = function() {
  
  #plotting an image of 256 by 256 pixels where each pixel corresponds to the time it took for that pixel of the Terrapixel visualization to be rendered
  pimage(new.tile.checkpoints$x, new.tile.checkpoints$y, new.tile.checkpoints$seconds.taken, 
         xlab = "X co-ordinate of image tile", ylab = "Y co-ordinate of image tile", main = "Total render runtime of each tile in seconds",
         col = fields::tim.colors(64))
  
}

