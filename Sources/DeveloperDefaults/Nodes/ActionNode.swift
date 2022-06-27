public class ActionNode: Node {
    public let action: () -> Void

    init(action: @escaping () -> Void, group: Int) {
        self.action = action
        super.init(group: group)
    }
}
