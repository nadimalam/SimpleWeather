//
//  SettingsViewModelTests.swift
//  SimpleWeatherTests
//
//  Created by Nadim Alam on 20/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import XCTest
@testable import SimpleWeather

class SettingsViewModelTests: XCTestCase {

    private var settingsVM: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        self.settingsVM = SettingsViewModel()
    }

    func testShouldReturnCorrectDisplayNameForCelcius() {
        XCTAssertEqual(settingsVM.selectedUnit.displayName, "Celsius")
    }
    
    func testShouldMakeSureThatDefaultSelectedUnitIsCelcius() {
        XCTAssertEqual(settingsVM.selectedUnit, .celsius)
    }
    
    func testShouldBeAbleToSaveUserUnitSelection() {
        self.settingsVM.selectedUnit = .fahrenheit
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey:"unit"))
    }
    
    override func tearDown() {
        super.tearDown()
        // Cleanup
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }
}
