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
    
    var userGames: [Game] = []
    
    var games: [Game] {
        let activity = Game(named: "Activity")
        let alhambra = Game(named: "Alhambra")
        let arlerErde = Game(named: "Arler Erde")
        let aufAchse = Game(named: "Auf Achse")
        let azul = Game(named: "Azul")
//        let azul1 = Game(named: "Azul - Original - Bunte Seite")
//        let azul2 = Game(named: "Azul - Buntglasfenster - Vorderseite & A")
        let bearsVsBabies = Game(named: "Bears vs. Babies")
        let cafeInternational = Game(named: "Café International")
        let camelUp = Game(named: "Camel Up")
//        let camelUp13 = Game(named: "Camel Up - Supercup 1&3")
//        let camelUp123 = Game(named: "Camel Up - Supercup 1&2&3")
        let campanile = Game(named: "Campanile")
        let carcassonne = Game(named: "Carcassonne")
        let dixit = Game(named: "Dixit")
        let explodingKittens = Game(named: "Exploding Kittens")
//        let explodingKittensApp = Game(named: "Exploding Kittens - App: Betrayal Pack")
        let ganzSchönClever = Game(named: "Ganz schön clever")
        let haltMalKurz = Game(named: "Halt mal kurz")
        let heckmeckAmBratwurmeck = Game(named: "Heckmeck am Bratwurmeck")
        let isleOfSkye = Game(named: "Isle of Skye")
        let istanbul = Game(named: "Istanbul")
        let kniffel = Game(named: "Kniffel")
        let ligretto = Game(named: "Ligretto")
        let marcoPolo = Game(named: "Marco Polo")
        let mauMau = Game(named: "Mau Mau")
        let orleans = Game(named: "Orleans")
        let phase10 = Game(named: "Phase 10")
        let pioneers = Game(named: "Pioneers")
        let qwirkle = Game(named: "Qwirkle")
        let qwixx = Game(named: "Qwixx")
//        let qwixxKlassisch = Game(named: "Qwixx - Klassisch")
        let raceToNewFoundLand = Game(named: "Race to New Found Land")
        let robinsonCrusoe = Game(named: "Robinson Crusoe")
//        let robinsonCrusoe2 = Game(named: "Robinson Crusoe - Szenario 2")
//        let robinsonCrusoe3 = Game(named: "Robinson Crusoe - Szenario 3")
        let romme = Game(named: "Rommé")
        let safeHouse = Game(named: "Safe House")
        let schlagDenRaab = Game(named: "Schlag den Raab - Das Spiel")
        let schüttels = Game(named: "Schüttel‘s")
        let speedCups = Game(named: "Speed Cups")
        let spiel = Game(named: "Spiel")
//        let spielRaffzahn = Game(named: "Spiel - Raffzahn")
//        let spielBunteKuh = Game(named: "Spiel - Bunte Kuh")
//        let spielAbquetschen = Game(named: "Spiel - Abquetschen")
        let stechen = Game(named: "Stechen")
        let taKe = Game(named: "Ta-Ke")
        let ubongo = Game(named: "Ubongo")
        let ulm = Game(named: "Ulm")
        let uno = Game(named: "Uno")
        let village = Game(named: "Village")
        let wizard = Game(named: "Wizard")
        let woodlands = Game(named: "Woodlands")
//        let woodlandsRotkäppchen = Game(named: "Woodlands - Rotkäppchen")
//        let woodlandsRobinHood = Game(named: "Woodlands - Robin Hood")
//        let woodlandsKönigArtus = Game(named: "Woodlands - König Artus")
//        let woodlandsGrafDracula = Game(named: "Woodlands - Graf Dracula")
        let sevenWondersDuel = Game(named: "7 Wonders Duel")
        
        return [activity, alhambra, arlerErde, aufAchse, azul, bearsVsBabies, cafeInternational, camelUp, campanile, carcassonne, dixit, explodingKittens, ganzSchönClever, haltMalKurz, heckmeckAmBratwurmeck, isleOfSkye, istanbul, kniffel, ligretto, marcoPolo, mauMau, orleans, phase10, pioneers, qwirkle, qwixx, raceToNewFoundLand, robinsonCrusoe, romme, safeHouse, schlagDenRaab, schüttels, speedCups, spiel, stechen, taKe, ubongo, ulm, uno, village, wizard, woodlands, sevenWondersDuel] + userGames
    }
    
    mutating func save(_ game: Game) {
        log.info("Game saved: \(game.name)")
        userGames.append(game)
    }
    
    static func modify(_ game: Game, toBe modifiedGame: Game) {
        log.info("Game modified: \(game.name) → \(modifiedGame.name)")
    }
    
}


