//
//  main.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 14/02/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation


var graph = Graph()
graph.initWithFileName("graph02.txt")

print("Vertices count: \(graph.verticesCount)")
print("Edges count: \(graph.edgesCount)\n")

graph.printAdjList()

print("\n")

graph.printAdjMatrix()












print("\n_________________________\n")
