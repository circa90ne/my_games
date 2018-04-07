# README

### File Download Solution:

I would use the rubyzip gem and File Library in order to accomplish this task.

In Categories Controller, I would have a respond_to block with a zip format handler in the show method since that's where the logic is for showing the games. In this code block, I would first create a file with all of the games information using the 'File' library. Then I'd utilize the rubyzip library to create a Zip File in the desired '~/Downloads' directory and push my text/csv file to that zip file.

I would have 2 buttons/links on the page, one titled 'Download ZIP(.txt)' and another titled 'Download ZIP(.csv)'. Clicking on either would download a zipped folder containing the list of games in that format.
