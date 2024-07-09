# 19\_기본 SwiftUI 프로젝트 분석

## 19.1\_예제 프로젝트 생성하기

## 19.2_DemoProjectApp.swift 파일

```swift
import SwiftUI

@main
struct DemoProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

구현된 선언부는 ContentView.swift 파일에 정의된 View를 포함하는 WindowGroup으로 구성된 Scene을 반환한다. 선언부에는 @main이 접두사로 붙는다. 이것은 기기에서 앱이 실행될 때 여기가 앱의 진입점임을 SwiftUI에 알려주는 역할을 한다.

---

## 19.3_ContentView.swift 파일

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
```

이것은 앱이 시작될 때 나타나는 첫 번째 화면의 내용을 포함하는 SwiftUI 뷰 파일이다. 이 파일 및 이와 유사한 다른 파일들은 SwiftUI에서 앱을 개발할 때 대부분의 작업이 수행되는 곳이다.

---

## 19.4_Assets.xcassets

Assets.xcassets 폴더에는 이미지, 아이콘 및 색상과 같이 앱에서 사용하는 리소스를 저장하는데 사용되는 애셋 카탈로그가 포함되어 있다.

---

## 19.5_DemoProject.entitlements

entitlements 파일은 앱 내에서 특정 iOS 기능에 대한 지원을 활성화하는 데 사용된다.

---

## 19.6_Preview Content

프리뷰 애셋 폴더에는 개발 중에 앱을 미리 볼 때 필요하지만 완성된 앱에서는 필요하지 않은 자산 및 데이터가 포함되어 있다.

---

## 19.7\_요약

Multiplatform App 템플릿을 사용하여 Xcode에서 새 SwiftUI 프로젝트를 생성하면 Xcode는 앱이 작동하는 데 필요한 최소한의 파일 세트를 자동으로 생성한다. 이러한 모든 파일과 폴더는 리소스 애셋 추가, 초기화 및 초기화 해제 작업 수행, 앱의 사용자 인터페이스 및 로직 구축 측면에서 앱에 기능을 추가하도록 수정할 수 있다.
