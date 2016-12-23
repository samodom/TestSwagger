Spy
===

This library provides a base type for spying on method calls to ensure one of two things:

* a method on a particular object instance has been invoked (i.e., relying on a *direct invocation spy method*)
* a class calls its superclass's implementation of an inherited method (i.e., relying on an *inherited invocation spy method*)

These two types of spies have their own characteristics.


## Direct-Invocation Spying

Direct invocation spying is for ensuring that a particular object instance has had a method invoked on it, regardless of whether the particular class has overriden the method or whether any overriden method calls its superclass's implementation.  In order to do so, the object's class is put into a state where the particular implementation of the method is replaced with an evidence-capturing spy method.  That spy method may or may not then forward the call to the true implementation, forwarding the input(s) and returning the output(s) as necessary.  See [Spy Method Forwarding](#spy-method-forwarding).


## Inherited- (or Indirect-) Invocation Spying

Inherited invocation spying is for ensuring that a subclass overriding an inherited method does or does not invoke its superclass's implementation of that method.  In order to do so, the object's superclass is put into a state where the inherited implementation of the method is replaced with an evidence-capturing spy method.  That spy method may or may not then forward the call to the true implementation, forwarding the input(s) and returning the output(s) as necessary.  See [Spy Method Forwarding](#spy-method-forwarding).


## Method Forwarding

Each spy has a default behavior for forwarding the captured method call to the true implementation.  That default behavior may or may not be overriden depending on the particulars of the spy.  If allowed, the forwarding behavior may be changed by manipulating the `forwardsMethodCalls` flag.
