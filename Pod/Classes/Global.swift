import Foundation

public var logging = false

func log(_ message: AnyObject) {
<<<<<<< Updated upstream
    if logging {
        print("[Eddystone] \(message)")
    }
}

func log(_ message: String) {
=======
>>>>>>> Stashed changes
    if logging {
        print("[Eddystone] \(message)")
    }
}

enum FrameType {
    case url, uid, tlm
}

typealias Byte = Int
