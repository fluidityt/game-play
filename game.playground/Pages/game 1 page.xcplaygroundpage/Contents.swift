//: Playground - noun: a place where people can play

import SpriteKit
import XCPlayground
import PlaygroundSupport

// catNode = childNodeWithName("//cat_body") as! CatNode
// can set multiple objects with same name


class GameScene: SKScene, SKPhysicsContactDelegate {

	let nodes = (base: SKNode(),
	             ball: SKSpriteNode(color: .blue, size: CGSize(width: 35, height: 35)))

	let sensitivity = (minCur: 0.006,
	                   maxCur: 0.85,
	                   divCur: 6.0)


	var time        = (lastFrame:  TimeInterval(),
	                   delta:			 TimeInterval(),
	                   isFirstrun: true)

	override func didMove(to view: SKView) {
		ballConfig(ball: nodes.ball)
		addChild(nodes.base); addChild(nodes.ball)
		physicsWorld.contactDelegate = self
		nodes.ball.parent!.physicsBody!.contactTestBitMask = PhysicsCategory.ball

	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

		typealias Angle = CGFloat
		enum ClockDirection { case wise, counterWise }

		secondTouch: do {
			nodes.ball.position = touches.first!.location(in: self)
		}

		firstTouch: do {
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
		_ = {
		touches.first!.location(in: self).x > touches.first!.previousLocation(in: self).x // Move right
			? ( self.nodes.base.zRotation += spin(direction: ClockDirection.wise))
			: ( self.nodes.base.zRotation += spin(direction: ClockDirection.counterWise))
		}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
	}

	func didBegin(_ contact: SKPhysicsContact) {

		print("hi")
		let collision = contact.bodyA.categoryBitMask
		let collision2 = contact.bodyB.categoryBitMask
		print(collision2)

		if collision == PhysicsCategory.ball | PhysicsCategory.yellow {
			print("ok")
		}
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
//
//
// MARK: implement:
//
//

let scene = GameScene(size: CGSize(width: 320, height: 240))
sceneConfig(scene: scene)

let (top, right, left) = (makeNode(image: "top",   posX: 0, posY: 0, scene: scene, parent: scene.nodes.base, catgegory: PhysicsCategory.cyan),
                          makeNode(image: "right", posX: 0, posY: 0, scene: scene, parent: scene.nodes.base, catgegory: PhysicsCategory.yellow),
                          makeNode(image: "left",  posX: 0, posY: 0, scene: scene, parent: scene.nodes.base, catgegory: PhysicsCategory.pink)
) // printPB("top ", node: top); printPB("righ", node: right); printPB("left", node: left)

//left.parent!.physicsBody!.contactTestBitMask = PhysicsCategory.yellow

XCPShowView(identifier: "My Scene", view: viewConfig(scene: scene))
