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
        
        if vertices.count == 0 {
            print("У графа нет смежных вершин")
            return
        }
        
        print("Список смежных вершин:")
        
        for i in 0..<vertices.count {
            print("\nВершина", terminator:" ")
            vertices[i].printVertex()
            
            for item in adjList[i] {
                print("\(item)", terminator:" ")
            }
        }
    }
    
    func printAdjMatrix() {
        
        print("Матрица смежности:\n")
        
        for i in 0..<vertices.count {
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
        
        for vertex in vertices {
            vertex.printVertexWithDegree()
        }
        
        print("")
    }
    
    func printIsolatedVertices() {
        
        print("\n2.2 Список изолированных вершин:\n")
        
        for vertex in vertices {
            if vertex.isIsolated {
                vertex.printVertex()
            }
        }
        
        print("")
    }
    
    func printHangingVertices() {
        
        print("\n2.3 Список висячих вершин:\n")

        for vertex in vertices {
            if vertex.isHanging {
                vertex.printVertex()
            }
        }
        
        print("")
    }
    
    func printHangingEdges() {
        
        print("\n2.4 Список висячих ребер:\n")
        
        var hangingEdges = [Edge]()
        
        for vertex in vertices {
            
            if vertex.isHanging {
                for edge in edges {
                    if edge.vertex1.value == vertex.value || edge.vertex2.value == vertex.value {
                        hangingEdges.append(edge)
                        continue
                    }
                }
            }
        }
        
        for edge in hangingEdges {
            edge.printEdge()
        }
    }
    
    func printLoopedVertices() {
        
        print("\n2.5 Список вершин с петлями:\n")
        
        for vertex in vertices {
            if vertex.isLooped {
                vertex.printVertex()
            }
        }
        
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
        
        for _ in 0..<vertices.count {
            markers.append(false)
        }
    }
    
    func getLinkedComponentsCount() -> Int {
        unmark()
        var count = 0
        
        for i in 0..<vertices.count {
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
