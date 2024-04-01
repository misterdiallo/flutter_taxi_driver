-- Create a table for public users

create table users (user_id uuid references auth.users not null primary key, full_name text not null, email text unique not null, phone_number text unique not null, user_type text not null, address text, date_of_birth timestamp, is_active boolean not null default true, created_at timestamp with time zone, updated_at timestamp with time zone);

-- Set up Row Level Security (RLS)
-- See https://supabase.com/docs/guides/auth/row-level-security for more details.

alter table users enable row level security;


create policy "Public users are viewable by everyone." on users
for
select using (true);


create policy "Users can insert their own user." on users
for
insert with check (auth.uid() = user_id);


create policy "Users can update own user." on users
for
update using (auth.uid() = user_id);

-- This trigger automatically creates a profile entry when a new user signs up via Supabase Auth.
-- See https://supabase.com/docs/guides/auth/managing-user-data#using-triggers for more details.

create function public.handle_new_user() returns trigger as $$
begin
  insert into public.users (user_id, full_name, email, phone_number, user_type, address, date_of_birth, is_active, created_at)
  values (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'email', new.raw_user_meta_data->>'phone_number', new.raw_user_meta_data->>'user_type', new.raw_user_meta_data->>'address', to_timestamp(new.raw_user_meta_data->>'date_of_birth', 'YYYY-MM-DD'), true, now());
  return new;
end;
$$ language plpgsql security definer;


create trigger on_auth_user_created after
insert on auth.users
for each row execute procedure public.handle_new_user();

-- https://svuniibwxdaaygkynwlv.supabase.co/auth/v1/verify?token=pkce_d5ef7faa4abfca39688bfcb651077eeb5fec66d16275b90ab7e9d41d&type=signup&redirect_to=https://localhost