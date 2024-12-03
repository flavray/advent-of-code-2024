func run(input: [[Int]]) -> Int {
    return input
        .filter { $0.valid() }
        .count
}

extension Array where Element == Int {
    func valid() -> Bool {
        if increasing() || decreasing() {
            return true
        }

        return [nonIncreasingIndex(), nonDecreasingIndex()]
            .compact()
            .filter { index in
                for i in [index, index+1] {
                    var copy = self
                    copy.remove(at: i)
                    if copy.increasing() || copy.decreasing() {
                        return true
                    }
                }

                return false
            }
            .count > 0
    }

    func nonIncreasingIndex() -> Int? {
        for i in 1...count-1 {
            let diff = self[i] - self[i-1]

            if diff < 1 || diff > 3 {
                return i-1
            }
        }

        return nil
    }

    func nonDecreasingIndex() -> Int? {
        for i in 1...count-1 {
            let diff = self[i-1] - self[i]

            if diff < 1 || diff > 3 {
                return i-1
            }
        }

        return nil
    }

    func increasing() -> Bool {
        guard count > 1 else { return true }

        for i in 1...count-1 {
            let diff = self[i] - self[i-1]

            if diff < 1 || diff > 3 {
                return false
            }
        }

        return true
    }

    func decreasing() -> Bool {
        guard count > 1 else { return true }

        for i in 1...count-1 {
            let diff = self[i-1] - self[i]

            if diff < 1 || diff > 3 {
                return false
            }
        }

        return true
    }
}

// MARK: - Test

let test_input = [
    [7, 6, 4, 2, 1],
    [1, 2, 7, 8, 9],
    [9, 7, 6, 2, 1],
    [1, 3, 2, 4, 5],
    [8, 6, 4, 4, 1],
    [1, 3, 6, 7, 9],
]

assert(run(input: test_input) == 4)

// MARK: Part 2

let input = readfile(filepath: "day2/data/input.txt")
    .map { line in
        line.components(separatedBy: " ")
            .map { Int($0)! }
    }


let result = run(input: input)

print("Result: \(result)")
