//
//  Graph.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation


struct Vertex {
    var value: String
    var degree: Int
    
    var isHanging:  Bool = false
    var isIsolated: Bool = false
    var isLooped:   Bool = false
    
    func printVertex() {
        print(value, terminator:" ")
    }
    
    func printVertexWithDegree() {
        print("\nВершина: " + value + ", степень: \(degree)", terminator:" ")
    }
}

struct Edge {
    var vertex1: Vertex
    var vertex2: Vertex
    
    var degree: Int
    
    func printEdge() {
        print(vertex1.value + " - " + vertex2.value)
    }
    
    func printEdgeWithDegree() {
        print("Ребро: " + vertex1.value + " - " + vertex2.value, ", степень: \(degree)")
    }
}

class Graph {

    var fileName: String?
    var stringsArray: String?
    
    var adjList = Array<Array<Int>>()
    var adjMatrix = Array<Array<Int>>()
    var markers = Array<Bool>()
    
    var vertices = [Vertex]()
    var edges = [Edge]()
    
    var getFileName: String { return fileName ?? "null" }
    
    
    // MARK: - Methods
    
    func initWithFileName(_ name: String) {
        fileName = name
        
        let text = getStringFromFilePath(name)
        
        if let stringsArray = text {
            
            self.stringsArray = stringsArray
            
            let verticesCount = Int(stringsArray.lines[0]) ?? 0
            
            for _ in 0..<verticesCount { // resize markers array
                markers.append(false)
            }
            
            for _ in 0..<verticesCount { // resize adjacent list of vertices
                adjList.append(Array())
            }
            
            for _ in 0..<verticesCount { // resize adjacent matrix
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
                    
                    edges.append(Edge(vertex1: Vertex(value: a,
                                                      degree: 0,
                                                      isHanging: false,
                                                      isIsolated: false,
                                                      isLooped: false),
                                      vertex2: Vertex(value: b,
                                                      degree: 0,
                                                      isHanging: false,
                                                      isIsolated: false,
                                                      isLooped: false),
                                      degree: 0))
                    
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
            
            for i in 0..<verticesCount {
                
                var degree: Int = 0
                var isLooped = false
                
                let array = adjList[i]
                degree += array.count
                
                for j in 0..<stringsArray.lines.count {
                    let components = stringsArray.lines[j].components(separatedBy: " ")
                    
                    if j > 0 {
                        
                        if components.count < 2 {
                            continue
                        }
                        
                        let a = components[0]
                        let b = components[1]
                        
                        if let int_a = Int(a), let int_b = Int(b) {
                            if int_a == int_b {
                                if i == int_a - 1 {
                                    degree += 1
                                    isLooped = true
                                }
                            }
                        }
                    }
                }
                
                var v = Vertex(value: "\(i + 1)", degree: degree, isHanging: false, isIsolated: false, isLooped: isLooped)
                
                if degree == 0 {
                    v.isIsolated = true
                } else if degree == 1 {
                    v.isHanging = true
                }
                
                vertices.append(v)
            }
        }
    }
}
