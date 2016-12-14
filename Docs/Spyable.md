Spyable
=======

Classes with methods and/or properties upon which one would like to spy can benefit from adopting the `Spyable` protocol.


## Captured Evidence

Capturing evidence about method calls can be accomplished using object association or object serialization.

Evidence stored to file is associated with a simple filename string, so the type alias `EvidenceFilename` has been created as another name for `String`.  Files are stored under a directory with the storing object's address as its name.

Methods currently available include only those for raw data.

```swift
persistDataEvidence(_: Data, named: EvidenceFilename)

retrievePersistedDataEvidence(named: EvidenceFilename) -> Data?

clearPersistedEvidence(named: EvidenceFilename)
```

Since spies can capture evidence using object association and file serialization, a common protocol has been created to represent both types of capture key: `SpyCaptureKey`.

```swift
extension ObjectAssociationKey: SpyCaptureKey {}
extension EvidenceFilename: SpyCaptureKey {}
```

The `clearCapturedSpyEvidence(for: Set<SpyCaptureKey>)` method will remove associated objects and delete storage files for serialized data.  Unused directories will be deleted.
