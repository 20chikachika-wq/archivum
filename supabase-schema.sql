-- Supabase SQL Editorで一度だけ実行してください。
create table if not exists public.archivum_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.archivum_data enable row level security;
create policy "Users can read own archive" on public.archivum_data for select using (auth.uid() = user_id);
create policy "Users can insert own archive" on public.archivum_data for insert with check (auth.uid() = user_id);
create policy "Users can update own archive" on public.archivum_data for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
