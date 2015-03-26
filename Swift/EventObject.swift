//
//  EventObject.swift
//  NDUtilities
//
//  Created by Lars Gerckens on 25.03.15.
//
//  Adopted from: http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/

import Foundation

protocol TargetAction
{
    func performAction(targetRef : AnyObject)
}

struct TargetActionWrapper<T: AnyObject where T: Equatable> : TargetAction
{
    weak var target: T?
    let action: (T) -> (AnyObject) -> ()
    
    func performAction(targetRef : AnyObject)
    {
        if let t = target
        {
            // An instance method in Swift is just a type method that takes the instance as an argument 
            // and returns a function which will then be applied to the instance.
            action(t)(targetRef)
        }
    }
}

class EventObject : NSObject
{
    private var actions = [UInt : [TargetAction]]()
    
    func addTarget<T: AnyObject where T: Equatable>(target: T, action: (T) -> (AnyObject) -> (), controlEvent: UInt)
    {
        if(actions[controlEvent] == nil)
        {
            actions[controlEvent] = [TargetAction]()
        }
        
        actions[controlEvent]!.append(TargetActionWrapper(target: target, action: action))
    }
    
    func removeTargetForControlEvent<T: AnyObject where T: Equatable>(target: T, controlEvent: UInt)
    {
        if var a = actions[controlEvent]
        {
            for(var i = 0; i < a.count; i++)
            {
                let wrapper = a[i] as TargetActionWrapper<T>
                if(wrapper.target == target)
                {
                    actions[controlEvent]!.removeAtIndex(i)
                    return
                }
            }
        }
    }
    
    func performActionForControlEvent(controlEvent: UInt)
    {
        if let a = actions[controlEvent]
        {
            for(var i = 0; i < a.count; i++)
            {
                a[i].performAction(self)
            }
        }
    }
}