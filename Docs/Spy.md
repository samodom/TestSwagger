Spy
===

A spy is a form of test double that captures invocations of one or more methods on a subject under test.  Captured information is referred to as *evidence*.


## Types Of Spies

This library provides a base type for spying on method calls to ensure one of two things:

* a method on a particular object instance has been invoked (i.e., relying on a *direct invocation spy method*)
* a class calls its superclass's implementation of an inherited method (i.e., relying on an *inherited invocation spy method*)

These two types of spies have their own characteristics.


### Direct-Invocation Spying

Direct invocation spying is for ensuring that a particular object instance has had a method invoked on it, regardless of whether the particular class has overriden the method or whether any overriden method calls its superclass's implementation.  In order to do so, the object's class is put into a state where the particular implementation of the method is replaced with an evidence-capturing spy method.  That spy method may or may not then forward the call to the true implementation, forwarding the input(s) and returning the output(s) as necessary.  See [Spy Method Forwarding](#spy-method-forwarding).


### Indirect-Invocation (or Inherited Method) Spying

Indirect invocation spying is for ensuring that a subclass overriding an inherited method does or does not invoke its superclass's implementation of that method.  In order to do so, the object's superclass is put into a state where the inherited implementation of the method is replaced with an evidence-capturing spy method.  That spy method may or may not then forward the call to the true implementation, forwarding the input(s) and returning the output(s) as necessary.  See [Spy Method Forwarding](#spy-method-forwarding).


## Properties And Behaviors

### Subject

Spies have subjects for method swizzling and evidence cleanup.  Depending on whether the spied methods are instance or class methods, spies are created with object instances or with classes.

For example, spies for the `UIView` methods `layoutIfNeeded` (instance) and `animate(withDuration:animations:)` (class) might be created with statements such as the following:

```swift
let instanceSpy = UIView.createLayoutIfNeededSpy(on: myView)
let classSpy = UIView.createAnimateWithDurationAnimationsSpy(on: MyView.self)
```

In these examples, the subjects being used are `myView` and `MyView.self`, respectively.

### Construction

Users can create their own spies by using the two built-in types for direct- and indirect-invocation spying:

```swift
DirectInvocationSpy<Subject>.init?(
        on subject: Subject,
        rootClass: AnyClass,
        selectors: SpyCoselectors
)

IndirectInvocationSpy<Subject>.init?(
        on subject: Subject,
        rootClass: AnyClass,
        selectors: SpyCoselectors
}
```

Subjects must match the following requirements:

- (direct-spying on class methods) subjects must be the root spyable class or one of its subclasses
- (direct-spying on instance methods) subjects must be instances of the root spyable class or one of its subclasses
- (indirect-spying on class methods) subjects must subclasses of the root spyable class
- (indirect-spying on instance methods) subjects must be instances of a subclass of the root spyable class


### Context-based and non-context-based spying

Spies provide two options for executing test code while spying.  The first is with a context using the `spy(on:)` method and providing a closure to execute while spying.  The second is a pair of methods to execute at the appropriate time during your test: `beginSpying()` and `endSpying()`.

Context-based example within a test method:

```swift
func testSomething() {
	mySpy.spy {
		/// perform any necessary testing steps
		/// and assertions here
	}
}
```

Non-context-based example with test fixture managing the spy:

```swift
override func setUp() {
	super.setUp()
	
	mySpy.beginSpying()
}

override func tearDown() {
	mySpy.endSpying()

	super.tearDown()
}

func testSomething() {
	/// perform any necessary testing steps
	/// and assertions here
}
```


### Spy Method Forwarding

Each spy has a default behavior for forwarding the captured method call to the true implementation.  That default behavior may or may not be overriden depending on the particulars of the spy.  If allowed, the forwarding behavior may be changed by manipulating the `forwardsMethodCalls` flag.

