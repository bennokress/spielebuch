//
//  Mock.swift
//  Spielebuch
//
//  Created by Benno Kress on 29.05.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation

// THIS IS ONLY A TEMPORARY SOLUTION TO GET THE UI READY FOR REAL DATA //

struct Mock {
    
    static var shared = Mock()
    
    /// Games added or edited by the user. Will be deleted when restarting the app.
    private var userGames: [Game] = []
    
    /// The games provided below. Those will be present with every app start.
    private var baseGames: [Game] = []
    
    /// The combination of baseGames and userGames.
    var games: [Game] { return baseGames + userGames }
    
    init() {
        baseGames = [activity, alhambra, arlerErde, aufAchse, azul, bearsVsBabies, cafeInternational, camelUp, campanile, carcassonne, dixit, explodingKittens, ganzSchönClever, haltMalKurz, heckmeckAmBratwurmeck, isleOfSkye, istanbul, kniffel, ligretto, marcoPolo, mauMau, orleans, phase10, pioneers, qwirkle, qwixx, raceToNewFoundLand, robinsonCrusoe, romme, safeHouse, schlagDenRaab, schüttels, speedCups, spiel, stechen, taKe, ubongo, ulm, uno, village, wizard, woodlands, sevenWondersDuel]
    }
    
    private let activity = Game(named: "Activity")
    private let alhambra = Game(named: "Alhambra")
    private let arlerErde = Game(named: "Arler Erde")
    private let aufAchse = Game(named: "Auf Achse")
    private let azul = Game(named: "Azul")
//    private let azul1 = Game(named: "Azul - Original - Bunte Seite")
//    private let azul2 = Game(named: "Azul - Buntglasfenster - Vorderseite & A")
    private let bearsVsBabies = Game(named: "Bears vs. Babies")
    private let cafeInternational = Game(named: "Café International")
    private let camelUp = Game(named: "Camel Up")
//    private let camelUp13 = Game(named: "Camel Up - Supercup 1&3")
//    private let camelUp123 = Game(named: "Camel Up - Supercup 1&2&3")
    private let campanile = Game(named: "Campanile")
    private let carcassonne = Game(named: "Carcassonne")
    private let dixit = Game(named: "Dixit")
    private let explodingKittens = Game(named: "Exploding Kittens")
//    private let explodingKittensApp = Game(named: "Exploding Kittens - App: Betrayal Pack")
    private let ganzSchönClever = Game(named: "Ganz schön clever")
    private let haltMalKurz = Game(named: "Halt mal kurz")
    private let heckmeckAmBratwurmeck = Game(named: "Heckmeck am Bratwurmeck")
    private let isleOfSkye = Game(named: "Isle of Skye")
    private let istanbul = Game(named: "Istanbul")
    private let kniffel = Game(named: "Kniffel")
    private let ligretto = Game(named: "Ligretto")
    private let marcoPolo = Game(named: "Marco Polo")
    private let mauMau = Game(named: "Mau Mau")
    private let orleans = Game(named: "Orleans")
    private let phase10 = Game(named: "Phase 10")
    private let pioneers = Game(named: "Pioneers")
    private let qwirkle = Game(named: "Qwirkle")
    private let qwixx = Game(named: "Qwixx")
//    private let qwixxKlassisch = Game(named: "Qwixx - Klassisch")
    private let raceToNewFoundLand = Game(named: "Race to New Found Land")
    private let robinsonCrusoe = Game(named: "Robinson Crusoe")
//    private let robinsonCrusoe2 = Game(named: "Robinson Crusoe - Szenario 2")
//    private let robinsonCrusoe3 = Game(named: "Robinson Crusoe - Szenario 3")
    private let romme = Game(named: "Rommé")
    private let safeHouse = Game(named: "Safe House")
    private let schlagDenRaab = Game(named: "Schlag den Raab - Das Spiel")
    private let schüttels = Game(named: "Schüttel‘s")
    private let speedCups = Game(named: "Speed Cups")
    private let spiel = Game(named: "Spiel")
//    private let spielRaffzahn = Game(named: "Spiel - Raffzahn")
//    private let spielBunteKuh = Game(named: "Spiel - Bunte Kuh")
//    private let spielAbquetschen = Game(named: "Spiel - Abquetschen")
    private let stechen = Game(named: "Stechen")
    private let taKe = Game(named: "Ta-Ke")
    private let ubongo = Game(named: "Ubongo")
    private let ulm = Game(named: "Ulm")
    private let uno = Game(named: "Uno")
    private let village = Game(named: "Village")
    private let wizard = Game(named: "Wizard")
    private let woodlands = Game(named: "Woodlands")
//    private let woodlandsRotkäppchen = Game(named: "Woodlands - Rotkäppchen")
//    private let woodlandsRobinHood = Game(named: "Woodlands - Robin Hood")
//    private let woodlandsKönigArtus = Game(named: "Woodlands - König Artus")
//    private let woodlandsGrafDracula = Game(named: "Woodlands - Graf Dracula")
    private let sevenWondersDuel = Game(named: "7 Wonders Duel")
    
    mutating func save(_ game: Game) {
        log.info("Game saved: \(game.name)")
        userGames.append(game)
    }
    
    mutating func modify(_ game: Game, toBe modifiedGame: Game) {
        log.info("Game modified: \(game.name) → \(modifiedGame.name)")
        guard let originalIndex = baseGames.firstIndex(of: game) else {
            log.error("Original game named \(game.name) not found")
            return
        }
        baseGames.remove(at: originalIndex)
        baseGames.insert(modifiedGame, at: originalIndex)
    }
    
}


