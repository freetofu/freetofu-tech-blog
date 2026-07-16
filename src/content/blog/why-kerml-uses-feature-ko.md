---
title: 왜 KerML은 `Property`가 아니라 `Feature`라는 단어를 선택했을까?
description: SysML v2(KerML)를 공부하다 보면 Feature, Feature Membership이라는 낯선 용어를 자주 만나게 됩니다. 왜 기존의 Property나 Association이 아니라 Feature라는 단어를 선택했을까요? 이번 글에서는 feature의 어원부터 영어에서의 의미, 그리고 KerML의 설계 철학까지 연결해서 살펴봅니다. 단어 하나에 담긴 SysML v2의 철학이 의외로 깊다는 것을 발견하게 될 것입니다.
pubDate: Jul 16 2026
heroImage: ../../assets/whyKerMLusesFeature.png
lang: ko
translationKey: why-kerml-uses-feature
---
SysML v2를 처음 공부하면서 꽤 생소하게 느껴졌던 표현이 하나 있었습니다.

```sysml
part def Car {
    part engine : Engine;
}
```

위 모델에서 `Car`와 `engine`의 관계는 KerML 관점에서 **Feature Membership**입니다.  
`engine`은 `Car`가 소유하는 **Feature**이고, `Car`는 `engine`의 **featuring type**이 됩니다.

이 표현은 SysML v1에 익숙한 사람에게 조금 낯설게 느껴질 수 있습니다. SysML v1에서는 블록 사이의 구조적 관계를 주로 **Association**이나 Association의 한 형태인 **Composition**으로 표현했기 때문입니다.

가령 자동차와 엔진의 관계를 생각하면, SysML v1에서는 흔히 두 Block을 Association으로 연결하고 자동차 쪽에 엔진이라는 Property가 있다고 이해했습니다. 그런데 SysML v2의 기반 언어인 KerML에서는 갑자기 `Feature`, `Feature Membership`, `Featuring Type` 같은 표현이 등장합니다.

처음에는 이런 생각이 들었습니다.

> 왜 익숙한 Property나 Association을 두고 굳이 Feature라는 단어를 사용했을까?

KerML 명세를 계속 읽어보니, **Feature는 단순히 Property를 새 이름으로 바꾼 것이 아니었습니다.**  
이 단어에는 KerML이 시스템의 구조를 바라보는 방식이 담겨 있었습니다.

그 이유를 이해하려면 먼저 영어 단어 `feature`의 원래 의미부터 살펴볼 필요가 있습니다.

---

## Feature의 원래 뜻은 ‘속성’이 아니다

`Feature`의 어원은 라틴어 **facere**에서 출발합니다.

> **facere = 만들다(to make)**

`factory`, `manufacture`, `feature`도 모두 이 어원과 연결됩니다.

Feature는 처음에는 **만들어진 모습이나 형태**를 뜻했습니다. 이후 사람의 얼굴을 이루는 생김새를 가리키는 말로 사용되기 시작했습니다.

예를 들어 다음 문장에서 `features`는 눈, 코, 입과 같은 이목구비를 뜻합니다.

> She has delicate features.  
> 그녀는 섬세한 이목구비를 가지고 있다.

여기서 중요한 점은 Feature가 단순한 성질이나 수치가 아니라, **어떤 대상을 구성하면서 그 대상을 특징짓는 요소**를 의미한다는 것입니다.

눈, 코, 입은 각각 독립된 요소이지만, 함께 모여 한 사람의 얼굴을 구성합니다. 그리고 그 요소들이 바로 그 사람의 생김새를 특징짓습니다.

---

## 얼굴의 구성 요소에서 제품의 기능으로

시간이 지나면서 Feature의 의미는 점차 넓어졌습니다.

```text
얼굴을 구성하는 요소
        ↓
사물을 구성하는 요소
        ↓
사물을 특징짓는 요소
        ↓
오늘날의 Feature
```

자동차 소개 자료에서 다음과 같은 목록을 흔히 볼 수 있습니다.

```text
Features

- Sunroof
- Navigation
- Heated seats
```

여기서 Feature는 자동차가 가진 추상적인 ‘속성’만을 의미하지 않습니다. 자동차를 구성하고, 다른 자동차와 구별되게 만드는 **기능과 요소**를 함께 뜻합니다.

소프트웨어에서 말하는 `New Features`도 마찬가지입니다. 이는 단순히 새로운 데이터 속성이 추가되었다는 뜻이 아니라, 제품을 구성하는 새로운 기능이나 능력이 추가되었다는 의미입니다.

즉, 일반적인 영어에서 Feature는 다음 의미를 함께 가집니다.

> **어떤 대상을 구성하면서, 동시에 그 대상을 특징짓는 요소**

---

## 노래의 ‘Featuring’도 같은 의미다

노래 제목에서도 `feature`와 같은 뿌리를 가진 표현을 자주 볼 수 있습니다.

```text
Eminem featuring Rihanna
```

여기서 `featuring`은 보통 “Rihanna가 참여한”이라고 번역합니다.

문장으로 쓰면 다음과 같습니다.

> This song features Rihanna.  
> 이 노래에는 Rihanna가 참여한다.

이 표현은 단순히 Rihanna가 노래 주변에 존재한다는 뜻이 아닙니다. Rihanna가 이 작품을 구성하는 중요한 요소로 포함되며, 그 참여가 곡의 특징 중 하나가 된다는 뜻입니다.

따라서 노래에서의 `featuring`도 결국 다음 의미를 가집니다.

> **어떤 대상을 구성하는 특징적인 요소로 포함하다**

이 의미는 KerML의 Feature를 이해하는 데 꽤 좋은 실마리가 됩니다.

---

## 다시 KerML의 Feature로 돌아가 보자

다음 SysML v2 모델을 보겠습니다.

```sysml
part def Car {
    part engine : Engine;
}
```

표면적으로 보면 `Car` 안에 `engine`이라는 Part가 하나 선언되어 있습니다.

하지만 KerML의 추상 구문 관점에서 보면 여기에는 다음과 같은 구조가 존재합니다.

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

`engine`은 단순한 변수나 필드가 아닙니다.

`engine`은 `Car`가 소유하는 **Feature**이며, `Car`와 `Engine` 사이의 관계를 규정하는 독립적인 모델 요소입니다.

이를 조금 풀어서 말하면 다음과 같습니다.

> 각 `Car` 인스턴스는 `engine`이라는 Feature를 통해 `Engine` 타입의 인스턴스와 관계를 맺는다.

따라서 `engine`은 단순히 “Car 안에 저장된 값”이 아니라, **Car를 구성하고 Car가 다른 대상과 어떻게 관계를 맺는지를 나타내는 요소**입니다.

이 관점에서 보면 Feature라는 단어가 꽤 정확합니다.

엔진은 자동차의 Property이기도 하지만, 더 본질적으로는 자동차를 구성하고 자동차라는 Type을 특징짓는 요소이기 때문입니다.

---

## SysML v1의 Association과 무엇이 다른가

SysML v1에서는 `Car`와 `Engine`을 각각 Block으로 정의한 뒤 Association으로 연결할 수 있습니다. 자동차 쪽 Association End는 `engine`이라는 Property로 해석됩니다.

개념적으로는 다음과 같은 모습입니다.

```text
Car ───── engine : Engine
```

이 방식에서는 관계의 출발점이 **두 Classifier 사이의 Association**입니다. 그리고 Association의 끝점이 각 Block의 Property 역할을 합니다.

반면 KerML에서는 Feature가 더 중심적인 개념입니다.

```sysml
part def Car {
    part engine : Engine;
}
```

이 모델에서 중요한 것은 별도의 선을 먼저 그리는 것이 아니라, `Car`가 `engine`이라는 Feature를 가진다는 사실입니다. 그 Feature가 `Engine`으로 typed되면서 `Car`와 `Engine` 사이의 관계가 정의됩니다.

두 접근의 차이를 단순화하면 다음과 같습니다.

| SysML v1에서 익숙한 관점 | SysML v2 / KerML 관점 |
|---|---|
| 두 Block 사이에 Association이 있다 | Type이 Feature를 가진다 |
| Association End가 Property가 된다 | Feature 자체가 독립적인 모델 요소다 |
| 관계를 선으로 먼저 생각하기 쉽다 | Type을 구성하는 Feature를 먼저 생각한다 |
| Property가 특정 관계의 끝점처럼 보인다 | Feature가 Type과 다른 Type 사이의 관계를 규정한다 |

SysML v2에서 Association이 완전히 사라진 것은 아닙니다. KerML에도 Association 개념은 존재합니다. 다만 시스템 구조를 표현하는 기본 사고방식이 **Association을 먼저 그리고 끝점에 Property를 다는 방식**에서, **Type을 구성하는 Feature를 선언하는 방식**으로 이동했습니다.

---

## 왜 Property보다 Feature가 더 적합한가

만약 KerML이 모든 것을 Property라고 불렀다면, 많은 사용자는 Feature를 Java나 C++의 멤버 변수와 비슷하게 이해했을 가능성이 큽니다.

```java
class Car {
    Engine engine;
}
```

이 코드에서 `engine`은 일반적으로 객체 내부에 저장되는 Field로 받아들여집니다.

하지만 KerML의 Feature는 그보다 훨씬 넓습니다.

SysML v2에서 다음과 같은 여러 요소는 KerML 관점에서 모두 Feature의 특수한 형태입니다.

- Attribute
- Part
- Port
- Reference
- Action
- Parameter
- Connector End

예를 들어 다음 요소들은 겉보기에는 서로 완전히 달라 보입니다.

```sysml
part engine : Engine;
attribute mass : MassValue;
port diagnosticPort : DiagnosticPort;
perform action startEngine;
```

그러나 KerML의 공통 기반에서는 모두 Type을 구성하고 다른 대상과의 관계를 규정하는 Feature로 다뤄질 수 있습니다.

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

`Property`라는 단어는 값이나 구조적 속성을 떠올리게 합니다. 반면 `Feature`는 구조, 동작, 연결, 입출력과 같은 다양한 요소를 모두 포괄할 수 있습니다.

그래서 KerML이 선택한 Feature는 단순한 용어 교체가 아닙니다.

> **Property보다 더 넓은 공통 개념을 만들기 위한 의도적인 선택**

이라고 볼 수 있습니다.

---

## Feature Membership은 단순한 포함 관계가 아니다

KerML 명세에서는 Feature Membership을 Type과 Feature 사이의 Owning Membership이라고 설명합니다. 동시에 이 관계는 Type Featuring도 의미합니다.

```sysml
part def Car {
    part engine : Engine;
}
```

여기서 `Car`는 `engine`을 소유합니다. 따라서 `engine`은 `Car`의 **owned feature**입니다.

반대 방향에서 보면 `Car`는 `engine`의 **featuring type**입니다.

이 표현은 다음과 같이 읽을 수 있습니다.

> `engine`이라는 Feature는 `Car`라는 Type의 맥락에서 의미를 가진다.

동일한 `Engine` 타입을 사용하더라도 Feature에 따라 시스템 안에서의 의미는 달라질 수 있습니다.

```sysml
part def Car {
    part mainEngine : Engine;
    part spareEngine : Engine;
}
```

`mainEngine`과 `spareEngine`은 모두 `Engine`으로 typed되지만, `Car`와 `Engine` 사이에서 서로 다른 역할과 관계를 나타냅니다.

즉, Feature는 Type만 가리키는 것이 아니라 다음을 함께 표현합니다.

- 어떤 Type의 맥락에 속하는가
- 무엇과 관계를 맺는가
- 그 관계에서 어떤 역할을 하는가
- 방향, 다중성, 값, 재정의 등의 제약이 무엇인가

이 정도 되면 Feature를 단순히 ‘속성’이라고 번역하는 순간 의미가 반쯤 증발합니다.

---

## 단어 하나에 담긴 KerML의 설계 철학

KerML은 단순히 “Type 안에 Property가 들어 있다”고 보지 않습니다.

대신 Type이 여러 Feature를 통해 구성되고, 그 Feature들이 다른 Type이나 값, 동작과의 관계를 규정한다고 봅니다.

```text
Type
 ├── Feature
 ├── Feature
 └── Feature
```

각 Feature는 단순히 Type 내부에 매달린 데이터 조각이 아닙니다. Feature는 모델 안에서 독립적인 의미를 가지며, 시스템의 구조와 동작을 연결하는 공통 기반이 됩니다.

따라서 KerML에서 Feature라는 단어는 다음 의미를 동시에 담고 있습니다.

> **Type을 구성하는 요소**

그리고

> **Type을 특징짓는 요소**

또한

> **Type이 다른 대상과 맺는 관계를 규정하는 요소**

이 세 가지를 모두 담기에는 Property보다 Feature가 더 적절합니다.

---

## 마무리

SysML v2를 처음 접했을 때 `Feature Membership`이라는 표현은 꽤 생소했습니다.

SysML v1에서는 자동차와 엔진을 Association으로 연결하는 그림이 익숙했습니다. 그런데 SysML v2에서는 `part def Car` 안에 `part engine`을 선언하고, 이를 Feature Membership이라고 설명합니다.

처음에는 괜히 용어만 어렵게 바꾼 것처럼 보일 수도 있습니다. 하지만 Feature의 어원과 일반적인 영어 의미를 살펴보면, 이 용어는 KerML의 설계 철학과 잘 맞습니다.

Feature는 원래 어떤 대상을 구성하고 그 대상을 특징짓는 요소를 뜻합니다. 노래에서 다른 가수가 `featuring`으로 참여하는 것도 같은 의미입니다. 그 가수는 작품에 포함되는 동시에 작품을 특징짓는 중요한 요소가 됩니다.

KerML의 Feature도 마찬가지입니다.

`engine`은 단순히 `Car` 안에 저장된 Property가 아닙니다. `Car`를 구성하고, `Car`와 `Engine`의 관계를 정의하며, 자동차라는 Type을 특징짓는 모델 요소입니다.

그래서 KerML이 Property가 아니라 Feature라는 단어를 선택한 것은 단순한 이름 변경이 아닙니다.

> **시스템을 속성들의 묶음이 아니라, 서로 관계를 맺는 구성 요소들의 구조로 바라보겠다는 선언**

에 가깝습니다.

SysML v2의 문법이 낯설 때는 단어를 억지로 기존 SysML v1 개념에 끼워 맞추기보다, 왜 새로운 단어를 선택했는지 살펴보는 편이 좋습니다.

가끔은 명세의 철학이 수백 페이지 뒤의 수식이 아니라, 우리가 대충 넘겨버린 단어 하나에 숨어 있기 때문입니다.
