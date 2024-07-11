# 22_SwiftUI 상태 프로퍼티, Observable, State, Environment 객체

### 게시자/구독자

SwiftUI는 데이터 주도 방식으로 앱 개발을 강조한다고 설명하였으며, 사용자 인터페이스 내의 뷰들은 기본 데이터의 변경에 따른 처리 코드를 작성하지 않아도 뷰가 업데이트된다고 설명하였다. 이것은 데이터와 사용자 인터페이스 내의 뷰 사이에 게시자(publisher)와 구독자(subscriber)를 구축하여 할 수 있다.

이를 위하여 SwiftUI는 상태 프로퍼티, Observable 객체, State 객체, 그리고 Environment 객체를 제공하며, 이들 모두는 사용자 인터페이스의 모양과 동작을 결정하는 상태를 제공한다. SwiftUI에서 사용자 인터페이스 레이아웃을 구성하는 뷰는 코드 내에서 직접 업데이트하지 않는다. 그 대신, 뷰와 바인딩된 상태 객체가 시간이 지남에 따라 변하면 그 상태에 따라 자동으로 뷰가 업데이트된다.

## 22.1\_상태 프로퍼티

상태 프로퍼티는 상태에 대한 가장 기본적인 형태이며, 뷰 레이아웃의 현재 상태(예를 들어, 토글 버튼이 활성화되었는지 여부, 텍스트 필드에 입력된 텍스트, 또는 피커 뷰에서의 현재 선택)를 저장하기 위해서만 사용된다. 상태 프로퍼티는 String이나 Int 값처럼 간단한 데이터 타입을 저장하기 위해 사용되며, @State 프로퍼티 래퍼를 사용하여 선언한다.

상태 값은 해당 뷰에 속한 것이기 때문에 private 프로퍼티로 선언되어야 한다.

상태 프로퍼티 값이 변경되었다는 것은 그 프로퍼티가 선언된 뷰 계층 구조를 다시 렌더링해야 한다는 SwiftUI 신호다. 즉, 그 계층 구조 안에 있는 모든 뷰를 빠르게 재생성하고 표시해야 한다. 결국, 그 프로퍼티에 의존하는 모든 뷰는 어떤 식으로든 최신 값이 반영되도록 업데이트된다.

상태 프로퍼티를 선언했다면 레이아웃에 있는 뷰와 바인딩을 할 수 있다. 바인딩이 되어 있는 뷰에서 어떤 변경이 일어나면 해당 상태 프로퍼티에 자동으로 반영된다.

상태 프로퍼티와의 바인딩은 프로퍼티 이름 앞에 ‘$’를 붙이면 된다.

```swift
struct ContentView: View {

	@State private var wifiEnabled = true
	@State private var userName = ""

	var body: some View {

		VStack {
			Toggle(isOn: $wifiEnabled) {
				Text("Enable Wi-Fi")
			}
			TextField("Enter user name", text: $userName)
			Text(userName)
			Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
		}
	}
}
```

---

## 22.2_State 바인딩

상태 프로퍼티는 선언된 뷰와 그 하위 뷰에 대한 현재 값이다. 하지만, 어떤 뷰가 하나 이상의 하위 뷰를 가지고 있으며 동일한 상태 프로퍼티에 대해 접근해야 하는 경우가 발생한다.

이 문제는 다음과 같이 @Binding 프로퍼티 래퍼를 이용하여 프로퍼티를 선언하면 해결된다.

```swift
struct ContentView: View {

	@State private var wifiEnabled = true
	@State private var userName = ""

	var body: some View {

		VStack {
			Toggle(isOn: $wifiEnabled) {
				Text("Enable Wi-Fi")
			}
			TextField("Enter user name", text: $userName)
			Text(userName)
			WifiImageView(wifiEnabled: $wifiEnabled)
		}
	}
}

struct WifiImageView: View {

	@Binding var wifiEnabled: Bool

	var body: some View {
		Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
	}
}
```

---

## 22.3_Observable 객체

상태 프로퍼티는 뷰의 상태를 저장하는 방법을 제공하며 해당 뷰에만 사용할 수 있다. 즉, 하위 뷰가 아니거나 State 바인딩이 구현되어 있지 않은 다른 뷰는 접근할 수 없다. 상태 프로퍼티는 일시적인 것이어서 부모 뷰가 사라지면 그 상태도 사라진다. 반면, Observable 객체는 여러 다른 뷰들이 외부에서 접근할 수 있는 지속적인 데이터를 표현하기 위해 사용된다.

### 알림

Observable 객체는 ObservableObject 프로토콜을 따르는 클래스나 구조체 형태를 취한다. Observable 객체는 데이터의 특성과 출처에 따라 애플리케이션마다 다르겠지만, 일반적으로는 시간에 따라 변경되는 하나 이상의 데이터 값을 모으고 관리하는 역할을 담당한다. 또한, Observable 객체는 타이머나 알림(notification)과 같은 이벤트를 처리하기 위해 사용될 수도 있다.

### 게시된 프로퍼티

Observable 객체는 게시된 프로퍼티(published property)로서 데이터 값을 게시한다. 그런 다음, Observer 객체는 게시자를 구도학여 게시된 프로퍼티가 변경될 때마다 업데이트를 받는다. 앞에서 설명한 상태 프로퍼티처럼, 게시된 프로퍼티와의 바인딩을 통해 Observable 객체에 저장된 데이터가 변경됨을 반영하기 위해서 SwiftUI 뷰는 자동으로 업데이트될 것이다.

Combine 프레임워크에 포함되어 있는 Observable 객체는 게시자와 구독자 간의 관계를 쉽게 구축할 수 있도록 iOS 13에 도입되었다.

Combine 프레임워크는 여러 게시자를 하나의 스트림으로 병합하는 것부터 게시된 데이터를 구독자 요구에 맞게 변형하는 것까지 다양한 작업을 수행하는 커스텀 게시자 구축 플랫폼을 제공한다. 또한, 최초 게시자와 최종 구독자 간에 복잡한 수준의 연쇄 데이터 처리 작업도 구현할 수 있다. 하지만, 일반적으로는 내장된 게시자 타입들 중 하나면 충분할 것이다. 실제로 Observable 객체의 게시된 프로퍼티를 구현하는 가장 쉬운 방법은 프로퍼티를 선언할 때 @Published 프로퍼티 래퍼를 사용하는 것이다. 이 래퍼는 래퍼 프로퍼티 값이 변경될 때마다 모든 구독자에게 업데이트를 알리게 된다.

```swift
import Foundation
import Combine

class DemoData: ObservableObject {

	@Published var userCount = 0
	@Published var currentUser = ""

	init() {
		// 데이터를 초기화하기 위한 코드가 여기 온다.
		updateData()
	}

	func updateData() {
		// 데이터를 최신 상태로 유지하기 위한 코드가 여기 온다.
	}
}
```

구독자는 Observable 객체를 구독하기 위하여 @ObservedObject 또는 @StateObject 프로퍼티 래퍼를 사용한다. 구독하게 되면 그 뷰 및 모든 하위 뷰가 상태 프로퍼티에서 사용했던 것과 같은 방식으로 게시된 프로퍼티에 접근하게 된다.

```swift
import SwiftUI

struct ContentView: View {

    @ObservedObject var demoData: DemoData = DemoData()

    var body: some View {
        Text("\(demoData.currentUser), you are user number \(demoData.userCount)")
    }
}

#Preview {
    ContentView(demoData: DemoData())
}
```

게시된 데이터가 변경되면 SwiftUI는 새로운 상태를 반영하도록 자동으로 뷰 레이아웃 렌더링을 다시 할 것이다.

---

## 22.4_State 객체

### 상태 객체

iOS 14에 도입된 상태 객체(state object) 프로퍼티 래퍼(@StateObject)는 @ObservedObject 래퍼의 대안이다. 상태 객체와 관찰되는 객체의 주요 차이점은 관찰되는 객체 참조는 그것을 선언한 뷰가 소유하지 않으므로 사용되는 동안에(예를 들어, 뷰가 다시 렌더링된 결과) SwiftUI 시스템에 의해 파괴되거나 다시 생성될 위험이 있다는 것이다.

@ObservedObject 대신 @StateObject를 사용하면 참조를 선언한 뷰가 참조를 소유하므로, 해당 참조가 선언된 로컬 뷰나 자식 뷰에 의해 계속해서 필요로 하는 동안에는 SwiftUI에 의해 파괴되지 않는다.

@ObservedObject를 사용할 특별한 필요가 없다면, 일반적으로 상태 객체를 사용하여 Observable 객체를 구독하는 것이 좋다. 구문 측면에서 보면 @ObservedObject와 @StateObject 모두는 완전히 상호 교환 가능하다.

```swift
import SwiftUI

struct ContentView: View {

    @StateObject var demoData: DemoData = DemoData()

    var body: some View {
        Text("\(demoData.currentUser), you are user number \(demoData.userCount)")
    }
}
```

---

## 22.5_Environment 객체

### 이동

구독되는 객체는 특정 상태가 앱 내의 몇몇 SwiftUI 뷰에 의해 사용되어야 할 경우에 가장 적합하다. 그런데 어떤 뷰에서 다른 뷰로 이동(navigation)하는 데 이동될 뷰에서도 동일한 구독 객체에 접근해야 한다면, 이동할 때 대상 뷰로 구독되는 객체에 대한 참조를 전달해야 할 것이다.

Environment 객체는 Observable 객체와 같은 방식으로 선언된다. 즉, 반드시 Observable 프로토콜을 따라야 하며, 적절한 프로퍼티가 게시되어야 한다. 하지만, 중요한 차이점은 이 객체는 SwiftUI 환경에 저장되며, 뷰에서 뷰로 전달할 필요 없이 모든 자식 뷰가 접근할 수 있다는 것이다.

```swift
class SpeedSetting: ObservableObject {
	@Published var speed = 0.0
}
```

Environment 객체를 구독해야 하는 뷰는 @StateObject 또는 @ObservedObject 래퍼 대신 @EnvironmentObject 프로퍼티 래퍼를 사용하여 객체를 참조하기만 하면 된다.

```swift
struct SpeedControlView: View {
    @EnvironmentObject var speedsetting: SpeedSetting

    var body: some View {
        Slider(value: $speedsetting.speed, in: 0...100)
    }
}

struct SpeedDisplayView: View {
    @EnvironmentObject var speedsetting: SpeedSetting

    var body: some View {
        Text("Speed = \(speedsetting.speed)")
    }
}
```

이 시점에서 우리에게는 SpeedSetting이라는 Observable 객체와 해당 타입의 Environment 객체를 참조하는 두 개의 뷰가 있다. 하지만 아직 Observable 객체의 인스턴스를 초기화하지 않았다. 이 작업을 수행하는 논리적 위치는 앞에서 본 하위 뷰의 상위 뷰 안이다.

Observable 객체 인스턴스를 통해 전달하는 environmentObject() 수정자를 사용하여 다음과 같이 한다.

```swift
struct ContentView: View {
    let speedsetting = SpeedSetting()

    var body: some View {
        VStack {
            SpeedControlView()
            SpeedDisplayView()
        }
        .environmentObject(speedsetting)
    }
}
```

이러한 단계가 수행되면 객체는 관찰되는 객체와 동일한 방식으로 작동하지만, 뷰 계층 구조를 통해 전달되지 않고 콘텐트 뷰의 모든 하위 뷰에 접근할 수 있다는 점만 다르다.

---

## 22.6\_요약

SwiftUI는 사용자 인터페이스와 앱의 로직에 데이터를 바인딩하는 방법 세 가지를 제공한다. 상태 프로퍼티는 사용자 인터페이스 레이아웃 내의 뷰 상태를 저장하는 데 사용되며, 현재 콘텐트 뷰에 관한 것이다. 이 값은 임시적이어서 해당 뷰가 사라지면 값도 없어진다.

사용자 인터페이스 밖에 있으며 앱 내의 SwiftUI 뷰 구조체의 하위 뷰에만 필요한 데이터는 Observable 객체 프로퍼티를 사용해야 한다. 이 방법을 사용하면 데이터를 표시하는 클래스나 구조체는 ObservableObject 프로토콜을 따라야 하며, 뷰와 바인딩될 프로퍼티는 @Published 프로퍼티 래퍼를 사용하여 선언되어야 한다. 뷰 선언부에 Observable 객체 프로퍼티와 바인딩하려면 프로퍼티는 @ObservedObject 또는 @StateObject 프로퍼티 래퍼를 사용해야 한다(대부분의 경우 @StateObject가 선호되는 옵션임).

사용자 인터페이스 밖에 있으며 여러 뷰가 접근해야 하는 데이터일 경우에는 Environment 객체가 최고의 해결책이 된다. Observable 객체와 동일한 방법으로 선언되지만, Environment 객체 바인딩은 @EnvironmentObject 프로퍼티 래퍼를 사용하여 SwiftUI 뷰 파일 내에 선언된다. 자식 뷰에 접근할 수 있게 되기 전에 environmentObject() 수정자를 사용하여 뷰 계층 구조에 삽입하기 전에 Environment 객체도 초기화해야 한다.
