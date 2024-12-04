import RegexBuilder

func run(input: String) -> Int {
    let regex = Regex {
        "mul("
        Capture {
            OneOrMore(.digit)
        } transform: { substring -> Int? in
            guard substring.count <= 3 else { return nil }
            return Int(substring)
        }
        ","
        Capture {
            OneOrMore(.digit)
        } transform: { substring -> Int? in
            guard substring.count <= 3 else { return nil }
            return Int(substring)
        }
        ")"
    }

    return input.matches(of: regex).reduce(0) { acc, match in
        print(match.output)
        let (_, first, second) = match.output
        guard let first = first, let second = second else { return acc }

        return acc + first * second
    }
}

// MARK: - Test

let test_input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

assert(run(input: test_input) == 161)

// MARK: Part 1

let input = readfile(filepath: "day3/data/input.txt").joined(separator: "\n")

let result = run(input: input)

print("Result: \(result)")
