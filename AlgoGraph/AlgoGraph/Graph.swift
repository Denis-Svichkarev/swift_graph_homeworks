//
//  Graph.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

struct Edge {
    var vertex1: String
    var vertex2: String
    
    func printEdge() {
        print(vertex1 + " - " + vertex2)
    }
}

class Graph {

    private var n = 0 // vertices count
    
    var fileName: String?
    var stringsArray: String?
    
    var adjList = Array<Array<Int>>()
    var adjMatrix = Array<Array<Int>>()
    var markers = Array<Bool>()
    
    var edges = [Edge]()
    
    var isolatedVertices = [String]()
    var hangingVertices = [String]()
    
    var verticesCount: Int { return n }
    var getFileName: String { return fileName ?? "null" }
    
    
    // MARK: - Methods
    
    func initWithFileName(_ name: String) {
        fileName = name
        
        let text = getStringFromFilePath(name)
        
        if let stringsArray = text {
            
            self.stringsArray = stringsArray
            
            n = Int(stringsArray.lines[0]) ?? 0
            
            for _ in 0..<n { // resize markers array
                markers.append(false)
            }
            
            for _ in 0..<n { // resize adjacent list of vertices
                adjList.append(Array())
            }
            
            for _ in 0..<n { // resize adjacent matrix
                adjMatrix.append(Array())
            }
            
            let lines = Int(stringsArray.lines[0]) ?? 0
            
            for i in 0..<adjMatrix.count {
                for _ in 0..<lines {
                    adjMatrix[i].append(0)
                }
            }
            
            for i in 0..<stringsArray.lines.count {
                
                if i > 0 {
                    
                    let components = stringsArray.lines[i].components(separatedBy: " ")
                    
                    if components.count < 2 {
                        continue
                    }
                    
                    let a = components[0]
                    let b = components[1]
                    
                    edges.append(Edge(vertex1: a, vertex2: b))
                    
                    if let int_a = Int(a), let int_b = Int(b) {
                        adjList[int_a - 1].append(int_b)
                        adjMatrix[int_a - 1][int_b - 1] += 1
                        if int_a == int_b {
                            continue
                        }
                        adjList[int_b - 1].append(int_a)
                        adjMatrix[int_b - 1][int_a - 1] += 1
                    }
                }
            }
        }
    }
}
