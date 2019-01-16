//
//  
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

extension CGPoint {

    public init (_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }

    public func with(x: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    public func with(y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    public func distance(_ point: CGPoint) -> CGFloat {
        let difference = self.difference(point)
        
        return hypot(difference.dx, difference.dy);
    }
    
    public func difference(_ point: CGPoint) -> CGVector {
        let startPoint = self
        let stopPoint = point
        
        return CGVector(dx: abs(startPoint.x - stopPoint.x), dy: abs(startPoint.y - stopPoint.y))
    }
    
    public func nearestPoint(to points: [CGPoint]) -> CGPoint {
        let point = self
        var result = CGPoint.zero
        
        let distances = points.map { point.distance($0) }
        distances.min().do {
            let index = distances.firstIndex(of: $0) ?? 0
            result = points[index]
        }
        
        return result
    }
    
    //  operators
    static public func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static public func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
    }
    
    static public func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
 
    static public func -= (left: inout CGPoint, right: CGPoint) {
        left = left - right
    }
}
