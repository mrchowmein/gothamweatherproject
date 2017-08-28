//
//  ConditionsTableViewController.swift
//  Gotham Weather Project
//
//  Created by Jason Chan MBP on 8/15/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit
import Firebase
import SystemConfiguration

class ConditionsTableViewController: UITableViewController {
    
    var ref: FIRDatabaseReference?
    var handle: FIRDatabaseHandle?
    
    @IBAction func fCSwitch(_ sender: UISwitch) {
        
        if (sender.isOn) == true {
            self.cond1.text = "High: " + condDictH["1"]! + "  Low: " + condDictL["1"]!
            self.cond2.text = "High: " + condDictH["2"]! + "  Low: " + condDictL["2"]!
            self.cond3.text = "High: " + condDictH["3"]! + "  Low: " + condDictL["3"]!
            self.cond4.text = "High: " + condDictH["4"]! + "  Low: " + condDictL["4"]!
            self.currentTemp.text = String(Int(Double(currentTempF)!)) + "°F"
            
        } else {
            
            self.currentTemp.text = String(Int((Double(currentTempF)!-32) * 0.556)) + "°C"
            
            var condDictLC: [String: String] = [
                "1": "",
                "2": "",
                "3": "",
                "4": "",
                ]
            
            var condDictHC: [String: String] = [
                "1": "",
                "2": "",
                "3": "",
                "4": "",
                ]
            
            for (key, value) in condDictH {
                let newval = String(Int((Double(value)! - 32) * 0.556))
                condDictHC.updateValue(newval, forKey: key)
            }
            
            for (key, value) in condDictL {
                let newval = String(Int((Double(value)! - 32) * 0.556))
                condDictLC.updateValue(newval, forKey: key)
            }
            
            self.cond1.text = "High: " + condDictHC["1"]! + "  Low: " + condDictLC["1"]!
            self.cond2.text = "High: " + condDictHC["2"]! + "  Low: " + condDictLC["2"]!
            self.cond3.text = "High: " + condDictHC["3"]! + "  Low: " + condDictLC["3"]!
            self.cond4.text = "High: " + condDictHC["4"]! + "  Low: " + condDictLC["4"]!
        }
        
        
    }
    
    
    @IBOutlet weak var timeStamp: UILabel!
    
    var borough = ""
    var boroughTitle = ""
    
    var daynameDict: [String:String] = [
        "1": "",
        "2": "",
        "3": "",
        "4": "",
        
        ]
    
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
        "staten" : "",
        "test" : "",
        
        ]
    
    var condDictH: [String: String] = [
        "1": "",
        "2": "",
        "3": "",
        "4": "",
        ]
    
    var condDictL: [String: String] = [
        "1": "",
        "2": "",
        "3": "",
        "4": "",
        ]
    
    var gifURL: [String: String] = [
        "1": "",
        "2": "",
        "3": "",
        "4": "",
        ]
    
    var currentTempF = ""
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        //self.present(UIViewController(), animated: true, completion: nil)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    var currentURL = ""
    
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var conditionsLabel: UILabel!
    
    @IBOutlet weak var t1: UILabel!
    @IBOutlet weak var t2: UILabel!
    @IBOutlet weak var t3: UILabel!
    @IBOutlet weak var t4: UILabel!
    
    
    @IBOutlet weak var cond1: UILabel!
    @IBOutlet weak var cond2: UILabel!
    @IBOutlet weak var cond3: UILabel!
    @IBOutlet weak var cond4: UILabel!
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var imgC: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = boroughTitle
        print(borough)
        
        ref = FIRDatabase.database().reference()
        
        
        
            
            
            handle = ref?.child(borough).child("temp").observe(.value, with: { (snapshot) in
                
                if let item = snapshot.value as? String
                {
                    
                    self.currentTempF = item
                
                }
                
            })
        
        handle = ref?.child(borough).child("humidity").observe(.value, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                let humid = item
                self.humidLabel.text = humid
            }
            
        })
        
        handle = ref?.child(borough).child("wind").observe(.value, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                let wind = item
                self.windLabel.text = wind
            }
            
        })
        
        handle = ref?.child(borough).child("weather").observe(.value, with: { (snapshot) in
            
            if let item = snapshot.value as? String
            {
                let condition = item
                self.conditionsLabel.text = condition
            }
            
        })
        
        
        
        
        
            handle = ref?.child(borough).child("curURL").observe(.value, with: { (snapshot) in
                
                if let item = snapshot.value as? String
                {
                    //print(item)
                    self.currentURL = item
                }
                
            })
            
            handle = ref?.child("time").child("time").observe(.value, with: { (snapshot) in
                
                if let item = snapshot.value as? String
                {
                    //print(item)
                    self.timeStamp.text = item
                }
                
            })
            
            for (key,value) in daynameDict {
                
                handle = ref?.child(borough).child(key).child("dayname").observe(.value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String
                    {
                        self.daynameDict.updateValue(item, forKey: key)
                    }
                    
                })
            }
            
            for (key,value) in condDictH {
                
                handle = ref?.child(borough).child(key).child("high").observe(.value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String
                    {
                        self.condDictH.updateValue(item, forKey: key)
                    }
                    
                })
            }
            
            for (key,value) in condDictL {
                
                handle = ref?.child(borough).child(key).child("low").observe(.value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String
                    {
                        self.condDictL.updateValue(item, forKey: key)
                    }
                    
                })
            }
            
            for (key,value) in gifURL {
                
                handle = ref?.child(borough).child(key).child("url").observe(.value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String
                    {
                        
                        self.gifURL.updateValue(item, forKey: key)
                    }
                    
                })
            }
            
        
        //print(weatherStatDict)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let connection = isInternetAvailable()

        
        if connection == true{
            
            //check if weather URL is present
            if gifURL["1"] == "" {
                print("error loading image")
                self.currentTemp.text = "Connection error. Try again."
                self.timeStamp.text = " "
                timeStamp.textColor = .red
                currentTemp.textColor = .red
                
            } else {
                
                //display current temp
                self.currentTemp.text = String(Int(Double(currentTempF)!)) + "°F"
                
                //display day
                self.t1.text = daynameDict["1"]
                self.t2.text = daynameDict["2"]
                self.t3.text = daynameDict["3"]
                self.t4.text = daynameDict["4"]
                
                //display high and low temps
                self.cond1.text = "High: " + condDictH["1"]! + "  Low: " + condDictL["1"]!
                self.cond2.text = "High: " + condDictH["2"]! + "  Low: " + condDictL["2"]!
                self.cond3.text = "High: " + condDictH["3"]! + "  Low: " + condDictL["3"]!
                self.cond4.text = "High: " + condDictH["4"]! + "  Low: " + condDictL["4"]!
                
                
                //display weather image
                let url1 = URL(string: gifURL["1"]!)
                let data1 = try? Data(contentsOf: url1!)
                img1.image = UIImage(data: data1!)
                
                let url2 = URL(string: gifURL["2"]!)
                let data2 = try? Data(contentsOf: url2!)
                img2.image = UIImage(data: data2!)
                
                let url3 = URL(string: gifURL["3"]!)
                let data3 = try? Data(contentsOf: url3!)
                img3.image = UIImage(data: data3!)
                
                let url4 = URL(string: gifURL["4"]!)
                let data4 = try? Data(contentsOf: url4!)
                img4.image = UIImage(data: data4!)
                
                //print(currentURL)
                let urlC = URL(string: currentURL)
                let dataC = try? Data(contentsOf: urlC!)
                imgC.image = UIImage(data: dataC!)
            }
        } else {
            noConnection()
        }
        
        
    }
    
    
    
    func noConnection(){
        
        let alertController = UIAlertController(title: "Error", message: "No Data Connection", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}
