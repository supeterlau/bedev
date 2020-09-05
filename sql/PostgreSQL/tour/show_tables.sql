/*-- SELECT *
SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema' AND
    tablename != 'SequelizeMeta';
*/


create or replace function export_csv(table_name varchar(20))
returns varchar
as $$
declare 
  out_path varchar(50);
begin
  select concat('/home/db/', table_name, '.csv') into out_path;
  -- raise notice '%', out_path;
  -- copy table_name TO $path$out_path$pat DELIMITER ',' CSV HEADER;
  execute format ('
    COPY %I TO %L DELIMITER $d$,$d$ CSV HEADER;
    ', table_name, out_path);
  return out_path;
end;$$ LANGUAGE plpgsql;
select export_csv('Users');
-- do $$
-- declare
--   r record;
-- begin
--   for r in SELECT tablename
--               FROM pg_catalog.pg_tables
--               WHERE schemaname != 'pg_catalog' AND 
--                   schemaname != 'information_schema' AND
--                   tablename != 'SequelizeMeta'
--   <<outer>>
--   loop
--     -- raise notice '%', r.tablename;
--     export_csv(r.tablename);
--     exit outer;
--   end loop;
-- end;$$
