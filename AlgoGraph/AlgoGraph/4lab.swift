//
//  4lab.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 10/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

func run4Lab() {

    let weightedGraph = WeightedGraph()
    var exist = weightedGraph.initWithFileName("graph_v21_4.txt")
    
    if !exist {
        return
    }
    
    print("Свичкарев Денис (21 вариант)\n")
    
    print("*** Лабораторная №4 ***\n")
    
    print("\tЗадание 1\n")
    print("Построение минимального остовного дерева с помощью алгоритма Борувки.\n")
    
    weightedGraph.borvka()
    
    print("\n\tЗадание 2\n")
    print("Построение минимального остовного дерева с помощью алгоритма Ярника (Прима).\n")
    
    let newGraph = WeightedGraph()
    exist = newGraph.initWithFileName("generated_graph_v21_4.txt")
    
    if !exist {
        return
    }
    
    newGraph.prima()
    
    print("\n\tЗадание 3\n")
    print("Построение минимального остовного дерева с помощью алгоритма Крускала.\n")
    
    let newGraph2 = WeightedGraph()
    exist = newGraph2.initWithFileName("generated_graph_v21_4.txt")
    
    if !exist {
        return
    }
    
    newGraph.kruskal()
    
    print("\n-------------------------------\n")
}
