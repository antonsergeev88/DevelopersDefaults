import Foundation

extension String {
    func snakeCasedKey() -> String {
        let words = self.camelCaseWordRanges
        let result = words.map { range in
            self[range].lowercased()
        }.joined(separator: "_")
        return result
    }

    func capitalizedTitle() -> String {
        let words = self.camelCaseWordRanges
        let result = words.map { range in
            self[range].localizedCapitalized
        }.joined(separator: " ")
        return result
    }

    // stdlib implementation (JSONEncoder.swift)
    private var camelCaseWordRanges: [Range<String.Index>] {
        guard !self.isEmpty else { return [] }
        var words : [Range<String.Index>] = []
        var wordStart = self.startIndex
        var searchRange = self.index(after: wordStart)..<self.endIndex

        while let upperCaseRange = self.rangeOfCharacter(
            from: CharacterSet.uppercaseLetters,
            options: [],
            range: searchRange
        ) {
            let untilUpperCase = wordStart..<upperCaseRange.lowerBound
            words.append(untilUpperCase)

            searchRange = upperCaseRange.lowerBound..<searchRange.upperBound
            guard let lowerCaseRange = self.rangeOfCharacter(
                from: CharacterSet.lowercaseLetters,
                options: [],
                range: searchRange
            )
            else {
                wordStart = searchRange.lowerBound
                break
            }

            let nextCharacterAfterCapital = self.index(after: upperCaseRange.lowerBound)
            if lowerCaseRange.lowerBound == nextCharacterAfterCapital {
                wordStart = upperCaseRange.lowerBound
            } else {
                let beforeLowerIndex = self.index(before: lowerCaseRange.lowerBound)
                words.append(upperCaseRange.lowerBound..<beforeLowerIndex)
                wordStart = beforeLowerIndex
            }
            searchRange = lowerCaseRange.upperBound..<searchRange.upperBound
        }
        words.append(wordStart..<searchRange.upperBound)
        return words
    }
}
