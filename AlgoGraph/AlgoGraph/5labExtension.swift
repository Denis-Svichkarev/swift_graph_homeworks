//
//  5labExtension.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 16/05/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

extension WeightedGraph {
    
    // MARK: - 1 Task
    
    func fordWithStack(s: Int) {
        
        dist[s] = 0;
        var bag = Array<Int>()
        
        bag.append(s)
        
        while (!bag.isEmpty) {
            let u = bag.last
            bag.removeLast()
            
            for x in adjWList[u!] {
                let v = x.0 - 1
                let w = x.1 - 1
                
                print("u: \(u!), v: \(v)")
                
                if dist[u!] + w < dist[v] {
                    dist[v] = dist[u!] + w
                    pred[v] = u!
                    bag.append(v)
                }
            }
        }
    }

    // MARK: - 2 Task
    
    func fordWithQueue() {
        
        
    }
    
    // MARK: - 3 Task
    
    func fordWithPriorityQueue() {
        
        
    }
    
    // MARK: - Helpers
    
    func printSPT() {
    
        print("Дерево кратчайших путей: ")
    
        for v in 0..<vertices.count {
            print("\(dist[v]) : \(v)")
            
            var x = v
            
            while pred[x] >= 0 {
                print("<- \(pred[x])", terminator: "")
                x = pred[x]
            }
            
            print("")
        }
    }
}
