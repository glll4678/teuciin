import CommonExtensions

extension Character {

        /// A Boolean value indicating whether this character represents a space or a tone number.
        var isSpaceOrTone: Bool {
                return self.isSpace || self.isCantoneseToneDigit
        }

        /// A Boolean value indicating whether this character represents a separator or a tone number.
        var isSeparatorOrTone: Bool {
                return self.isSeparator || self.isCantoneseToneDigit
        }

        /// A Boolean value indicating whether this character represents a space, or a separator, or a tone number.
        var isSpaceOrSeparatorOrTone: Bool {
                return self.isSpace || self.isSeparator || self.isCantoneseToneDigit
        }
}

extension Character {

        private static let reverseLookupTriggers: Set<Character> = ["r"]

        /// r / v / x / q
        var isReverseLookupTrigger: Bool {
                return Character.reverseLookupTriggers.contains(self)
        }
}
