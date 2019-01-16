//
// 
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

extension CGRect {
    
    public enum Position {
        case topLeft
        case bottomLeft
        case bottomRight
        case topRight
        case middleLeft
        case middleRight
        case middleTop
        case middleBottom
        case center
    }

    public func point(at position: Position) -> CGPoint {
        switch position {
        case .topLeft: return self.topLeft
        case .bottomLeft: return self.bottomLeft
        case .bottomRight: return self.bottomRight
        case .topRight: return self.topRight

        case .middleLeft: return self.middleLeft
        case .middleRight: return self.middleRight
        case .middleTop: return self.middleTop
        case .middleBottom: return self.middleBottom

        case .center: return self.center
        }
    }

    public func arrayRepresentation() -> [CGPoint] {
        let minX = self.x
        let minY = self.y
        let maxX = minX + self.width
        let maxY = minY + self.height

        return [
            CGPoint(minX, minY),  //  topLeft
            CGPoint(minX, maxY),  //  bottomLeft
            CGPoint(maxX, maxY),  //  bottomRight
            CGPoint(maxX, minY)   //  topRight
        ]
    }
    
    public var x: CGFloat {
        get { return self.origin.x }
        set { self.origin.x = newValue }
    }
    
    public var y: CGFloat {
        get { return self.origin.y }
        set { self.origin.y = newValue }
    }
    
    public var width: CGFloat {
        get { return self.size.width }
        set { self.size.width = newValue }
    }
    
    public var height: CGFloat {
        get { return self.size.height }
        set { self.size.height = newValue }
    }

    //  animatable
    public var topLeft: CGPoint {
        get { return CGPoint(x: self.minX, y: self.minY) }
        set { self.origin = newValue }
    }

    //  animatable
    public var topRight: CGPoint {
        get { return CGPoint(x: self.maxX, y: self.minY) }
        set { self.origin = newValue - CGPoint(x: self.width, y: 0) }
    }

    //  animatable
    public var bottomLeft: CGPoint {
        get { return CGPoint(x: self.minX, y: self.maxY) }
        set { self.origin = newValue - CGPoint(x: 0, y: self.height) }
    }

    //  animatable
    public var bottomRight: CGPoint {
        get { return CGPoint(x: self.maxX, y: self.maxY) }
        set { self.origin = newValue - CGPoint(x: self.width, y: self.height) }
    }
    
    public var middleLeft: CGPoint {
        return CGPoint(x: self.minX, y: self.midY)
    }
    
    public var middleRight: CGPoint {
        return CGPoint(x: self.maxX, y: self.midY)
    }
    
    public var middleTop: CGPoint {
        return CGPoint(x: self.midX, y: self.minY)
    }
    
    public var middleBottom: CGPoint {
        return CGPoint(x: self.midX, y: self.maxY)
    }
    
    public var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

