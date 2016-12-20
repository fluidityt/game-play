import SpriteKit

public func printPB(_ name: String, node: SKNode) {
	print(name, node.physicsBody!.categoryBitMask, node.physicsBody!.collisionBitMask)
}

public struct PhysicsCategory {
	public static let none = UInt32(0)
	public static let ball = UInt32(10)
	public static let cyan = UInt32(2)
	public static let yellow = UInt32(4)
	public static let pink = UInt32(6)
}

public func viewConfig(scene: SKScene) -> SKView {
	let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height:320))
	sceneView.showsFPS = true
	sceneView.presentScene(scene)
	sceneView.showsPhysics = true

	return sceneView
}

public func makeNode(image: String, posX: Int, posY: Int,
                     scene: SKScene, parent: SKNode? = nil, catgegory: UInt32) -> SKSpriteNode {

	let newNode = SKSpriteNode(imageNamed: image)
	newNode.position = CGPoint(x: posX, y: posY)
	newNode.setScale(0.1)
	newNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: image),
	                                    alphaThreshold: 0,
	                                    size: newNode.size)
	newNode.physicsBody?.isDynamic = true
	newNode.physicsBody?.usesPreciseCollisionDetection = true

	newNode.physicsBody?.categoryBitMask = catgegory
	newNode.physicsBody?.collisionBitMask = PhysicsCategory.none
	if let par = parent {
		par.addChild(newNode)
	} else { scene.addChild(newNode) }
	return newNode
}

public func sceneConfig(scene: SKScene) {
	scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
	scene.backgroundColor = .white
	scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
	scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
	scene.physicsBody?.usesPreciseCollisionDetection = true
}



public func ballConfig(ball: SKSpriteNode) {
	ball.position = CGPoint(x:100,y: 50)
	ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
	guard let pb = ball.physicsBody else { return }
	pb.affectedByGravity = false
	pb.isDynamic = true
	pb.usesPreciseCollisionDetection = true
	//pb.resting
	pb.categoryBitMask = PhysicsCategory.ball
	pb.collisionBitMask = PhysicsCategory.yellow
	printPB("ball", node: ball)
}

