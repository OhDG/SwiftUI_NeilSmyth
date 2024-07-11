# 23_SwiftUI 예제 튜토리얼

## 23.1\_예제 프로젝트 생성하기

## 23.2\_프로젝트 살펴보기

## 23.3\_레이아웃 수정하기

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
    }
}
```

---

## 23.4\_스택에 슬라이더 뷰 추가하기

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
            Slider(value: Value)
        }
    }
}
```

---

## 23.5\_상태 프로퍼티 추가하기

```swift
struct ContentView: View {

    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            Text("Hello, world!")
            Slider(value: $rotation, in: 0 ... 360, step: 0.1)
        }
    }
}
```

---

## 23.6_Text 뷰에 수정자 추가하기

```swift
struct ContentView: View {

    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            VStack {
                Text("Hello, world!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Slider(value: $rotation, in: 0 ... 360, step: 0.1)
            }
        }
    }
}
```

---

## 23.7\_회전과 애니메이션 추가하기

```swift
struct ContentView: View {

    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            VStack {
                Text("Hello, world!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 5), value: rotation)
                Slider(value: $rotation, in: 0 ... 360, step: 0.1)
            }
        }
    }
}
```

---

## 23.8\_스택에 TextField 추가하기

```swift
struct ContentView: View {

    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"

    var body: some View {
        VStack {
            VStack {
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 5), value: rotation)

                Slider(value: $rotation, in: 0 ... 360, step: 0.1)

                TextField("Enter text here", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
    }
}
```

---

## 23.9\_색상 피커 추가하기

ForEach는 그 자체로 배열이나 범위와 같은 데이터 세트를 반복하여 여러 뷰를 생성하도록 특별히 설계된 SwiftUI 뷰 구조다.

```swift
struct ContentView: View {

    var colors: [Color] = [.black, .red, .green, .blue]
    var colornames =  ["Black", "Red", "Green", "Blue"]

    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"

    var body: some View {
        VStack {
            VStack {
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 5), value: rotation)
                    .foregroundColor(colors[colorIndex])

                Slider(value: $rotation, in: 0 ... 360, step: 0.1)

                TextField("Enter text here", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Picker(selection: $colorIndex, label: Text("Color")) {
                    ForEach (0 ..< colornames.count, id:\.self) { color in
                        Text(colornames[color])
                            .foregroundColor(colors[color])
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }
}
```

---

## 23.10\_레이아웃 정리하기

```swift
struct ContentView: View {

    var colors: [Color] = [.black, .red, .green, .blue]
    var colornames =  ["Black", "Red", "Green", "Blue"]

    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 5), value: rotation)
                    .foregroundColor(colors[colorIndex])
                Spacer()
                Divider()

                Slider(value: $rotation, in: 0 ... 360, step: 0.1)
                    .padding()

                TextField("Enter text here", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Picker(selection: $colorIndex, label: Text("Color")) {
                    ForEach (0 ..< colornames.count, id:\.self) { color in
                        Text(colornames[color])
                            .foregroundColor(colors[color])
                    }
                }
                .pickerStyle(.wheel)
                .padding()
            }
        }
    }
}
```

---

## 23.11\_요약

레이아웃에 뷰들을 추가하는 다양한 방법과 상태 프로퍼티 바인딩과 수정자 사용까지 다뤘다. 이번 장은 Spacer와 Divider를 소개했으며, 데이터 배열로부터 동적으로 뷰를 생성하기 위하여 ForEach를 어떻게 사용하는지도 살펴보았다.
