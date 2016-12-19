//: Playground - noun: a place where people can play

import UIKit
import UIKit
import SpriteKit
import XCPlayground

class GameScene: SKScene {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		print("hey")
	}
}

let scene = GameScene(size: CGSize(width: 320, height: 240))
scene.backgroundColor = .white

XCPShowView(identifier: "My Scene", view: initializeView(scene: scene))
