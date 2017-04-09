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
        
        
    }
    
    func printAnalysisOfReachibleLists() {
        
        print("\n2.4 Анализ списков достижимости:\n")
        
        
    }
    
    func checkForAcyclicity() {
        
        print("\n2.5 Проверка орграфа на ацикличность:\n")
        
        
    }
    
    // MARK: - 3 Task
    
    func printGraphWithTopologicalOrdering() {
        
        print("\n3.1 Орграф в линейном виде с учетом топологического упорядочения:\n")
        
        
    }
    
    func printGraphWithTieredParallelForm() {
        
        print("\n3.2 Орграф в ярусно-параллельной форме:\n")
        
        
    }
}
