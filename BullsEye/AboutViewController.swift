//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Ryan Sobol on 11/18/17.
//  Copyright © 2017 Ryan Sobol Consulting LLC. All rights reserved.
//

import WebKit
import UIKit

class AboutViewController: UIViewController {
  @IBOutlet weak var webView: WKWebView!

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let url = Bundle.main.url(
      forResource: "BullsEye",
      withExtension: "html"
    )
    else {
      return
    }

    webView.loadFileURL(url, allowingReadAccessTo: url)

//    guard let htmlData = try? Data(contentsOf: url) else {
//      return
//    }
//
//    webView.load(
//      htmlData,
//      mimeType: "text/html",
//      characterEncodingName: "UTF-8",
//      baseURL: URL(fileURLWithPath: Bundle.main.bundlePath)
//    )
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }
}
