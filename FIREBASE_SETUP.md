# Firebase 실시간 매칭 설정

실제 참여자끼리 가위바위보를 하려면 Firebase 프로젝트를 만들고 설정해야 합니다.

## 1. Firebase 프로젝트 만들기

1. [Firebase Console](https://console.firebase.google.com/) 접속
2. **프로젝트 추가** → 이름 입력 (예: konghanjok) → 생성
3. **Realtime Database** 메뉴 → **데이터베이스 만들기** → 위치 선택(asia-northeast3 등) → **테스트 모드로 시작** (나중에 규칙 적용)

## 2. 앱 등록 및 설정 값 복사

1. 프로젝트 설정(톱니바퀴) → **일반** 탭
2. **내 앱** → 웹(</>) 아이콘 클릭 → 앱 닉네임 입력 → 등록
3. **firebaseConfig** 객체 전체 복사

## 3. 프로젝트에 설정 넣기

1. `firebase-config.js` 파일 열기
2. `window.FIREBASE_CONFIG = null;` 를 지우고, 아래처럼 복사한 설정 붙여넣기:

```js
window.FIREBASE_CONFIG = {
  apiKey: "AIza...",
  authDomain: "your-project.firebaseapp.com",
  databaseURL: "https://your-project-default-rtdb.firebaseio.com",
  projectId: "your-project",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123...",
  appId: "1:123:web:..."
};
```

3. **databaseURL** 이 꼭 있어야 합니다 (Realtime Database 주소).

## 4. 인증 사용 설정

1. Firebase Console → **빌드** → **Authentication**
2. **시작하기** → **Sign-in method** 탭
3. **익명** 사용 설정 → 사용 설정 켜기 → 저장

## 5. Realtime Database 규칙 적용

1. **Realtime Database** → **규칙** 탭
2. `firebase-database-rules.json` 내용을 복사해 규칙란에 붙여넣기
3. **게시** 클릭

이후 매칭 시 **실제 대기 중인 상대**와 연결되고, 가위바위보는 실시간으로 진행됩니다.

**설정 전/설정 안 할 때**: 기존처럼 AI 상대와만 대결합니다 (`FIREBASE_CONFIG` 가 `null` 이면 AI 모드).
