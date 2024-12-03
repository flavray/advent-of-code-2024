import Foundation

func readfile(filepath: String) -> [String] {
    return try! String(contentsOf: URL(fileURLWithPath: filepath))
        .components(separatedBy: "\n")
        .filter { $0.count > 0 }
}

extension Array {
    func compact<T>() -> [T] where Element == Optional<T> {
        var result = [T]()
        for element in self {
            if let element = element {
                result.append(element)
            }
        }
        return result
    }
}
