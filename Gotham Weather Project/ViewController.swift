//
//  ViewController.swift
//  Gotham Weather Project
//
//  Created by Jason Chan MBP on 8/9/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit
import Firebase
import SystemConfiguration

class ViewController: UIViewController{
    
    var ref: FIRDatabaseReference!
    var handle: FIRDatabaseHandle!
    var upperWestTemp:[String] = []
    var currentBorough = ""
    var currentTitle = ""
    
    @IBAction func celFSwitch(_ sender: UISwitch) {
        
        let connection = isInternetAvailable()
        if connection == true{
            
            
            if (sender.isOn){
                
                printFahr()
            } else{
                
                printCel()
            }} else{
            
            noConnection()
        }
    }
    
    
    
    
    
    @IBAction func infoBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Gotham Weather Project, Version 1.20", message: "Copyright 2017 Jason F Chan. All Rights Reserved. Vintage map of New York City sourced from the New York Public Library.  Weather data sourced from Weather Underground. ", preferredStyle: .actionSheet)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var fCSwitch: UISwitch!
    
    var tempcf = "tempc"
    
    
    
    //@IBOutlet weak var updateTimeLabel: UILabel!
    
    //@IBOutlet weak var bronxLabel: UILabel!
    
    @IBOutlet weak var uppwestLabel: UIButton!
    @IBAction func upperwestBtn(_ sender: Any) {
        
        currentBorough = "upperwest"
        currentTitle = "Central Park"
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
        
    }
    
    @IBOutlet weak var lowermanhLabel: UIButton!
    @IBAction func lowermanhBtn(_ sender: Any) {
        
        currentBorough = "lowermanh"
        currentTitle = "Lower Manhattan"
        
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
        
    }
    
    
    @IBOutlet weak var williamsburgLabel: UIButton!
    @IBAction func williamsburgBtn(_ sender: Any) {
        
        currentBorough = "williamsburg"
        currentTitle = "Bed–Stuy"
        
        
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    @IBOutlet weak var statenLabel: UIButton!
    @IBAction func statenBtn(_ sender: Any) {
        
        currentBorough = "staten"
        currentTitle = "Staten Island"
        
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    
    @IBOutlet weak var astoriaLabel: UIButton!
    @IBAction func astoriaBtn(_ sender: Any) {
        
        currentBorough = "astoria"
        currentTitle = "Astoria"
        
        
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    @IBOutlet weak var flushingLabel: UIButton!
    @IBAction func flushingBtn(_ sender: Any) {
        currentBorough = "flushings"
        currentTitle = "Flushing"
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    @IBOutlet weak var jamaicaLabel: UIButton!
    
    @IBAction func jamaicaBtn(_ sender: Any) {
        currentBorough = "jamaicaqueens"
        currentTitle = "Jamaica"
        
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    @IBOutlet weak var prospectLabel: UIButton!
    @IBAction func prospectBtn(_ sender: Any) {
        
        currentBorough = "prospectpark"
        currentTitle = "Prospect Park"
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    @IBOutlet weak var brightonLabel: UIButton!
    @IBAction func brightonBtn(_ sender: Any) {
        currentBorough = "brightonbeach"
        currentTitle = "Coney Island"
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
    }
    
    
    @IBOutlet weak var eastbronxLabel: UIButton!
    @IBAction func bronxBtn(_ sender: Any) {
        
        currentBorough = "eastbronx"
        currentTitle = "Bronx"
        let connection = isInternetAvailable()
        if connection == true{
            
            self.performSegue(withIdentifier: "forecast", sender: nil)
        } else {
            noConnection()
        }
        
        
    }
    
    
    // Dict to hold the weather status from Firebase
    var weatherStatDict: [String:String] = [
        
        "upperwest" : "",
        "lowermanh" : "",
        "eastbronx" : "",
        "flushings" : "",
        "astoria" : "",
        "jamaicaqueens" : "",
        "brightonbeach" : "",
        "prospectpark" : "",
        "williamsburg" : "",
        "staten" : ""
        
        
    ]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
        
    }
    
    func tempColor (temp: String) -> UIColor {
        
        let tempFloat = Float(temp)
        
        
        switch (tempFloat!)
        {
        case -20...30.9:
            return .blue
            
        case 31...50.9:
            return .cyan
            
        case 51...67.9:
            return .green
            
        case 68...74.9:
            return .yellow
            
        case 75...89.9:
            return .orange
            
        case 90...150:
            return .red
            
        default:
            return .white
        }
        
        
        
        //        if tempFloat! >= 75 {
        //
        //            return .red
        //        }
        //        else{
        //        return .white
        //        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        observeWeather()
        var connection = isInternetAvailable()
        print(connection)
        
        if connection == true {
            
            print("fahr on")
            printFahr()
        }
        else{
            noConnection()
            print("no connection")
        }
    }
    
    
    func noConnection(){
        
        let alertController = UIAlertController(title: "Error", message: "No Data Connection", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    
    func observeWeather(){
        
        ref = FIRDatabase.database().reference()
        
        
        handle = ref.child("upperwest").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "upperwest")
                let labelpl = self.uppwestLabel
                labelpl?.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //labelpl?.setTitleColor(color, for: .normal)
                
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
                
            }
            
        })
        
        
        
        handle = ref.child("lowermanh").child("temp").observe(.value, with: { (snapshot) in
            
            let labelpl = self.lowermanhLabel
            if var item = snapshot.value as? String
            {
             item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "lowermanh")
                //print(self.weatherStatDict)
                labelpl?.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                // labelpl?.setTitleColor(color, for: .normal)
                self.eastbronxLabel.layer.shadowColor = UIColor.black.cgColor
                self.eastbronxLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
                self.eastbronxLabel.layer.shadowRadius = 10
                self.eastbronxLabel.layer.shadowOpacity = 1.0
            }
            
        })
        
        handle = ref.child("eastbronx").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "eastbronx")
                self.eastbronxLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.eastbronxLabel.setTitleColor(color, for: .normal)
                self.eastbronxLabel.layer.shadowColor = UIColor.black.cgColor
                self.eastbronxLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
                self.eastbronxLabel.layer.shadowRadius = 10
                self.eastbronxLabel.layer.shadowOpacity = 1.0
                
            }
            
        })
        
        handle = ref.child("flushings").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
             item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "flushings")
                self.flushingLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.flushingLabel.setTitleColor(color, for: .normal)
                
                let labelpl = self.flushingLabel
                
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
            }
            self.ref.removeObserver(withHandle: self.handle)
        })
        
        
        handle = ref.child("astoria").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "astoria")
                self.astoriaLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.astoriaLabel.setTitleColor(color, for: .normal)
                let labelpl = self.astoriaLabel
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                
                labelpl?.layer.shadowOpacity = 1.0
            }
            
        })
        
        handle = ref.child("jamaicaqueens").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "jamaicaqueens")
                self.jamaicaLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.jamaicaLabel.setTitleColor(color, for: .normal)
                let labelpl = self.jamaicaLabel
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
            }
            
        })
        
        
        handle = ref.child("brightonbeach").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "brightonbeach")
                self.brightonLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.brightonLabel.setTitleColor(color, for: .normal)
                
                let labelpl = self.brightonLabel
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
            }
            
        })
        
        
        handle = ref.child("prospectpark").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "prospectpark")
                self.prospectLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.prospectLabel.setTitleColor(color, for: .normal)
                
                let labelpl = self.prospectLabel
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
            }
            
        })
        
        handle = ref.child("williamsburg").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "williamsburg")
                self.williamsburgLabel.setTitle(item, for: .normal)
                //let color = self.tempColor(temp: item)
                //self.williamsburgLabel.setTitleColor(color, for: .normal)
                
                let labelpl = self.williamsburgLabel
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
                
            }
            
        })
        
        handle = ref.child("staten").child("temp").observe(.value, with: { (snapshot) in
            
            if var item = snapshot.value as? String
            {
                item = item + "°F"
                self.weatherStatDict.updateValue(item, forKey: "staten")
                self.statenLabel.setTitle(item, for: .normal)
                
                //let color = self.tempColor(temp: item)
                //self.statenLabel.setTitleColor(color, for: .normal)
                
                let labelpl = self.statenLabel
                labelpl?.layer.shadowColor = UIColor.black.cgColor
                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
                labelpl?.layer.shadowRadius = 10
                labelpl?.layer.shadowOpacity = 1.0
                
            }
            
        })
        
    }
    
    
    //    func observeWeatherC(){
    //
    //        ref = FIRDatabase.database().reference()
    //
    //
    //        handle = ref.child("upperwest").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //
    //                self.weatherStatDict.updateValue(item, forKey: "upperwest")
    //                let labelpl = self.uppwestLabel
    //                labelpl?.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //labelpl?.setTitleColor(color, for: .normal)
    //                //
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //
    //            }
    //
    //        })
    //
    //
    //
    //        handle = ref.child("lowermanh").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            let labelpl = self.lowermanhLabel
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "lowermanh")
    //                //print(self.weatherStatDict)
    //                labelpl?.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                               // labelpl?.setTitleColor(color, for: .normal)
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //            }
    //
    //        })
    //
    //        handle = ref.child("eastbronx").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "eastbronx")
    //                self.eastbronxLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.eastbronxLabel.setTitleColor(color, for: .normal)
    //                //                                self.eastbronxLabel.layer.shadowColor = color.cgColor
    //                //                                self.eastbronxLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                self.eastbronxLabel.layer.shadowRadius = 10
    //                //                                self.eastbronxLabel.layer.shadowOpacity = 1.0
    //
    //            }
    //
    //        })
    //
    //        handle = ref.child("flushings").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "flushings")
    //                self.flushingLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.flushingLabel.setTitleColor(color, for: .normal)
    //                //
    //                //                                let labelpl = self.flushingLabel
    //                //
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //            }
    //            self.ref.removeObserver(withHandle: self.handle)
    //        })
    //
    //
    //        handle = ref.child("astoria").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "astoria")
    //                self.astoriaLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.astoriaLabel.setTitleColor(color, for: .normal)
    //                //                                let labelpl = self.astoriaLabel
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //            }
    //
    //        })
    //
    //        handle = ref.child("jamaicaqueens").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "jamaicaqueens")
    //                self.jamaicaLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.jamaicaLabel.setTitleColor(color, for: .normal)
    //                //                                let labelpl = self.jamaicaLabel
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //            }
    //
    //        })
    //
    //
    //        handle = ref.child("brightonbeach").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "brightonbeach")
    //                self.brightonLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.brightonLabel.setTitleColor(color, for: .normal)
    //                //
    //                //                                let labelpl = self.brightonLabel
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //            }
    //
    //        })
    //
    //
    //        handle = ref.child("prospectpark").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "prospectpark")
    //                self.prospectLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.prospectLabel.setTitleColor(color, for: .normal)
    //                //
    //                //                                let labelpl = self.prospectLabel
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //            }
    //
    //        })
    //
    //        handle = ref.child("williamsburg").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "williamsburg")
    //                self.williamsburgLabel.setTitle(item, for: .normal)
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.williamsburgLabel.setTitleColor(color, for: .normal)
    //                //
    //                //                                let labelpl = self.williamsburgLabel
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //
    //            }
    //
    //        })
    //
    //        handle = ref.child("staten").child("tempc").observe(.value, with: { (snapshot) in
    //
    //            if let item = snapshot.value as? String
    //            {
    //                self.weatherStatDict.updateValue(item, forKey: "staten")
    //                self.statenLabel.setTitle(item, for: .normal)
    //                //
    //                //                                let color = self.tempColor(temp: item)
    //                //                                //self.statenLabel.setTitleColor(color, for: .normal)
    //                //
    //                //                                let labelpl = self.statenLabel
    //                //                                labelpl?.layer.shadowColor = color.cgColor
    //                //                                labelpl?.layer.shadowOffset = CGSize(width: 5, height: 5)
    //                //                                labelpl?.layer.shadowRadius = 10
    //                //                                labelpl?.layer.shadowOpacity = 1.0
    //
    //            }
    //
    //        })
    //    }
    
    
    func printFahr() {
        
        self.uppwestLabel.setTitle(weatherStatDict["upperwest"], for: .normal)
        self.lowermanhLabel.setTitle(weatherStatDict["lowermanh"], for: .normal)
        self.eastbronxLabel.setTitle(weatherStatDict["eastbronx"], for: .normal)
        self.astoriaLabel.setTitle(weatherStatDict["astoria"], for: .normal)
        self.flushingLabel.setTitle(weatherStatDict["flushings"], for: .normal)
        self.jamaicaLabel.setTitle(weatherStatDict["jamaicaqueens"], for: .normal)
        self.statenLabel.setTitle(weatherStatDict["staten"], for: .normal)
        self.prospectLabel.setTitle(weatherStatDict["prospectpark"], for: .normal)
        self.williamsburgLabel.setTitle(weatherStatDict["williamsburg"], for: .normal)
        self.brightonLabel.setTitle(weatherStatDict["brightonbeach"], for: .normal)
    }
    
    func printCel(){
        
        self.uppwestLabel.setTitle(String(Int((Double(weatherStatDict["upperwest"]!)! - 32) * 0.556)), for: .normal)
        self.lowermanhLabel.setTitle(String(Int((Double(weatherStatDict["lowermanh"]!)! - 32) * 0.556)), for: .normal)
        self.eastbronxLabel.setTitle(String(Int((Double(weatherStatDict["eastbronx"]!)! - 32) * 0.556)), for: .normal)
        self.astoriaLabel.setTitle(String(Int((Double(weatherStatDict["astoria"]!)! - 32) * 0.556)), for: .normal)
        self.flushingLabel.setTitle(String(Int((Double(weatherStatDict["flushings"]!)! - 32) * 0.556)), for: .normal)
        self.jamaicaLabel.setTitle(String(Int((Double(weatherStatDict["jamaicaqueens"]!)! - 32) * 0.556)), for: .normal)
        self.statenLabel.setTitle(String(Int((Double(weatherStatDict["staten"]!)! - 32) * 0.556)), for: .normal)
        self.prospectLabel.setTitle(String(Int((Double(weatherStatDict["prospectpark"]!)! - 32) * 0.556)), for: .normal)
        self.williamsburgLabel.setTitle(String(Int((Double(weatherStatDict["williamsburg"]!)! - 32) * 0.556)), for: .normal)
        self.brightonLabel.setTitle(String(Int((Double(weatherStatDict["brightonbeach"]!)! - 32) * 0.556)), for: .normal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nav = segue.destination as! UINavigationController
        let cvc = nav.topViewController as! ConditionsTableViewController
        cvc.borough = currentBorough;
        cvc.boroughTitle = currentTitle
        
        
        //        let forecastTable: ConditionsTableViewController = segue.destination as! ConditionsTableViewController
        //        forecastTable.borough = currentBorough
    }
    
}

