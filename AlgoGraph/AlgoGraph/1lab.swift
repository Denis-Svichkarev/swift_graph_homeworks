//
//  1lab.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 08/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

func runFirstLab() {
    
    let graph = Graph()
    
    graph.initWithFileName("graph_v21.txt")
    
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
    
    graph.printLinkedComponentsOfSimpleGraph()
    
    print("\n\tЗадание 5\n")
    
    
    
    /*print("Spanning tree: \n")
     
     print("recursiveDFS(8):")
     
     graph.unmark()
     graph.recursiveDFS(v: 8, printSpanningTree: true)
     
     print("\n\nrecursiveDFS(2):")
     
     graph.unmark()
     graph.recursiveDFS(v: 2, printSpanningTree: true)
     
     print("\n\nLinked component: \n")
     graph.printLinkedComponents()*/
}
