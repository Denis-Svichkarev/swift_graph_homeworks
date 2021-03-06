//
//  5lab.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 16/05/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

func run5Lab() {
    
    let weightedGraph = WeightedGraph()
    let exist = weightedGraph.initWithFileName("graph_v21_5.txt")
    
    if !exist {
        return
    }
    
    print("Свичкарев Денис (21 вариант)\n")
    
    print("*** Лабораторная №5 ***\n")

    print("Построить дерево кратчайших путей для заданного ориентированного графа.\n")
    
    weightedGraph.printWeightedGraph()

    print("\n\tЗадание 1 - Алгоритм Форда. Мешок - стек\n")
    
    weightedGraph.fordWithStack(s: 0)
    weightedGraph.printSPT()
    
    print("\tЗадание 2 - Алгоритм Форда. Мешок - очередь\n")
    
    weightedGraph.fordWithQueue(s: 0)
    weightedGraph.printSPT()
    
    print("\tЗадание 3 - Алгоритм Форда. Мешок - приоритетная очередь\n")
    
    weightedGraph.fordWithPriorityQueue(s: 0)
    weightedGraph.printSPT()
    
    print("-------------------------------\n")
}
