#!/bin/python3

#this is a selenium-based web scraper to download precipitation data from the CA department of water resources.  IMPORTANT - use with the wrapper script ca_rainfall_hist.sh to define the station id codes and feed them into this scraper.

from selenium import webdriver
import sys #you need this for command line input
#from selenium.common.exceptions import NoSuchElementException
import os #to save things, I think
import pyautogui #not actually sure if you need this

# To prevent download dialog
profile = webdriver.FirefoxProfile() #modify the profile of Firefox for this session
profile.set_preference('browser.download.folderList', 2) # custom location (aka don't use the default)
profile.set_preference('browser.download.manager.showWhenStarting', False) #supress the download dialog box so it doesn't pause every time through the loop
profile.set_preference('browser.download.dir', "~/Downloads/water") #set a vanilla download folder
profile.set_preference('browser.helperApps.neverAsk.saveToDisk', 'text/csv') #never ask if you want to save to disk, same thing about not pausing every time through this loop

browser = webdriver.Firefox(profile) #open up your browser, using this profile
browser.get(sys.argv[1]) #fetch url defined in command line argument 1 (from wrapper shell script)

button = browser.find_element_by_class_name('buttons-csv') #find the button for downloading a csv file by CSS class
button.click() #click on the button to download the file
browser.close() #close the browser else you'll have a browser window open for every single station in the loop
