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
    private var isWalked: Bool = true
    private var isMaleGoblins: Bool = true

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
        scene.backgroundColor = .lightGray
        
        let skeleton = DZSpineSceneBuilder.loadSkeletonName("spineboy", scale: 1)!
        let builder = DZSpineSceneBuilder.builder() as! DZSpineSceneBuilder
        let node = builder.node(with: skeleton, animationName: isWalked ? "walk" : "jump", loop: true)!
        
        let placeholder = SKNode()
        placeholder.position = CGPoint(x: size.width / 2, y: size.height / 3)
        placeholder.addChild(node)
        scene.addChild(placeholder)
        return scene
    }
    
    func buildGoblin(size: CGSize) -> SKScene {
        let scene = SKScene(size: size)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .lightGray

        let skeleton = DZSpineSceneBuilder.loadSkeletonName("goblins", scale: 1)!
        
        if isMaleGoblins {
            spSkeleton_setSkinByName(skeleton.spineContext.pointee.skeleton, "goblin")
        } else {
            spSkeleton_setSkinByName(skeleton.spineContext.pointee.skeleton, "goblingirl")
        }
        
        spSkeleton_setSlotsToSetupPose(skeleton.spineContext.pointee.skeleton)
        let builder = DZSpineSceneBuilder.builder() as! DZSpineSceneBuilder
        let node = builder.node(with: skeleton, animationName: "walk", loop: true)!

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
    
    @IBAction func jumpAction(_ sender: Any) {
        isWalked = !isWalked
        
        if let view = self.view as! SKView? {
            view.presentScene(buildSpineboyLoop(size: view.bounds.size))
        }
        
        (sender as? UIButton)?.setTitle(isWalked ? "Jump" : "Walk", for: .normal)
    }
    
    @IBAction func changeSkin(_ sender: Any) {
        isMaleGoblins = !isMaleGoblins

        if let view = self.view as! SKView? {
            view.presentScene(buildGoblin(size: view.bounds.size))
        }
    }
}
