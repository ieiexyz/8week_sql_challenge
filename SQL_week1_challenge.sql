/* --------------------
   Case Study Questions
   --------------------*/
   
-- 1. What is the total amount each customer spent at the restaurant?

SELECT customer_id, SUM(price) AS total_expense 
FROM dannys_diner.sales
JOIN dannys_diner.menu
ON dannys_diner.sales.product_id=dannys_diner.menu.product_id
GROUP BY customer_id
ORDER BY customer_id;

-- 2. How many days has each customer visited the restaurant?

SELECT customer_id, COUNT(order_date) AS visits
FROM dannys_diner.sales
GROUP BY customer_id
ORDER BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?

SELECT min(s.order_date), s.customer_id, m.product_name
FROM dannys_diner.sales s
JOIN dannys_diner.menu m
ON s.product_id = m.product_id
GROUP BY s.order_date, s.customer_id, m.product_name
ORDER BY min(s.order_date), s.customer_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT m.product_id, COUNT(s.order_date), m.product_name
FROM dannys_diner.sales s
JOIN dannys_diner.menu m
ON s.product_id = m.product_id
GROUP BY m.product_id, m.product_name
ORDER BY COUNT(s.order_date) DESC;

-- 5. Which item was the most popular for each customer?

SELECT s.customer_id, COUNT(s.order_date), m.product_name
FROM dannys_diner.sales s
JOIN dannys_diner.menu m
ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
ORDER BY COUNT(s.order_date) DESC;

-- 6. Which item was purchased first by the customer after they became a member?

SELECT s.customer_id, s.order_date, m.product_name
FROM dannys_diner.sales s
JOIN dannys_diner.members b ON b.customer_id = s.customer_id
JOIN dannys_diner.menu m ON m.product_id = s.product_id
WHERE s.order_date >= b.join_date
GROUP BY s.order_date, s.customer_id, m.product_name
ORDER BY s.order_date;

-- 7. Which item was purchased just before the customer became a member?

SELECT
  	m.customer_id,
    s.order_date,
    m.join_date,
    me.product_name
    
FROM dannys_diner.sales as s
JOIN dannys_diner.members as m
ON s.customer_id = m.customer_id
JOIN dannys_diner.menu me 
ON me.product_id = s.product_id
WHERE s.order_date < m.join_date
ORDER BY customer_id, order_date DESC;

-- 8.What is the total items and amount spent for each member before they became a member?

SELECT 

	s.customer_id,
	COUNT(DISTINCT(s.product_id)) as menu_item,
    SUM(me.price) as total_sales

FROM dannys_diner.sales as s
JOIN dannys_diner.members as m
ON s.customer_id = m.customer_id
JOIN dannys_diner.menu me 
ON me.product_id = s.product_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id;