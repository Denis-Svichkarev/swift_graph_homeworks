//
//  main.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation


var graph = Graph()
graph.initWithFileName("graph_v25.txt")

print("Свичкарев Денис (25 вариант)\n")

print("*** Лабораторная №1 ***\n")

print("Количество вершин: \(graph.verticesCount)")
print("Количество ребер: \(graph.edgesCount)")
print("Количество компонент связности: \(graph.getLinkedComponentsCount())")


print("\n\tЗадание 1\n")

graph.printAdjList()
print("\n")
graph.printAdjMatrix()

print("\n\tЗадание 2\n")

graph.printDegreeVertices()
graph.printIsolatedVertices()
graph.printHangingVertices()
graph.printHangingEdges()
graph.printLoopedVertices()
graph.printMultipleEdges()

print("\n\tЗадание 3\n")

graph.printAdjListOfSimpleGraph()

print("\n\tЗадание 4\n")

graph.printLinkedComponentsOfSimpleGraph()

print("\n\tЗадание 5\n")

//graph.recursiveDFS(v: 1, printSpanningTree: true)
//graph.recursiveBFS(v: 1, printSpanningTree: true)





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
