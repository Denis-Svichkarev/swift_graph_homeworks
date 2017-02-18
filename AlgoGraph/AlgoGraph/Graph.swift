//
//  Graph.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

class Graph {

    private var n = 0
    private var m = 0
    
    private var fileName : String?
    
    var adjList = Array<Array<Int>>()
    
    var verticesCount:  Int { return n }
    var edgesCount:     Int { return m }
    var getFileName:    String { return fileName ?? "null" }
    
    
    func initWithFileName(_ name: String) {
        fileName = name
        
        let text = getStringFromFilePath(name)
        
        if let stringsArray = text {
            
            if stringsArray.lines.count > 0 {
                for _ in 1..<stringsArray.lines.count {
                    adjList.append(Array())
                }
            }
            
            for i in 0..<stringsArray.lines.count {
                
                if i == 0 {
                    n = Int(stringsArray.lines[i]) ?? 0
                } else {
                    m += 1
                    
                    let components = stringsArray.lines[i].components(separatedBy: " ")
                    
                    let a = components[0]
                    let b = components[1]
                    
                    if let int_a = Int(a), let int_b = Int(b) {
                        adjList[int_a - 1].append(int_b)
                        if int_a == int_b {
                            continue
                        }
                        adjList[int_b - 1].append(int_a)
                    }
                }
            }
        }
    }
    
    func printAdjList() {
        
        if n == 0 {
            print("Graph hasn't adjacent vertices")
            return
        }
        
        print("List of adjacent vertices:")
        
        for i in 0..<n {
            print("\nVertex \(i + 1) :", terminator:" ")
            
            for item in adjList[i] {
                print("\(item)", terminator:" ")
            }
        }
    }
}
