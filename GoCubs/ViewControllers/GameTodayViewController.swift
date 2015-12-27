//
//  GameTodayViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro on 12/26/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class GameTodayViewController: UIViewController {
  
  //MARK: - Properties
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var yesOrNoLabel: UILabel!
  @IBOutlet var detailsLabel: UILabel!
  @IBOutlet var closeButton: UIButton!
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.localizeAndAccessibilize()
    self.findOutIfTheresAGameToday()
  }
  
  private func localizeAndAccessibilize() {
    self.titleLabel.text = LocalizedString.gameTodayTitle
    self.closeButton.accessibilityLabel = AccessibilityString.closeButton
  }
  
  //MARK: - IBActions
  
  @IBAction private func close() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  //MARK: - Network
  
  private func findOutIfTheresAGameToday() {
    var gameDate: NSDate
    if let
      month = LaunchEnvironmentKey.MonthToTest.processInfoValue(),
      monthInt = Int(month),
      day = LaunchEnvironmentKey.DayToTest.processInfoValue(),
      dayInt = Int(day),
      year = LaunchEnvironmentKey.YearToTest.processInfoValue(),
      yearInt = Int(year) {
        
        let dateComponents = NSDateComponents()
        dateComponents.month = monthInt
        dateComponents.day = dayInt
        dateComponents.year = yearInt
        if let date = NSCalendar.currentCalendar().dateFromComponents (dateComponents) {
          gameDate = date
        } else {
          assertionFailure()
          //In production: Just use today's date
          gameDate = NSDate()
        }
    } else {
      //Things weren't passed in, actualy use today's date.
      gameDate = NSDate()
    }
    
    self.findOutIfTheresAGameForDate(gameDate)
  }
  
  func findOutIfTheresAGameForDate(date: NSDate) {
    self.dateLabel.text = NSDateFormatter.cub_longDateFormatter.stringFromDate(date)
    
    //Since we have to ask the interwebs, show something during loading.
    self.yesOrNoLabel.text = LocalizedString.gameTodayLoading
    CubsGameChecker.isThereAGameForDate(date, failure: {
      [weak self]
      error in
      self?.configureForError(error)
      }) {
        [weak self]
        isThereAGame, details in
        self?.configureForGame(isThereAGame, details: details)
    }
  }
  
  private func configureForGame(isThereAGame: Bool, details: String) {
    if isThereAGame {
      self.yesOrNoLabel.text = LocalizedString.gameTodayPositive
    } else {
      self.yesOrNoLabel.text = LocalizedString.gameTodayNegative
    }
    
    self.detailsLabel.text = details
  }
  
  private func configureForError(error: NSError) {
    self.yesOrNoLabel.text = LocalizedString.gameTodayError
    self.detailsLabel.text = error.localizedDescription
  }
}