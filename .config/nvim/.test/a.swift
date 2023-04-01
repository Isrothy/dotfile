class foo: Equatable {
    var bar: Int
    init() {
        bar = 0
    }

    static func == (lhs: foo, rhs: foo) -> Bool {
        return lhs.bar == rhs.bar
    }
}
