extension Sequence {
    func grouped<V>(by keyPath: KeyPath<Element, V>) -> [[Element]] where V: Equatable {
        var groups: [[Element]] = []
        var previousElement: Element?
        for element in self {
            defer { previousElement = element }
            if let previousElement = previousElement {
                if previousElement[keyPath: keyPath] == element[keyPath: keyPath] {
                    groups[groups.count - 1] += [element]
                } else {
                    groups.append([element])
                }
            } else {
                groups = [[element]]
            }
        }
        return groups
    }
}
