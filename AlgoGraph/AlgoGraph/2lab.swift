//
//  2lab.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 08/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

func run2Lab() {

    let orientedGraph = OrientedGraph()
    orientedGraph.initWithFileName("generated_graph_v21.txt") 
    
    print("Свичкарев Денис (21 вариант)\n")
    
    print("*** Лабораторная №2 ***\n")
    
    print("\tЗадание 1\n")

    print("Орграф, соответствующий максимальной связной компоненте графа из 1 лаб. работы:\n")
    
    orientedGraph.printOrientedGraph()
    
    print("\n\tЗадание 2")
    
    orientedGraph.printSemiDegrees()
    orientedGraph.printSourceAndSinkVertices()
    orientedGraph.printReachibleVertices()
    orientedGraph.printAnalysisOfReachibleLists()
    orientedGraph.checkForAcyclicity()
    
    print("\n\tЗадание 3\n")

    let orientedGraph2 = OrientedGraph()
    orientedGraph2.initWithFileName("graph_v21_2.txt")
    orientedGraph2.printOrientedGraph()
    orientedGraph2.calculateSemiDegrees()
    
    orientedGraph2.printGraphWithTopologicalOrdering()
    
    print("\n-------------------------------\n")
}
