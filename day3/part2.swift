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

    let doRegex = Regex {
        ")(od"
    }

    let dontRegex = Regex {
        ")(t'nod"
    }

    return input.matches(of: regex).reduce(0) { acc, match in
        let subinput = String(input[..<match.range.lowerBound].reversed())
        let dontIndex = subinput.firstMatch(of: dontRegex)?.range.lowerBound
        let doIndex = subinput.firstMatch(of: doRegex)?.range.lowerBound

        guard dontIndex == nil || (doIndex != nil && doIndex! < dontIndex!) else { return acc }

        let (_, first, second) = match.output
        guard let first = first, let second = second else { return acc }

        return acc + first * second
    }
}

// MARK: - Test

let test_input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

assert(run(input: test_input) == 48)

// MARK: Part 2

let input = readfile(filepath: "day3/data/input.txt").joined(separator: "\n")

let result = run(input: input)

print("Result: \(result)")
