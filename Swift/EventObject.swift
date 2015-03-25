//
//  EventObject.swift
//  NDUtilities
//
//  Created by Lars Gerckens on 25.03.15.
//
//

import Foundation

protocol TargetAction
{
    func performAction()
}

struct TargetActionWrapper<T: AnyObject> : TargetAction
{
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction()
    {
        if let t = target
        {
            // An instance method in Swift is just a type method that takes the instance as an argument 
            // and returns a function which will then be applied to the instance.
            action(t)()
        }
    }
}

class EventObject : NSObject
{
    var actions = [UInt : [TargetAction]]()
    
    override init()
    {

    }
    
    func setTarget<T: AnyObject>(target: T, action: (T) -> () -> (), controlEvent: UInt)
    {
        if(actions[controlEvent] == nil)
        {
            actions[controlEvent] = [TargetAction]()
        }
        
        actions[controlEvent]!.append(TargetActionWrapper(target: target, action: action))
    }
    
    func removeTargetForControlEvent(controlEvent: UInt)
    {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: UInt)
    {
        if let a = actions[controlEvent]
        {
            for(var i = 0; i < a.count; i++)
            {
                a[i].performAction()
            }
        }
    }
}