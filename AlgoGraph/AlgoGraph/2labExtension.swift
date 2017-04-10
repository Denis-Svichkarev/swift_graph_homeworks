//
//  2labExtension.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 08/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

extension OrientedGraph {

    // MARK: - 1 Task
    
    func printOrientedGraph() {
        
        print("Орграф, соответствующий максимальной связной компоненте графа из 1 лаб. работы:\n")
        
        for e in edges {
            print(e.vertex1.value + " -> " + e.vertex2.value)
        }
    }
    
    // MARK: - 2 Task
    
    func printSemiDegrees() {
        
        print("2.1 Значения полустепени исхода и полустепени захода\n")
        
        for i in 0..<vertices.count {
            
            var v = vertices[i]
            
            var semiDegreeOut = 0
            var semiDegreeIn = 0
            
            for e in edges {
                
                if e.vertex1.value == v.value {
                    semiDegreeOut += 1
                }
                
                if e.vertex2.value == v.value {
                    semiDegreeIn += 1
                }
            }
            
            vertices[i].degreeIn = semiDegreeIn
            vertices[i].degreeOut = semiDegreeOut
            
            v.degreeOut = semiDegreeOut
            print("Вершина: " + v.value + " - Полустепень исхода: \(semiDegreeOut), полустепень захода: \(semiDegreeIn)")
        }
    }
    
    func printSourceAndSinkVertices() {
        
        print("\n2.2 Список вершин-источников и список вершин-стоков\n")
        
        
        for i in 0..<vertices.count {
            
            if vertices[i].degreeIn == 0 {
                vertices[i].isSource = true
            }
            
            if vertices[i].degreeOut == 0 {
                vertices[i].isSink = true
            }
        }
        
        print("Вершины-источники:\n")
            
        for v in vertices {
            if v.isSource {
                v.printVertex()
            }
        }
        
        print("\n")
        
        print("Вершины-стоки:\n")
        
        for v in vertices {
            if v.isSink {
                v.printVertex()
            }
        }
        
        print("")
    }
    
    func printReachibleVertices() {
        
        print("\n2.3 Список достижимых вершин:\n")
        
        for _ in 0..<vertices.count {
            reachabilityList.append(Array())
        }
        
        for v in vertices {
            unmark()
            traverse(v: Int(v.value)!)
        }
    }

    func traverse(v: Int) {
        
        unmark()
        
        var bag = [(Int, Int)]()
        
        bag.append((0, v))
        
        while bag.count != 0 {
            
            let p = bag.last!
            bag.removeLast()
            
            if markers[p.1 - 1] { continue }
            markers[p.1 - 1] = true
            parent[p.1 - 1] = p.0
            //print("# \(p.0), \(p.1)")
            
            for w in adjList[p.1 - 1] {
                if markers[w - 1] { continue }
                bag.append((p.1, w))
            }
        }
        
        print("Вершина \(v):", terminator: " ")
        
        for i in 0..<markers.count {
            if markers[i] {
                reachabilityList[v - 1].append(i + 1)
                print("\(i + 1)", terminator: " ")
            }
        }
        
        print("")
    }
    
    func printAnalysisOfReachibleLists() {
        
        print("\n2.4 Анализ списков достижимости:\n")
        
        
    }
    
    func checkForAcyclicity() {
        
        print("\n2.5 Проверка орграфа на ацикличность:\n")
        
        let isAcyclic = isAcyclicDFS(v: 1)
        
        if isAcyclic {
            print("Граф ацикличен")
        } else {
            print("Граф цикличен")
        }
    }
    
    func isAcyclicDFS(v: Int) -> Bool {
        
        statuses[v - 1] = .active
        
        for w in adjList[v - 1] {
            switch statuses[w - 1] {
            case .active:
                return false
            case .new:
                if !isAcyclicDFS(v: w) {
                    return false
                }
            default : break
            }
        }
        
        statuses[v - 1] = .done
        return true
    }
    
    // MARK: - 3 Task
    
    func printGraphWithTopologicalOrdering() {
        
        print("\n3.1 Орграф в линейном виде с учетом топологического упорядочения:\n")
        
        
    }
    
    func printGraphWithTieredParallelForm() {
        
        print("\n3.2 Орграф в ярусно-параллельной форме:\n")
        
        
    }
}
