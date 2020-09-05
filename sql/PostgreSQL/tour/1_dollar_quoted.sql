do 
'declare
   film_count integer;
begin 
   select count(*) into film_count
   from "Users";
   raise notice ''The number of films: %'', film_count;
end;';
