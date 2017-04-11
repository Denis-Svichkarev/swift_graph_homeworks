//
//  3labExtension.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 10/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

extension OrientedGraph {

    // MARK: - 1 Task
    
    func printTieredForm() {
        
        calculateSemiDegrees()
        
        var levels = [[String]]()
        var vertices_copy = vertices
        
        
        while vertices_copy.count > 0 {
            
            var vertices_copy2 = [Vertex]()
            
            var level = [String]()
            
            for v in vertices_copy {
                if v.degreeIn == 0 {
                    level.append(v.value)
                } else {
                    vertices_copy2.append(v)
                }
            }
            
            levels.append(level)
            
            for i in 0..<vertices_copy2.count {
                
                var vertex = vertices_copy2[i]
                
                for e in edges {
                    
                    var isOnLevel = false
                    
                    for v in level {
                        if v == e.vertex1.value {
                            isOnLevel = true
                            break
                        }
                    }
                    
                    if !isOnLevel { continue }
                    
                    if e.vertex1.degree == 0 && e.vertex2.value == vertex.value {
                        vertex.degreeIn -= 1
                    }
                }
                
                vertices_copy2[i] = vertex
            }
            
            vertices_copy = vertices_copy2
            
            for i in 0..<edges.count {
                
                var edge = edges[i]
                
                for v in vertices_copy {
                    if v.value == edge.vertex1.value {
                        edge.vertex1.degree = v.degree
                    }
                    
                    if v.value == edge.vertex2.value {
                        edge.vertex2.degree = v.degree
                    }
                }
            }
            
        }
        
        for i in 0..<levels.count {
            let level = levels[i]
            
            print("\(i) уровень:", terminator: " ")
            for v in level {
                print(v, terminator: " ")
            }
            
            print("");
        }
    }
    
    // MARK: - 2 Task
    
    
    
    
    // MARK: - 3 Task
    
    
    
    
}
