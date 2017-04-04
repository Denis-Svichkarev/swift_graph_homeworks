//
//  GraphExtension.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 04/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

extension Graph {
    
    // MARK: - 1 Task
    
    func printAdjList() {
        
        if verticesCount == 0 {
            print("У графа нет смежных вершин")
            return
        }
        
        print("Список смежных вершин:")
        
        for i in 0..<verticesCount {
            print("\nВершина \(i + 1) :", terminator:" ")
            
            for item in adjList[i] {
                print("\(item)", terminator:" ")
            }
        }
    }
    
    func printAdjMatrix() {
        
        print("Матрица смежности:\n")
        
        for i in 0..<verticesCount {
            for item in adjMatrix[i] {
                print("\(item)", terminator:" ")
            }
            print("")
        }
    }
    
    func printLinkedComponents() {
        
        for i in 0..<markers.count {
            if markers[i] == true {
                print("\(i + 1)", terminator:" ")
            }
        }
    }
    
    // MARK: - 2 Task
    
    func printDegreeVertices() {
        
        print("2.1 Степени вершин:")
        
        isolatedVertices = [String]()
        
        for i in 0..<verticesCount {
            
            var degree: Int = 0
            
            let array = adjList[i]
            degree += array.count
            
            if let stringsArray = stringsArray {
                
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
                                }
                            }
                        }
                    }
                }
            }
            
            if degree == 0 {
                isolatedVertices.append("\(i + 1)")
            } else if degree == 1 {
                hangingVertices.append("\(i + 1)")
            }
            
            print("\nВершина \(i + 1) : \(degree)", terminator:" ")
        }
        
        print("")
    }
    
    func printIsolatedVertices() {
        
        print("\n2.2 Список изолированных вершин:\n")
        
        for i in 0..<isolatedVertices.count {
            print("\(isolatedVertices[i])", terminator:" ")
        }
        
        print("")
    }
    
    func printHangingVertices() {
        
        print("\n2.3 Список висячих вершин:\n")
        
        for i in 0..<hangingVertices.count {
            print("\(hangingVertices[i])", terminator:" ")
        }
        
        print("")
    }
    
    func printHangingEdges() {
        
        print("\n2.4 Список висячих ребер:\n")
        
        
        print("")
    }
    
    func printLoopedVertices() {
        
        print("\n2.5 Список вершин с петлями:\n")
        
        
        print("")
    }
    
    func printMultipleEdges() {
        
        print("\n2.6 Список кратных ребер:\n")
        
        
        print("")
    }
    
    // MARK: - 3 Task
    
    func printAdjListOfSimpleGraph() {
        
        print("\nСписок смежных вершин простого графа:\n")
        
        
        print("")
    }
    
    // MARK: - 4 Task
    
    func printLinkedComponentsOfSimpleGraph() {
        
        print("\nКомпоненты простого графа:\n")
        
        
        print("")
    }
    
    // MARK: - 5 Task
    
    func recursiveDFS(v: Int, printSpanningTree: Bool) {
        
        if v > markers.count {
            return
        }
        
        if markers[v - 1] == true {
            return
        }
        
        if printSpanningTree { print("'\(v)'", terminator:" ") }
        
        markers[v - 1] = true
        
        for i in 0..<adjList[v - 1].count {
            recursiveDFS(v: adjList[v - 1][i], printSpanningTree: printSpanningTree)
        }
    }
    
    func unmark() {
        markers.removeAll()
        
        for _ in 0..<verticesCount {
            markers.append(false)
        }
    }
    
    func getLinkedComponentsCount() -> Int {
        unmark()
        var count = 0
        
        for i in 0..<verticesCount {
            if markers[i] == true {
                continue
            }
            count += 1
            recursiveDFS(v: i + 1, printSpanningTree: false)
        }
        
        return count
    }
    
    func recursiveBFS(v: Int, printSpanningTree: Bool) {
        
        
    }
}
