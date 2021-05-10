/* Question 1 */
USE campus_eats_fall2020;

DROP PROCEDURE IF EXISTS insert_Restaurant;

DELIMITER //
CREATE PROCEDURE insert_Restaurant 
(
  location_param varchar(75) ,
  restaurant_name_param varchar(75),
  schedule_param varchar(75),
  website_param varchar(75)
  )
  
BEGIN
  DECLARE location_var      varchar(75);
  DECLARE schedule_var   varchar(75);
  DECLARE website_var    varchar(75);

  -- Validate paramater values
  IF schedule_param not in ("9am -10pm","11am - 11pm","10am - 9pm") THEN
    SIGNAL SQLSTATE '22003'
      SET MESSAGE_TEXT = 'The schedule column must be at or after 9am and before 11pm.',
      MYSQL_ERRNO = 1264;
  END IF;

  -- Set default values for parameters
  IF location_param IS NULL THEN
    SELECT location_address INTO location_var
    FROM location WHERE location_address = location_param;
  ELSE
    SET location_var = location_param;
  END IF;

  INSERT INTO restaurant
         ( location, restaurant_name,
          schedule, website)
  VALUES ( location_param, restaurant_name_param, 
          schedule_param, website_param );
END//

DELIMITER ;

-- test
CALL insert_Restaurant ('North Carolina', 'Botsford Inc', 
'9am -10pm', 'http://kesslergreenholt.com/'
);
CALL insert_Restaurant (NULL, 'Botsford Inc', 
'9am -10pm', 'http://kesslergreenholt.com/');

-- this statement raises an error
CALL insert_Restaurant(NULL, 'Botsford Inc', 
'7am -10pm', 'http://kesslergreenholt.com/');
                    
select * from restaurant where restaurant_name = 'Botsford Inc';

/* Question 2 */
USE campus_eats_fall2020;

DROP FUNCTION IF EXISTS get_driver_id;

DELIMITER //

CREATE FUNCTION get_driver_id
(
   driver_id_param VARCHAR(50)
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE driver_id_var INT;
  
  SELECT driver_id
  INTO driver_id_var
  FROM driver
  WHERE driver_name = driver_id_param;
  
  RETURN(driver_id_var);
END//

DELIMITER ;

SELECT driver_id, driver_name
FROM driver
WHERE driver_id = get_driver_id('Fred');

/* Question 3 */
USE campus_eats_fall2020;

DROP FUNCTION IF EXISTS get_restaurant_id;

DELIMITER //

CREATE FUNCTION get_restaurant_id
(
   restaurant_id_param VARCHAR(50)
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE restaurant_id_var INT;
  
  SELECT restaurant_id
  INTO restaurant_id_var
  FROM restaurant
  WHERE restaurant_name = restaurant_id_param;
  
  RETURN(restaurant_id_var);
END//

DELIMITER ;

SELECT restaurant_id, restaurant_name
FROM restaurant
WHERE restaurant_id = get_restaurant_id('Berge Inc');

SELECT *
FROM restaurant;

/* Question 4 */
USE campus_eats_fall2020;

Select get_avg_rating_restuarant(1);

DROP FUNCTION IF EXISTS get_avg_rating_restuarant;
DELIMITER //

CREATE FUNCTION get_avg_rating_restuarant
(
   avg_rating_param INT
)
RETURNS DECIMAL(9,2)
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE balance_due_var DECIMAL(9,2);
  
  Select avg_rating 
  INTO balance_due_var
  from (
SELECT  restaurant_id,(rest_question_1+rest_question_2)/2 as 'avg_rating' FROM campus_eats_fall2020.restaurant_rating
group by restaurant_id) t  where restaurant_id=avg_rating_param;
 
  RETURN balance_due_var;
END//



  Select avg_rating 
  from (
SELECT  Rating_ID,(driver_question_1+driver_question_2)/2 as 'avg_rating' FROM campus_eats_fall2020.driver_rating t1
join driver t2 on  t1.rating_id = t2.rating 
group by Rating_ID) t  where Rating_ID=1;


DELIMITER ;

/* Question 5 */
use campus_eats_fall2020;

Select get_avg_rating_driver(8);

DROP FUNCTION IF EXISTS get_avg_rating_driver;
DELIMITER //

CREATE FUNCTION get_avg_rating_driver
(
   avg_rating_param INT
)
RETURNS DECIMAL(9,2)
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE rating_res DECIMAL(9,2);
  Select avg_rating 
  INTO rating_res
  from (
SELECT  driver_id,(driver_question_1+driver_question_2)/2 as 'avg_rating' FROM campus_eats_fall2020.driver_rating
group by driver_id) t  where driver_id=avg_rating_param;
  RETURN rating_res;
END//

