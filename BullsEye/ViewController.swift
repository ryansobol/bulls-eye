//
//  ViewController.swift
//  BullsEye
//
//  Created by Ryan Sobol on 11/17/17.
//  Copyright © 2017 Ryan Sobol Consulting LLC. All rights reserved.
//

import QuartzCore
import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

  var currentValue = 0
  var targetValue = 0
  var score = 0
  var round = 0

  func updateLabels() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    roundLabel.text = String(round)
  }

  func startNewRound() {
    round += 1
    targetValue = 1 + Int(arc4random_uniform(100))
    currentValue = 50
    slider.value = Float(currentValue)

    updateLabels()
  }

  func startNewGame() {
    score = 0
    round = 0

    startNewRound()

    let transition = CATransition()

    transition.type = kCATransitionFade
    transition.duration = 0.3
    transition.timingFunction = CAMediaTimingFunction(
      name: kCAMediaTimingFunctionEaseOut
    )

    view.layer.add(transition, forKey: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
    slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)

    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    let trackLeftResizeable = #imageLiteral(resourceName: "SliderTrackLeft").resizableImage(withCapInsets: insets)
    let trackRightResizable = #imageLiteral(resourceName: "SliderTrackRight").resizableImage(withCapInsets: insets)

    slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    startNewGame()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func moveSlider(_ slider: UISlider) {
    currentValue = Int(slider.value.rounded())
  }

  @IBAction func showAlert() {
    let difference = abs(currentValue - targetValue)
    var points = 100 - difference

    let title: String

    if difference == 0 {
      title = "Perfect!"
      points += 100
    }
    else if difference < 5 {
      title = "You almost had it!"

      if difference == 1 {
        points += 50
      }
    }
    else if difference < 10 {
      title = "Pretty good!"
    }
    else {
      title = "Not even close..."
    }

    score += points

    let message = "You scored \(points) points."

    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )

    let action = UIAlertAction(
      title: "OK",
      style: .default,
      handler: { _ in self.startNewRound() }
    )

    alert.addAction(action)

    present(alert, animated: false, completion: nil)
  }

  @IBAction func resetGame() {
    startNewGame()
  }
}

