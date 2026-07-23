---
title: Understanding SysML v2 Specialization Through Set Theory
description: SysML v2 has four specialization relationships — Subclassification, Feature Typing, Subsetting, and Redefinition. Their syntax differs, but they all rest on KerML's single notion of Specialization. This article ties them together through set theory, showing that Specialization is, at its core, a relationship that narrows the range of what is possible.
pubDate: Jul 23 2026
lang: en
translationKey: sysml-v2-specialization-set-theory
heroImage: ../../assets/understandingSpecialization.png
---
When you study SysML v2, the following relationships keep coming up.

```text
Subclassification
Feature Typing
Subsetting
Redefinition
```

These relationships differ in syntax and in what they apply to, but they all rest on one shared concept in KerML: `Specialization`.

If you memorize each one as a separate piece of syntax, the differences are hard to keep straight. But seen through set theory, they all connect to a single principle.

> **The set of cases a more specific model element allows is contained in the set of cases a more general model element allows.**

In other words, Specialization is, at its core, **a relationship that narrows the range of what is possible.**

---

## Design is a process of narrowing the set of possible solutions

Suppose we are designing a system.

At the start, we do not know exactly what the thing we want to build looks like. We only know that the possible designs form a very large set.

For example, in the early stage of designing a new vehicle, many possibilities may be open.

```text
All possible vehicle designs
├── Internal-combustion vehicles
├── Electric vehicles
├── Passenger vehicles
├── Commercial vehicles
├── Front-wheel-drive vehicles
├── Rear-wheel-drive vehicles
└── Many other combinations
```

We then add design conditions one at a time.

```text
It must be a passenger car.
It must use an electric motor.
It must seat five people.
It must meet a specific size and weight.
```

Each condition removes part of the space of possible designs.

Expressed as sets:

```text
All possible designs
⊇ Designs that satisfy the passenger-car condition
⊇ Designs that also satisfy the electric condition
⊇ Designs that also satisfy the five-seat condition
⊇ Designs that satisfy every design condition
```

The design process can ultimately be seen as this:

> **Adding constraints to locate a design target we do not yet know precisely, and gradually narrowing the set of possible solutions.**

If the set that remains at the end is specific enough, that set expresses the meaning of the system we set out to build.

From this perspective, Specialization in SysML v2 is not merely inheritance syntax.

Specialization is a core modeling means of adding constraints to a general system concept and narrowing it toward a more specific design concept.

---

## 1. A Type is a set of instances

In KerML, a Type is not just a name or a classification label.

Each Type corresponds to the set of all instances classified by that Type. This set is called the Type's **extent**.

Consider the following model.

```sysml
part def Vehicle;
part def Car :> Vehicle;
```

As sets, this is:

```text
extent(Vehicle)
= the set of all instances classified as Vehicle

extent(Car)
= the set of all instances classified as Car
```

Since every car is a vehicle, the following holds.

```text
extent(Car) ⊆ extent(Vehicle)
```

So `Car` specializing `Vehicle` means:

> Every instance classified as `Car` is necessarily also classified as `Vehicle`.

For an instance `c`, we can write:

```text
c ∈ extent(Car)
⇒ c ∈ extent(Vehicle)
```

The reverse does not necessarily hold.

```text
c ∈ extent(Vehicle)
⇏ c ∈ extent(Car)
```

Every car is a vehicle, but not every vehicle is a car.

---

## 2. Specialization adds constraints

Let (G) be a general Type and (S) a more specific Type.

Specialization can be understood as the following set-inclusion relationship.

```text
extent(S) ⊆ extent(G)
```

A specific Type does not allow more cases than a general Type. It allows only the portion of the general Type's cases that also satisfy an additional condition.

For example, we might have:

```text
extent(ElectricCar)
⊆ extent(Car)
⊆ extent(Vehicle)
```

Each step down adds a condition.

```text
Vehicle
→ the condition of being a vehicle

Car
→ the added condition of being a vehicle and a car

ElectricCar
→ the added condition of being a car and electrically driven
```

So Specialization is more accurately understood not as simply pulling in the content of a parent element, but as:

> **A relationship that preserves the meaning of the parent element while applying additional constraints.**

The accumulation of these constraints gradually narrows the set of possible instances.

---

# The four kinds of Specialization in SysML v2

In KerML, `Specialization` connects a specific Type and a general Type.

The forms you mainly encounter in SysML v2 are these four.

```text
Specialization
├── Subclassification
├── Feature Typing
├── Subsetting
└── Redefinition
```

All four narrow the range of what is possible, but they differ in **what** they narrow.

---

## 3. Subclassification: narrowing a Classifier's set of instances

`Subclassification` is Specialization between Classifiers.

```sysml
part def Vehicle;
part def Car :> Vehicle;
```

Here `Car` is the subclassifier and `Vehicle` is the superclassifier.

As sets:

```text
extent(Car) ⊆ extent(Vehicle)
```

`Car` is a more specific Classifier than `Vehicle`.

If `Vehicle` defines the general condition of being a vehicle, `Car` adds the further condition of being a car.

### The core of Subclassification

> **It defines the set of instances a Classifier represents more narrowly.**

Through Subclassification, a subordinate Classifier must satisfy all constraints of its superclassifier.

The fact that a subordinate Classifier inherits the Features of its superclassifier can be understood in the same light. Since every instance of the subordinate Classifier is an instance of the superclassifier, the structure and constraints that apply to the superclassifier also apply to the subordinate instances.

---

## 4. A Feature is a relationship between instances

To understand the remaining three relationships, we first need to look at KerML's Feature.

Consider the following model.

```sysml
part def Engine;
part def Vehicle {
    part engine : Engine;
}
```

`engine` is hard to see as merely a variable stored inside `Vehicle`.

In KerML, a Feature is a Type that classifies how the things present in a model relate to one another. The specification explains that a Feature connects instances in the extent of its featuring Type with instances in the extent of its featured Type.

Simplified set-theoretically, this can be written as:

```text
engine ⊆ extent(Vehicle) × extent(Engine)
```

That is, `engine` is a set of relationships made up of ordered pairs of `Vehicle` instances and `Engine` instances.

```text
engine = {
    (Vehicle1, Engine1),
    (Vehicle2, Engine2),
    ...
}
```

Each ordered pair means:

```text
(Vehicle1, Engine1)
Vehicle1 has Engine1
as the value of its engine Feature.
```

If a Type is a set of instances, a Feature can be seen as a **set of relationships** between instances.

---

## 5. Feature Typing: restricting the range of a Feature's value

In the following declaration:

```sysml
part engine : Engine;
```

`engine` is a Feature and `Engine` is the Type of that Feature.

The relationship connecting the two is `Feature Typing`.

Feature Typing restricts the range of what can be the value of the `engine` Feature.

```text
range(engine) ⊆ extent(Engine)
```

So the value of `engine` must be an instance classified as `Engine`.

```text
e ∈ range(engine)
⇒ e ∈ extent(Engine)
```

Feature Typing does not determine what value the Feature actually holds. Instead, it constrains the Type that value must belong to.

### The core of Feature Typing

> **It restricts the Type of value a Feature can hold.**

Compared with Subclassification:

```text
Subclassification
extent(Car) ⊆ extent(Vehicle)

Feature Typing
range(engine) ⊆ extent(Engine)
```

Subclassification narrows a Classifier's set of instances; Feature Typing narrows the range of a Feature's value.

---

## 6. Subsetting: defining a subset of a Feature's relationships

Consider the following model.

```sysml
part def Vehicle {
    part engine : Engine;
    part mainEngine subsets engine;
}
```

`mainEngine` subsets `engine`.

As sets, this can be written as:

```text
extent(mainEngine) ⊆ extent(engine)
```

Here both extents are sets of the relationship pairs a Feature represents.

For example, suppose the `engine` relationship is:

```text
engine = {
    (Vehicle1, EngineA),
    (Vehicle1, EngineB),
    (Vehicle2, EngineC)
}
```

Then `mainEngine` might be:

```text
mainEngine = {
    (Vehicle1, EngineA),
    (Vehicle2, EngineC)
}
```

Every relationship pair in `mainEngine` is also in `engine`.

```text
mainEngine ⊆ engine
```

So if a value is a value of `mainEngine`, it is necessarily also a value of `engine`.

```text
x ∈ mainEngine
⇒ x ∈ engine
```

But not every `engine` value needs to be a `mainEngine` value.

A subsetting Feature may have a more specific Type or a more restricted multiplicity than the subsetted Feature. The KerML specification likewise explains that a subsetting Feature may further restrict the featuring Type, featured Type, and multiplicity of the subsetted Feature.

### The core of Subsetting

> **It defines part of the relationships represented by an existing Feature as a more specific Feature.**

Subclassification and Subsetting have a similar set structure.

```text
Subclassification
extent of the specific Classifier
⊆ extent of the general Classifier

Subsetting
extent of the specific Feature
⊆ extent of the general Feature
```

The difference is what they apply to.

* Narrow a Classifier, and it is Subclassification.
* Narrow a Feature, and it is Subsetting.

---

## 7. Redefinition: adding contextual replacement to Subsetting

Redefinition may look similar to override in programming languages.

But if you understand it only as identical to override, it is easy to miss the **set-inclusion relationship** that Redefinition carries.

The KerML specification defines Redefinition clearly:

> **Redefinition is a kind of subsetting.**

That is, Redefinition is not a separate principle from Subsetting, but **a more specific relationship built on Subsetting.**

Consider the following model.

```sysml
part def Vehicle {
    part engine : Engine;
}
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor
        redefines Vehicle::engine;
}
```

First, `ElectricCar` is a Subclassification of `Vehicle`.

```text
extent(ElectricCar) ⊆ extent(Vehicle)
```

And `ElectricCar::engine` redefines `Vehicle::engine`.

Since Redefinition is a kind of Subsetting, it carries the following inclusion.

```text
extent(ElectricCar::engine)
⊆ extent(Vehicle::engine)
```

To this, Redefinition adds one further meaning of its own.

> In the context of the subordinate Type, the redefining Feature stands in for the inherited redefined Feature.

That is, Subsetting adds a new Feature representing part of a general Feature, whereas Redefinition takes a Feature inherited from a parent Type and replaces it with a version made more specific for the context of the current Type.

### In Redefinition, the values are not independent

Redefinition does not end with simply adding one narrower relationship.

According to the KerML specification, the redefining Feature and the redefined Feature must have the same value at each instance in the domain of the redefining Feature. So the Type or multiplicity restriction applied to the redefining Feature also affects the value of the redefined Feature.

For example:

```sysml
part def ElectricMotor :> Engine;
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor[1]
        redefines Vehicle::engine;
}
```

In the `ElectricCar` context, `engine` is further restricted as:

```text
range(ElectricCar::engine)
⊆ extent(ElectricMotor)
⊆ extent(Engine)
```

The multiplicity is also restricted to `[1]`.

This does not add a new Feature separate from `Vehicle::engine`. It uses the `engine` inherited from `Vehicle` under a more specific condition in the `ElectricCar` context.

### The core of Redefinition

> **Redefinition inherits the meaning of Subsetting while defining and replacing the inherited Feature more specifically in the context of the current Type.**

So it can be summarized as:

```text
Redefinition
= Subsetting
+ contextual replacement of the inherited Feature
+ a value-agreement constraint between the two Features
```

---

## 8. The difference between Subsetting and Redefinition

Both relationships define a more specific Feature.

But the modeling intent differs.

### Subsetting

```sysml
part def Vehicle {
    part engine : Engine[1..2];
    part mainEngine subsets engine;
}
```

`engine` and `mainEngine` coexist in different roles.

```text
mainEngine ⊆ engine
```

`mainEngine` represents the portion of the whole `engine` relationship that corresponds to the main engine.

### Redefinition

```sysml
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor[1]
        redefines Vehicle::engine;
}
```

`ElectricCar::engine` defines the inherited `Vehicle::engine` more specifically in the context of `ElectricCar`.

So they can be distinguished as follows.

```text
Subsetting
Defines a separate, more specific Feature
that represents part of an existing
Feature relationship.

Redefinition
Building on a Subsetting relationship,
defines the inherited Feature more
specifically in the current Type context
and uses it in place of the original.
```

Redefinition is not an entirely different relationship from Subsetting.

> **Every Redefinition is a Subsetting, but not every Subsetting is a Redefinition.**

As a set relationship:

```text
Redefinition ⊂ Subsetting
```

Here this expresses the classification structure of **kinds of relationships**, not the extent of a Feature.

---

# Comparing the four relationships at a glance

| Relationship      | Specific element | General element | What it narrows                                                              |
| ----------------- | ---------------- | --------------- | --------------------------------------------------------------------------- |
| Subclassification | Classifier       | Classifier      | A Classifier's set of instances                                             |
| Feature Typing    | Feature          | Type            | The range of values a Feature can hold                                      |
| Subsetting        | Feature          | Feature         | The set of relationships a Feature represents                               |
| Redefinition      | Feature          | Feature         | An inherited Feature relationship, made more specific in the current context |

Summarized as formulas:

```text
Subclassification
extent(SpecificClassifier)
⊆ extent(GeneralClassifier)
```

```text
Feature Typing
range(Feature)
⊆ extent(FeatureType)
```

```text
Subsetting
extent(SubsettingFeature)
⊆ extent(SubsettedFeature)
```

```text
Redefinition
extent(RedefiningFeature)
⊆ extent(RedefinedFeature)
and the redefining Feature stands in for
the redefined Feature in the context
of the current Type.
```

---

# Tying it together with one example

The following model contains all four relationships.

```sysml
part def Engine;
part def ElectricMotor :> Engine;
part def Vehicle {
    part engine : Engine[1..2];
    part mainEngine subsets engine;
}
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor[1]
        redefines Vehicle::engine;
}
```

## `ElectricMotor :> Engine`

```text
extent(ElectricMotor) ⊆ extent(Engine)
```

`ElectricMotor` is a Subclassification of `Engine`.

---

## `engine : Engine`

```text
range(Vehicle::engine) ⊆ extent(Engine)
```

`Vehicle::engine` is Feature Typed as `Engine`.

---

## `mainEngine subsets engine`

```text
extent(mainEngine) ⊆ extent(engine)
```

Every `mainEngine` value is necessarily also an `engine` value.

---

## `ElectricCar::engine redefines Vehicle::engine`

```text
extent(ElectricCar::engine)
⊆ extent(Vehicle::engine)
```

Since Redefinition is a kind of Subsetting, it carries this inclusion.

At the same time, in the `ElectricCar` context it replaces the inherited `Vehicle::engine` with the more specific condition `ElectricMotor[1]`.

```text
range(ElectricCar::engine)
⊆ extent(ElectricMotor)
⊆ extent(Engine)
```

---

# Specialization is a relationship for inference more than reuse

Specialization has the effect of model reuse.

Structure and Features defined in a parent Type can be used in a subordinate Type without redeclaring them.

But from a set-theoretic view, its more important role is **inference**.

Suppose we have the following model.

```sysml
part def ElectricCar :> Car;
part def Car :> Vehicle;
```

If an instance is an `ElectricCar`, we can infer:

```text
ElectricCar instance
⇒ Car instance
⇒ Vehicle instance
```

The same holds for Features.

```sysml
part mainEngine subsets engine;
```

If a value is a value of `mainEngine`, then:

```text
mainEngine value
⇒ engine value
```

Since Redefinition is also a kind of Subsetting, the value of a redefining Feature falls within the meaning and constraints of the redefined Feature.

So Specialization is not a mere hierarchical representation.

> **It is a relationship that lets us safely infer facts about a more general element from what we know about a more specific one.**

---

# Specialization is the inheritance of constraints

Usually, when we say inheritance, we picture a subordinate element receiving the properties of a parent element.

```text
Parent element's properties
→ passed down to the subordinate element
```

But KerML's Specialization is more essentially understood like this.

```text
Constraints defined by the parent element
→ must also hold in the subordinate element

The subordinate element
→ may define additional constraints
```

That is, Specialization is closer to **the inheritance of constraints** than to the inheritance of data or members.

```text
The parent concept's constraints
+
the subordinate concept's additional constraints
=
a more specific concept
```

A subordinate element cannot allow a wider range than its parent. It must have an equal or more restricted range.

Thanks to this principle, the meaning of a model stays consistent as it moves from general concepts down to specific ones.

---

# Closing: Specialization is a language for narrowing the design space

Early in design, the range of possible solutions is wide.

As conditions such as requirements, structure, value Types, and multiplicity are added, the set of possible designs steadily narrows.

```text
All possible systems
⊇ Systems of a particular kind
⊇ Systems with a particular structure
⊇ Systems that satisfy particular values and multiplicities
⊇ The system we want to design
```

SysML v2's Specialization expresses this process explicitly within the model.

* Subclassification narrows **the range of system kinds**.
* Feature Typing narrows **the range of a Feature's values**.
* Subsetting narrows **the range of a Feature's relationships**.
* Redefinition, building on Subsetting, **makes an inherited Feature more specific in a particular context**.

In the end, all four relationships follow the same principle.

```text
Specific ⊆ General
```

They differ only in which set they narrow.

Once you understand Specialization through set theory, `:>`, `:`, `subsets`, and `redefines` are not unrelated pieces of syntax.

They all express one design principle.

> **Starting from general possibility, adding constraints, and searching toward the more specific set of solutions that corresponds to the system we intend.**

This is why Specialization matters in SysML v2 during the design process.
