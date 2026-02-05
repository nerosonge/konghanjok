# Supabase 실시간 매칭 설정

이미 `supabase-config.js`에 URL과 anon key가 들어가 있으므로, **Supabase 대시보드에서 테이블만 만들고 Realtime만 켜면** 됩니다.

## 1. 테이블 생성

1. [Supabase](https://supabase.com) 로그인 → 프로젝트 선택
2. 왼쪽 **SQL Editor** 클릭
3. **New query** 선택 후 `supabase-schema.sql` 파일 내용 전체 복사해서 붙여넣기
4. **Run** 실행

`ALTER PUBLICATION supabase_realtime ADD TABLE ...` 에서 이미 추가된 테이블이라 오류가 나면, 그 줄만 지우고 다시 실행하거나 무시해도 됩니다.

## 2. Realtime 켜기 (Publications에 있음)

**Replication** 메뉴가 아니라 **Publications** 메뉴입니다.

1. 왼쪽 **Database** → **Publications** 클릭  
   (또는 [Publications 설정](https://supabase.com/dashboard/project/qsdewkgxieqqpvvfaqel/database/publications) 직접 이동)
2. **supabase_realtime** publication 선택
3. `waiting`, `rooms` 테이블이 목록에 있으면 체크(토글 ON), 없으면 **SQL Editor**에서 아래 실행:

```sql
ALTER PUBLICATION supabase_realtime ADD TABLE waiting;
ALTER PUBLICATION supabase_realtime ADD TABLE rooms;
```

(이미 추가돼 있어서 오류가 나면 그대로 두면 됩니다.)

## 3. RLS (Row Level Security)

`supabase-schema.sql` 안에 이미 다음 정책이 들어 있습니다.

- `waiting`: anon 사용자 읽기/쓰기 허용
- `rooms`: anon 사용자 읽기/쓰기 허용

별도 설정 없이 그대로 사용하면 됩니다.

---

## 4. 실시간 매칭 테스트

- **실시간 대전하기** → **실시간 상대 찾기** 하면, 같은 모델·반대쪽 대기 중인 유저가 있을 때 실시간으로 매칭됩니다.
- **테스트는 반드시 서로 다른 브라우저 또는 기기 2대**로 하세요.  
  같은 브라우저에서 탭 2개로 하면 `user_id`가 같아서 “나 vs 나”로 인식되어 매칭에서 제외됩니다.
- 브라우저 개발자도구(F12) → Console에서 `[Realtime]` 로그로 구독 상태를 확인할 수 있습니다.
