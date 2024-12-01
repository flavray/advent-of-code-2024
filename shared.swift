import Foundation

func readfile(filepath: String) -> [String] {
    return try! String(contentsOf: URL(fileURLWithPath: filepath))
        .components(separatedBy: "\n")
        .filter { $0.count > 0 }
}

