
import PlaygroundSupport

print("hi.")


var x = 0
for i in 0...10 {
    x += i
    print(x)
 //   XCPCaptureValue("Value for x", value: x)
}

PlaygroundPage.current.finishExecution()