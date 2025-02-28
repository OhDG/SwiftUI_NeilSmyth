# 18_SwiftUI 아키텍처

## 18.1_SwiftUI 앱 계층 구조

## 18.2_App

### 생명주기

App 객체는 SwiftUI 애플리케이션 구조 내 최상위 요소이며 애플리케이션의 실행 중인 각 인스턴스의 시작 및 생명 주기(lifecycle)를 처리한다.

App 요소는 애플리케이션의 사용자 인터페이스를 구성하는 다양한 Scene을 관리하는 역할을 한다. 애플리케이션에는 하나의 App 인스턴스만 포함된다.

---

## 18.3_Scene

각 SwiftUI 애플리케이션에는 하나 이상의 Scene이 포함된다. Scene은 애플리케이션 사용자 인터페이스의 섹션 또는 영역을 나타낸다.

SwiftUI에는 응용 프로그램을 설계할 때 사용할 수 있는 미리 빌드된 기본 Scene 타입이 포함되어 있으며, 그중 가장 일반적인 것은 WindowGroup 및 DocumentGroup이다. Scene을 그룹화하여 자신만의 사용자 지정 Scene을 만드는 것도 가능하다.

---

## 18.4_View

View는 버튼, 레이블, 그리고 텍스트 필드와 같은 사용자 인터페이스의 시각적 요소를 구성하는 기본적인 빌딩 블록이다. 각 Scene에는 애플리케이션의 사용자 인터페이스 섹션을 구성하는 뷰의 계층 구조가 포함된다.

---

## 18.5\_요약

SwiftUI 애플리케이션은 계층적으로 구성된다. 계층 구조의 맨 위에는 애플리케이션의 시작 및 생명 주기를 담당하는 App 인스턴스가 있다. 하나 이상의 자식 Scene 인스턴스에는 애플리케이션의 사용자 인터페이스를 구성하는 View 인스턴스의 계층이 포함되어 있다. 이러한 Scene은 WindowGroup과 같은 SwiftUI 기본 Scene 타입 중 하나에서 파생되거나 사용자 정의로 구축될 수 있다.

iOS 또는 watchOS에서 애플리케이션은 일반적으로 전체 디스플레이를 차지하는 창 형태를 취하는 단일 Scene을 포함한다. 하지만 macOS 또는 iPadOS 시스템에서 응용 프로그램은 여러 Scene 인스턴스로 구성될 수 있으며, 종종 동시에 표시되거나 탭 인터페이스에서 함께 그룹화될 수 있는 별도의 창으로 표시된다.
