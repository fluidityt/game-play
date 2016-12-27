import SpriteKit

// Physics stuff:
public enum CategoryBitmasks: UInt32 {
	case white = 0x2A
	case gray = 0x2B
}


// Properties:
public class PT: SKScene {
	let whiteNode = SKSpriteNode(color: .black, size: CGSize(width: 100, height: 100))
	let grayNode = SKSpriteNode(color: .lightGray, size: CGSize(width: 100, height: 100))
	func configNodes() {
		print("configuring nodes...")
		whiteNode.position.x -= 55
		grayNode.position.x += 55
		whiteNode.physicsBody!.categoryBitMask = CategoryBitmasks.white.rawValue
		grayNode.physicsBody!.categoryBitMask = CategoryBitmasks.gray.rawValue

	}
}

// Load:
public extension PT {	override func didMove(to view: SKView) {
	// Nodes:
	let nodes = [whiteNode, grayNode]
	for node in nodes {
		addChild(node)
		node.position = CGPoint(x:frame.midX,y:frame.midY)
		node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
	}
	configNodes()

	// Physics:
	physicsWorld.gravity = CGVector(dx: 0, dy: 0)

	}}

// Touches Began:
public extension PT { override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

	}}

public extension PT { override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
	whiteNode.position = (touches.first?.location(in: self))!

	}}

// Update:
public extension PT { override func update(_ currentTime: TimeInterval) {

	}
}

