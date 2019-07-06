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
    
    /// Matches added or edited by the user. Will be deleted when restarting the app.
    private var userMatches: [Match] = []
    
    /// The matches provided below. Those will be present with every app start.
    private var baseMatches: [Match] = []
    
    /// The combination of baseMatches and userMatches.
    var matches: [Match] { return baseMatches + userMatches }
    
    init() {
        baseGames = [activity, alhambra, arlerErde, aufAchse, azul, bearsVsBabies, cafeInternational, camelUp, campanile, carcassonne, dixit, explodingKittens, ganzSchönClever, haltMalKurz, heckmeckAmBratwurmeck, isleOfSkye, istanbul, kniffel, ligretto, marcoPolo, mauMau, orleans, phase10, pioneers, qwirkle, qwixx, raceToNewFoundLand, robinsonCrusoe, romme, safeHouse, schlagDenRaab, schüttels, speedCups, spiel, stechen, taKe, ubongo, ulm, uno, village, wizard, woodlands, sevenWondersDuel]
        basePlayers = [sandra, benno, norbert, gabi, urban, franziS, doris, phips, franziH, markus, andrea, alex, caro, christina, andi, günther, uli, django, michelle]
        baseMatches = [match01, match02, match03, match04, match05, match06, match07, match08, match09, match10, match11, match12, match13, match14, match15, match16, match17, match18, match19, match20, match21]
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
    
    // MARK: - Mocked Scores
    private var score01benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: true,      value: 100) }
    private var score01sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 99) }
    
    private var score02benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 55) }
    private var score02sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 88) }
    private var score02urban: Score         { return Score(player: urban,       isScoreOfStartingPlayer: true,      value: 66) }
    private var score02franzi: Score        { return Score(player: franziS,     isScoreOfStartingPlayer: false,     value: 77) }
    
    private var score03benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 1) }
    private var score03sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 5) }
    private var score03norbert: Score       { return Score(player: norbert,     isScoreOfStartingPlayer: true,      value: 3) }
    private var score03gabi: Score          { return Score(player: gabi,        isScoreOfStartingPlayer: false,     value: 4) }
    
    private var score04benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 30) }
    private var score04sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 28) }
    
    private var score05benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 15) }
    private var score05sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 14) }
    private var score05django: Score        { return Score(player: django,      isScoreOfStartingPlayer: false,     value: 13) }
    private var score05michelle: Score      { return Score(player: michelle,    isScoreOfStartingPlayer: true,      value: 12) }
    
    private var score06benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 300) }
    private var score06sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 212) }
    
    private var score07benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 38) }
    private var score07sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 28) }
    private var score07markus: Score        { return Score(player: markus,      isScoreOfStartingPlayer: false,     value: 40) }
    private var score07andrea: Score        { return Score(player: andrea,      isScoreOfStartingPlayer: true,      value: 27) }
    
    private var score08benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 300) }
    private var score08sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 280) }
    private var score08doris: Score         { return Score(player: doris,       isScoreOfStartingPlayer: true,      value: 297) }
    
    private var score09benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 10) }
    private var score09sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 14) }
    private var score09alex: Score          { return Score(player: alex,        isScoreOfStartingPlayer: true,      value: 9) }
    private var score09caro: Score          { return Score(player: caro,        isScoreOfStartingPlayer: false,     value: 11) }
    
    private var score10benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 21) }
    private var score10sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 28) }
    
    private var score11benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: true,      value: 50) }
    private var score11sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 48) }
    
    private var score12benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 6) }
    private var score12sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 4) }
    private var score12günther: Score       { return Score(player: günther,     isScoreOfStartingPlayer: false,     value: 8) }
    private var score12uli: Score           { return Score(player: uli,         isScoreOfStartingPlayer: true,      value: 9) }
    
    private var score13benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 30) }
    private var score13sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 28) }
    private var score13christina: Score     { return Score(player: christina,   isScoreOfStartingPlayer: false,     value: 30) }
    private var score13andi: Score          { return Score(player: andi,        isScoreOfStartingPlayer: true,      value: 28) }
    
    private var score14benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 1) }
    private var score14sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 2) }
    
    private var score15benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 31) }
    private var score15sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 28) }
    
    private var score16benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: true,      value: 19) }
    private var score16sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 21) }
    
    private var score17benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 8) }
    private var score17sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 7) }
    private var score17norbert: Score       { return Score(player: norbert,     isScoreOfStartingPlayer: false,     value: 6) }
    private var score17gabi: Score          { return Score(player: gabi,        isScoreOfStartingPlayer: false,     value: 5) }
    
    private var score18benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 30) }
    private var score18sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: true,      value: 28) }
    
    private var score19benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: false,     value: 500) }
    private var score19sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 399) }
    private var score19doris: Score         { return Score(player: doris,       isScoreOfStartingPlayer: true,      value: 486) }
    
    private var score20benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: true,      value: 37) }
    private var score20sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 27) }
    private var score20phips: Score         { return Score(player: phips,       isScoreOfStartingPlayer: false,     value: 30) }
    private var score20franzi: Score        { return Score(player: franziH,     isScoreOfStartingPlayer: false,     value: 32) }
    
    private var score21benno: Score         { return Score(player: benno,       isScoreOfStartingPlayer: true,      value: 8) }
    private var score21sandra: Score        { return Score(player: sandra,      isScoreOfStartingPlayer: false,     value: 9) }
    
    // MARK: - Mocked Matches
    private var match01: Match {
        return Match(date: Date(timeIntervalSince1970: 1561104000), game: kniffel, scores: [score01benno, score01sandra])
    }
    private var match02: Match {
        return Match(date: Date(timeIntervalSince1970: 1561017600), game: woodlands, scores: [score02benno, score02sandra, score02urban, score02franzi])
    }
    private var match03: Match {
        return Match(date: Date(timeIntervalSince1970: 1560931200), game: ulm, scores: [score03benno, score03sandra, score03norbert, score03gabi])
    }
    private var match04: Match {
        return Match(date: Date(timeIntervalSince1970: 1560844800), game: haltMalKurz, scores: [score04benno, score04sandra])
    }
    private var match05: Match {
        return Match(date: Date(timeIntervalSince1970: 1560758400), game: ganzSchönClever, scores: [score05benno, score05sandra, score05django, score05michelle])
    }
    private var match06: Match {
        return Match(date: Date(timeIntervalSince1970: 1560672000), game: spiel, scores: [score06benno, score06sandra])
    }
    private var match07: Match {
        return Match(date: Date(timeIntervalSince1970: 1560585600), game: qwixx, scores: [score07benno, score07sandra, score07markus, score07andrea])
    }
    private var match08: Match {
        return Match(date: Date(timeIntervalSince1970: 1560499200), game: azul, scores: [score08benno, score08sandra, score08doris])
    }
    private var match09: Match {
        return Match(date: Date(timeIntervalSince1970: 1560412800), game: activity, scores: [score09benno, score09sandra, score09alex, score09caro])
    }
    private var match10: Match {
        return Match(date: Date(timeIntervalSince1970: 1560326400), game: ubongo, scores: [score10benno, score10sandra])
    }
    private var match11: Match {
        return Match(date: Date(timeIntervalSince1970: 1560240000), game: istanbul, scores: [score11benno, score11sandra])
    }
    private var match12: Match {
        return Match(date: Date(timeIntervalSince1970: 1560153600), game: romme, scores: [score12benno, score12sandra, score12günther, score12uli])
    }
    private var match13: Match {
        return Match(date: Date(timeIntervalSince1970: 1560067200), game: mauMau, scores: [score13benno, score13sandra, score13christina, score13andi])
    }
    private var match14: Match {
        return Match(date: Date(timeIntervalSince1970: 1559980800), game: ligretto, scores: [score14benno, score14sandra])
    }
    private var match15: Match {
        return Match(date: Date(timeIntervalSince1970: 1559894400), game: aufAchse, scores: [score15benno, score15sandra])
    }
    private var match16: Match {
        return Match(date: Date(timeIntervalSince1970: 1559808000), game: bearsVsBabies, scores: [score16benno, score16sandra])
    }
    private var match17: Match {
        return Match(date: Date(timeIntervalSince1970: 1559721600), game: isleOfSkye, scores: [score17benno, score17sandra, score17norbert, score17gabi])
    }
    private var match18: Match {
        return Match(date: Date(timeIntervalSince1970: 1559635200), game: carcassonne, scores: [score18benno, score18sandra])
    }
    private var match19: Match {
        return Match(date: Date(timeIntervalSince1970: 1559548800), game: kniffel, scores: [score19benno, score19sandra, score19doris])
    }
    private var match20: Match {
        return Match(date: Date(timeIntervalSince1970: 1559462400), game: pioneers, scores: [score20benno, score20sandra, score20phips, score20franzi])
    }
    private var match21: Match {
        return Match(date: Date(timeIntervalSince1970: 1559376000), game: explodingKittens, scores: [score21benno, score21sandra])
    }
    
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
    
    // MARK: - Match Methods
    
    mutating func save(_ match: Match) {
        log.info("Match saved")
        userMatches.append(match)
    }
    
    mutating func modify(_ match: Match, toBe modifiedMatch: Match) {
        log.info("Match modified")
        if let baseMatchIndex = baseMatches.firstIndex(of: match) {
            baseMatches.remove(at: baseMatchIndex)
            baseMatches.insert(modifiedMatch, at: baseMatchIndex)
        } else if let userMatchIndex = userMatches.firstIndex(of: match) {
            userMatches.remove(at: userMatchIndex)
            userMatches.insert(modifiedMatch, at: userMatchIndex)
        } else {
            log.error("Original match of \(match.game.name) on \(match.date.shortDescription) not found"); return
        }
    }
    
}


