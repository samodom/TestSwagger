Common properties are all type-level:
  - root class (used for both validation and association creation)
  - original and spy selectors -- both are defined initially by the root class and they always produce the true methods/implementations for any subclass even if the root class was used in the creation of the selector
  - method call forwarding flag


Direct Spy
  Requirements:
    - (class method) the subject is the spy's root class or one of its subclasses
    - (instance method) the subject is an instance of the spy's root class or one of its subclasses

  Properties - type-level:
    - (class method) the subject class

  Properties - instance-level:
    - (instance method) the subject instance

  Property persistence:
    - (class method) TBD
    - (instance method) the subject instance

  Evidence persistence:
    - (class method) TBD
    - (instance method) the subject instance


Indirect spy
  Requirements:
    - (class method) the subject is strictly a subclass (directly or transitively) of the spy's root class
    - (instance method) the subject is an instance of strictly a subclass (directly or transitively) of the spy's root class

  Properties - type-level:
    - (class method) the subject class

  Properties - instance-level:
    - (instance method) the subject instance

  Property persistence:
    - (class method) TBD
    - (instance method) the subject instance

  Evidence persistence:
    - (class method) TBD
    - (instance method) the subject instance
