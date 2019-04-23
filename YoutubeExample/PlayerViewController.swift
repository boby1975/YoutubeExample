//
//  PlayerViewController.swift
//  YoutubeExample
//
//  Created by iMAC on 4/22/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit


class PlayerViewController: PullUpController {
    
    // MARK: - IBOutlets
    @IBOutlet public weak var label: UILabel!
    
    @IBOutlet private weak var separatorView: UIView!{
        didSet {
            separatorView.layer.cornerRadius = separatorView.frame.height/2
        }
    }
    

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        willMoveToStickyPoint = { point in
            print("willMoveToStickyPoint \(point)")
        }
        
        didMoveToStickyPoint = { point in
            print("didMoveToStickyPoint \(point)")
        }
        
        onDrag = { point in
            print("onDrag: \(point)")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.cornerRadius = 16
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print ("PlayerViewControllerWillAppear")
        pullUpControllerMoveToVisiblePoint(35, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print ("PlayerViewControllerDidAppear")
    }
    
    // MARK: - PullUpController
    override var pullUpControllerPreferredSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.80 )
    }
 
    override var pullUpControllerPreviewOffset: CGFloat {
        return 35
    }
    
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        return [UIScreen.main.bounds.height*0.40]
    }
    
    override var pullUpControllerIsBouncingEnabled: Bool {
        return false
    }
    
    override var pullUpControllerPreferredLandscapeFrame: CGRect {
        return CGRect(x: 5, y: 5, width: 280, height: UIScreen.main.bounds.height - 10)
    }
}

