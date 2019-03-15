//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 09/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

class WeatherListTableViewController: UITableViewController {

    private var weatherListViewModel = WeatherListViewModel()
    private var dataSource: TableViewDataSource<WeatherCell,WeatherViewModel>!
    private let cellIdentifier: String = "WeatherCell"
    private var lastUnitSelection :Unit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configureDataSource()
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    func configureDataSource() {
        let emptyTableViewMessage = "No locations have been added. \nPlease use +\n to add a new city."
        self.dataSource = TableViewDataSource(cellIdentifier: cellIdentifier,
                                              items: self.weatherListViewModel.weatherViewModels,
                                              emptyTableViewMessage: emptyTableViewMessage) { cell, viewModel in
            viewModel.name.bind { cell.cityNameLabel.text = $0 }
            viewModel.currentTemperature.temperature.bind { cell.temperatureLabel.text = $0.formatAsDegree }
        }
    }

    // MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSegueForAddWeatherCityViewController(segue)
        } else if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingsTableViewController(segue)
        } else if segue.identifier == "WeatherDetailViewController" {
            prepareSegueForWeatherDetailViewController(segue)
        }
    }
    
    private func prepareSegueForAddWeatherCityViewController(_ segue: UIStoryboardSegue) {
        guard let navViewController = segue.destination as? UINavigationController,
              let addWeatherCityViewController = navViewController.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("View Controller Not Found!")
        }
        addWeatherCityViewController.delegate = self
    }
    
    private func prepareSegueForSettingsTableViewController(_ segue: UIStoryboardSegue) {
        guard let navViewController = segue.destination as? UINavigationController,
              let settingsTableViewController = navViewController.viewControllers.first as? SettingsTableViewController else {
                fatalError("View Controller Not Found!")
        }
        settingsTableViewController.delegate = self
    }
    
    private func prepareSegueForWeatherDetailViewController(_ segue: UIStoryboardSegue) {
        guard let weatherDetailViewController = segue.destination as? WeatherDetailViewController,
              let indexPath = self.tableView.indexPathForSelectedRow else {
                fatalError("View Controller Not Found!")
        }
        let weatherViewModel = self.weatherListViewModel.modelAt(indexPath.row)
        weatherDetailViewController.weatherViewModel = weatherViewModel
    }
}

// MARK:- AddWeatherDelegate
extension WeatherListTableViewController: AddWeatherDelegate {
    func addWeatherDidSave(viewModel: WeatherViewModel) {
        self.weatherListViewModel.addWeatherViewModel(viewModel)
        self.dataSource.updateItems(self.weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }
}

// MARK:- SettingsDelegate
extension WeatherListTableViewController: SettingsDelegate {
    func settingsDone(viewModel: SettingsViewModel) {
        if self.lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue {
            self.weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
            self.tableView.reloadData()
            self.lastUnitSelection = Unit(rawValue: viewModel.selectedUnit.rawValue)!
        }
    }
}
