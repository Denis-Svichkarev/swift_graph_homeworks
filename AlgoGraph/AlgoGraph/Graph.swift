//
//  Graph.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

class Graph {

    private var n = 0 // vertices count
    private var m = 0 // edges count
    
    private var fileName : String?
    private var stringsArray : String?
    
    var adjList = Array<Array<Int>>()
    var adjMatrix = Array<Array<Int>>()
    var markers = Array<Bool>()
    
    var isolatedVertices = [String]()
    var hangingVertices = [String]()
    
    var verticesCount:           Int { return n }
    var edgesCount:              Int { return m }
    
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
                    m += 1
                    
                    let components = stringsArray.lines[i].components(separatedBy: " ")
                    
                    if components.count < 2 {
                        continue
                    }
                    
                    let a = components[0]
                    let b = components[1]
                    
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
        
        for _ in 0..<n {
            markers.append(false)
        }
    }
    
    func getLinkedComponentsCount() -> Int {
        unmark()
        var count = 0
        
        for i in 0..<n {
            if markers[i] == true {
                continue
            }
            count += 1
            recursiveDFS(v: i + 1, printSpanningTree: false)
        }
        
        return count
    }
    
    // MARK: - Print
    
    func printAdjList() {
        
        if n == 0 {
            print("У графа нет смежных вершин")
            return
        }
        
        print("Список смежных вершин:")
        
        for i in 0..<n {
            print("\nВершина \(i + 1) :", terminator:" ")
            
            for item in adjList[i] {
                print("\(item)", terminator:" ")
            }
        }
    }
    
    func printAdjMatrix() {
        
        print("Матрица смежности:\n")
        
        for i in 0..<n {
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
    
    func printDegreeVertices() {
        
        print("2.1 Степени вершин:")
        
        isolatedVertices = [String]()
        
        for i in 0..<n {
            
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
}
