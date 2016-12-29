import SpriteKit

// Properties:
public class PT: SKScene {
	public let topNode = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 50)),
						 midNode = SKSpriteNode(color: .gray,  size: CGSize(width: 50, height: 50)),
						 botNode = SKSpriteNode(color: .blue,  size: CGSize(width: 50, height: 50))
}

// Load:
 extension PT {

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
		botNode.physicsBody!.categoryBitMask = 4; botNode.physicsBody!.collisionBitMask = 2

		topNode.physicsBody!.contactTestBitMask = 4
		botNode.physicsBody!.contactTestBitMask = 2

	}

	override public func didMove(to view: SKView) {
		// Nodes:
		configNodes()

		// Scene:
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		physicsBody!.usesPreciseCollisionDetection = true
		physicsWorld.gravity = CGVector(dx: 0, dy: -1)

	}
}

// Game Loop:
public extension PT {

	override func update(_ currentTime: TimeInterval) {
		//print ( getCurrentMillis() )
		//timestampo =	CFAbsoluteTimeGetCurrent() - 504615200
	}

	override func didEvaluateActions() {

	}

	override func didSimulatePhysics() {

	}

	override func didApplyConstraints() {


	}

	override func didFinishUpdate() {

	}

}

// Touches Began:
public extension PT { override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	topNode.physicsBody!.applyForce(CGVector(dx: 0, dy: 700))
	midNode.physicsBody!.applyForce(CGVector(dx: 0, dy: 500))
	}}

// Touches Moved:
public extension PT { override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
	topNode.run(.move(to: touches.first!.location(in: self), duration: 0))

	}}

// Physics:
extension PT: SKPhysicsContactDelegate {

	public func setPhysicsDelegateToSelf() {
		physicsWorld.contactDelegate = self

	}
	// could set a timout phase in a dispatch with endcontact
	public func didBegin(_ contact: SKPhysicsContact) {
		print("hit detected")
		//topNode.physicsBody?.allContactedBodies()
		if contact.bodyA == topNode.physicsBody! { topNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))}
		if contact.bodyB == topNode.physicsBody! { topNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))}	}

}
