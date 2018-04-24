//
//  ViewController.swift
//  Demo
//
//  Created by Artur Rymarz on 19.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import UIKit
import VariousViewsEffects

class ViewController: UIViewController {
    @IBOutlet weak var exampleView: UIView?

    @IBAction func explode(_ sender: Any) {
        exampleView?.explode(completion: {
            self.reshowImage()
        })
    }

    @IBAction func breakGlass(_ sender: Any) {
        exampleView?.breakGlass(size: GridSize(columns: 15, rows: 21), completion: {
            self.reshowImage()
        })
    }

    @IBAction func showSnowflakes(_ sender: Any) {
        exampleView?.addSnowflakes(amount: 10, speed: .slow)
    }

    private func reshowImage() {
        self.exampleView?.alpha = 0
        self.exampleView?.isHidden = false

        UIView.animate(withDuration: 1, animations: {
            self.exampleView?.alpha = 1
        })
    }
}
