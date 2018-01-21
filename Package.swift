
import PackageDescription
let package = Package(
    name: "swifty-server",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 3),
        ]
)
