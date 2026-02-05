-- Supabase SQL Editor에서 실행하세요.
-- 대기열 (모델_방향별 대기 유저) — 컬럼명은 condition (Supabase REST와 맞춤)
CREATE TABLE IF NOT EXISTS waiting (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  queue_key TEXT NOT NULL,
  user_id TEXT NOT NULL,
  "condition" TEXT,
  room_id UUID,
  display_name TEXT,
  joined_at TIMESTAMPTZ DEFAULT now()
);

-- 게임 방
CREATE TABLE IF NOT EXISTS rooms (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  player_left TEXT NOT NULL,
  player_right TEXT NOT NULL,
  model TEXT,
  condition_left TEXT,
  condition_right TEXT,
  display_name_left TEXT,
  display_name_right TEXT,
  scores JSONB DEFAULT '{}',
  round INT DEFAULT 1,
  choices JSONB DEFAULT '{}',
  phase TEXT DEFAULT 'choose',
  result TEXT,
  winner TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Realtime 구독 허용
ALTER PUBLICATION supabase_realtime ADD TABLE waiting;
ALTER PUBLICATION supabase_realtime ADD TABLE rooms;

-- RLS 정책 (anon이 읽기/쓰기 가능)
ALTER TABLE waiting ENABLE ROW LEVEL SECURITY;
ALTER TABLE rooms ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow all waiting" ON waiting FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow all rooms" ON rooms FOR ALL USING (true) WITH CHECK (true);
