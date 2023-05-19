import Foundation
import PythonKit

open class PythonInteractor<StoredObjectKey: Hashable & CaseIterable> {
    private let serialQueue = DispatchQueue(label: "pythonInteractorQueue", qos: .background)
    private var storage = [StoredObjectKey: PythonObject]()
    
    public init(
        proof _: PythonRuntime.Proof,
        scriptURL: URL,
        initializeStorage: @escaping (PythonObject, StoredObjectKey) -> PythonObject
    ) {
        let scriptPath = scriptURL.deletingLastPathComponent().path
        let scriptName = String(scriptURL.lastPathComponent.split(separator: ".")[0])
        
        serialQueue.async {
            let sys = Python.import("sys")
            sys.path.append(scriptPath)
            
            let script = Python.import(scriptName)
            for key in StoredObjectKey.allCases {
                self.storage[key] = initializeStorage(script, key)
            }
        }
    }
    
    public func execute<T>(
        accessing value: StoredObjectKey,
        _ action: @escaping (PythonObject) -> T
    ) async -> T {
        await withUnsafeContinuation { continuation in
            serialQueue.async {
                let result = action(self.storage[value]!)
                continuation.resume(with: .success(result))
            }
        }
    }
}
