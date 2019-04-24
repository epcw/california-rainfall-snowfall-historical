#!/bin/python3

#this is a selenium-based web scraper to download snowpack water content data from the CA department of water resources.  IMPORTANT - use with the wrapper script ca_snowpack_hist.sh to define the station id codes and feed them into this scraper.

from selenium import webdriver
import sys #you need this for command line input
#from selenium.common.exceptions import NoSuchElementException
import os #to save things, I think
import pyautogui #not actually sure if you need this
from selenium.webdriver.chrome.options import Options #options (for running headless)

# instantiate a chrome options object so you can set the size and headless preference
chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--window-size=1920x1080")

#browser = webdriver.Chrome(executable_path='C:\\Program Files (x86)\\Chromedriver\\chromedriver.exe') #open up your browser (windows version)
browser = webdriver.Chrome(chrome_options=chrome_options) #open up your browser (Ubuntu version, with headless flags)
data = browser.get(sys.argv[1]) #fetch url defined in command line argument 1 (from wrapper shell script)
data = browser.find_element_by_tag_name("body")

print(data.text)

browser.close() #close the browser else you'll have a browser window open for every single station in the loop
