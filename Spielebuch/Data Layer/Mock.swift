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
    
    /// Players added or edited by the user. Will be deleted when restarting the app.
    private var userPlayers: [Player] = []
    
    /// The players provided below. Those will be present with every app start.
    private var basePlayers: [Player] = []
    
    /// The combination of basePlayers and userPlayers.
    var players: [Player] { return basePlayers + userPlayers }
    
    init() {
        baseGames = [activity, alhambra, arlerErde, aufAchse, azul, bearsVsBabies, cafeInternational, camelUp, campanile, carcassonne, dixit, explodingKittens, ganzSchönClever, haltMalKurz, heckmeckAmBratwurmeck, isleOfSkye, istanbul, kniffel, ligretto, marcoPolo, mauMau, orleans, phase10, pioneers, qwirkle, qwixx, raceToNewFoundLand, robinsonCrusoe, romme, safeHouse, schlagDenRaab, schüttels, speedCups, spiel, stechen, taKe, ubongo, ulm, uno, village, wizard, woodlands, sevenWondersDuel]
        basePlayers = [sandra, benno, norbert, gabi, urban, franziS, doris, phips, franziH, markus, andrea, alex, caro, christina, andi, günther, uli]
    }
    
    // MARK: - Mocked Games
    
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
    
    // MARK: - Mocked Players
    
    private let sandra = Player(firstName: "Sandra", lastName: "Gaede", nickname: nil, base64Image: nil)
    private let benno = Player(firstName: "Benno", lastName: "Kress", nickname: nil, base64Image: nil)
    private let norbert = Player(firstName: "Norbert", lastName: "Kress", nickname: nil, base64Image: nil)
    private let gabi = Player(firstName: "Gabi", lastName: "Kress", nickname: nil, base64Image: nil)
    private let urban = Player(firstName: "Urban", lastName: "Kress", nickname: nil, base64Image: nil)
    private let franziS = Player(firstName: "Franziska", lastName: "Steinecker", nickname: "Franzi", base64Image: nil)
    private let doris = Player(firstName: "Doris", lastName: "Gaede", nickname: nil, base64Image: nil)
    private let phips = Player(firstName: "Philipp", lastName: "Hatlapatka", nickname: "Phips", base64Image: nil)
    private let franziH = Player(firstName: "Franziska", lastName: "Hatlapatka", nickname: "Franzi", base64Image: nil)
    private let markus = Player(firstName: "Markus", lastName: "Sager", nickname: nil, base64Image: nil)
    private let andrea = Player(firstName: "Andrea", lastName: "Sager", nickname: nil, base64Image: nil)
    private let alex = Player(firstName: "Alexander", lastName: "Barth", nickname: "Alex", base64Image: nil)
    private let caro = Player(firstName: "Carolin", lastName: "Sinemus", nickname: "Caro", base64Image: nil)
    private let christina = Player(firstName: "Christina", lastName: "Lang", nickname: nil, base64Image: nil)
    private let andi = Player(firstName: "Andreas", lastName: "Lang", nickname: "Andi", base64Image: nil)
    private let günther = Player(firstName: "Günther", lastName: "Bräuer", nickname: nil, base64Image: nil)
    private let uli = Player(firstName: "Ulrike", lastName: "Bräuer", nickname: "Uli", base64Image: nil)
    
    // MARK: - Game Methods
    
    mutating func save(_ game: Game) {
        log.info("Game saved: \(game.name)")
        userGames.append(game)
    }
    
    mutating func modify(_ game: Game, toBe modifiedGame: Game) {
        log.info("Game modified: \(game.name) → \(modifiedGame.name)")
        if let baseGameIndex = baseGames.firstIndex(of: game) {
            baseGames.remove(at: baseGameIndex)
            baseGames.insert(modifiedGame, at: baseGameIndex)
        } else if let userGameIndex = userGames.firstIndex(of: game) {
            userGames.remove(at: userGameIndex)
            userGames.insert(modifiedGame, at: userGameIndex)
        } else {
            log.error("Original game named \(game.name) not found"); return
        }
    }
    
    // MARK: - Player Methods
    
    mutating func save(_ player: Player) {
        log.info("Player saved: \(player.displayname)")
        userPlayers.append(player)
    }
    
    mutating func modify(_ player: Player, toBe modifiedPlayer: Player) {
        log.info("Player modified: \(player.displayname) → \(modifiedPlayer.displayname)")
        if let basePlayerIndex = basePlayers.firstIndex(of: player) {
            basePlayers.remove(at: basePlayerIndex)
            basePlayers.insert(modifiedPlayer, at: basePlayerIndex)
        } else if let userPlayerIndex = userPlayers.firstIndex(of: player) {
            userPlayers.remove(at: userPlayerIndex)
            userPlayers.insert(modifiedPlayer, at: userPlayerIndex)
        } else {
            log.error("Original player named \(player.displayname) not found"); return
        }
    }
    
}


