# 왜 KerML은 Namespace의 `name`을 필수로 만들지 않았을까?

KerML 명세를 읽다가 한 가지 의문이 생겼다.

Namespace는 다른 Element를 포함하고, 그 안의 Member를 이름으로 찾기 위한 범위를 만든다. 그렇다면 Namespace에는 당연히 이름이 있어야 하지 않을까? 하지만 KerML 메타모델에서 Namespace가 상속받는 `name`은 필수가 아니라 `0..1`, 즉 선택 사항이다.

명세는 그 이유를 직접 설명하지 않는다. 아래 내용은 Namespace, Qualified Name, Name Resolution에 관한 설명을 연결해 설계 의도를 추론한 것이다.

## Namespace는 이름이 아니라 Membership으로 성립한다

KerML에서 Namespace는 Membership Relationship을 통해 다른 Element를 Member로 가진다.

```text
Namespace
   └─ owns → Membership
                 └─ memberElement → Element
```

Namespace를 Namespace답게 만드는 핵심은 이름이 아니라 Membership이다. 이름이 없어도 다른 Element를 포함할 수 있고, Ownership 구조도 유지된다.

```kerml
namespace {
    classifier A;
}
```

이 Namespace에는 이름이 없지만 `A`를 소유하는 Namespace라는 사실은 변하지 않는다. 즉 모델의 구조가 이름에 의존하지 않는다.

## Qualified Name은 모델의 본체가 아니다

이름은 다른 Element를 텍스트에서 참조할 때 중요하다.

```kerml
namespace Vehicle {
    namespace Powertrain {
        classifier Engine;
    }
}
```

이때 `Engine`은 다음과 같이 참조할 수 있다.

```text
Vehicle::Powertrain::Engine
```

하지만 KerML 명세에 따르면 Qualified Name은 Textual Concrete Syntax에서 Element를 식별하기 위한 표기다. Name Resolution이 끝난 Abstract Syntax에는 `Vehicle::Powertrain::Engine`이라는 문자열 대신 실제 `Engine` Element에 대한 Reference가 들어간다.

```text
Vehicle::Powertrain::Engine
              │ Name Resolution
              ▼
Reference ─────────► Engine Element
```

따라서 Namespace에 이름이 없어 Qualified Name을 만들 수 없더라도, Namespace와 Member 자체가 사라지는 것은 아니다. 모델 내부 관계는 실제 Element Reference로 유지될 수 있다.

## 이름은 Identity보다 Address에 가깝다

이 관점에서 Name은 Element의 본질적인 정체성이라기보다 사람이 사용하는 주소에 가깝다.

파일 경로는 파일을 찾는 데 유용하지만 파일 내용 그 자체는 아니다. 파일을 이동하면 경로는 바뀌어도 파일 내용은 유지된다. KerML의 Qualified Name도 비슷하다.

```text
Vehicle::Powertrain::Engine
              ↓
Product::Propulsion::Engine
```

Namespace 구조나 이름이 바뀌면 Qualified Name은 달라질 수 있다. 하지만 모델 관리 도구가 기존 Reference를 보존한다면 같은 Element로 계속 관리할 수 있다.

모든 Namespace에 이름을 강제하면 외부에서 참조할 필요가 없는 내부 구조나 도구가 만든 임시 컨테이너에도 억지 이름을 붙여야 한다. 그러면 `Temp1`, `Group2`, `Container3` 같은 이름이 늘어난다. 이름표는 많아지지만 정보는 늘지 않는 기묘한 관료제 모델이 탄생한다.

## 익명 Namespace가 치르는 비용

물론 이름을 생략하면 대가가 있다.

KerML 명세에 따르면 이름 없는 Namespace의 Member는 자신이 이름을 가지고 있더라도 Qualified Name을 가질 수 없다. 중간 Namespace의 이름 Segment가 없기 때문이다.

```text
NamedNamespace::Member   가능
???::Member              불가능
```

따라서 익명 Namespace 안의 Member는 다른 위치의 텍스트에서 이름으로 참조하기 어렵다. 검색 결과, 오류 메시지, 문서, API 응답을 사람이 읽을 때도 불편할 수 있다.

즉 `name`이 선택 사항이라는 사실이 이름을 생략하는 것이 좋은 모델링 방법이라는 뜻은 아니다.

## 언어 규칙과 모델링 규칙은 다르다

KerML은 다음 두 경우를 모두 표현할 수 있도록 이름을 선택 사항으로 둔 것으로 보인다.

1. 사람이 이름으로 탐색하고 재사용하는 공개 Namespace
2. 외부 참조가 필요하지 않은 내부 또는 익명 Namespace

반면 조직의 모델링 가이드에서는 더 엄격한 규칙을 적용할 수 있다.

- Root Namespace와 Package에는 이름을 부여한다.
- 다른 Package에서 참조되는 Namespace에는 이름을 부여한다.
- 문서나 API에 노출되는 Namespace에는 안정적인 이름을 부여한다.
- 익명 Namespace는 제한된 로컬 구조에만 사용한다.

언어는 표현 가능성을 열어 두고, 좋은 모델을 만들기 위한 정책은 사용자와 조직이 선택하게 한 것이다.

## 정리

Namespace의 `name`이 `1`이 아니라 `0..1`인 이유를 나는 다음과 같이 해석한다.

> KerML에서 Namespace의 본질은 이름이 아니라 Membership을 통한 구조이며, Qualified Name은 그 구조를 텍스트에서 찾기 위한 선택적인 주소 체계이기 때문이다.

이름이 없어도 Namespace는 Member를 포함할 수 있고, Abstract Syntax에서는 실제 Element Reference로 관계를 유지할 수 있다. 따라서 언어 차원에서 모든 Namespace에 이름을 강제할 필요는 없다.

다만 이름 없는 Namespace는 Qualified Name을 만들 수 없어 참조, 재사용, 검색, 문서화에 불리하다. 실무에서는 공개되거나 재사용되는 Namespace에 이름을 붙이는 편이 좋다.

결국 `0..1`은 “이름이 중요하지 않다”는 뜻이 아니다.  
**이름이 모델의 존재 조건은 아니라는 뜻에 가깝다.**

## 참고

- OMG Kernel Modeling Language 1.0, §7.2.5.1 *Namespaces Overview*
- OMG Kernel Modeling Language 1.0, §8.3.2.1 *Elements and Relationships Abstract Syntax*
- OMG Kernel Modeling Language 1.0, §8.3.2.4 *Namespaces Abstract Syntax*

> 설계 의도에 관한 설명은 명세에 직접 적힌 결론이 아니라, 관련 조항을 연결한 개인적인 해석이다.
