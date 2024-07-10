# 21_SwiftUI 스택과 프레임

## 21.1_SwiftUI 스택

SwiftUI는 VStack(수직), HStack(수평), ZStack(중첩되게 배치하는 뷰) 형태인 3개의 스택 레이아웃 뷰를 제공한다.

스택은 SwiftUI View 파일 내에 하위 뷰들이 스택 뷰에 포함되도록 선언한다.

---

## 21.2_Spacer, alignment, 그리고 padding

SwiftUI는 뷰 사이에 공간을 추가하기 위한 Spacer 컴포넌트를 가지고 있다. Spacer를 스택 안에서 사용하면 Spacer는 배치된 뷰들의 간격을 제공하기 위하여 스택의 방향(즉, 수평 또는 수직)에 따라 유연하게 확장/축소된다.

스택의 정렬은 스택이 선언될 때 정렬 값을 지정하면 된다.

### 간격

또한, 간격(spacing) 값을 지정할 수도 있다.

뷰 주변의 간격은 padding() 수정자를 이용하여 구현할 수 있다. 매개변수 없이 호출하면 SwiftUI는 레이아웃, 콘텐트, 그리고 화면 크기에 대한 최적의 간격을 자동으로 사용한다.

---

## 21.3\_컨테이너의 자식 뷰 제한

컨테이너 뷰는 직접적인 하위 뷰를 10개로 제한한다.

만약 스택에 포함된 직접적인 자식 뷰가 10개를 넘어야 한다면 뷰들은 여러 컨테이너로 나눠서 담겨야 할 것이다. 물론, 하위 뷰로 스택을 추가하여 할 수도 있지만 Group 뷰라는 또 다른 유용한 컨테이너가 있다.

```swift
VStack {

	Group {
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
	}

	Group {
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
		Text("Sample Text")
	}
}
```

이것은 10개의 하위 뷰 제한을 피하게 할 뿐만 아니라, Group은 여러 뷰에서 작업을 수행할 때에도 유용하다.

---

## 21.4\_동적 HStack과 VStack 변환

설계 단계에서 HStack으로 할지 아니면 VStack으로 할지에 대한 결정은 마지막에 해야 한다. SwiftUI는 레이아웃에 사용되는 스택 타입을 앱 코드 내에서 동적으로 변경할 수도 있게 한다. 이것은 AnyLayout 인스턴스를 생성하고 HStackLayout 또는 VStackLayout 컨테이너에 할당하여 할 수 있다.

```swift
@State var myLayout: AnyLayout = AnyLayout(VStackLayout())

var body: some View {

	VStack {
		myLayout {
			Image(systemName: "goforward.10")
				.resizable()
				.aspectRatio(contentMode: .fit)
			Image(systemName: "goforward.15")
				.resizable()
				.aspectRatio(contentMode: .fit)
		}

		HStack {
			Button(action: {
				myLayout = AnyLayout(HStackLayout()) }) {
				Text("HStack")
			}
			Button(action: {
				myLayout = AnyLayout(VStackLayout()) }) {
				Text("VStack")
			}
		}
	}
}
```

---

## 21.5\_텍스트 줄 제한과 레이아웃 우선순위

디폴트로, HStack은 Text 뷰를 한 줄로 보여준다.

예를 들어, 스택의 크기가 제한되어 있거나 다른 뷰들과 공간을 나눠서 사용해야 하는 상황처럼, 스택이 충분한 공간을 가지고 있지 않다면 자동으로 여러 줄로 표시될 것이다.

텍스트를 몇 줄로 표현할지는 lineLimit() 수정자를 사용하면 정할 수 있다.

```swift
HStack {
	Image(systemName: "airplane")
	Text("Flight times;")
	Text("London")
}
.font(.largeTitle)
.lineLimit(1)
```

### 줄 제한

줄 제한(line limit)은 텍스트가 표시될 수 있는 최대 및 최소 줄 수를 제공하는 범위로 지정할 수도 있다.

```swift
.lineLimit(1....4)
```

### 우선순위

우선순위(priority)에 대한 가이드가 없으면 스택 뷰는 안에 포함된 뷰들의 길이와 여유 공간을 기반으로 Text 뷰를 어떻게 자를지 결정하게 된다. 텍스트 뷰 선언부에 우선순위 정보가 없다면 스택은 어떤 뷰의 텍스트가 더 중요한지 알 방법이 없다. 우선순위는 layoutPriority() 수정자를 사용해서 줄 수 있다. 이 수정자는 스택에 있는 뷰에 추가될 수 있으며, 해당 뷰의 우선순위 레벨을 가리키는 값을 전달할 수 있다. 높은 숫자가 더 큰 우선순위를 갖게 되어 잘리는 현상이 사라질 것이다.

```swift
HStack {
	Image(systemName: "airplane")
	Text("Flight times;")
	Text("London")
		.layoutPriority(1)
}
.font(.largeTitle)
.lineLimit(1)
```

도시명에 더 높은 우선순위가 할당되었다. 우선순위를 지정하지 않으면 우선순위 값은 디폴트로 0이다.

---

## 21.6\_전통적 스택 vs. 지연 스택

기존 HStack 및 VStack 뷰를 사용할 때 시스템은 포함된 하위 뷰들이 현재 사용자에게 표시되는지 여부와는 관계없이 초기화 시 모든 하위 뷰를 생성한다. 대부분의 요구사항에서는 이것이 문제가 되지 않을 수 있지만 스택에 수천 개의 하위 뷰가 있는 상황에서는 성능 저하로 이어질 수 있다.

이 문제를 해결하지 위해 SwiftUI는 지연(lazy) 수직 및 수평 스택 뷰도 제공한다. 이러한 뷰(LazyVStack 및 LazyHStack이라고 함)는 기존 스택 뷰와 동일한 선언 구문을 사용하지만 필요할 때만 하위 뷰를 생성하도록 설계되었다. 예를 들어, 사용자가 스택을 스크롤할 때 현재 화면 밖에 있는 뷰는 사용자에게 표시되는 지점에 도달한 후에만 생성된다. 뷰가 영역을 벗어나면 SwiftUI는 해당 뷰를 해제하여 더 이상 시스템 리소스를 차지하지 않는다.

기존 스택을 사용할지 아니면 지연 스택을 사용할지 결정할 때는 일반적으로 기존 스택을 사용하여 시작하고 많은 수의 자식 뷰로 인한 성능 문제가 발생할 때 지연 스택으로 전환하는 것이 좋다.

---

## 21.7_SwiftUI 프레임

기본적으로 뷰는 자신의 콘텐트와 자신이 속한 레이아웃에 따라 자동으로 크기가 조절된다. 대부분은 뷰의 크기가와 위치는 스택 레이아웃을 사용하여 조절할 수 있지만, 때로는 뷰 자체가 특정 크기나 영역에 맞아야 하기도 한다. 이를 위해 SwiftUI는 조절 가능한 frame 수정자를 제공한다.

```swift
Text("Hello Wolrd, how are you?")
	.font(.largeTitle)
	.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
	.border(Color.black, width: 5)
```

### 안전 영역/카메라 노치

디폴트로, frame은 화면을 채울 때 화면의 안전 영역(safe area)을 준수한다. 안전 영역 밖에 있다고 판단하는 여역으로는 일부 디바이스 모델에 있는 카메라 노치(camera notch)가 차지하는 부분과 시간, 와이파이, 셀룰러 신호 강도 아이콘을 표시하는 화면 상단이 포함된다. 안전 영역 밖에까지 확장되도록 frame을 구성하려면 edgesIgnoringSafeArea() 수정자를 사용하면 안전 영역을 무시하게 된다.

```swift
.edgesIgnoringSafeArea(.all)
```

---

## 21.8_frame과 GeometryReader

### 리더

프레임은 뷰들을 담고 있는 컨테이너의 크기에 따라 조절되도록 구현할 수도 있다. 이 작업은 GeometryReader로 뷰를 감싸고 컨테이너의 크기를 식별하기 위한 리더(reader)를 이용하여 할 수 있다. 이 리더는 프레임의 크기를 계산하는 데 사용된다. 다음의 예제는 두 개의 Text 뷰를 포함하고 있는 VStack의 크기를 기준으로 Text 뷰의 크기를 설정한다.

```swift
GeometryReader { geometry in
	VStack {
		Text("Hello World, how are you?")
			.font(.largeTitle)
			.frame(width: geometry.size.width / 2, height: (geometry.size.height / 4) * 3)
		Text("Goodbye World")
			.font(.largeTitle)
			.frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
	}
}
```

---

## 21.9\_요약

기본적으로, 뷰는 콘텐트와 뷰를 포함하고 있는 컨테이너에 적용된 제한에 따라 크기가 정해진다. 뷰가 사용할 수 있는 공간이 충분하지 않은 경우 뷰의 크기가 제한적이므로 콘텐트가 잘리게 된다. 우선순위 설정을 하면 컨테이너 안의 다른 뷰의 크기보다 줄이거나 늘릴 수 있다.

뷰에 할당된 공간을 보다 효과적으로 제어하기 위해 뷰에 유연한 프레임을 적용할 수 있다. 프레임은 크기를 고정하거나, 최솟값과 최댓값 범위 내에서 제한하거나, GeometryReader를 사용하여 뷰 크기를 조절할 수 있다.
