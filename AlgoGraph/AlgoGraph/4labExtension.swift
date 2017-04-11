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
        
        F = generateSimpleGraph(component: component!, graph: F!)
        
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
    
    func generateSimpleGraph(component: [String], graph: Graph) -> Graph {
        
        var newEdges = [Edge]()
        
        for edge in graph.edges {
            
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
        
        let orientedGraphString = graph.generateInputTextStringWithEdges(edges: newEdges)
        writeToFileString("generated_graph_v21_4.txt", text: orientedGraphString)
        
        let tree = Graph()
        tree.initWithFileName("generated_graph_v21_4.txt")
        
        return tree
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
}
