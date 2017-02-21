//
//  GoCubsUITests.swift
//  GoCubsUITests
//
//  Created by Ellen Shapiro on 10/12/15.
//  Copyright © 2015 Designated Nerd Software. All rights reserved.
//

import XCTest

class GoCubsXCUITests: XCTestCase, RobotTests {
    
    var basicRobot: BasicRobot = XCUIRobot()
    var listRobot: GameListRobot = XCUIRobot()
    var detailRobot: GameDetailRobot = XCUIRobot()

    override func setUp() {
        super.setUp()
        self.launchToGameList()
    }
    
    //MARK: - Actual Tests
    
    func testKnownPostseasonWin() {
        self.verifyKnownPostseasonWin()
    }
    
    func testKnownPostseasonLoss() {
        self.verifyKnownPostseasonLoss()
    }
    
    func testKnownRegularSeasonWin() {
        self.verifyKnownRegularSeasonWin()
    }
    
    func testKnownRegularSeasonLoss() {
        self.verifyKnownRegularSeasonLoss()
    }
    
    func testKnownRegularSeasonPostponement() {
        self.verifyKnownRegularSeasonPostponement()
    }
}