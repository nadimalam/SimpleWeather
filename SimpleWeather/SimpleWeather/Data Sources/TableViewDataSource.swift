//
//  TableViewDataSource.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 20/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource where CellType: UITableViewCell {

    let cellIdentifier: String
    var items: [ViewModel]
    let emptyTableViewMessage: String
    let configureCell: (CellType, ViewModel) -> ()
    
    init(cellIdentifier: String, items: [ViewModel], emptyTableViewMessage: String, configureCell: @escaping (CellType, ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.emptyTableViewMessage = emptyTableViewMessage
        self.configureCell = configureCell
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setEmptyMessage(for: tableView)
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier,
                                                       for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found.")
        }
        let viewModel = self.items[indexPath.row]
        self.configureCell(cell, viewModel)
        return cell
    }
 
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
    
    func setEmptyMessage(for tableView: UITableView) {
        self.items.count == 0 ?
            tableView.setEmptyMessage(self.emptyTableViewMessage) :
            tableView.restore()
    }
}
