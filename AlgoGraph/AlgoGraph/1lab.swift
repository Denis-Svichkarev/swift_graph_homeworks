//
//  1lab.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 08/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

func run1Lab() {
    
    let graph = Graph()
    
    graph.initWithFileName("graph_v21_1.txt")
    
    print("Свичкарев Денис (21 вариант)\n")
    
    print("*** Лабораторная №1 ***\n")
    
    print("Количество вершин: \(graph.vertices.count)")
    print("Количество ребер: \(graph.edges.count)")
    print("Количество компонент связности: \(graph.getLinkedComponentsCount())")
    
    
    print("\n\tЗадание 1\n")
    
    graph.printAdjList()
    graph.printAdjMatrix()
    
    print("\n\tЗадание 2\n")
    
    graph.printDegreeVertices()
    graph.printIsolatedVertices()
    graph.printHangingVertices()
    graph.printHangingEdges()
    graph.printLoopedVertices()
    graph.printMultipleEdges()
    
    print("\n\tЗадание 3\n")
    
    let simpleGraph = graph.getSimpleGraph()
    
    print("Сгенерирован простой граф\n")
    print("Количество вершин: \(simpleGraph.vertices.count)")
    print("Количество ребер: \(simpleGraph.edges.count)")
    print("Количество компонент связности: \(simpleGraph.getLinkedComponentsCount())\n")
    
    simpleGraph.printAdjList()
    
    print("\n\n\tЗадание 4\n")
    
    print("Количество компонент связности: \(simpleGraph.getLinkedComponentsCount())\n")
    
    simpleGraph.printLinkedComponentsOfSimpleGraph()
    
    print("\n\tЗадание 5\n")
    
    print("Поиск в глубину\n")
    
    var i = 1
    for c in simpleGraph.linkedComponets {
        if c.count > 1 {
            
            print("Остовное дерево для компоненты \(i):")
            
            simpleGraph.unmark()
            var component = [String]()
            simpleGraph.recursiveDFS(v: Int(c[0])!, printSpanningTree: true, component: &component)
            
            print("\n")
                            
            i += 1
        }
    }
    
    print("Поиск в ширину\n")
    
    i = 1
    for c in simpleGraph.linkedComponets {
        if c.count > 1 {
            
            print("Остовное дерево для компоненты \(i):")
            
            simpleGraph.unmark()
            simpleGraph.BFS(vertices: c)
            
            print("\n")
            
            i += 1
        }
    }
    
    // Compose oriented graph for 2 lab using max linked comonent
    
    if simpleGraph.linkedComponets.count > 0 {
        
        var maxComponent = simpleGraph.linkedComponets[0]
        
        for c in simpleGraph.linkedComponets {
            if c.count > maxComponent.count {
                maxComponent = c
            }
        }
        
        var newEdges = [Edge]()
        
        for edge in simpleGraph.edges {
            
            var connected = false
            
            for v in maxComponent {
                if v == edge.vertex1.value {
                    connected = true
                    break
                }
            }
            
            if connected {
                newEdges.append(edge)
            }
        }
        
        let orientedGraphString = simpleGraph.generateInputTextStringWithEdges(edges: newEdges)
        writeToFileString("generated_graph_v21.txt", text: orientedGraphString)
        
        print("Сгенерирован орграф исходя из максимальной компоненты связности")
    }
    
    print("\n-------------------------------\n")
}
