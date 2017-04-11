//
//  4labExtension.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 10/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

extension WeightedGraph {

    // MARK: - 1 Task
    
    func borvka() {
        
        F = Graph()
        F?.initAsSimpleGraph(graph: self)
        F?.adjList = adjList
        
        for e in weightedEdges {
            F?.edges.append(Edge(vertex1: e.vertex1, vertex2: e.vertex2, degree: e.weight))
        }

        let components = F?.getLinkedComponents()
        var component = components?[0]
        
        for c in components! {
            if c.count > (component?.count)! {
                component = c
            }
        }
        
        let newWeightedGraph = generateSimpleGraph(component: component!)
        
        adjWList = newWeightedGraph.adjWList
        vertices = newWeightedGraph.vertices
        markers = newWeightedGraph.markers
        adjList = newWeightedGraph.adjList
        weightedEdges = newWeightedGraph.weightedEdges
        
        F = Graph()
        F?.initAsSimpleGraph(graph: self)
        F?.adjList = adjList
        
        for i in 0..<(F?.adjList)!.count {
            F?.adjList[i].removeAll()
        }
        
        var count = F!.countAndLabel()
        
        while count > 1 {
            labels = F!.labels
            addAllSafeEdges(count: count)
            count = F!.countAndLabel()
            print("count: \(count)\n")
        }
        
        if let F = F {
            
            for i in 0..<F.vertices.count {
                print("\(i + 1):", terminator: " ")
                
                for x in adjWList[i] {
                    print("(\(x.0), \(x.1))", terminator: " ")
                }
                
                print("")
            }
        }
    }
    
    func addAllSafeEdges(count: Int) {
        
        var S = [(Int, Int, Int)]()
        
        for _ in 0..<count {
            S.append((0, 0, 1000))
        }
        
        for u in 1...vertices.count {
            for v in adjWList[u - 1] {
                if labels[u - 1] != labels[v.0 - 1] {
                    if v.1 < S[labels[u - 1] - 1].2 {
                        S[labels[u - 1] - 1] = (u, v.0, v.1)
                    }
                    if v.1 < S[labels[v.0 - 1] - 1].2 {
                        S[labels[v.0 - 1] - 1] = (u, v.0, v.1)
                    }
                }
            }
        }
        
        for i in 0..<count {
            if S[i].2 != 1000 {
                F?.addEdge(v: S[i].0, w: S[i].1)
            }
        }
        
        if let F = F {
            
            for i in 0..<F.vertices.count {
                print("\(i + 1):", terminator: " ")
                
                for x in F.adjList[i] {
                    print("\(x)", terminator: " ")
                }
                
                print("")
            }
            
            print("")
        }
    }
    
    func generateSimpleGraph(component: [String]) -> WeightedGraph {
        
        var newEdges = [WeightedEdge]()
        
        for edge in weightedEdges {
            
            var connected = false
            
            for v in component {
                if v == edge.vertex1.value {
                    connected = true
                    break
                }
            }
            
            if connected {
                newEdges.append(edge)
            }
        }
        
        let orientedGraphString = generateInputTextStringWithWeightedEdges(edges: newEdges)
        writeToFileString("generated_graph_v21_4.txt", text: orientedGraphString)
        
        let newGraph = WeightedGraph()
        newGraph.initWithFileName("generated_graph_v21_4.txt")
        
        return newGraph
    }
    
    // MARK: - 2 Task
    
    
    
    // MARK: - 3 Task
    
    
}

extension Graph {
    
    func initAsSimpleGraph(graph: Graph) {
        
        vertices = graph.vertices
        
        for _ in 0..<vertices.count { // resize markers array
            markers.append(false)
        }
        
        for _ in 0..<vertices.count { // resize adjacent list of vertices
            adjList.append(Array())
        }
        
        for _ in 0..<vertices.count { // resize labels
            labels.append(0)
        }
    }
    
    func countAndLabel() -> Int {
        var count = 0
        unmark()
        
        for v in 1...vertices.count {
            if !markers[v - 1] {
                count += 1
                labelComponent(v: v, count: count)
            }
        }
        
        return count
    }
    
    func labelComponent(v: Int, count: Int) {
        markers[v - 1] = true
        labels[v - 1] = count
        
        for w in adjList[v - 1] {
            if !markers[w - 1] {
                labelComponent(v: w, count: count)
            }
        }
    }
    
    func addEdge(v: Int, w: Int) {
        
        if v < 1 || v > vertices.count {
            return
        }
        
        if w < 1 || w > vertices.count {
            return
        }
        
        for x in adjList[v - 1] {
            if x == w {
                return
            }
        }
        
        adjList[v - 1].append(w)
        adjList[w - 1].append(v)
    }
    
    func generateInputTextStringWithWeightedEdges(edges: [WeightedEdge]) -> String {
        
        var text = ""
        
        var newVertices = [Vertex]()
        
        for edge in edges {
            if !hasVertex(vertices: newVertices, vertex: edge.vertex1) {
                newVertices.append(edge.vertex1)
            }
            
            if !hasVertex(vertices: newVertices, vertex: edge.vertex2) {
                newVertices.append(edge.vertex2)
            }
        }
        
        text.append("\(newVertices.count)\n")
        
        
        var verticesForRemove = [Vertex]()
        
        for v in vertices {
            var remove = true
            
            for e in edges {
                if e.vertex1.value == v.value || e.vertex2.value == v.value {
                    remove = false
                    break
                }
            }
            
            if remove {
                verticesForRemove.append(v)
            }
        }
        
        var newEdges = [WeightedEdge]()
        
        for i in 0..<edges.count {
            var edge = edges[i]
            
            var count1 = 0
            var count2 = 0
            
            for v in verticesForRemove {
            
                let n = Int(edge.vertex1.value)!
                
                if n > Int(v.value)! {
                    count1 += 1
                }
                
                let n2 = Int(edge.vertex2.value)!
                
                if n2 > Int(v.value)! {
                    count2 += 1
                }
            }
            
            edge.vertex1.value = "\(Int(edge.vertex1.value)! - count1)"
            edge.vertex2.value = "\(Int(edge.vertex2.value)! - count2)"
            
            newEdges.append(edge)
        }
        
        for edge in newEdges {
            text.append(edge.vertex1.value + " " + edge.vertex2.value + " \(edge.weight)" + "\n")
        }
        
        return text
    }
}
