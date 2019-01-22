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
    private(set) var country = Countries(values: [Country]())
    private(set) var countriesManager = CountriesManager()
    
    
    func update() {
        DispatchQueue.main.async {
            self.rootView?.table?.reloadData()
        } 
    }

    private var model = Countries(values: [Country]()) {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.table?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.table?.register(CityCellCollectionViewCell.self)
        
        self.countriesManager.parsCountries()
        self.countriesManager.completion = {
            self.model = Countries(values: $0)
            print(1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.update()
    }
}


extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCellClass: CityCellCollectionViewCell.self, for: indexPath)
        (cell as? CityCellCollectionViewCell).do {
            $0.fill(country: self.model.values[indexPath.row])
        }
        
        return cell
            
//        let date = self.model.values[indexPath.row]
//        let weater = date.weather.isSome
//        if weater {
//            let cell = tableView.dequeueReusableCell(withCellClass: CityCellCollectionViewCell.self, for: indexPath)
//            (cell as? CityCellCollectionViewCell).do {
//                $0.fill(country: self.model.values[indexPath.row])
//            }
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withCellClass: CityCellCollectionViewCell.self, for: indexPath)
//            (cell as? CityCellCollectionViewCell).do {
//                $0.fill(country: self.model.values[indexPath.row])
//            }
//            return cell
//        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withCellClass: CityCellCollectionViewCell.self)
        
        return cell?.height ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weatherVC = WeatherViewController()
        weatherVC.city = self.model.values[indexPath.row].capital!
        self.navigationController?.pushViewController(weatherVC, animated: true)
        
    }
}
