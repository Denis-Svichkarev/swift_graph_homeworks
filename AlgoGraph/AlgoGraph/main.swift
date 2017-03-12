//
//  main.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation


var graph = Graph()
graph.initWithFileName("graph05.txt")

print("Количество вершин: \(graph.verticesCount)")
print("Количество ребер: \(graph.edgesCount)")
print("Количество компонент связности: \(graph.getLinkedComponentsCount())")


print("\n************** 1 **************\n")

graph.printAdjList()
print("\n")
graph.printAdjMatrix()

print("\n************** 2 **************\n")

graph.printDegreeVertices()
graph.printIsolatedVertices()

print("\n************** 3 **************\n")

print("\n************** 4 **************\n")

print("\n************** 5 **************\n")


/*print("Spanning tree: \n")

print("recursiveDFS(8):")

graph.unmark()
graph.recursiveDFS(v: 8, printSpanningTree: true)

print("\n\nrecursiveDFS(2):")

graph.unmark()
graph.recursiveDFS(v: 2, printSpanningTree: true)

print("\n\nLinked component: \n")
graph.printLinkedComponents()*/










print("\n_________________________\n")
