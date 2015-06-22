//
//  LRUCache.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 6/16/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import Foundation

private class LRUCacheNode<Key: Hashable, Value> {
    let key: Key
    var value: Value
    var previous: LRUCacheNode?
    var next: LRUCacheNode?
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

class LRUCache<T:Hashable, S> {
    private var _head:LRUCacheNode<T, S>!
    private var _tail:LRUCacheNode<T, S>!
    private var _capacity:Int
    private var _currentCount = 0
    
//    subscript (key: Key) -> Value? {
//        get {
//            return get(key)
//        }
//        set(newValue) {
//            add(key, newValue)
//        }
//    }
    init(capacity:Int) {
        _capacity = capacity
    }
    subscript (key:T) -> S! {
        get {
            return get(key)
        }
        set(newValue) {
            add(key, value: newValue)
        }
    }
    func add(key:T, value:S) -> (T, S)!
    {
        let n = LRUCacheNode(key: key, value: value)
        if (_head == nil)
        {
            _head = n
            _tail = n
            _currentCount = 1
        }
        else
        {
            n.next = _head
            n.previous = nil
            _head.previous = n
            _head = n
            
//            dump()
            
            ++_currentCount
            if (_currentCount > _capacity)
            {
                let del = _tail
                _tail = _tail.previous
                _tail.next = nil
                --_currentCount
                return (del.key, del.value)
            }
        }
        return nil
    }
    func dump()
    {
        var n = _head
        
        while (n != nil)
        {
            print("[prev : \(n.previous?.key), cur:\(n.key), next:\(n.key)]->")
            n = n.next
        }
        println()
    }

    func get(key:T) -> S!
    {
        var cur = _head
        
        while (cur != nil)
        {
            if (cur.key == key)
            {
//                if (cur.next == nil)
//                {
//                    _tail = cur.previous
//                }
//                cur.previous?.next = cur.next
//                cur.next?.previous = cur.previous
//                
//                cur.next = _head
//                _head.previous = cur
//                cur.previous = nil
                
//                if (_currentCount > _capacity) {
//                    _tail = _tail.previous
//                    _tail.next = nil
//                    --_currentCount
//                }
                bringToFront(cur)
                return cur.value
            }
            
            cur = cur.next
        }
        return nil
    }
    private func bringToFront(n:LRUCacheNode<T, S>)
    {
        if (_head === n)
        {
            return
        }
        n.previous?.next = n.next
        n.next?.previous = n.previous
        
        if (n.next == nil)
        {
            _tail = n.previous
            _tail.next = nil
        }
        n.previous = nil
        n.next = _head
        
        _head.previous = n
        _head = n
    }
    
    
}