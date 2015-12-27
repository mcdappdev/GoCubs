//
//  CalendarParsingTests.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/27/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import Foundation
import XCTest
@testable import GoCubs

class CalendarParsingTests: XCTestCase {
  
  //MARK: - Tests
  
  func testParsingEventAtWrigley() {
    let eventString = "BEGIN:VEVENT\nDTSTART:20150406T000500Z\nDTEND:20150406T030500Z\nDTSTAMP:20151226T213654Z\nUID:413661@mlb.com\nCREATED:20151226T213654Z\nDESCRIPTION:FINAL: St. Louis Cardinals 3 - Chicago Cubs 0\\nWinning Pitcher: Wainwright, Adam\\nLosing Pitcher: Lester, Jon\\nSave Pitcher: Rosenthal, Trevor\\nWrigley Field, Chicago\\n\\nBuy tickets to a future game: http://mlb.mlb.com/ticketing/index.jsp?c_id=chc&affiliateId=iCal-SGT-chc\\n\\nClick below for a complete game wrap and box score plus video, photos, stats, gameday and more!\\nhttp://www.mlb.com/r/game?gid=2015_04_05_slnmlb_chnmlb_1\\n\\nWatch or Listen with MLB.TV:\\nhttp://mlb.mlb.com/mlb/subscriptions/index.jsp?product=mlbtv&affiliateId=ICAL\nLAST-MODIFIED:20151226T213654Z\nLOCATION:Wrigley Field\\, Chicago\nSUMMARY:FINAL: St. Louis Cardinals 3 - Chicago Cubs 0\nTRANSP:TRANSPARENT\nSEQUENCE:1451165814\nEND:VEVENT"
    
    guard let event = CalendarParser.parseEvent(eventString) else {
      XCTFail("Couldn't parse event string!")
      return
    }
    
    XCTAssertTrue(event.isAtWrigley)
    XCTAssertEqual(event.month, 4)
    XCTAssertEqual(event.day, 5)
    XCTAssertEqual(event.year, 2015)
    XCTAssertEqual(event.location, "Wrigley Field, Chicago")
    XCTAssertEqual(event.summary, "FINAL: St. Louis Cardinals 3 - Chicago Cubs 0")
    XCTAssertEqual(event.displayDescription, "FINAL: St. Louis Cardinals 3 - Chicago Cubs 0\nWinning Pitcher: Wainwright, Adam\nLosing Pitcher: Lester, Jon")
  }
  
  func testParsingEventNotAtWrigley() {
    let eventString = "BEGIN:VEVENT\nDTSTART:20160630T231000Z\nDTEND:20160701T021000Z\nDTSTAMP:20151226T213654Z\nUID:448047@mlb.com\nCREATED:20151226T213654Z\nDESCRIPTION:Chicago Cubs vs. New York Mets\\nFirst pitch: 7:10:00 PM EDT\\nCiti Field, Flushing\\n\\nBuy Tickets: http://mlb.mlb.com/ticketing/singlegame.jsp?c_id=nym&game=448047&affiliateId=iCal-SGT-chc\\n\\nClick below for a full game preview plus video, photos, stats, gameday and more!\\nhttp://www.mlb.com/r/game?gid=2016_06_30_chnmlb_nynmlb_1\\n\\nWatch or Listen with MLB.TV:\\nhttp://mlb.mlb.com/mlb/subscriptions/index.jsp?product=mlbtv&affiliateId=ICAL\nLAST-MODIFIED:20151226T213654Z\nLOCATION:Citi Field\\, Flushing\nSUMMARY:Chicago Cubs vs. New York Mets\nTRANSP:TRANSPARENT\nSEQUENCE:1451165814\nEND:VEVENT"
    
    
    guard let event = CalendarParser.parseEvent(eventString) else {
      XCTFail("Couldn't parse event string!")
      return
    }
    
    XCTAssertFalse(event.isAtWrigley)
    XCTAssertEqual(event.month, 6)
    XCTAssertEqual(event.day, 30)
    XCTAssertEqual(event.year, 2016)
    XCTAssertEqual(event.location, "Citi Field, Flushing")
    XCTAssertEqual(event.summary, "Chicago Cubs vs. New York Mets")
    XCTAssertEqual(event.displayDescription, "Chicago Cubs vs. New York Mets\nFirst pitch: 7:10:00 PM EDT\nCiti Field, Flushing")
  }
}