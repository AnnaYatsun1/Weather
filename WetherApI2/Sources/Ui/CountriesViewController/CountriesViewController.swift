//
//  CountriesViewController.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, ModelDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private(set) var countriesManager = NetworkManager()
    private var observer: Cancellable?
    
    private let newModel = ArrayModel(values: [Country]())
    
    private var table: UITableView? {
        return self.rootView?.table
    }
    
    func update() {
        DispatchQueue.main.async {
            self.table?.reloadData()
        } 
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observer = self.newModel.observer { state, object in
            switch state {
            case .updateFinished: self.update()
            case .updateCancelled: return
            case .updateFailed: return
            case .updateStarted: return
            }
        }
        
        self.table?.register(CityCellTableViewCell.self)
        self.countriesManager.loadCountries() { 
            self.newModel.update(values: $0)
            print("capital \($0.count)")
        }
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newModel.values.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(cellClass: CityCellTableViewCell.self, for: indexPath) {
            $0.fill(country: self.newModel.values.value[indexPath.row].value)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let city = self.newModel.values.value[indexPath.row]
        let weatherViewController = WeatherViewController(city: city)
        
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
