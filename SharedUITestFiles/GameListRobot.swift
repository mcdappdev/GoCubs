//
//  GameListRobot.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 2/20/17.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

import Foundation
import XCTest

//NOTE: @testable imports will no-op in XCUI bundles.
// Any file you use from the main app should also be added to the XCUI target.
@testable import GoCubs

//MARK: Game List Robot Protocol

protocol GameListRobot: BasicRobot {
    
    func tapCell(withDateText dateText: String,
                 gameText: String,
                 file: StaticString,
                 line: UInt)
}

//MARK: - Game List Robot default implementation

extension GameListRobot {
    
    func verifyOnGameList(file: StaticString = #file,
                          line: UInt = #line) {
        NSLog("Verify on game list")
        self.checkTableViewIsVisible(withAccessibilityIdentifier: AccessibilityString.gamesTableview,
                                     file: file,
                                     line: line)
    }
    
    func selectRow(forMonth month: Int,
                   day: Int,
                   homeTeam: Team,
                   awayTeam: Team,
                   file: StaticString = #file,
                   line: UInt = #line) {
        NSLog("Select row")
        let shortMonth = DateFormatter.cub_shortMonthName(for: month)
        let dateText = "\(shortMonth) \(day)"
        let gameText = LocalizedString.versus(awayTeam.rawValue,
                                              homeTeam: homeTeam.rawValue)
        self.tapCell(withDateText: dateText,
                     gameText: gameText,
                     file: file,
                     line: line)
    }
}
