# 20_SwiftUI로 커스텀 뷰 생성하기

## 20.1_SwiftUI 뷰

### 뷰

사용자 인터페이스 레이아웃은 뷰 사용과 생성, 그리고 결합을 통해 SwiftUI로 구성된다. SwiftUI에서 뷰(view)는 View 프로토콜을 따르는 구조체로 선언된다. View 프로토콜을 따르도록 하기 위해서 구조체는 body 프로퍼티를 가지고 있어야 하며, 이 body 프로퍼티 안에 뷰가 선언되어야 한다.

---

## 20.2\_기본 뷰 생성하기

## 20.3\_뷰 추가하기

### 클로저

```swift
struct ContentView: View {
	var body: some View {
		Text("Hello, ") + Text("how ") + Text("are you?")
	}
}
```

앞의 예제에서 body 프로퍼티의 클로저(closure)는 반환 구문이 없다. 왜냐하면 단일 표현식으로 되어 있기 때문이다. 하지만, 다음의 예제와 같이 클로저에 별도의 표현식이 추가되면 return 구문을 추가해야 한다.

```swift
struct ContentView: View {

	@State var fileopen: Bool = true

	var body: some View {

		var myString: String = "File closed"

		if (fileopen) {
			myString = "File open"
		}

		return VStack {
			HStack {
				Text(myString)
					.padding()
				Text("Goodbye, world")
			}
		}
	}
}
```

---

## 20.4\_하위 뷰로 작업하기

애플은 최대한 뷰를 작고 가볍게 하라고 권장한다. 이것은 재사용할 수 있는 컴포넌트 생성을 권장하고, 뷰 선언부를 더 쉽게 관리하도록 하며, 레이아웃이 더 효율적으로 렌더링되도록 한다.

---

## 20.5\_프로퍼티로서의 뷰

HStack을 carStack이라는 이름의 프로퍼티에 할당하고 VStack 레이아웃에서 참조한다.

```swift
struct ContentView: View {

	let carStack = HStack {
		Text("Car Image")
		Image(systemName: "car.fill")
	}

	var body: some View {
		VStack {
			Text("Main Title")
				.font(.largeTitle)
				carStack
		}
	}
}
```

---

## 20.6\_뷰 변경하기

### 수정자

SwiftUI와 함께 제공되는 모든 뷰는 커스터마이징이 필요 없을 정도로 완전히 정확하게 우리가 원하는 모양과 동작을 하는 건 아니기 때문에 수정자(modifier)를 뷰에 적용하여 변경할 수 있다.

---

## 20.7\_텍스트 스타일로 작업하기

## 20.8\_수정자 순서

수정자들을 연결할 때 수정자들이 적용되는 순서가 중요하다는 점을 알아야 한다.

```swift
Text("Sample Text")
	.border(Color.black)
	.padding()

Text("Sample Text")
	.padding()
	.border(Color.black)
```

---

## 20.9\_ 커스텀 수정자

커스텀 수정자는 ViewModifier 프로토콜을 따르는 구조체로 선언되며, 다음과 같이 구현된다.

```swift
struct StandardTitle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle)
			.background(Color.white)
			.border(Color.gray, width: 0.2)
			.shadow(color: Color.black, radius: 5, x: 0, y: 5)
	}
}
```

필요한 곳에서 modifier() 메서드를 통해 커스텀 수정자를 전달하여 적용한다.

```swift
Text("Text 1")
	.modifier(StandardTitle())
Text("Text 2")
	.modifier(StandardTitle())
```

---

## 20.10\_기본적인 이벤트 처리

### 데이터 주도적

SwiftUI가 데이터 주도적(data-driven)이라고는 했지만, 사용자 인터페이스인 뷰를 사용자가 조작할 때 발생하는 이벤트 처리는 여전히 필요하다.

```swift
struct ContentView: View {
	var body: some View {
		Button(action: buttonPressed) {
			Text("Click Me")
		}
	}

	func buttonPressed() {
		// 동작할 코드가 온다.
	}
}
```

액션 함수를 지정하는 대신, 버튼이 클릭되었을 때 실행될 코드를 클로저도 지정할 수도 있다.

```swift
Button(action: {
	// 동작할 코드가 온다.
}) {
	Text("Click Me")
}
```

---

## 20.11\_커스텀 컨테이너 뷰 만들기

### 정적

하위 뷰는 뷰 선언부를 작고 가벼우며 재사용할 수 있는 블록으로 나누는 유용한 방법을 제공한다. 하지만 하위 뷰의 한 가지 한계는 컨테이너 뷰의 콘텐트가 정적(static)이라는 점이다. 다시 말해, 하위 뷰가 레이아웃에 포함되는 시점에 하위 뷰에 포함될 뷰를 동적으로 지정할 수 없다. 하위 뷰에 포함되는 뷰들은 최초 선언부에 지정된 하위 뷰들뿐이다.

간격이 10이며 largeTitle 폰트 수정자를 가진 VStack이 프로젝트 내에서 자주 필요하지만, 사용할 곳마다 서로 다른 뷰들이 여기에 담겨야 한다고 가정하자. 하위 뷰를 사용해서는 이러한 유연성을 갖지 못하지만, 커스텀 컨테이너 뷰를 생성할 때 SwiftUI의 ViewBuilder 클로저 속성을 이용하면 가능하다.

ViewBuilder는 스위프트 클로저 형태를 취하며 여러 하위 뷰로 구성된 커스텀 뷰를 만드는 데 사용될 수 있으며, 이 뷰가 레이아웃 선언부 내에 사용될 때까지 내용을 선언할 필요가 없다. ViewBuilder 클로저는 콘텐트 뷰들을 받아서 동적으로 만들어진 단일 뷰로 반환한다.

```swift
struct MyVStack<Content: View>: View {
	let content: () -> Content
	init(@ViewBuilder content: @escaping() -> Content) {
		self.content = content
	}

	var body: some View {
		VStack(spacing: 10) {
			content()
		}
		.font(.largeTitle)
	}
}
```

```swift
MyVStack {
	Text("Text 1")
	Text("Text 2")
	HStack {
		Image(systemName: "star.fill")
		Image(systemName: "star.fill")
		Image(systemName: "star")
	}
}
```

---

## 20.12\_레이블 뷰로 작업하기

### 쉐이프 렌더링/SF 심볼/샌 프란시스코

레이블 뷰는 아이콘과 텍스트가 나란히 배치된 형태의 두 요소로 구성된다는 점에서 대부분의 다른 SwiftUI 뷰와 다르다. 이미지는 모든 이미지 애셋이나, SwiftUI 쉐이프 렌더링(shape rendering), 또는 SF 심볼(SF symbol)의 형태를 취할 수 있다.

SF 심볼은 애플 플랫폼용 앱을 개발할 때 사용할 수 있고 애플의 샌 프란시스코(San Francisco) 시스템 폰트를 보완하도록 설계된 수천 개의 확장 가능한 벡터 드로잉 모음이다.

```swift
Label("Welcome to SwiftUI", systemImage: "person.circle.fill")
	.font(.largeTitle)

Label("Welcome to SwiftUI", image: "myimage")

Label(
	title: {
		Text("Welcome to SwiftUI")
			.font(.largeTitle)
	},
	icon: { Circle()
		.fill(Color.blue)
		.frame(width: 25, height: 25)
	}
}
```

---

## 20.13\_요약

SwiftUI의 사용자 인터페이스는 SwiftUI View 파일에 선언되며, View 프로토콜을 따르는 컴포넌트들로 구성된다. View 프로토콜을 따르도록 하기 위해서 구조체는 View 자신인 body라는 이름의 프로퍼티를 포함해야 한다.

SwiftUI는 사용자 인터페이스 레이아웃을 설계하는 데 사용되는 내장 컴포넌트들의 라이브러리를 제공한다. 뷰의 모양과 동작은 수정자를 적용하여 구성할 수 있으며, 커스텀 뷰와 하위 뷰를 생성하기 위하여 수정되거나 그루핑될 수 있다. 마찬가지로, 커스텀 컨테이너 뷰는 ViewBuilder 클로저 프로퍼티를 이용하여 생성될 수 있다.

수정자를 뷰에 적용하면 새롭게 변경된 뷰가 반환되며, 그 다음에 오는 수정자가 다시 적용된다. 뷰에 수정자를 적용하는 순서가 중요한 영향을 주게 된다.
