//: Playground - noun: a place where people can play

import SpriteKit
import XCPlayground
import PlaygroundSupport


class GameScene: SKScene {

	let nodes = (base: SKNode(),
	             empty: SKNode())

	let sensitivity = (minCur: 0.006,
	                   maxCur: 0.85,
	                   divCur: 6.0)


	var time        = (lastFrame:  TimeInterval(),
	                   delta:			 TimeInterval(),
	                   isFirstrun: true)

	override func didMove(to view: SKView) {
		addChild(nodes.base)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

		typealias Angle = CGFloat
		enum ClockDirection { case wise, counterWise }

		// Gives us our raw next angle:
		func angleOffset() -> Angle {

			// Math:
			let x = abs(
				touches.first!.location(in: self).x
					- touches.first!.previousLocation(in: self).x
			)

			let y = x / frame.width
			var zz = y / CGFloat(time.delta)
			zz /= CGFloat(sensitivity.divCur)

			// Logic:
			let z = Double(zz)

			if      z > sensitivity.maxCur { return CGFloat( sensitivity.maxCur )}
			else if z < sensitivity.minCur { return CGFloat( sensitivity.minCur )}
			else													 { return CGFloat ( z ) }
		}

		// Tells us if positive or negative angle:
		func spin(direction: ClockDirection) -> Angle {
			if direction == .wise { return ( 0 - angleOffset() ) }
			else									{ return ( 0 + angleOffset() ) }
		}

		// Logic:
		touches.first!.location(in: self).x > touches.first!.previousLocation(in: self).x // Move right
			? ( nodes.base.zRotation += spin(direction: ClockDirection.wise))
			: ( nodes.base.zRotation += spin(direction: ClockDirection.counterWise))
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
