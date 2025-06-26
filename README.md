# 📱 프론트엔드 개발자 채용 과제 - Flutter 앱

Flutter 기반 **프론트미션 과제 프로젝트**입니다.  
MVVM & Clean Architecture를 기반으로 구성되었으며, Riverpod, GoRouter 등의 Flutter 기술 스택을 사용했습니다.

## 🔧 개발 환경

- **Flutter SDK**: `3.29.2`
- **IDE**: Android Studio 또는 VS Code

## 🧱 아키텍처

- **패턴**: MVVM + Clean Architecture
- **상태관리**: Riverpod
- **라우팅**: GoRouter
- **모델 관리**: Freezed + JsonSerializable
- **보안 저장소**: Flutter Secure Storage

## 📦 사용한 주요 라이브러리

| 라이브러리 | 설명 |
|------------|------|
| `flutter_riverpod` | 상태 관리 |
| `go_router` | 라우팅 관리 |
| `freezed` / `json_annotation` | 불변 모델 클래스 및 JSON 직렬화 |
| `flutter_secure_storage` | 인증 토큰 저장 |
| `dio` / `retrofit` | 네트워크 통신 |
| `infinite_scroll_pagination` | 무한 스크롤 페이지네이션 |

## 🎥 데모 영상

👉 [프로젝트 데모 영상 보기](https://github.com/user-attachments/assets/4d0f79f6-2dcd-42b5-b1b1-17b7041062bf)

## ✅ 실행 방법

🧩 1. 프로젝트 클론

터미널에서 아래 명령어를 실행해 프로젝트를 로컬에 복사합니다.
```bash
git clone https://github.com/oneStar92/bigs_mission.git
cd bigs_mission
```

▶️ 2. 프로젝트 열기

Android Studio 또는 VSCode로 해당 디렉토리 프로젝트를 엽니다.

🚀 3. Flutter 패키지 설치
필요한 의존성을 설치합니다
```bash
flutter pub get
```

🛠️ 4. 코드 생성 (build_runner)

Freezed, JsonSerializable 등을 위한 코드 생성:
```bash
dart run build_runner build --delete-conflicting-outputs
```

🖥️ 5. 시뮬레이터 실행

Android Studio:
	•	상단 툴바에서 기기 선택 → 실행 ▶️ 클릭

VS Code:
	•	좌측 하단 디바이스 선택 → iOS Simulator 또는 Android Emulator 클릭

📱 6. 앱 실행

Android Studio:
	•	▶️ 버튼 클릭하여 실행

VS Code:
	•	상단 메뉴에서 Run > Start Debugging 또는 F5 키
