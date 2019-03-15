//
//  AddWeatherCityViewController.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 09/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(viewModel: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind { self.addCityViewModel.city = $0 }
        }
    }
    
    var delegate: AddWeatherDelegate?
    
    @IBAction func addCityButtonPressed() {
        
        if let enteredCity = cityNameTextField.text,
           let unit = UserDefaults.standard.value(forKey: "unit") as? String {
            
            // Remove any leading or trailing spaces that were entered accidently.
            let cityTrimmed = enteredCity.removeLeadingTrailingSpaces()
            // Handle cities that have spaces in there names.
            let city = cityTrimmed.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            
            let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=72f5c5e926920c651f158f00ad3f97f1&units=\(unit)"
            
            // Create the weather url.
            let weatherURL = URL(string: urlString)!
            
            // Create the weather resource.
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                let weatherViewModel = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherViewModel
            }
            
            WebService().load(resource: weatherResource) { [weak self] result in
                if let weatherViewModel = result {
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(viewModel: weatherViewModel)
                        self?.CancelButtonPressed()
                    }
                }
            }
        }
    }
    
    @IBAction func CancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
