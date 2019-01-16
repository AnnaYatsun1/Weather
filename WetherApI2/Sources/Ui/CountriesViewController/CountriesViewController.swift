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
    
    public var model = ModelManager.shared
    private(set) var country = Countries()
    
    func update() {
        DispatchQueue.main.async {
            self.rootView?.table?.reloadData()
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.rootView?.table?.register(CityCellCollectionViewCell.self)
        country.persingCountryAPI()
        self.model.observer { state, object in
            if state == .needToUpdate {
                self.update()
           }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.update()
    }
    
}


extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.model.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCellClass: CityCellCollectionViewCell.self) as! CityCellCollectionViewCell
        cell.fill(country: self.model.countries[indexPath.row])
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withCellClass: CityCellCollectionViewCell.self)
        
        return cell?.height ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weatherVC = WeatherViewController()
        weatherVC.capital = self.model.countries[indexPath.row].capital
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
}
