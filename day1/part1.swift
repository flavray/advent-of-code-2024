func run(input: [(Int, Int)]) -> Int {
    var (first, second) = input.reduce(into: ([Int](), [Int]())) { acc, item in
        acc.0.append(item.0)
        acc.1.append(item.1)
    }

    first.sort()
    second.sort()

    return zip(first, second).reduce(into: 0) { acc, item in
        acc += abs(item.0 - item.1)
    }
}

// MARK: - Test

let test_input = [(3, 4), (4, 3), (2, 5), (1, 3), (3, 9), (3, 3)]
assert(run(input: test_input) == 11)

// MARK: - Part 1

let input = readfile(filepath: "day1/data/input.txt")
    .map { line in
        let components = line.components(separatedBy: "   ")
            .map(Int.init)

        return (components[0]!, components[1]!)
    }

let result = run(input: input)

print("Result: \(result)")
