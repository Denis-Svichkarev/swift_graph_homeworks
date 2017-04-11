//
//  3lab.swift
//  AlgoGraph
//
//  Created by Denis Svichkarev on 10/04/2017.
//  Copyright © 2017 Denis Svichkarev. All rights reserved.
//

import Foundation

func run3Lab() {
    
    let orientedGraph = OrientedGraph()
    orientedGraph.initWithFileName("graph_v21_3.txt")
    
    print("Свичкарев Денис (21 вариант)\n")
    
    print("*** Лабораторная №3 ***\n")
    
    orientedGraph.printOrientedGraph()
    
    print("\n\tЗадание 1\n")
    print("Приведение ациклического орграфа (DAG) к ярусно-параллельной форме.\n")
    
    orientedGraph.printTieredForm()
    
    print("\n\tЗадание 2\n")
    print("Компоненты сильной связности в орграфе (Алгоритм Kosaraju-Sharir).\n")
    
    let orientedGraph2 = OrientedGraph()
    orientedGraph2.initWithFileName("graph_v21_3_2.txt")
    orientedGraph2.printOrientedGraph()
    orientedGraph2.printStrongLinkedComponents()
    
    print("\n\tПринадлежность вершин сильным компонентам:\n")
    
    for l in orientedGraph2.label {
        print("\(l)", terminator: " ")
    }
    
    print("\n\n\tЗадание 3\n")
    print("Полученный метаграф:\n")
    
    
    
    
    
    print("\n-------------------------------\n")
}
