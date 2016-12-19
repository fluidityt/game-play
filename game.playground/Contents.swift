//: Playground - noun: a place where people can play

import UIKit
import UIKit
import SpriteKit
import XCPlayground

class GameScene: SKScene {

	let nodes = (base: SKNode(),
	             empty: SKNode())

	var sensitivity = (minCur: 0.006,
	                   maxCur: 0.85,
	                   divCur: 6.0,
	                   curCur: 0.2)

	var time        = (lastFrame:  TimeInterval(),
	                   delta:			 TimeInterval(),
	                   isFirstrun: true)

	override func didMove(to view: SKView) {
		addChild(nodes.base)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		func setSensDotCur() {
			let x = abs(
				touches.first!.location(in: self).x
					- touches.first!.previousLocation(in: self).x
			)

			let y = x / frame.width
			var zz = y / CGFloat(time.delta)
			zz /= CGFloat(sensitivity.divCur)

			let z = Double(zz)
			if z > sensitivity.maxCur			 { sensitivity.curCur = sensitivity.maxCur }
			else if z < sensitivity.minCur { sensitivity.curCur = sensitivity.minCur }
			else { sensitivity.curCur = z }
		}
		func spinClockwise() {
			nodes.base.zRotation -= CGFloat(sensitivity.curCur)
		}
		func spinCounterClockwise() {
			nodes.base.zRotation += CGFloat(sensitivity.curCur)
		}
		// Implement:
		setSensDotCur()
		touches.first!.location(in: self).x > touches.first!.previousLocation(in: self).x // Move right
			? spinClockwise()
			: spinCounterClockwise()
		print(sensitivity.curCur)
	}

	override func update(_ currentTime: TimeInterval) {

		// Initial stuff:
		if time.isFirstrun {
			time.lastFrame = currentTime
			time.isFirstrun = false
			return
		}

		// Time stuff:
		time.delta = (currentTime - time.lastFrame)
		time.lastFrame = currentTime
	}
}

// MARK: implement:

let scene = GameScene(size: CGSize(width: 320, height: 240))
scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
scene.backgroundColor = .white

let (top, right, left) = (makeNode(image: "top",   posX: 0, posY: 0, scene: scene, parent: scene.nodes.base),
                          makeNode(image: "right", posX: 0, posY: 0, scene: scene, parent: scene.nodes.base),
                          makeNode(image: "left",  posX: 0, posY: 0, scene: scene, parent: scene.nodes.base)
)

XCPShowView(identifier: "My Scene", view: initializeView(scene: scene))
