Spying
======

1. [What is spying?](#what-is-spying?)
1. [Types of spies](#types-of-spies)
1. [Spy components](#spy-components)
  1. [Subjects](#subjects)
  1. [Spy methods](#spy-methods)
  1. [Evidence](#evidence)
    1. [Unique association keys](#unique-association-keys)
    1. [Persisting evidence to disk](#persisting-evidence-to-disk)
1. [Spy responsibilities](#spy-responsibilities)
  1. [Method swizzling](#method-swizzling)
  1. [Evidence cleanup](#evidence-cleanup)
1. [Defining a spy](#constructing-a-spy)
  1. [Spy controllers](#spy-controllers)
  1. [Construction](#construction)
    1. [Subject](#subject)
    1. [Construction](#construction)
1. [Using spies](#using-spies)
  1. [Context-based spying](#context-based-spying)
  1. [Switched spying](#switched-spying)
  1. [Method forwarding](#method-forwarding)

## What is spying?

Spying is a testing method that verifies software behavior by observing method calls.  Types upon which one spies are considered "spyable."  Special methods and controller types that manage spying behavior are called "spies."  Information gathered by spies about software behavior is called "evidence."

> **Definition:** *root spyable class* --
> the original class defining a test subject's spyable method


## Types of spies

This library provides a single class for spying on method calls to ensure one of two things.

* A method on a particular object instance has been invoked (i.e., relying on a *direct invocation spy method*).
* A class calls its superclass's implementation of an inherited method (i.e., relying on an *inherited invocation spy method*).


### Direct-invocation spying

Direct-invocation spying is used to ensure that a particular object instance has (or has not) had a method invoked on it, regardless of whether the particular class has overriden the method or whether any overriden method calls its superclass's implementation.  In order to do so, the object's class is put into a state where the particular implementation of the method is replaced with an evidence-capturing spy method.  That spy method may or may not then forward the call to the true implementation, forwarding the input(s) and returning the output(s) as necessary.


### Indirect-invocation (or inherited-method) spying

Indirect-invocation spying is used to ensure that a subclass overriding an inherited method does (or does not) invoke its superclass's implementation of that method.  In order to do so, the object's *superclass* is put into a state where the inherited implementation of the method is replaced with an evidence-capturing spy method.  That spy method may or may not then forward the call to the true implementation, forwarding the input(s) and returning the output(s) as necessary.


## Spy components

### Subjects

Spies have *subjects* (or targets) upon which they spy for method swizzling and evidence cleanup.  Depending on whether the spied methods are instance or class methods, spies are created with object instances or with classes.  Some common subject functionality is available by implementing the `ObjectSpyable` and `ClassSpyable` protocols.


### Spy methods

Spies operate by replacing the implementation of testable methods with *spy methods* that are used to capture evidence about calls to the spyable method.  These methods must have the same signature as the spyable methods in order to be used as a replacement.


### Evidence

Evidence of calls being made to methods can be captured by using *object association* on the subject or by *serializing objects* to the file system.  That evidence can then be made available through new properties on the subject.

> Example:
>
> Direct-invocation spying on `MyClass.someInstanceMethod(input:)` would suggest the introduction of two new instance properties on `MyClass` such as `someInstanceMethodCalled: Bool` and `someInstanceMethodInput: InputType?` which would be accessed using the subject instance.  The boolean flag indicating whether the method has been called would be stored on the subject using object association.  The input to the method would be stored using object association or file persistence, depending on the type and size of the input.  The same technique is used for class methods.


#### Persisting evidence to disk

Evidence stored to file is associated with a simple file path.


#### Common evidence reference

Since evidence can be stored using either object association or filesystem persistence, a single enumerated type is provided for specifying any type of evidence reference.

```swift
enum EvidenceReference {
	case association(key: ObjectAssociationKey)
	case serialization(path: String)
}
```


#### Evidence methods

Several convenience methods are included in the `ObjectSpyable` and `ClassSpyable` protocol implementations for simplifying the persistence, retrieval and clearing of evidence.  Any filesystem errors encountered are ignored so that these methods fail silently.


```swift
extension ObjectSpyable {
	func saveEvidence(_: Any, with: EvidenceReference)
	func loadEvidence(with: EvidenceReference) -> Any?
	func removeEvidence(with: EvidenceReference)
}
```

```swift
extension ClassSpyable {
	static func saveEvidence(_: Any, with: EvidenceReference)
	static func loadEvidence(with: EvidenceReference) -> Any?
	static func removeEvidence(with: EvidenceReference)
}
```


## Spy responsibilities

### Method swizzling

The mechanism behind spying is *method swizzling* wherein a method's implementation is temporarily replaced with an alternate implementation (from a *spy method*).  Invoking the original method by name will instead invoke the alternate method, capturing evidence in the process.  Depending on design choices, the alternate method may return a pre-set output or may invoke the original method, passing the test input(s) and returning the original method's output(s).


### Evidence cleanup

As a convenience for custom spies, evidence cleanup is automatic as long as the spyable type provides all references to the evidence.  For this reason, spy construction requires these references.


## Defining a spy

In order to create a spy, the are two components that must be provided by the root spyable: the *spy controller* and a constructor method.


### Spy controllers

A spy controller is a static group of values that provide information used in the construction of a spy.  These values include:

* the **root spyable class** (defined above)
* the **spy vector** (for specifying either direct- or indirect-invocation spying)
* the set of pairs of **selectors** identifying both the spyable and spy methods along with their method type (class or instance), each captured in a structure called `SpyCoselectors`
* the complete set of references to spy evidence expected to be collected on any call to the original method: see [Evidence References](#common-evidence-reference)
* the forwarding behavior to be used when calls are captured by the spy method: see [Method Forwarding Behavior](#method-forwarding-behavior)


### Spy constructors

### Subject

A spy subject must meet different requirements depending upon the type of spy:

| Vector/Method type | Requirement |
|:------------------:|:------------|
| **direct** / **instance** | The subject is an **object instance**  of the root spyable class or one of its subclasses.  |
| **direct** / **class** | The subject is an **class**  that is either the root spyable class or one of its subclasses. |
| **indirect** / **instance** | The subject is an **object instance of a subclass** of the root spyable class. |
| **indirect** / **class** | The subject is a **subclass** of the root spyable class. |


### Construction

As long as the spy controller being used provides the correct required information, spies can be created by passing the subject to the controller's `createSpy(on:)` method.


## Using spies

Spies provide two options for executing test code while spying.  The first is with a context using the `spy(on:)` method and providing a closure to execute while spying.  The second is a pair of methods to execute at the appropriate time during your test: `beginSpying()` and `endSpying()`.


### Context-based spying

> Example within a test method:
>
> ```swift
> func testSomething() {
> 	mySpy.spy {
> 		/// perform any necessary testing steps
> 		/// and assertions here
> 	}
> }
> ```


### Switched spying

> Example with test fixture managing the spy:
>
> ```swift
> override func setUp() {
> 	  super.setUp()
>
> 	  mySpy.beginSpying()
> }
>
> override func tearDown() {
> 	  mySpy.endSpying()
>
> 	  super.tearDown()
> }
>
> func testSomething() {
> 	  /// perform any necessary testing steps
> 	  /// and assertions here
> }
> ```

### Method forwarding

Spy controllers are responsible for providing the expected method forwarding behavior in their spy methods.  Controllers may be designed to always forward calls, never forward calls or permit user customization.  The `forwardsInvocations` property on `SpyController` is a boolean value that is immutable per the protocol.  Any implementing controller may make this property mutable.
