//
//  WeatherDataSource.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 19/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    let cellIdentifier: String = "WeatherCell"
    private var weatherListViewModel: WeatherListViewModel
    
    init(_ weatherListViewModel: WeatherListViewModel) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    // MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setEmptyMessage(for: tableView)
        return self.weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WeatherCell else {
            fatalError("\(self.cellIdentifier) Not Found!")
        }
        let weatherViewModel = self.weatherListViewModel.modelAt(indexPath.row)        
        weatherViewModel.name.bind { cell.cityNameLabel.text = $0 }
        weatherViewModel.currentTemperature.temperature.bind { cell.temperatureLabel.text = $0.formatAsDegree }
        return cell
    }
    
    func setEmptyMessage(for tableView: UITableView) {
        self.weatherListViewModel.weatherViewModels.count == 0 ?
            tableView.setEmptyMessage("No locations have been added. \nPlease use +\n to add a new city.") :
            tableView.restore()
    }
}

// MARK:- UITableViewDelegate
extension WeatherDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
