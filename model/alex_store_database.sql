DROP DATABASE IF EXISTS ALEX_STORE_DATABASE;

CREATE DATABASE ALEX_STORE_DATABASE;

USE ALEX_STORE_DATABASE;

CREATE TABLE user_table(
	id int,
    fullname varchar(100) not null,
    email varchar(100) not null,
    password varchar(100)  not null,
    status varchar(10)not null,
    DOB date,
    token varchar(100)  not null,
    PRIMARY KEY(id)
);


INSERT INTO `user_table` (`id`, `fullname`, `email`, `password`, `status`, `DOB`, `token`) VALUES
(2023, 'Gideon Bonsu', 'gidi@gmail.com', '391ab1e749c3bba9f9add2253686af23', 'user', '2021-12-15', 'a79781035eee8866ac5cd6406e20421cea187116e2a5d11b79bd604227558e05adb2b970d13b9d81304fe928f42641c64ab9'),
(7139, 'Joshua Owusu Ansah', 'owusuja500@gmail.com', '391ab1e749c3bba9f9add2253686af23', 'user', '2021-12-10', 'babda2c41f843d5ee5070f60f9c666b6d5c03ed1341a0a3c14f2de6ea01e6fd3fb3f715f2083592820a3013b5c4f189bb8fb');





CREATE TABLE product_table(
	name_of_product varchar(100),
    quantity_in_stock int, 
    date_product_was_bought date,
    PRIMARY KEY(name_of_product)
);

INSERT INTO product_table VALUES
("Nissan Frontier",200,"2020-02-12"),
("Toyota Jiaarm",36,"2020-02-12"),
("Nissan Ball Joint",200,"2020-02-12"),
("Picanto Door",45,"2020-02-12"),
("Land Rover Engine",10,"2020-02-12");


CREATE TABLE sales_table(
	id_of_user int,
    name_of_product varchar(100),
    price int,
    quantity_per_purchase int,
    date_of_sale date,
    FOREIGN KEY(id_of_user) REFERENCES user_table(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(name_of_product) REFERENCES product_table(name_of_product) 
);



INSERT INTO sales_table(id_of_user,name_of_product,price,quantity_per_purchase,date_of_sale) VALUES 
(2134,"Nissan Frontier",2000,2,"2021-02-12"),
(2134,"Toyota Jiaarm",500,5,"2021-02-12"),
(2135,"Nissan Ball Joint",900,1,"2021-02-12"),
(2135,"Toyota Jiaarm",500,5,"2021-02-12"),
(2136,"Picanto Door",900,1,"2021-02-12"),
(2136,"Land Rover Engine",500,5,"2021-02-12");



#QUIRIES 
#Quiry one is to know the kind of goods that moves fast
SELECT name_of_product,SUM(quantity_per_purchase) AS "Quantity Sold"
FROM sales_table
GROUP BY name_of_product
ORDER BY SUM(quantity_per_purchase) DESC;  #From the result that will be generated by this query, the admin of the will be able to see the type
#of goods that really sells

#Second Query: Knowing the type available goods at the shop
SELECT S.name_of_product,P.quantity_in_stock,SUM(S.quantity_per_purchase) 
AS "Quantity Sold", P.quantity_in_stock-SUM(S.quantity_per_purchase) AS "Goods Left"
FROM sales_table AS S
CROSS JOIN product_table AS P ON S.name_of_product=P.name_of_product
GROUP BY S.name_of_product
ORDER BY P.quantity_in_stock-SUM(S.quantity_per_purchase) DESC; 
#With this the admin will know the number of available goods that are in the shop

#Query three: Know the person that sold a particular item
SELECT S.name_of_product, S.quantity_per_purchase,S.date_of_sale,U.fullname
FROM sales_table AS S
INNER JOIN user_table AS U ON U.id=S.id_of_user;

#Query Four: Know the total amount of revenue that has been made within a month
SELECT SUM(price*quantity_per_purchase)
FROM sales_table
WHERE MONTH(date_of_sale)=MONTH(CURRENT_DATE())
#From the above table, no revenue will be realised because no sell has been made within this month. So the query as should be null












