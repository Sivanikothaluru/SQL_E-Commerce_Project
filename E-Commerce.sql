use ecommerce;

SELECT * FROM ecommerce.orders_details; 

select * from sales_target;

select * from customers_details;

select Customer_name,State from customers_details;

select * from customers_details where City='Pune';

select Order_id,Order_date from customers_details order by Order_id;

select order_id,Amount+200 as Amount from orders_details where Amount between 1000 and 1500;

select * from customers_details where state = 'Tamil Nadu' and city = 'Chennai';

select * from orders_details where Category in ('clothing', 'Furniture') order by Category;

select Order_id,Customer_name from customers_details where Customer_name like '_i%';

select * from orders_details where profit is null;

select concat(concat(concat(concat(customer_name,' is from '),State),' and city is '),City) as Customer_data from customers_details;

select count(distinct(customer_name)) as count,state 
from customers_details
group by state
order by count;

select quantity, max(Profit) from orders_details
group by quantity having max(Profit)>100
order by max(profit);

select * from customers_details,orders_details;

SELECT max(STR_TO_DATE(order_date, "%d-%m-%Y")) as latest_order_date,customer_name 
from customers_details 
group by customer_name;

select count(distinct order_id) as no_of_orders, 
	count(distinct customer_name) as no_of_customers,
    count(distinct city) as no_of_cities,
    count(distinct State) as no_of_states
    from customers_details;
    
create view combined_orders as
select c.Order_date,c.Customer_name,c.State,c.City, o.order_id,o.Amount,o.Profit, o.Quantity, o.Category,o.Sub_Category
from customers_details c inner join orders_details o
on c.order_id=o.order_id;

select * from combined_orders;

select Customer_name,State,City, sum(Amount) as sales from combined_orders
where Customer_name not in (
	select distinct Customer_name
	from combined_orders
	where year(str_to_date(order_date,"%d-%m-%Y"))=2018)
and year(str_to_date(order_date,"%d-%m-%Y"))= 2019
group by Customer_name,State,City
order by sales desc
limit 5;

select State, City, count(Distinct Customer_name) as num_of_customers,
		sum(Profit) as total_profit,
        sum(Quantity) as total_quantity
from combined_orders
group by State, City
order by total_profit desc
limit 10;

select day_of_order,LPAD('*',num_of_orders,'*') as num_of_orders,sales
from (select dayname(str_to_date(order_date, '%d-%m-%Y')) as day_of_order,
		count(distinct order_id) as num_of_orders, 
        sum(Amount) as sales
	from combined_orders
    group by day_of_order) sales_per_day
order by sales desc;

select customer_name, sum(Profit) as total_profit from 
customers_details c inner join orders_details o on c.Order_id=o.Order_id 
where Quantity>10
group by customer_name
order by sum(Profit);

alter table customers_details 
rename column Order_date to date_of_order;
select * from customers_details;

update customers_details set Customer_name = 'Dileep Kumar' where order_id='B-25601';
select * from customers_details;

insert into sales_target 
values('Apr-18','Clothing',11400);
select * from sales_target where target=11400;
