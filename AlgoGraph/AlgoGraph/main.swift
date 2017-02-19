//
//  main.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation


var graph = Graph()
graph.initWithFileName("graph03.txt")

print("Vertices count: \(graph.verticesCount)")
print("Edges count: \(graph.edgesCount)")
print("Linked components count: \(graph.getLinkedComponentsCount())\n")

graph.printAdjList()
print("\n")
graph.printAdjMatrix()
print("")

graph.unmark()
graph.recursiveDFS(v: 11)

print("Linked component: \n")
graph.printLinkedComponents()










print("\n_________________________\n")
