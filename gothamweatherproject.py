import requests
import time
import pyrebase
import datetime


#firebase setup
config = {
  "apiKey": "yourkey",
  "authDomain": "yourauthdomain",
  "databaseURL": "yourdatabaseurl",
  "storageBucket": "yourstoragebucket"
}
firebase = pyrebase.initialize_app(config)
auth = firebase.auth()
user = auth.sign_in_with_email_and_password("email@email.com", "yourpwd")
db = firebase.database()




#NYC Neighborhood Dictionary
neighborhoods = {
    #"hellskit" : "KNYNEWYO254",
    "upperwest" : "KNYNEWYO679",
    "lowermanh" : "KNYNEWYO321",
    #"greenwich" : "KNYNEWYO591",
    #upperman : "KNYNEWYO202",
    #"midtown" : "KNYNEWYO568"
    "astoria" : "KNYNEWYO759",
    "flushing" : "KNYQUEEN33",
    "williamsburg" : "KNYBROOK40",
    #"middlevillage" : "KNYMIDDL57",
    "prospectpark" : "KNYNEWYO400",
    "brightonbeach" : "KNYNEWYO152",
    "jamaicaqueens" : "KNYNEWYO697",
    "eastbronx" : "KNYBRONX14",
    #westbronx : "KNYBRONX3"
    "staten" : "KNYNEWYO277"
}


while True:

    print("Start")
    for key, value in neighborhoods.items():
        print(key)

        # query weather underground for current weather
        fileName = "http://api.wunderground.com/api/yourkey/geolookup/conditions/q/pws:{}.json".format(value)
        parsed_json = requests.get(fileName).json()

        location = parsed_json['current_observation']['observation_location']['city']
        temp_f = str(int(parsed_json['current_observation']['temp_f']))
        temp_c = str(int(parsed_json['current_observation']['temp_c']))
        humidity =str(parsed_json['current_observation']['relative_humidity'])
        winddir = str(parsed_json['current_observation']['wind_dir'])
        windspeed = str(int(parsed_json['current_observation']['wind_mph']))
        windString = winddir + " @ " + windspeed + " MPH"
        weather = parsed_json['current_observation']['weather']
        currentURL = parsed_json['current_observation']['icon_url']
        currentURL = currentURL[4:]
        currentURL = "https" + currentURL
        tempData = {"temp": str(temp_f)}

        #Update firebase with current weather data
        db.child(key).child("temp").set(str(temp_f), user["idToken"])
        db.child(key).child("tempc").set(str(temp_c), user["idToken"])
        db.child(key).child("weather").set(str(weather), user["idToken"])
        db.child(key).child("curURL").set(str(currentURL), user["idToken"])
        db.child(key).child("humidity").set(str(humidity), user["idToken"])
        db.child(key).child("wind").set(str(windString), user["idToken"])





        # query forecast
        fileNameF = "http://api.wunderground.com/api/yourkey/geolookup/forecast/q/pws:{}.json".format(value)
        parsed_jsonF = requests.get(fileNameF).json()
        period = 0

        for day in parsed_jsonF['forecast']['simpleforecast']['forecastday']:
            dayname = day['date']['weekday']
            cond = day['conditions']
            high = day['high']['fahrenheit']
            low = day['low']['fahrenheit']
            weatherURL = day['icon_url']
            weatherURL = weatherURL[4:]
            weatherURL = "https" + weatherURL
            period += 1

            #update firebase with forecast weather data
            db.child(key).child(period).child("dayname").set(str(dayname), user["idToken"])
            db.child(key).child(period).child("conditions").set(str(cond), user["idToken"])
            db.child(key).child(period).child("high").set(str(high), user["idToken"])
            db.child(key).child(period).child("low").set(str(low), user["idToken"])
            db.child(key).child(period).child("url").set(str(weatherURL), user["idToken"])

        print(key + "forecast done")

        time.sleep(6)



    timestamp = '{0: %b %d, %Y %H:%M}'.format(datetime.datetime.now())
    timestampdata = {"time" : timestamp}
    db.child("time").set(timestampdata, user["idToken"])
    print("db updated on: " + timestamp)

    #30 min refresh
    time.sleep(1720)
    user = auth.refresh(user["refreshToken"])

    print("token refresh: %s" % (time.strftime("%c")))

    #1hr refresh
    time.sleep(1720)
    user = auth.refresh(user["refreshToken"])

    print("token refresh: %s" % (time.strftime("%c")))