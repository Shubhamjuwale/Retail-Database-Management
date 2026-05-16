use OnlineRetail
/* Find the product that has been ordered the most times.*/
SELECT Top 1 COUNT(o.pid) AS most,
       p.name,
       p.type
FROM product AS p
JOIN orderitem AS o 
    ON p.pid = o.pid
GROUP BY p.name, p.type
ORDER BY most DESC;

/*Find all the orders that were placed for products that are sold by stores in the city of Toronto. */
SELECT p.name AS product_name,
p.type,
o.price,
s.name AS store_name,
s.province,
s.city
FROM product AS p
JOIN orderitem AS o 
ON p.pid = o.pid
JOIN store AS s 
ON p.sid = s.sid
WHERE s.city = 'Toronto';

/*My contribution*/
/*Update the name and contact phone number of the address where the province is Quebec and city is Montreal.    */   
Update address set name = 'john cena', contactPhoneNumber = '123-456-7890'
WHERE province = 'Quebec' AND city = 'Montreal';
SELECT * 
FROM address
WHERE province = 'Quebec'
  AND city = 'Montreal';

/*Create a report of all products whose price is above average price using subquery.*/
SELECT *
FROM product
WHERE price > (SELECT AVG(price) FROM product);

/*Query the total quantity of products from store with storeid 8 in the shopping cart using a subquery. */
SELECT SUM(quantity) AS total_quantity
FROM save_to_shopping_cart
WHERE pid IN (
SELECT pid
FROM product
WHERE sid = 8
);

/*Display the total quantity of products from store with storeid 8 in the shopping cart*/
SELECT * 
FROM save_to_shopping_cart;
SELECT SUM(quantity)
FROM save_to_shopping_cart
JOIN product 
ON save_to_shopping_cart.pid = product.pid
WHERE product.sid = 8;
/*My contribution*/
/*Update the payment state of orders to unpaid which were created after year 2017 and with a total amount greater than 50*/
UPDATE orders
SET paymentState = 'unpaid'
WHERE YEAR(creationTime) = 2017
AND totalAmount > 50;
select * from orders 
where year(creationTime)=2017 
 and totalAmount>50;

 /*Find all the details of the buyers who have a phone number that starts with the contact number 91.*/
SELECT b.userid, u.name, u.phoneNumber
FROM buyer AS b
JOIN users AS u 
ON b.userid = u.userid
WHERE phoneNumber LIKE '91%';

/*Delete the store which opened before year 2017*/
DELETE FROM store
WHERE YEAR(startTime) < 2017;

/*Retrieve all stores and their associated managers*/
SELECT m.userid,
u.name AS Manager,
s.name AS storeName
FROM manage AS m
JOIN users AS u 
ON m.userid = u.userid
JOIN store AS s 
ON m.sid = s.sid;

 /*Display the address, starttime and endtime of the service points in the same city as that of  userid 5 */
SELECT *
FROM ServicePoint as sc
WHERE sc.city in (
SELECT city
FROM address
WHERE userid = 5
);


/*Retrieve all credit card payments and their associated order information*/
 SELECT o.*,
 p.creditcardNumber,
 p.payTime
 FROM orders AS o
 JOIN payment AS p 
 ON o.orderNumber = p.orderNumber;

  /*Find all sellers who manage more than one store.*/
SELECT m.userid,
u.name AS Manager,
COUNT(m.sid) AS Store_Count
FROM manage AS m
JOIN users AS u 
ON m.userid = u.userid
GROUP BY m.userid, u.name
HAVING COUNT(m.sid) > 1;

/*Retrieve the names of buyers who have made at least one order and have also left a comment on a product.*/
SELECT DISTINCT u.name
FROM users u
JOIN buyer b 
ON b.userid = u.userid
JOIN comments c 
ON b.userid = c.userid;

 