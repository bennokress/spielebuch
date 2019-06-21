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
        basePlayers = [sandra, benno, norbert, gabi, urban, franziS, doris, phips, franziH, markus, andrea, alex, caro, christina, andi, günther, uli, django, michelle]
    }
    
    // MARK: - Mocked Games
    
    private var activity: Game              { return Game(named: "Activity") }
    private var alhambra: Game              { return Game(named: "Alhambra") }
    private var arlerErde: Game             { return Game(named: "Arler Erde") }
    private var aufAchse: Game              { return Game(named: "Auf Achse") }
    private var azul: Game                  { return Game(named: "Azul") }
//    private var azul1: Game                 { return Game(named: "Azul - Original - Bunte Seite") }
//    private var azul2: Game                 { return Game(named: "Azul - Buntglasfenster - Vorderseite & A") }
    private var bearsVsBabies: Game         { return Game(named: "Bears vs. Babies") }
    private var cafeInternational: Game     { return Game(named: "Café International") }
    private var camelUp: Game               { return Game(named: "Camel Up") }
//    private var camelUp13: Game             { return Game(named: "Camel Up - Supercup 1&3") }
//    private var camelUp123: Game            { return Game(named: "Camel Up - Supercup 1&2&3") }
    private var campanile: Game             { return Game(named: "Campanile") }
    private var carcassonne: Game           { return Game(named: "Carcassonne") }
    private var dixit: Game                 { return Game(named: "Dixit") }
    private var explodingKittens: Game      { return Game(named: "Exploding Kittens") }
//    private var explodingKittensApp: Game   { return Game(named: "Exploding Kittens - App: Betrayal Pack") }
    private var ganzSchönClever: Game       { return Game(named: "Ganz schön clever") }
    private var haltMalKurz: Game           { return Game(named: "Halt mal kurz") }
    private var heckmeckAmBratwurmeck: Game { return Game(named: "Heckmeck am Bratwurmeck") }
    private var isleOfSkye: Game            { return Game(named: "Isle of Skye") }
    private var istanbul: Game              { return Game(named: "Istanbul") }
    private var kniffel: Game               { return Game(named: "Kniffel") }
    private var ligretto: Game              { return Game(named: "Ligretto") }
    private var marcoPolo: Game             { return Game(named: "Marco Polo") }
    private var mauMau: Game                { return Game(named: "Mau Mau") }
    private var orleans: Game               { return Game(named: "Orleans") }
    private var phase10: Game               { return Game(named: "Phase 10") }
    private var pioneers: Game              { return Game(named: "Pioneers") }
    private var qwirkle: Game               { return Game(named: "Qwirkle") }
    private var qwixx: Game                 { return Game(named: "Qwixx") }
//    private var qwixxKlassisch: Game        { return Game(named: "Qwixx - Klassisch") }
    private var raceToNewFoundLand: Game    { return Game(named: "Race to New Found Land") }
    private var robinsonCrusoe: Game        { return Game(named: "Robinson Crusoe") }
//    private var robinsonCrusoe2: Game       { return Game(named: "Robinson Crusoe - Szenario 2") }
//    private var robinsonCrusoe3: Game       { return Game(named: "Robinson Crusoe - Szenario 3") }
    private var romme: Game                 { return Game(named: "Rommé") }
    private var safeHouse: Game             { return Game(named: "Safe House") }
    private var schlagDenRaab: Game         { return Game(named: "Schlag den Raab - Das Spiel") }
    private var schüttels: Game             { return Game(named: "Schüttel‘s") }
    private var speedCups: Game             { return Game(named: "Speed Cups") }
    private var spiel: Game                 { return Game(named: "Spiel") }
//    private var spielRaffzahn: Game         { return Game(named: "Spiel - Raffzahn") }
//    private var spielBunteKuh: Game         { return Game(named: "Spiel - Bunte Kuh") }
//    private var spielAbquetschen: Game      { return Game(named: "Spiel - Abquetschen") }
    private var stechen: Game               { return Game(named: "Stechen") }
    private var taKe: Game                  { return Game(named: "Ta-Ke") }
    private var ubongo: Game                { return Game(named: "Ubongo") }
    private var ulm: Game                   { return Game(named: "Ulm") }
    private var uno: Game                   { return Game(named: "Uno") }
    private var village: Game               { return Game(named: "Village") }
    private var wizard: Game                { return Game(named: "Wizard") }
    private var woodlands: Game             { return Game(named: "Woodlands") }
//    private var woodlandsRotkäppchen: Game  { return Game(named: "Woodlands - Rotkäppchen") }
//    private var woodlandsRobinHood: Game    { return Game(named: "Woodlands - Robin Hood") }
//    private var woodlandsKönigArtus: Game   { return Game(named: "Woodlands - König Artus") }
//    private var woodlandsGrafDracula: Game  { return Game(named: "Woodlands - Graf Dracula") }
    private var sevenWondersDuel: Game      { return Game(named: "7 Wonders Duel") }
    
    // MARK: - Mocked Players
    
    private var sandra: Player              { return Player(firstName: "Sandra",    lastName: "Gaede",      nickname: nil,      base64Image: nil) }
    private var benno: Player               { return Player(firstName: "Benno",     lastName: "Kress",      nickname: nil,      base64Image: nil) }
    private var norbert: Player             { return Player(firstName: "Norbert",   lastName: "Kress",      nickname: nil,      base64Image: nil) }
    private var gabi: Player                { return Player(firstName: "Gabi",      lastName: "Kress",      nickname: nil,      base64Image: nil) }
    private var urban: Player               { return Player(firstName: "Urban",     lastName: "Kress",      nickname: nil,      base64Image: nil) }
    private var franziS: Player             { return Player(firstName: "Franziska", lastName: "Steinecker", nickname: "Franzi", base64Image: nil) }
    private var doris: Player               { return Player(firstName: "Doris",     lastName: "Gaede",      nickname: nil,      base64Image: nil) }
    private var phips: Player               { return Player(firstName: "Philipp",   lastName: "Hatlapatka", nickname: "Phips",  base64Image: nil) }
    private var franziH: Player             { return Player(firstName: "Franziska", lastName: "Hatlapatka", nickname: "Franzi", base64Image: nil) }
    private var markus: Player              { return Player(firstName: "Markus",    lastName: "Sager",      nickname: nil,      base64Image: nil) }
    private var andrea: Player              { return Player(firstName: "Andrea",    lastName: "Sager",      nickname: nil,      base64Image: nil) }
    private var alex: Player                { return Player(firstName: "Alexander", lastName: "Barth",      nickname: "Alex",   base64Image: nil) }
    private var caro: Player                { return Player(firstName: "Carolin",   lastName: "Sinemus",    nickname: "Caro",   base64Image: nil) }
    private var christina: Player           { return Player(firstName: "Christina", lastName: "Lang",       nickname: nil,      base64Image: nil) }
    private var andi: Player                { return Player(firstName: "Andreas",   lastName: "Lang",       nickname: "Andi",   base64Image: nil) }
    private var günther: Player             { return Player(firstName: "Günther",   lastName: "Bräuer",     nickname: nil,      base64Image: nil) }
    private var uli: Player                 { return Player(firstName: "Ulrike",    lastName: "Bräuer",     nickname: "Uli",    base64Image: nil) }
    private var django: Player              { return Player(firstName: "Rudi",      lastName: "Siegl",      nickname: "Django", base64Image: nil) }
    private var michelle: Player            { return Player(firstName: "Michelle",  lastName: "Siegl",      nickname: nil,      base64Image: nil) }
    
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


