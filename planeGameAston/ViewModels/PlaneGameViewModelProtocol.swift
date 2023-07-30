//
//  PlaneGameViewModelProtocol.swift
//  planeGameAston
//
//  Created by Rogulev Sergey on 07.07.2023.
//

import Foundation

protocol PlaneGameViewModelProtocol {
    
    var isGameStarted: Bool { get set }
    var isResultsShown: Bool { get set }
    
    func getAvailableGameModes() -> [PlaneGameModel]
}
