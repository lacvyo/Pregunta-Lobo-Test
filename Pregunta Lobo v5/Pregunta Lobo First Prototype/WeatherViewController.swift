//
//  WeatherViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 12/19/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // accesando el weather
        
        let url = URL(string: "http://www.accuweather.com/es/pr/arecibo/00612/weather-forecast/2123")
        
        if url != nil {
            
            let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                var weather = ""
                
                if error == nil {
                    
                    let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as NSString!
                    
                    var urlContentArray = urlContent?.components(separatedBy: "<span class=\"cond\">")
                    
                    var urlContentArray2 = urlContent?.components(separatedBy: "<span class=\"temp\">")
                    
                    if (urlContentArray?.count)! > 0 {
                        
                        var weatherArray = urlContentArray?[1].components(separatedBy: "</span>")
                        
                        var weatherArray2 = urlContentArray2?[1].components(separatedBy: "</span>")
                        
                        //Casting a double para convertir de Celcius a Fahrenheit.
                        
                        weatherArray2?[0] = (weatherArray2?[0].replacingOccurrences(of: "[e\\a\\b\\c\\d\\f\\g\\&\\;]", with: "", options: .regularExpression))!
                        
                        var doubleTemp = Int((weatherArray2?[0])!)
                        //print(doubleTemp)
                        doubleTemp = self.celciusToFahrenheit(doubleTemp!)
                        //let tempInt = Int(doubleTemp!)
                        //let tempString = String(describing: tempInt)
                        print(doubleTemp!)
                        //print(weatherArray?[0])
                        
                       // print((weatherArray2?[0])!)
                        weather = "\n" + (weatherArray?[0])! + "\n" + String(doubleTemp!) 	+ "ºF"
                        //weather = "\n" + (weatherArray?[0])! + "\n" + tempString + "ºF"
                        
                    } else {
                        
                        urlError = true
                        
                    }
                    
                    
                    
                } else {
                    
                    urlError = true
                    
                }
                
                DispatchQueue.main.async {
                    
                    if urlError == true {
                        
                        self.showError()
                        
                    } else {
                        
                        self.weatherTextView.text = weather
                        
                    }
                }
                
            })
            
            task.resume()
            
            
        } else {
            
            showError()
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showError() {
        
        weatherTextView.text = "El clima no puede ser presentado. Verifique su conexión a Internet."
    }
    
    //Conversion de Celcius a Fahrenheit.
    func celciusToFahrenheit(_ celciusTemp: Int) -> Int
    {
        var calculating = celciusTemp*9
        calculating = calculating/5
        calculating += 32
        
        let result = Int(calculating)
        
        return result
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
