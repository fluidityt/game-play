import SpriteKit
import XCPlayground

boringSetupCode: do {
	let pt = PT(size: CGSize(width: 700, height: 325))
	let view = SKView(frame: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: 700, height: 325)))
	pt.backgroundColor = .white
	view.showsFPS = true
	view.presentScene(pt)

	XCPShowView(identifier: "My Scene", view: view)
}




