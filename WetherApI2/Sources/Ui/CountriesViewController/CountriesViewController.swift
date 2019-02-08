//
//  CountriesViewController.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    public var countriesManager: CountriesNetworkService
    public var weatherManager: WeatherNetworkService
    private var observer = CancellableObject()
    private var indexPath: IndexPath?
    
    private let model = ArrayModel(values: [Country]())
    
    private var table: UITableView? {
        return self.rootView?.table
    }
    
    func update() {
        DispatchQueue.main.async {
            self.table?.reloadData()
        } 
    }

    init(countriesManager: CountriesNetworkService, weatherManager: WeatherNetworkService) {
      
        self.countriesManager = countriesManager
        self.weatherManager = weatherManager
        super.init(nibName: nil, bundle: nil)
        self.observer.value = self.model.observer { state in 
            switch state {
            case .add: 
                self.update()
            case .remove: break
            case .update: self.reload()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table?.register(CityCellTableViewCell.self)
        self.countriesManager.getCountries(self.model)
    }
    
    func reload() {
        if let indexPath = self.indexPath {
            self.table?.reloadRows(at: [indexPath], with: .none)
        } else {
            self.update()
        }
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(cellClass: CityCellTableViewCell.self, for: indexPath) {
            $0.fill(country: self.model[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = self.model[indexPath.row]
        let weatherViewController = WeatherViewController(city: country, wetherManeger: weatherManager )
        country.observer { _ in
            dispatchOnMain {
                self.table?.reloadRows(at: [indexPath], with: .top)
            }
        }

        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
