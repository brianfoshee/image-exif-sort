This script will iterate through folders with images in them, find the date and time they were taken
based on EXIF data, and save the file to a single folder based on the date and time in this format:
```
Photo was taken Dec 23, 2010 at 12:34:15 PM
File will be saved as 20101223-123415-0.jpg
```
*note - the -0 at the end of the file is in case there are multiple images at this time. It'll
increment infinitely.

I'm sure this could be sped up.

Set the folders in the initialize method.

Image memory now being released! (via JanneM)

Use-Case:
When my sister got married she received hundreds of images from her photographer.
These images were all named inconsistently, and some were even named the same even
though they were completely different pictures. This was because they had come from
multiple cameras. My sister wanted to be able to view
them in order based on the time they were taken, and be able to have them all in one
folder without having to manually rename the ones that were named the same. This fixed
her issue.
