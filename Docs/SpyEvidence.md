Spy Evidence
============

## Unique Keys

In order to allocate memory with unique content that can be used as an object association key, the `UUIDKeyString` function is provided.  Keys are created by a simple wrapping call to the `ObjectAssociationKey` initializer.

```swift
let myKeyString = UUIDKeyString()
let myKey = ObjectAssociationKey(myKeyString)
```
