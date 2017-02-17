Other Testing Tools
===================

To facilitate passing the file and line of a test invocation for purposes of reporting test failures, a simple structure has been created: `CodeSource`.

```swift
struct CodeSource {
    let file: String
    let line: UInt
}
```


Accompanying this type is another failure-recording method defined on `XCTestCase` that also provides a default value for the `expected` parameter of the original method:

```swift
extension XCTestCase {
    func recordFailure(
        withDescription description: String,
        at: CodeSource,
        expected: Bool = true
    )
}
```
