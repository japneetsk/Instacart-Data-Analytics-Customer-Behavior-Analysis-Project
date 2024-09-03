-- Create tables to house the project data 

create table insta_aisles (aisle_id number, 
                           aisle varchar2(4000 byte)
                           );

create table insta_department (department_id number, 
                               department varchar2(4000 byte)
                               );

create table insta_department (department_id number, 
                               department varchar2(4000 byte)
                               );

create table insta_order_products_prior (order_id number, 
                                         product_id number,
                                         add_to_cart_order number,
                                         reordered number
                                         );

create table insta_order_products_train (order_id number, 
                                         product_id number,
                                         add_to_cart_order number,
                                         reordered number
                                         );

create table insta_orders (order_id number,
                           user_id number,
                           eval_set varchar2(4000 byte),
                           order_number number,
                           order_dow number,
                           order_hour_of_day number,
                           days_since_prior_order number
                           );

create table insta_products (product_id number,
                             product_name	varchar2(4000 byte),
                             aisle_id	number,
                             department_id number
                             );

-- Data inserted in above tables using the "Import" command. Verify results below.

select * from insta_aisles;
select * from insta_department;
select * from insta_order_products_prior;
select * from insta_order_products_train;
select * from insta_orders;
select * from insta_products;

-- Doing Some Analysis

create or replace view order_total_dow_vw as
select 
  count(order_id) as number_of_orders, 
  decode(order_dow, 
        '0', 'Sunday', 
        '1', 'Monday', 
        '2', 'Tuesday', 
        '3', 'Wednesday', 
        '4', 'Thursday', 
        '5', 'Friday', 
        '6', 'Saturday',
        'Other Day') as day_of_week
  from insta_orders  
 group by order_dow 
 order by number_of_orders desc;
 
select * from order_total_dow_vw; 

----------------------------------------

CREATE OR REPLACE VIEW ORDER_BY_HOUR_VW AS
select 
  count(ORDER_ID) as TOTAL_ORDERS, 
  ORDER_HOUR_OF_DAY 
  from INSTA_ORDERS
 group by ORDER_HOUR_OF_DAY 
 order by ORDER_HOUR_OF_DAY;

select * from ORDER_BY_HOUR_VW;

------------------------------------------

CREATE OR REPLACE VIEW ORDER_BY_PRODUCT_NAME_VW AS

select COUNT(PROD_PRIOR.ORDER_ID) as NUMBER_OF_ORDERS, 
       PROD.PRODUCT_ID, 
       PROD.PRODUCT_NAME
from INSTA_ORDER_PRODUCTS_PRIOR PROD_PRIOR, 
     INSTA_PRODUCTS PROD
where PROD_PRIOR.PRODUCT_ID = PROD.PRODUCT_ID 
 group by PROD.PRODUCT_ID, PROD.PRODUCT_NAME 
 order by NUMBER_OF_ORDERS desc;

select * from ORDER_BY_PRODUCT_NAME_VW;

------------------------------------------

create or replace view ORDER_DETAILS_VW as

SELECT  PRIOR_ORDERS.ORDER_ID,
        PRIOR_ORDERS.PRODUCT_ID,
        PRIOR_ORDERS.ADD_TO_CART_ORDER,
        PRIOR_ORDERS.REORDERED,
        ORDERS.USER_ID,
        ORDERS.ORDER_NUMBER,
        ORDERS.ORDER_DOW,
        ORDERS.ORDER_HOUR_OF_DAY,
        ORDERS.DAYS_SINCE_PRIOR_ORDER
        
FROM INSTA_ORDER_PRODUCTS_PRIOR PRIOR_ORDERS,
     INSTA_ORDERS ORDERS

WHERE PRIOR_ORDERS.ORDER_ID = ORDERS.ORDER_ID;

select * from order_details_vw;






