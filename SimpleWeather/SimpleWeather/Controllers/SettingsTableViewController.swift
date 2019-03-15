//
//  SettingsTableViewController.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 10/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func settingsDone(viewModel: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {

    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Outlet Actions
    
    @IBAction func doneButtonPressed() {
        if let delegate = self.delegate {
            delegate.settingsDone(viewModel: self.settingsViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        let settingsItem = self.settingsViewModel.units[indexPath.row]
        cell.textLabel?.text = settingsItem.displayName
        
        if settingsItem == self.settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Uncheck all cells first.
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            self.settingsViewModel.selectedUnit = Unit.allCases[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
