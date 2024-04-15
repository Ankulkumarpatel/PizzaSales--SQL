use Pizza_Sales;

--Retrieve the total number of orders placed.
select count(order_details_id) AS 'Total Orders' from order_details;

--Calculate the total revenue generated from pizza sales.
select round(sum(price * quantity),2) AS 'Total Revenue' from pizzas join order_details on pizzas.pizza_id = order_details.pizza_id;

--Identify the highest-priced pizza.
select TOP 1 Name,round(Price,2) from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id order by price desc;

--Identify the most common pizza size ordered.
select size,count(order_details_id) AS 'Total Orders' from pizzas join order_details on pizzas.pizza_id=order_details.pizza_id group by size order by 'Total Orders' desc;

--List the top 5 most ordered pizza types along with their quantities.
select TOP 5 Name,sum(quantity) AS 'Total Quantity' from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by Name order by 'Total Quantity' desc;

--Join the necessary tables to find the total quantity of each pizza category ordered.
select category,sum(quantity) AS 'Total Quantity' from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by category order by 'Total Quantity' desc;

--Determine the distribution of orders by hour of the day.
select Datepart(Hour,time) AS 'Hour',count(order_id) AS 'Total Orders' from orders group by Datepart(Hour,time) order by 'Total Orders' desc;

--Join relevant tables to find the category-wise distribution of pizzas.
select category,count(order_id) AS 'Total Orders' from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by category order by 'Total Orders' desc;

--Group the orders by date and calculate the average number of pizzas ordered per day.
select ROUND(AVG(quantity),0) from (select date,sum(quantity) AS quantity from orders join order_details on orders.order_id = order_details.order_id group by date) AS Average_quantity;

--Determine the top 3 most ordered pizza types based on revenue.
select top 3 Name,round(sum(price * quantity),2) AS 'Total Revenue' from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by Name order by 'Total Revenue' desc;

--Calculate the percentage contribution of each pizza type to total revenue.
select Name,concat(round(sum(price * quantity) *100/(select sum(price * quantity)from pizzas join order_details on pizzas.pizza_id=order_details.pizza_id),2),'%') AS 'Percentage' from pizza_types join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by Name order by 'Percentage' desc;

--Analyze the cumulative revenue generated over time.
select date,round(sum(Revenue) over(order by date),0) AS Cumulative_Revenue from (select date,sum(quantity * price) AS Revenue from order_details join pizzas on order_details.pizza_id=pizzas.pizza_id join orders on orders.order_id=order_details.order_id group by date) AS Sales;

--Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select top 3 category,round(sum(price * quantity),2) AS 'Total Revenue' from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details on pizzas.pizza_id=order_details.pizza_id group by category order by 'Total Revenue' desc;

