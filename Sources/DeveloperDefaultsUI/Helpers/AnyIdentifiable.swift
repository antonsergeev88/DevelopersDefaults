struct AnyIdentifiable<ID, Element>: Identifiable where ID: Hashable {
    let id: ID
    let element: Element
}

extension Sequence {
    func indexed() -> [AnyIdentifiable<Int, Element>] {
        enumerated().map { .init(id: $0.offset, element: $0.element) }
    }
}
