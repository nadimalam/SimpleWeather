//
//  WeatherDetailViewController.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 18/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModalBindings()
    }
    
    private func setupViewModalBindings() {
        if let weatherViewModel = self.weatherViewModel {
            weatherViewModel.name.bind { self.cityNameLabel.text = $0 }
            weatherViewModel.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = $0.formatAsDegree }
            weatherViewModel.currentTemperature.temperatureMin.bind { self.minTempLabel.text = $0.formatAsDegree }
            weatherViewModel.currentTemperature.temperatureMax.bind { self.maxTempLabel.text = $0.formatAsDegree }
        }
    }
}
