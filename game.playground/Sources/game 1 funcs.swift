import SpriteKit

public func initializeView(scene: SKScene) -> SKView {
	let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height:320))
	sceneView.showsFPS = true
	sceneView.presentScene(scene)
	return sceneView
}

public func makeNode(image: String, posX: Int, posY: Int, scene: SKScene, parent: SKNode? = nil) -> SKSpriteNode {
	let newNode = SKSpriteNode(imageNamed: image)
	newNode.position = CGPoint(x: posX, y: posY)
	newNode.setScale(0.1)
	if let par = parent {
		par.addChild(newNode)
	} else { scene.addChild(newNode) }
	return newNode
}