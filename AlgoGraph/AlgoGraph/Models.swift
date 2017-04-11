//
//  Graph.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

enum VertexStatus: Int {
    case new = 0, active, done
}

struct Vertex {
    var value: String
    var degree: Int
    
    var degreeIn: Int
    var degreeOut: Int
    
    var isHanging:  Bool = false
    var isIsolated: Bool = false
    var isLooped:   Bool = false
    
    var isSource:   Bool = false
    var isSink:     Bool = false

    var status: VertexStatus
    
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
    
    func isLooped() -> Bool {
        if vertex1.value == vertex2.value {
            return true
        }
        
        return false
    }
    
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
    var parent = Array<Int>()
    var linkedComponets = Array<Array<String>>()
    
    var vertices = [Vertex]()
    var edges = [Edge]()
    var statuses = [VertexStatus]()
    
    var getFileName: String { return fileName ?? "null" }
    
    
    func initWithFileName(_ name: String) {
        fileName = name
        let text = getStringFromFilePath(name)
        initWithString(text)
    }
    
    func initWithString(_ string: String?) {
        
        if let stringsArray = string {
            
            self.stringsArray = stringsArray
            
            let verticesCount = Int(stringsArray.lines[0]) ?? 0
            
            for _ in 0..<verticesCount { // resize markers array
                markers.append(false)
            }
            
            for _ in 0..<verticesCount { // resize parent array
                parent.append(-1)
            }
            
            for _ in 0..<verticesCount { // resize statues array
                statuses.append(.new)
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
                                                      degree: 0, degreeIn: 0, degreeOut: 0,
                                                      isHanging: false, isIsolated: false, isLooped: false, isSource: false, isSink: false, status: .new),
                                      vertex2: Vertex(value: b,
                                                      degree: 0, degreeIn: 0, degreeOut: 0,
                                                      isHanging: false, isIsolated: false, isLooped: false, isSource: false, isSink: false, status: .new),
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
                
                var v = Vertex(value: "\(i + 1)", degree: degree,  degreeIn: 0, degreeOut: 0,isHanging: false, isIsolated: false, isLooped: isLooped, isSource: false, isSink: false, status: .new)
                
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

class OrientedGraph: Graph {
    
    var reachabilityList = Array<Array<Int>>()
    var dplus = [Int]()
    var dminus = [Int]()
    
    var StKos = [Int]()
    var label = [Int]()
    
    var reverseGraph: OrientedGraph?
    
    override func initWithString(_ string: String?) {
        super.initWithString(string)
        
        adjList = Array<Array<Int>>()
        
        for _ in 0..<vertices.count { // resize adjacent list of vertices
            adjList.append(Array())
        }
        
        for _ in 0..<vertices.count {
            label.append(0)
        }
        
        for edge in edges {
            adjList[Int(edge.vertex1.value)! - 1].append(Int(edge.vertex2.value)!)
        }
        
        for _ in 0..<vertices.count { // resize adjacent list of vertices
            dplus.append(0)
            dminus.append(0)
        }
    }
}

struct VertexWithInfo {
    
    var value: String
    var edgesTo = [Edge]()
}

struct MetaVertex {
    
    var number: Int
    var vertices: [VertexWithInfo]
}

class MetaGraph {
    
    var vertices = [MetaVertex]()
    var edges = [Edge]()
    
    var adjList = Array<Array<Int>>()
    
    func initWithComponents(components: [Int], edges: [Edge]) {
        
        self.edges = edges
        
        for i in 0..<components.count {
            
            var existVertex = false
            
            for v in vertices {
                if v.number == components[i] {
                    existVertex = true
                    break
                }
            }
            
            if !existVertex {
                vertices.append(MetaVertex(number: components[i], vertices: [VertexWithInfo(value: "\(i + 1)", edgesTo: [Edge]())]))
            } else {
                
                for j in 0..<vertices.count {
                    if vertices[j].number == components[i] {
                        vertices[j].vertices.append(VertexWithInfo(value: "\(i + 1)", edgesTo: [Edge]()))
                    }
                }
            }
        }
        
        for _ in vertices {
            adjList.append(Array())
        }
    }
    
    func printMetagraph() {
        
        for i in 0..<vertices.count {
            print("Вершина \(vertices[i].number): (", terminator: " ")
            for j in vertices[i].vertices {
                print(j.value, terminator: " ")
            }
            print(")")
        }
        
        for i in 0..<vertices.count {
            var v1 = vertices[i]
            
            for j in 0..<v1.vertices.count {
                var v2 = v1.vertices[j]
                
                for e in edges {
                    if e.vertex1.value == v2.value {
                        v2.edgesTo.append(e)
                    }
                }
                
                v1.vertices[j] = v2
            }
            
            vertices[i] = v1
        }
        
        
        for i in 0..<vertices.count {
            let v = vertices[i]
            let currentMetaNumber = v.number
            
            for v2 in v.vertices {
                for e in v2.edgesTo {
                    
                    let adj = isInComponents(exceptNumber: currentMetaNumber, value: e.vertex2.value)
                    
                    for a in adj {
                        
                        var exist = false
                        
                        for x in adjList[i] {
                            if x == a {
                                exist = true
                                break
                            }
                        }
                        
                        if !exist {
                            adjList[i].append(a)
                        }
                    }
                }
            }
        }
        
        print("\nСписки смежности:\n")
        
        for i in 0..<adjList.count {
            print("Вершина \(vertices[i].number):", terminator: " ")
            
            for j in adjList[i] {
                print("\(j)", terminator: " ")
            }
            
            print("")
        }
    }
    
    func isInComponents(exceptNumber: Int, value: String) -> [Int] {
        
        var linkedMetaVertices = [Int]()
        
        for v in vertices {
            if v.number != exceptNumber {
                
                for v2 in v.vertices {
                    if v2.value == value {
                        linkedMetaVertices.append(v.number)
                    }
                }
            }
        }
        
        return linkedMetaVertices
    }
}
