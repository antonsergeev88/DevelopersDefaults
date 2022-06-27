public class InfoNode: Node {
    public let info: () -> String

    init(info: @escaping () -> String, group: Int) {
        self.info = info
        super.init(group: group)
    }
}
