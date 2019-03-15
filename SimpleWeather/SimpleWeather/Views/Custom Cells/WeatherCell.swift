//
//  WeatherCell.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 09/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    func configure(_ viewModel: WeatherViewModel) {
        self.cityNameLabel.text = viewModel.name.value
        self.temperatureLabel.text = "\(viewModel.currentTemperature.temperature.value.formatAsDegree)"
    }
}
