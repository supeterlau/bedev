-- \copy (select * from "Users") to '/home/db/users.csv' with csv
\copy (select * from "Users") to '/home/db/users.csv' DELIMITER ',' CSV HEADER;
