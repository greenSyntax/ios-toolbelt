
extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Dictionary {
    
    /// Merge two dictionaries, if they have common keys, it will be replaced by passed dictionary value.
    ///
    /// - Parameter dictionary: dictionary to be merged
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
}
