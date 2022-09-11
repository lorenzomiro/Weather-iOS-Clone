//
//  ViewController.swift
//  Weather
//
//  Created by Miro on 9/9/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    let APIKey = "837ef64c2e610070cde57cf9f1a408b5"
    
    //set location to Las Vegas coordinates (for testing purposes)
    
    var lat = 36.1716
    
    var long = 115.1391
    
    //get loading bar
    
    var activityIndicator: NVActivityIndicatorView!
    
    // get location features
    
    var locationManager = CLLocationManager()
    
    
    
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.addSublayer(gradientLayer)
        
        let indicatorSize: CGFloat = 80
        
        let indicatorFrame = CGRect(x:(view.frame.width - indicatorSize)/2, y:(view.frame.height - indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        
        activityIndicator.backgroundColor = UIColor.black
        
        view.addSubview(activityIndicator)
    
        activityIndicator.startAnimating()

        if (CLLocationManager.locationServicesEnabled()) { //update location
            
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            locationManager.startUpdatingLocation()
            
            
            
        }
        
//        activityIndicator.stopAnimating()
        
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setGreyGradientBackground()
        
    }
    
    //checks for updated location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        lat = location.coordinate.latitude
        
        long = location.coordinate.longitude
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(APIKey)&units=imperial").responseJSON { response in self.activityIndicator.stopAnimating() 
            
            if let responseStr = response.result.value {
                
                let jsonResponse = JSON(data: responseStr)
                
                let jsonWeather = jsonResponse["weather"].array![0]
                
                let jsonTemp = jsonResponse["main"]
                
                let iconName = jsonWeather["icon"].stringValue
                
            }
            
            
            
        }
        
    }
    
    func setBlueGradientBackground() {
        
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [topColor, bottomColor]
        
    }
    
    func setGreyGradientBackground() {
        
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [topColor, bottomColor]
        
        
    }


}

