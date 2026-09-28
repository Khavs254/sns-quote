-- Run once in Supabase → SQL Editor

create table if not exists ss_products (
  code       text primary key,
  descr      text,
  cat        text,
  unit       text,
  price      numeric default 0,
  disc       numeric default 0,
  deleted    boolean default false,
  updated_at timestamptz default now()
);
create table if not exists ss_projects (
  id         uuid primary key,
  name       text,
  client     text,
  data       jsonb,
  updated_at timestamptz default now()
);
create index if not exists ss_products_updated on ss_products (updated_at);
create index if not exists ss_projects_updated on ss_projects (updated_at desc);

alter table ss_products enable row level security;
alter table ss_projects enable row level security;

-- Anyone holding the publishable key may read and write.
-- Keep the HTML file inside the company.
create policy ss_products_all on ss_products for all to anon using (true) with check (true);
create policy ss_projects_all on ss_projects for all to anon using (true) with check (true);
