import SpriteKit

// Properties:
public class PT: SKScene {
	public let topNode = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 50)),
						 midNode = SKSpriteNode(color: .gray,  size: CGSize(width: 50, height: 50)),
						 botNode = SKSpriteNode(color: .blue,  size: CGSize(width: 50, height: 50))
}

// Load:
public extension PT {

	// Util:
	private func configNodes() { print("configuring nodes...")

		// General setup for all nodes:
		let nodes = [topNode, midNode, botNode]
		for node in nodes {
			addChild(node)
			node.position		 = CGPoint(x:frame.midX,y:frame.midY)
			node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
			node.physicsBody!.usesPreciseCollisionDetection = true
			node.physicsBody!.isDynamic = true
		}

		// Node-specific setup:
		topNode.position.y += 100
		botNode.position.y -= 100

		topNode.physicsBody!.categoryBitMask = 2; topNode.physicsBody!.collisionBitMask = 4
		midNode.physicsBody!.categoryBitMask = 2; midNode.physicsBody!.collisionBitMask = 4
		botNode.physicsBody!.categoryBitMask = 4; //botNode.physicsBody!.collisionBitMask = 2
	}

	override func didMove(to view: SKView) {
		// Nodes:
		configNodes()

		// Scene:
		physicsWorld.gravity = CGVector(dx: 0, dy: -1)
	}
}

// Touches Began:
public extension PT { override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	topNode.physicsBody!.applyForce(CGVector(dx: 0, dy: 700))
	midNode.physicsBody!.applyForce(CGVector(dx: 0, dy: 500))
	}}

public extension PT { override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
	//whiteNode.position = (touches.first?.location(in: self))!

	}}

// Update:
public extension PT { override func update(_ currentTime: TimeInterval) {

	}
}

