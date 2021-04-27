# database_campus


Person to Order table: One person could make one to many orders, and one order only could be made by one person. Person_id in order is an FK to person.
Order to Location: One location could have one to many orders and one order only could be belonged one location. 
Order to Restaurant: One restaurant could have one to many orders, and one order only can be made by one restaurant. Restaurant_id in order is an FK to the restaurant.
Person to Staff table: one person could be one to many staffs, and one staff is only one person. The person_id is a foreign key to the person.
Person to faculty table:  one person could be one to many faculties, and one faculty is only one person. The person_id is a foreign key to faculty.
Person to Student table: one person could be one to many students, and one student is only one person. The person_id is a foreign key to the student.
Driver to student table: One driver could mail food to one to many students, and one student gets food from one driver. Student_id in a driver is an FK to a student.
Driver to delivery: one driver could make one to many deliveries, and one delivery could be made by one driver. Driver_id in delivery is an FK to the driver. 
Delivery to a vehicle: one vehicle could mail one to many deliveries, and one delivery could be made by one vehicle. Vehicle_id in delivery is an FK to vehicle.
Then we add Restaurant_rating table and driver_rating table.
 



![image](https://user-images.githubusercontent.com/83249178/116154214-61342c80-a6b6-11eb-8f72-8af2d8486f55.png)
