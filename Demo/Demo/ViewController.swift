//
//  ViewController.swift
//  Demo
//
//  Created by Artur Rymarz on 19.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var exampleView: UIView?

    @IBAction func startAnimation(_ sender: Any) {
//        exampleView?.breakAnimation(size: GridSize(columns: 15, rows: 21), removeAfterCompletion: true, completion: {
//            print("animation finished")
//        })

        exampleView?.explode()
    }
}
