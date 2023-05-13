import Foundation
import Python

public enum PythonRuntime {
    public struct Proof {}
    
    @discardableResult
    public static func initialize(stdLibURL: URL, pipsURL: URL) -> Proof {
        let stdLibPath = stdLibURL.path
        let libDynloadPath = stdLibURL.appendingPathComponent("lib-dynload").path
        let pipsPath = pipsURL.path
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath):\(pipsPath)", 1)
        Py_Initialize()
        return .init()
    }
}
