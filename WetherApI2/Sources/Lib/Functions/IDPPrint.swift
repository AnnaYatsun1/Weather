//
//  IDPPrint.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 11/02/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

func debugPrint(_ value: String) {
    print("-------------------------------------------------")
    print(value)
    print("-------------------------------------------------")
}

func debugPrint(_ value: String?) {
    value.do {
        print("-------------------------------------------------")
        print($0)
        print("-------------------------------------------------")
    }
}
