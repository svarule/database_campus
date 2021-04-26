-- a)  two roles:  ce_user and ce_admin
-- ce_user has select privileges to all tables
-- ce_admin has full privileges to all tables

CREATE ROLE IF NOT EXISTS ce_user, ce_admin, user;

GRANT ALL ON Campus_Eats_Fall2020.* TO ce_admin WITH GRANT OPTION;
GRANT SELECT on Campus_Eats_Fall2020.* TO ce_user WITH GRANT OPTION;

-- b)  two user accounts:  haps_user with password pa55word and jay_admin with password pa55word
 -- (both @localhost if appropriate)
DROP USER IF EXISTS haps_user@localhost;
DROP USER IF EXISTS jay_admin@localhost;

CREATE USER haps_user@localhost IDENTIFIED BY 'pa55word';
CREATE USER jay_admin@localhost IDENTIFIED BY 'pa55word';

-- c)  assign the ce_user role to haps_user and the ce_admin role to jay_admin

GRANT ce_user to haps_user@localhost;
GRANT ce_admin TO jay_admin@localhost;

-- d)  create a view to the restaurant table that is named view_haps and only shows restaurant id 1

CREATE VIEW view_haps AS
SELECT restaurant_id
FROM restaurant
WHERE restaurant_id=1;

-- e)  grant haps_user both select and update privileges to the view

GRANT select, update on Campus_Eats_Fall2020.view_haps TO haps_user@localhost WITH GRANT OPTION;