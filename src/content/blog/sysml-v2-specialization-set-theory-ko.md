---
title: SysML v2의 Specialization을 집합론으로 이해하기
description: SysML v2에는 Subclassification, Feature Typing, Subsetting, Redefinition이라는 네 가지 관계가 있다. 문법은 다르지만 모두 KerML의 Specialization이라는 하나의 개념에 기반한다. 이 글은 네 관계를 집합론의 관점에서 하나의 원리로 꿰어, Specialization이 본질적으로 가능한 범위를 좁히는 관계임을 보인다.
pubDate: Jul 23 2026
lang: ko
translationKey: sysml-v2-specialization-set-theory
heroImage: ../../assets/understandingSpecialization.png
---
SysML v2를 공부하다 보면 다음과 같은 관계가 반복해서 등장한다.

```text
Subclassification
Feature Typing
Subsetting
Redefinition
```

이 관계들은 문법과 적용 대상이 서로 다르지만, 모두 KerML의 `Specialization`이라는 공통 개념을 기반으로 한다.

각 관계를 별개의 문법으로 외우면 차이를 구분하기 어렵다. 하지만 집합론의 관점에서 보면 이들은 모두 하나의 원리로 연결된다.

> **더 구체적인 모델 요소가 허용하는 경우의 집합은 더 일반적인 모델 요소가 허용하는 경우의 집합에 포함된다.**

즉, Specialization은 본질적으로 **가능한 범위를 좁히는 관계**다.

---

## 설계는 가능한 해의 집합을 좁혀 가는 과정이다

우리가 어떤 시스템을 설계한다고 생각해 보자.

처음에는 만들고자 하는 대상이 정확히 어떤 모습인지 알지 못한다. 다만 가능한 설계안이 매우 넓은 집합으로 존재한다.

예를 들어 새로운 차량을 설계하는 초기 단계에서는 다음과 같은 다양한 가능성이 열려 있을 수 있다.

```text
모든 가능한 차량 설계
├── 내연기관 차량
├── 전기 차량
├── 승용 차량
├── 상용 차량
├── 전륜구동 차량
├── 후륜구동 차량
└── 그 밖의 다양한 조합
```

여기에 설계 조건을 하나씩 추가한다.

```text
승용차여야 한다.
전기 모터를 사용해야 한다.
탑승 인원은 5명이어야 한다.
특정 크기와 중량을 만족해야 한다.
```

각 조건은 가능한 설계안의 일부를 제거한다.

집합으로 표현하면 다음과 같다.

```text
전체 가능한 설계안
⊇ 승용차 조건을 만족하는 설계안
⊇ 전기차 조건도 만족하는 설계안
⊇ 5인승 조건도 만족하는 설계안
⊇ 모든 설계 조건을 만족하는 설계안
```

설계 과정은 결국 다음과 같이 볼 수 있다.

> **아직 정확히 알지 못하는 설계 대상을 찾기 위해 제약을 추가하고, 가능한 해의 집합을 점점 좁혀 가는 과정**

최종적으로 남은 집합이 충분히 구체적이라면, 그 집합은 우리가 만들고자 했던 시스템의 의미를 나타낸다.

이 관점에서 SysML v2의 Specialization은 단순한 상속 문법이 아니다.

Specialization은 일반적인 시스템 개념에 제약을 추가하여, 더 구체적인 설계 개념으로 좁혀 가는 핵심적인 모델링 수단이다.

---

## 1. Type은 인스턴스의 집합이다

KerML에서 Type은 단순한 이름이나 분류표가 아니다.

각 Type에는 그 Type으로 분류되는 모든 인스턴스의 집합이 대응된다. 이 집합을 Type의 **extent**라고 한다.

다음 모델을 생각해 보자.

```sysml
part def Vehicle;
part def Car :> Vehicle;
```

이를 집합으로 나타내면 다음과 같다.

```text
extent(Vehicle)
= Vehicle로 분류되는 모든 인스턴스의 집합

extent(Car)
= Car로 분류되는 모든 인스턴스의 집합
```

모든 자동차는 차량이므로 다음 관계가 성립한다.

```text
extent(Car) ⊆ extent(Vehicle)
```

따라서 `Car`가 `Vehicle`을 specialize한다는 것은 다음을 의미한다.

> `Car`로 분류되는 모든 인스턴스는 반드시 `Vehicle`로도 분류된다.

어떤 인스턴스 `c`에 대해 다음과 같이 표현할 수 있다.

```text
c ∈ extent(Car)
⇒ c ∈ extent(Vehicle)
```

반대는 반드시 성립하지 않는다.

```text
c ∈ extent(Vehicle)
⇏ c ∈ extent(Car)
```

모든 자동차는 차량이지만, 모든 차량이 자동차인 것은 아니기 때문이다.

---

## 2. Specialization은 제약을 추가한다

일반 Type을 (G), 더 구체적인 Type을 (S)라고 하자.

Specialization은 다음과 같은 집합 포함 관계로 이해할 수 있다.

```text
extent(S) ⊆ extent(G)
```

구체적인 Type은 일반 Type보다 더 많은 경우를 허용하지 않는다. 일반 Type이 허용하는 경우 중에서 추가 조건을 만족하는 일부만 허용한다.

예를 들어 다음과 같은 관계가 있을 수 있다.

```text
extent(ElectricCar)
⊆ extent(Car)
⊆ extent(Vehicle)
```

여기서 아래 단계로 내려갈수록 조건이 추가된다.

```text
Vehicle
→ 차량이라는 조건

Car
→ 차량이면서 자동차라는 추가 조건

ElectricCar
→ 자동차이면서 전기 구동 차량이라는 추가 조건
```

따라서 Specialization은 단순히 상위 요소의 내용을 가져오는 관계라기보다 다음과 같이 이해하는 편이 정확하다.

> **상위 요소의 의미를 유지하면서 추가 제약을 적용하는 관계**

이러한 제약의 누적이 가능한 인스턴스의 집합을 점차 좁힌다.

---

# SysML v2의 네 가지 Specialization

KerML에서 `Specialization`은 구체적인 Type과 일반적인 Type을 연결한다.

SysML v2에서 주로 접하게 되는 형태는 다음 네 가지다.

```text
Specialization
├── Subclassification
├── Feature Typing
├── Subsetting
└── Redefinition
```

네 관계는 모두 가능한 범위를 좁히지만, **무엇의 범위를 좁히는가**가 다르다.

---

## 3. Subclassification: Classifier의 인스턴스 집합을 좁힌다

`Subclassification`은 Classifier 사이의 Specialization이다.

```sysml
part def Vehicle;
part def Car :> Vehicle;
```

여기서 `Car`는 subclassifier이고 `Vehicle`은 superclassifier다.

집합적으로는 다음과 같다.

```text
extent(Car) ⊆ extent(Vehicle)
```

`Car`는 `Vehicle`보다 더 구체적인 Classifier다.

`Vehicle`이 차량이라는 일반 조건을 정의한다면, `Car`는 여기에 자동차라는 추가 조건을 부여한다.

### Subclassification의 핵심

> **Classifier가 나타내는 인스턴스의 집합을 더 좁게 정의한다.**

Subclassification을 통해 하위 Classifier는 상위 Classifier의 제약을 모두 만족해야 한다.

하위 Classifier가 상위 Classifier의 Feature를 상속하는 것도 이러한 의미에서 이해할 수 있다. 하위 Classifier의 모든 인스턴스가 상위 Classifier의 인스턴스이므로, 상위 Classifier에 적용되는 구조와 제약도 하위 인스턴스에 적용된다.

---

## 4. Feature는 인스턴스 사이의 관계다

나머지 세 관계를 이해하려면 먼저 KerML의 Feature를 살펴봐야 한다.

다음 모델을 생각해 보자.

```sysml
part def Engine;
part def Vehicle {
    part engine : Engine;
}
```

`engine`은 단순히 `Vehicle` 안에 저장된 변수라고 보기 어렵다.

KerML에서 Feature는 모델에 존재하는 대상들이 서로 어떻게 관계되는지를 분류하는 Type이다. 명세에서는 Feature가 featuring Type의 extent에 속한 인스턴스와 featured Type의 extent에 속한 인스턴스를 연결한다고 설명한다.

이를 집합론적으로 단순화하면 다음과 같이 표현할 수 있다.

```text
engine ⊆ extent(Vehicle) × extent(Engine)
```

즉, `engine`은 `Vehicle` 인스턴스와 `Engine` 인스턴스의 순서쌍으로 구성된 관계 집합이다.

```text
engine = {
    (Vehicle1, Engine1),
    (Vehicle2, Engine2),
    ...
}
```

각 순서쌍은 다음을 의미한다.

```text
(Vehicle1, Engine1)
Vehicle1이 engine Feature의 값으로
Engine1을 가진다.
```

Type이 인스턴스의 집합이라면, Feature는 인스턴스 사이의 **관계 집합**이라고 볼 수 있다.

---

## 5. Feature Typing: Feature 값의 범위를 제한한다

다음 선언에서:

```sysml
part engine : Engine;
```

`engine`은 Feature이고 `Engine`은 그 Feature의 Type이다.

이 둘을 연결하는 관계가 `Feature Typing`이다.

Feature Typing은 `engine` Feature의 값이 될 수 있는 대상의 범위를 제한한다.

```text
range(engine) ⊆ extent(Engine)
```

따라서 `engine`의 값은 반드시 `Engine`으로 분류되는 인스턴스여야 한다.

```text
e ∈ range(engine)
⇒ e ∈ extent(Engine)
```

Feature Typing은 Feature가 실제로 어떤 값을 가지는지를 결정하지 않는다. 대신 그 값이 속해야 하는 Type을 제약한다.

### Feature Typing의 핵심

> **Feature가 가질 수 있는 값의 Type을 제한한다.**

Subclassification과 비교하면 다음과 같다.

```text
Subclassification
extent(Car) ⊆ extent(Vehicle)

Feature Typing
range(engine) ⊆ extent(Engine)
```

Subclassification은 Classifier의 인스턴스 집합을 좁히고, Feature Typing은 Feature 값의 범위를 좁힌다.

---

## 6. Subsetting: Feature 관계의 부분집합을 정의한다

다음 모델을 생각해 보자.

```sysml
part def Vehicle {
    part engine : Engine;
    part mainEngine subsets engine;
}
```

`mainEngine`은 `engine`을 subset한다.

집합적으로는 다음과 같이 표현할 수 있다.

```text
extent(mainEngine) ⊆ extent(engine)
```

여기서 두 extent는 모두 Feature가 나타내는 관계쌍의 집합이다.

예를 들어 `engine` 관계가 다음과 같다고 하자.

```text
engine = {
    (Vehicle1, EngineA),
    (Vehicle1, EngineB),
    (Vehicle2, EngineC)
}
```

이때 `mainEngine`은 다음과 같을 수 있다.

```text
mainEngine = {
    (Vehicle1, EngineA),
    (Vehicle2, EngineC)
}
```

`mainEngine`의 모든 관계쌍은 `engine`에도 포함된다.

```text
mainEngine ⊆ engine
```

따라서 어떤 값이 `mainEngine`의 값이라면, 반드시 `engine`의 값이기도 하다.

```text
x ∈ mainEngine
⇒ x ∈ engine
```

그러나 모든 `engine` 값이 `mainEngine` 값일 필요는 없다.

Subsetting Feature는 subsetted Feature보다 더 구체적인 Type이나 더 제한된 multiplicity를 가질 수 있다. KerML 명세에서도 Subsetting Feature가 subsetted Feature의 featuring Type, featured Type 및 multiplicity를 추가로 제한할 수 있다고 설명한다.

### Subsetting의 핵심

> **기존 Feature가 나타내는 관계 중 일부를 더 구체적인 Feature로 정의한다.**

Subclassification과 Subsetting은 집합 구조가 유사하다.

```text
Subclassification
구체 Classifier의 extent
⊆ 일반 Classifier의 extent

Subsetting
구체 Feature의 extent
⊆ 일반 Feature의 extent
```

차이는 적용 대상이다.

* Classifier를 좁히면 Subclassification
* Feature를 좁히면 Subsetting

---

## 7. Redefinition: Subsetting에 문맥적 대체 의미를 추가한다

Redefinition은 프로그래밍 언어의 override와 비슷해 보일 수 있다.

하지만 override와 완전히 같은 개념으로만 이해하면 Redefinition이 가진 **집합적 포함 관계**를 놓치기 쉽다.

KerML 명세는 Redefinition을 명확하게 다음과 같이 정의한다.

> **Redefinition is a kind of subsetting.**

즉, Redefinition은 Subsetting과 별개의 원리가 아니라, **Subsetting을 기반으로 하는 더 구체적인 관계**다.

다음 모델을 보자.

```sysml
part def Vehicle {
    part engine : Engine;
}
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor
        redefines Vehicle::engine;
}
```

먼저 `ElectricCar`는 `Vehicle`의 Subclassification이다.

```text
extent(ElectricCar) ⊆ extent(Vehicle)
```

그리고 `ElectricCar::engine`은 `Vehicle::engine`을 redefine한다.

Redefinition은 Subsetting의 한 종류이므로 다음과 같은 포함 관계를 가진다.

```text
extent(ElectricCar::engine)
⊆ extent(Vehicle::engine)
```

여기에 Redefinition만의 의미가 하나 더 추가된다.

> 하위 Type의 문맥에서 redefining Feature가 상속된 redefined Feature를 대신한다.

즉, Subsetting은 일반 Feature의 일부를 나타내는 새로운 Feature를 추가하지만, Redefinition은 상위 Type에서 상속된 Feature를 현재 Type의 문맥에 맞게 더 구체화하여 대체한다.

### Redefinition에서 값은 서로 독립적이지 않다

Redefinition은 단순히 더 좁은 관계를 하나 추가하는 데서 끝나지 않는다.

KerML 명세에 따르면, redefining Feature와 redefined Feature는 redefining Feature의 domain에 속하는 각 인스턴스에서 동일한 값을 가져야 한다. 따라서 redefining Feature에 적용한 Type이나 multiplicity 제한은 redefined Feature의 값에도 영향을 준다.

예를 들어:

```sysml
part def ElectricMotor :> Engine;
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor[1]
        redefines Vehicle::engine;
}
```

`ElectricCar` 문맥에서 `engine`은 다음과 같이 더 제한된다.

```text
range(ElectricCar::engine)
⊆ extent(ElectricMotor)
⊆ extent(Engine)
```

또한 multiplicity도 `[1]`로 제한된다.

이는 `Vehicle::engine`과 별개의 새로운 Feature를 추가하는 것이 아니다. `Vehicle`에서 상속된 `engine`을 `ElectricCar` 문맥에서 더 구체적인 조건으로 사용하는 것이다.

### Redefinition의 핵심

> **Redefinition은 Subsetting의 의미를 상속하면서, 상속된 Feature를 현재 Type의 문맥에서 더 구체적으로 정의하고 대체한다.**

따라서 다음과 같이 정리할 수 있다.

```text
Redefinition
= Subsetting
+ 상속된 Feature의 문맥적 대체
+ 두 Feature 값의 일치 제약
```

---

## 8. Subsetting과 Redefinition의 차이

두 관계 모두 더 구체적인 Feature를 정의한다.

그러나 모델링 의도가 다르다.

### Subsetting

```sysml
part def Vehicle {
    part engine : Engine[1..2];
    part mainEngine subsets engine;
}
```

`engine`과 `mainEngine`은 서로 다른 역할로 함께 존재한다.

```text
mainEngine ⊆ engine
```

`mainEngine`은 전체 `engine` 관계 중 주 엔진에 해당하는 일부를 나타낸다.

### Redefinition

```sysml
part def ElectricCar :> Vehicle {
    part engine : ElectricMotor[1]
        redefines Vehicle::engine;
}
```

`ElectricCar::engine`은 상속된 `Vehicle::engine`을 `ElectricCar`라는 문맥에서 더 구체적으로 정의한다.

따라서 다음과 같이 구분할 수 있다.

```text
Subsetting
기존 Feature 관계의 일부를 나타내는
별도의 구체적인 Feature를 정의한다.

Redefinition
Subsetting 관계를 기반으로,
상속된 Feature를 현재 Type 문맥에서
더 구체적으로 정의하여 대신 사용한다.
```

Redefinition은 Subsetting보다 완전히 다른 관계가 아니다.

> **모든 Redefinition은 Subsetting이지만, 모든 Subsetting이 Redefinition은 아니다.**

집합 관계로 표현하면 다음과 같다.

```text
Redefinition ⊂ Subsetting
```

여기서 이는 Feature의 extent가 아니라, **관계 종류의 분류 구조**를 나타내는 표현이다.

---

# 네 관계를 한 번에 비교하기

| 관계                | 구체 요소      | 일반 요소      | 좁히는 대상                            |
| ----------------- | ---------- | ---------- | --------------------------------- |
| Subclassification | Classifier | Classifier | Classifier의 인스턴스 집합               |
| Feature Typing    | Feature    | Type       | Feature가 가질 수 있는 값의 범위            |
| Subsetting        | Feature    | Feature    | Feature가 나타내는 관계 집합               |
| Redefinition      | Feature    | Feature    | 상속된 Feature 관계를 현재 문맥에서 더 구체화한 집합 |

수식으로 요약하면 다음과 같다.

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
그리고 redefining Feature가
현재 Type의 문맥에서
redefined Feature를 대신한다.
```

---

# 하나의 예제로 연결하기

다음 모델에는 네 관계가 모두 포함되어 있다.

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

`ElectricMotor`는 `Engine`의 Subclassification이다.

---

## `engine : Engine`

```text
range(Vehicle::engine) ⊆ extent(Engine)
```

`Vehicle::engine`은 `Engine`으로 Feature Typing된다.

---

## `mainEngine subsets engine`

```text
extent(mainEngine) ⊆ extent(engine)
```

모든 `mainEngine` 값은 반드시 `engine` 값이기도 하다.

---

## `ElectricCar::engine redefines Vehicle::engine`

```text
extent(ElectricCar::engine)
⊆ extent(Vehicle::engine)
```

Redefinition은 Subsetting의 한 종류이므로 포함 관계를 가진다.

동시에 `ElectricCar` 문맥에서는 상속된 `Vehicle::engine`을 더 구체적인 `ElectricMotor[1]` 조건으로 대체한다.

```text
range(ElectricCar::engine)
⊆ extent(ElectricMotor)
⊆ extent(Engine)
```

---

# Specialization은 재사용보다 추론을 위한 관계다

Specialization에는 모델 재사용이라는 효과가 있다.

상위 Type에서 정의한 구조와 Feature를 하위 Type에서 다시 선언하지 않고 활용할 수 있다.

하지만 집합론적 관점에서 더 중요한 역할은 **추론**이다.

다음 모델이 있다고 하자.

```sysml
part def ElectricCar :> Car;
part def Car :> Vehicle;
```

어떤 인스턴스가 `ElectricCar`라면 다음을 추론할 수 있다.

```text
ElectricCar 인스턴스
⇒ Car 인스턴스
⇒ Vehicle 인스턴스
```

Feature에서도 마찬가지다.

```sysml
part mainEngine subsets engine;
```

어떤 값이 `mainEngine`의 값이라면 다음이 성립한다.

```text
mainEngine 값
⇒ engine 값
```

Redefinition도 Subsetting의 한 종류이므로, redefining Feature의 값은 redefined Feature의 의미와 제약 안에 포함된다.

따라서 Specialization은 단순한 계층 표현이 아니다.

> **구체적인 요소에 대해 알고 있는 사실을 더 일반적인 요소에 대한 사실로 안전하게 추론할 수 있게 하는 관계다.**

---

# Specialization은 제약의 상속이다

일반적으로 상속이라고 하면 상위 요소의 속성을 하위 요소가 물려받는 모습을 떠올린다.

```text
상위 요소의 속성
→ 하위 요소로 전달
```

하지만 KerML의 Specialization은 다음과 같이 이해하는 편이 더 본질적이다.

```text
상위 요소가 정의한 제약
→ 하위 요소에서도 반드시 성립

하위 요소
→ 추가 제약을 정의할 수 있음
```

즉, Specialization은 단순한 데이터나 멤버의 상속보다 **제약의 상속**에 가깝다.

```text
상위 개념의 제약
+
하위 개념의 추가 제약
=
더 구체적인 개념
```

하위 요소는 상위 요소보다 더 넓은 범위를 허용할 수 없다. 같거나 더 제한적인 범위를 가져야 한다.

이 원칙 덕분에 모델의 의미는 일반적인 개념에서 구체적인 개념으로 내려가도 일관성을 유지한다.

---

# 마무리: Specialization은 설계 공간을 좁히는 언어다

설계 초기에는 가능한 해의 범위가 넓다.

요구사항, 구조, 값의 Type, multiplicity와 같은 조건이 추가될수록 가능한 설계의 집합은 점점 좁아진다.

```text
전체 가능한 시스템
⊇ 특정 종류의 시스템
⊇ 특정 구조를 가진 시스템
⊇ 특정 값과 multiplicity를 만족하는 시스템
⊇ 우리가 설계하고자 하는 시스템
```

SysML v2의 Specialization은 이 과정을 모델 안에서 명시적으로 표현한다.

* Subclassification은 **시스템 종류의 범위**를 좁힌다.
* Feature Typing은 **Feature 값의 범위**를 좁힌다.
* Subsetting은 **Feature 관계의 범위**를 좁힌다.
* Redefinition은 Subsetting을 기반으로 **상속된 Feature를 특정 문맥에서 더 구체화**한다.

결국 네 관계는 모두 다음 원리를 따른다.

```text
Specific ⊆ General
```

다만 어떤 집합을 좁히는지가 다를 뿐이다.

Specialization을 집합론으로 이해하면 `:>`, `:`, `subsets`, `redefines`는 서로 무관한 문법이 아니다.

이들은 모두 하나의 설계 원리를 표현한다.

> **일반적인 가능성에서 출발해 제약을 추가하고, 우리가 의도한 시스템에 해당하는 더 구체적인 해의 집합을 찾아가는 것**

이것이 설계 과정에서 SysML v2의 Specialization이 중요한 이유다.
