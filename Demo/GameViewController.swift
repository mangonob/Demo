//
//  GameViewController.swift
//  Demo
//
//  Created by Trinity on 2019/9/6.
//  Copyright © 2019 Trinity. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            view.presentScene(buildSpineboyLoop(size: view.bounds.size))
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func buildSpineboyLoop(size: CGSize) -> SKScene {
        let scene = SKScene(size: size)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .white
        
        let skeleton = DZSpineSceneBuilder.loadSkeletonName("spineboy", scale: 1)!
        let builder = DZSpineSceneBuilder.builder() as! DZSpineSceneBuilder
        let node = builder.node(with: skeleton, animationNames: ["walk", "jump", "walk"], loop: true)!
        spSkeleton_setSkinByName(skeleton.spineContext.pointee.skeleton, "default")

        let placeholder = SKNode()
        placeholder.position = CGPoint(x: size.width / 2, y: size.height / 3)
        placeholder.addChild(node)
        scene.addChild(placeholder)
        return scene
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
