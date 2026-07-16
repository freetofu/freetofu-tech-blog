---
title: Why Does KerML Use the Term *Feature* Instead of *Property*?
description: This article explores why KerML, the foundation of SysML v2, uses the term *feature* instead of the more familiar *property*. It traces the word’s origin and connects its everyday meaning—from facial features to a musician “featuring” on a song—to its role in system modeling. The article also explains how Feature Membership, featuring types, and Feature Typing work in a simple `Car`–`engine` example. Ultimately, it shows that a feature is not just a stored attribute, but a meaningful model element that helps constitute and characterize a type.
pubDate: Jul 16 2026
heroImage: ../../assets/whyKerMLusesFeature.png
lang: en
translationKey: why-kerml-uses-feature
---
One of the terms that initially felt unfamiliar when I started learning SysML v2 was **Feature Membership**.

Consider a simple model:

```sysml
part def Car {
    part engine : Engine;
}
```

From the perspective of KerML, the relationship between `Car` and `engine` is a **Feature Membership**.

The `engine` element is an owned feature of `Car`, and `Car` is one of the **featuring types** of `engine`. Meanwhile, `engine` is typed by `Engine` through a **Feature Typing** relationship.

For someone coming from SysML v1, this terminology can feel unusual. In SysML v1, structural relationships between blocks were commonly understood through **associations**, including composition. A modeler might define `Car` and `Engine` as blocks, connect them with an association, and interpret the association end on the `Car` side as an `engine` property.

KerML approaches the same idea from a different direction. Instead of beginning with an association between two classifiers, it begins with a type and the features that characterize it.

That raises a natural question:

> Why introduce the term *feature* when words such as *property* and *association* already seem familiar?

The answer becomes clearer when we look at what the English word *feature* originally meant.

---

## *Feature* Did Not Originally Mean “Property”

The word *feature* ultimately traces back to the Latin verb **facere**, meaning:

> **to make**

The same root appears in words such as *factory* and *manufacture*.

Historically, *feature* referred to a form, shape, or something that had been made. It later became strongly associated with the visible parts of a person’s face.

For example:

> She has delicate features.

Here, *features* refers to the eyes, nose, mouth, and other elements that together make up a person’s appearance.

This is important because a feature is not merely an abstract characteristic. It is an **element that helps constitute something and makes that thing recognizable**.

The eyes, nose, and mouth are distinct elements, but together they form a face. At the same time, they distinguish one face from another.

That combination of **composition** and **characterization** lies at the heart of the word.

---

## From Facial Features to Product Features

Over time, the meaning expanded:

```text
elements that make up a face
            ↓
elements that make up an object
            ↓
elements that characterize an object
            ↓
the modern meaning of feature
```

This is why a car brochure may include a list such as:

```text
Features

- Sunroof
- Navigation
- Heated seats
```

These are not simply abstract properties of the car. They are functions or elements that help define what the product offers and how it differs from other products.

The same applies in software.

When a release note announces **new features**, it does not mean that a few new data fields have been added. It means that the product now has new capabilities or constituent elements.

In ordinary English, a feature is therefore best understood as:

> **an element that helps make up something and, at the same time, helps characterize it**

---

## What Does “Featuring” Mean in Music?

The same idea appears in music credits:

```text
Eminem featuring Rihanna
```

Here, *featuring* means that Rihanna participates in the track as a prominent contributor.

In sentence form:

> This song features Rihanna.

Rihanna is not merely adjacent to the song. Her contribution is included as a meaningful part of the work and becomes one of the elements that characterizes it.

So even in music, *featuring* carries the idea of:

> **including someone or something as a distinctive part of a larger work**

This provides a useful bridge back to KerML.

---

## Returning to Features in KerML

Now consider the SysML v2 example again:

```sysml
part def Car {
    part engine : Engine;
}
```

At the surface level, `engine` appears to be a part declared inside `Car`.

At the KerML level, however, several distinct semantic relationships are involved:

```text
Car
 │
 │ Feature Membership
 ▼
engine
 │
 │ Feature Typing
 ▼
Engine
```

More precisely:

- `Car` owns the feature `engine`.
- `Car` is a featuring type of `engine`.
- `engine` is typed by `Engine`.
- The relationship between `engine` and `Engine` is a Feature Typing relationship.

This distinction matters.

It is not strictly accurate to say that “the Feature Typing is `Engine`.” `Engine` is the type of `engine`; **Feature Typing** is the relationship that connects the feature to that type.

The feature `engine` is therefore not merely a variable or a field. It is a model element that specifies how instances of `Car` relate to instances of `Engine`.

A useful reading is:

> Each instance of `Car` is related, through the feature `engine`, to one or more instances classified by `Engine`, subject to the feature’s multiplicity and other constraints.

Seen this way, the term *feature* is quite deliberate. An engine is not only a property of a car. It is one of the elements that constitutes and characterizes what a car is.

---

## How This Differs from the Familiar SysML v1 View

In SysML v1, a modeler might define `Car` and `Engine` as blocks and connect them using an association. The association end on the `Car` side could then be interpreted as an `engine : Engine` property.

Conceptually:

```text
Car ───── engine : Engine
```

In that approach, the relationship often appears to begin with an **association between two classifiers**. The properties are understood as the ends of that association.

KerML places the feature itself closer to the center of the model.

```sysml
part def Car {
    part engine : Engine;
}
```

Rather than starting with a line between `Car` and `Engine`, the model states that `Car` has a feature named `engine`, and that this feature is typed by `Engine`.

A simplified comparison looks like this:

| Familiar SysML v1 perspective | SysML v2 / KerML perspective |
|---|---|
| Two blocks are connected by an association | A type owns a feature |
| An association end becomes a property | The feature is a first-class model element |
| The relationship is often visualized as a line first | The type is understood through its features first |
| The property appears as one end of a relationship | The feature specifies the relation between its featuring type and its type |

This does not mean that associations disappeared from KerML. KerML still defines associations as a modeling concept. The shift is more fundamental: the language gives **features** a broader and more central role in describing structure, behavior, interaction, and context.

---

## Why *Feature* Is Broader Than *Property*

If KerML had used the word *property* as its universal term, many readers would naturally interpret it in the object-oriented programming sense:

```java
class Car {
    Engine engine;
}
```

In such a language, `engine` is typically understood as a field stored inside an object.

A KerML feature is broader.

Many constructs that appear different at the SysML level share the common semantics of features at the KerML level, including:

- attributes
- parts
- ports
- references
- actions
- parameters
- connector ends

For example:

```sysml
part engine : Engine;
attribute mass : MassValue;
port diagnosticPort : DiagnosticPort;
perform action startEngine;
```

These elements serve different purposes, but they all characterize a type in some way. They may describe its composition, values, interaction points, behavior, or roles in relationships.

Conceptually:

```text
Feature
├── Attribute
├── Part
├── Port
├── Reference
├── Action
├── Parameter
└── Connector End
```

The word *property* tends to suggest a structural value or stored characteristic. The word *feature* is broad enough to include structure, behavior, direction, interaction, and contextual relationships.

That is why the terminology is more than a cosmetic change.

> KerML uses *feature* as a common semantic foundation for the many different ways in which a type can be constituted and characterized.

---

## Feature Membership Is More Than Containment

The KerML specification describes Feature Membership as a kind of owning membership that also implies type featuring.

Consider again:

```sysml
part def Car {
    part engine : Engine;
}
```

`Car` owns `engine`, so `engine` is an **owned feature** of `Car`.

Viewed in the opposite direction, `Car` is a **featuring type** of `engine`.

This means that the feature `engine` is understood in the context of `Car`.

Two features may have the same type while expressing different roles:

```sysml
part def Car {
    part mainEngine : Engine;
    part spareEngine : Engine;
}
```

Both features are typed by `Engine`, but they do not mean the same thing. They establish different relationships and roles within the context of `Car`.

A feature can specify more than a target type. It can also carry:

- multiplicity
- direction
- values
- subsetting
- redefinition
- ownership
- contextual meaning

Reducing all of this to the word *property* hides too much of the model.

---

## A Word That Reflects KerML’s Design Philosophy

KerML does not simply view a type as a container filled with properties.

Instead, a type is characterized through features that relate it to values, objects, behaviors, interactions, and other types.

```text
Type
 ├── Feature
 ├── Feature
 └── Feature
```

Each feature is more than a piece of data attached to the type. It is a first-class semantic element that helps define what instances of the type are and how they participate in the modeled system.

In KerML, *feature* carries several ideas at once:

> **an element that constitutes a type**

> **an element that characterizes a type**

> **an element that specifies how the type relates to something else**

The word *property* captures only part of that picture. *Feature* captures the broader intent.

---

## Conclusion

When I first encountered the term **Feature Membership** in SysML v2, it felt unnecessarily unfamiliar.

In SysML v1, I was used to thinking about a car and its engine through associations between blocks. In SysML v2, the same model is expressed by declaring `engine` as a feature of `Car`, with `Engine` as its type.

At first, this can look like a change in terminology for its own sake. But the history and everyday meaning of the word *feature* reveal why it fits KerML so well.

A feature is something that helps make up an entity while also helping define what that entity is. A guest artist *featured* on a song becomes a meaningful part of the work. In the same way, `engine` is not merely a stored property of `Car`; it is a model element that constitutes `Car`, characterizes it, and specifies its relationship to `Engine`.

KerML’s choice of the word *feature* is therefore not just a renaming exercise.

It reflects a deeper modeling perspective:

> **A system is not merely a collection of properties. It is a structure of meaningful features through which elements participate in relationships.**

When SysML v2 terminology feels unfamiliar, it is often worth resisting the urge to force it back into SysML v1 concepts. Sometimes the unfamiliar word is there because the language is trying to teach us a different way of seeing the model.

And occasionally, the design philosophy of a 400-page specification is hiding in a single word that everyone else skipped.
