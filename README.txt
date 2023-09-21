Pointing Diagnostic ~ version 0.2
Buzz Walter
July 21, 2023




This program will capture images from a pylon camera and monitor the horizontal and vertical pointing using the standard axes format of images, i.e. matrix format.  One can choose to save the time series to a csv
in the local working directory as a 2 x frame count comma delimeted set(x,y).  The frequency of acquisition will depend of course on the exposure time used, but generally the runtime adds 100 ms to any readout time.


Updates in version 0.2




  External triggering can be enabled from the panel and trigger delay can be set.  This is useful for exact measurement of periodic signals and picking out background signals or amplified signals just to name a few.


  Note that this can only be used for certain camera types(e.g. acA1920-40uc), so check the specific documentation associated with its use.  