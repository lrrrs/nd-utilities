//
//  Helper.swift
//  Tyme
//
//  Created by Lars Gerckens on 18.12.14.
//  Copyright (c) 2014 nulldesign. All rights reserved.
//

#if os(iOS)

import UIKit
import Foundation
    
typealias PLATFORM_COLOR = UIColor
typealias PLATFORM_VIEW = UIView
  
#else
    
import Cocoa

typealias PLATFORM_COLOR = NSColor
typealias PLATFORM_VIEW = NSView
        
#endif

extension PLATFORM_COLOR
{
    convenience init(hexValue: Int, alpha: CGFloat = 1.0)
    {
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

enum LayoutHelperDirection {
    case TopLeft
    case TopCenter
    case TopRight
    case RightTop
    case RightCenter
    case RightBottom
    case BottomRight
    case BottomCenter
    case BottomLeft
    case LeftBottom
    case LeftCenter
    case LeftTop
}

extension PLATFORM_VIEW
{
    func x(newX:CGFloat) -> PLATFORM_VIEW
    {
        self.frame.origin.x = newX
        return self
    }
    
    func y(newY:CGFloat) -> PLATFORM_VIEW
    {
        self.frame.origin.y = newY
        return self
    }
    
    func moveByX(deltaX:CGFloat) -> PLATFORM_VIEW
    {
        self.frame.origin.x += deltaX
        return self
    }
    
    func moveByY(deltaY:CGFloat) -> PLATFORM_VIEW
    {
        self.frame.origin.y += deltaY
        return self
    }
    
    func width(newWidth:CGFloat) -> PLATFORM_VIEW
    {
        self.frame.size.width = newWidth
        return self
    }
    
    func height(newHeight:CGFloat) -> PLATFORM_VIEW
    {
        self.frame.size.height = newHeight
        return self
    }
    
    func placeUnder(otherView:PLATFORM_VIEW, gap:CGFloat = 0.0) -> PLATFORM_VIEW
    {
        self.frame.origin.x = otherView.frame.origin.x
        self.frame.origin.y = otherView.frame.origin.y + otherView.frame.size.height + gap
        return self
    }
    
    func placeAbove(otherView:PLATFORM_VIEW, gap:CGFloat = 0.0) -> PLATFORM_VIEW
    {
        self.frame.origin.x = otherView.frame.origin.x
        self.frame.origin.y = otherView.frame.origin.y - gap - self.frame.size.height
        return self
    }
    
    func placeRightOf(otherView:PLATFORM_VIEW, gap:CGFloat = 0.0) -> PLATFORM_VIEW
    {
        self.frame.origin.x = otherView.frame.origin.x + otherView.frame.size.width + gap
        self.frame.origin.y = otherView.frame.origin.y
        return self
    }

    func placeLeftOf(otherView:PLATFORM_VIEW, gap:CGFloat = 0.0) -> PLATFORM_VIEW
    {
        self.frame.origin.x = otherView.frame.origin.x - self.frame.size.width - gap
        self.frame.origin.y = otherView.frame.origin.y
        return self
    }
    
    func centerIn(otherView:PLATFORM_VIEW) -> PLATFORM_VIEW
    {
        self.frame.origin.x = otherView.frame.size.width * 0.5 - self.frame.size.width * 0.5
        self.frame.origin.y = otherView.frame.size.height * 0.5 - self.frame.size.height * 0.5
        return self
    }
    
    func alignWith(otherView:PLATFORM_VIEW, direction:LayoutHelperDirection, gap:CGFloat = 0.0) -> PLATFORM_VIEW
    {
        switch direction
        {
            case .TopLeft, .LeftTop:
                self.frame.origin.x = gap
                self.frame.origin.y = gap
            
            case .TopCenter:
                self.frame.origin.x = round(otherView.frame.size.width * 0.5 - self.frame.size.width * 0.5)
                self.frame.origin.y = gap
                
            case .TopRight, .RightTop:
                self.frame.origin.x = round(otherView.frame.size.width - self.frame.size.width - gap)
                self.frame.origin.y = gap
                
            case .RightCenter:
                self.frame.origin.x = round(otherView.frame.size.width - self.frame.size.width - gap)
                self.frame.origin.y = round(otherView.frame.size.height * 0.5 - self.frame.size.height * 0.5)
                
            case .RightBottom, .BottomRight:
                self.frame.origin.x = round(otherView.frame.size.width - self.frame.size.width - gap)
                self.frame.origin.y = round(otherView.frame.size.height - self.frame.size.height - gap)
                
            case .BottomCenter:
                self.frame.origin.x = round(otherView.frame.size.width * 0.5 - self.frame.size.width * 0.5)
                self.frame.origin.y = round(otherView.frame.size.height - self.frame.size.height - gap)
                
            case .BottomLeft, .LeftBottom:
                self.frame.origin.x = gap
                self.frame.origin.y = round(otherView.frame.size.height - self.frame.size.height - gap)
                
            case .LeftCenter:
                self.frame.origin.x = gap
                self.frame.origin.y = round(otherView.frame.size.height * 0.5 - self.frame.size.height * 0.5)
        }
        
        return self
    }
}
