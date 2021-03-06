# Apple Rejected: Gotham Weather Project

Note: You will need to install the pods for the app to work since github will now allow large file uploads.

At times, there can be 10+ degrees of difference between one area of NYC to another. The weather at the Coney Island is not the same as the weather as Central Park. So why sum up of all of Gotham with a single data point?  The days of just receiving a single weather data point for all of Gotham is over! The Gotham Weather Project is a microclimate weather app designed exclusively for New York City. 

From the Bronx to Brooklyn, quickly see at a glance the varying temperatures through out the Big Apple projected onto a vintage map of the greater New York City region.  Well... the gatekeepers at Apple decided to they don't need a mircoclimate weather app for NYC.  However, this is a still an interesting enough app for me to use on a personal basis.    

How does it work?  A python script on my Raspberry Pi does a couple API calls and retrieves weather information from Personal Weather Stations (PWS) on Weather Underground's network.  Weather Underground allows developers to retrieve weather info from specific weather stations, thus, I could gather weather data from regions I am interested in, instead of just a single point in a city.  The data is then sent to my Firebase Real Time database.  I created an iOS app that plots the weather information onto an image map of NYC. By tapping on the region, more granular weather information and forecasts will be retrieved from my Firebase database. 
