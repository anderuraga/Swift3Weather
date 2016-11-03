//
//  ViewController.swift
//  Swift3Weather
//
//  Created by Spot Matic SL on 02/11/16.
//  Copyright © 2016 Spot Matic SL. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let API_KEY = "dfdcb5237e36145b21f5bf09b2453f77"

    @IBOutlet var temperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        /********************************************************************************************
         
         Si vamos a usar conexiones NO seguras HTTP(S)
         Tenemos que habilitar una opcion de configuración
         
         NSAllowsArbitraryLoads key to YES under NSAppTransportSecurity
 
        *********************************************************************************************/
 
        let stringUrl = "http://api.openweathermap.org/data/2.5/weather?q=Bilbao&appid=\(self.API_KEY)"
        let url = URL(string: stringUrl )!
            
            NSLog("callBackOffice: \(url)")
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    
                    do {
                        if let json =
                            try JSONSerialization.jsonObject( with: data!, options: .allowFragments ) as? [String: Any] {
                            print(json)
                            
                            if let main = json["main"] as? [String: Any] {
                                if let temp = main["temp"] as? Float {
                                    
                                    /* Para refrescar las vistas hay que usar un tarea asincrona*/
                                    DispatchQueue.main.async {
                                            self.temperature.text = String(temp)
                                    }
                                    /* refrescar vista */
                                    
                                    
                                }
                            }
                            
                        }else{
                            NSLog ("Error JSONSerialization")
                        }
                        
                    } catch let error as NSError {
                        NSLog("Error \(error): \(error.userInfo) ")
                    }
                    
                }//else
            })
            task.resume()
       
    }//end:viewWillAppear

}

