//
//  Result.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 21/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case sucess(Value)
    case failure(Error)
}
