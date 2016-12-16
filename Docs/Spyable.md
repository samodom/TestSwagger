Spyable
=======

Classes with methods and/or properties upon which one would like to spy can benefit from adopting the `Spyable` protocol.


## Captured Evidence

Capturing evidence about method calls can be accomplished using object association or object serialization.

Evidence stored to file is associated with a simple filename string, so the type alias `SpyEvidenceFilename` has been created as another name for `String`.  Files are stored under a directory with the storing object's address as its name.

Methods currently available include only those for raw data.

```swift
func persistDataEvidence(_: Data, named: SpyEvidenceFilename)
func retrievePersistedDataEvidence(named: SpyEvidenceFilename) -> Data?
func clearPersistedEvidence(named: SpyEvidenceFilename)
```


In order to remove spy evidence, the following methods are provided for removing associated objects and deleting storage files for serialized data.  In the case of persisted evience, the spy evidence directory is also deleted if it is empty.

```swift
func clearCapturedSpyEvidence(for: Set<ObjectAssociationKey>)
func clearCapturedSpyEvidence(for: Set<SpyEvidenceFilename>)
```
