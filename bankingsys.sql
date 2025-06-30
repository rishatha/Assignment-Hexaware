--Task 1

create database HMBank;
use HMBank;

-- 1. create tables
create table customers (
customer_id int primary key,
first_name varchar(50),
last_name varchar(50),
dob date,
email varchar(50),
phone_number varchar(20),
address varchar(200));

create table accounts (
account_id int primary key,
customer_id int,
account_type varchar(20),
balance decimal(15,2),
foreign key (customer_id) references customers(customer_id));

create table transactions (
transaction_id int primary key,
account_id int,
transaction_type varchar(20),
amount decimal(15,2),
transaction_date date,
foreign key (account_id) references accounts(account_id));

--inserting values

insert into customers values
(1,'arun','kumar','1990-01-15','arun@gmail.com','9000000001','chennai'),
(2,'divya','shree','1985-05-20','divya@gmail.com','9000000002','madurai'),
(3,'rahul','raj','1992-08-10','rahul@gmail.com','9000000003','coimbatore'),
(4,'meena','shah','1988-12-05','meena@gmail.com','9000000004','salem'),
(5,'vijay','patel','1995-03-30','vijay@gmail.com','9000000005','trichy'),
(6,'kavya','sandeep','1997-07-25','kavya@gmailcom','9000000006','chennai'),
(7,'anil','patel','1980-11-11','anil@gmail.com','9000000007','coimbatore'),
(8,'priya','das','1982-02-14','priya@gmail.com','9000000008','madurai'),
(9,'raj','varma','2000-09-09','raj@gmail.com','9000000009','salem'),
(10,'nisha','verma','1998-10-17','nisha@gmail.com','9000000010','trichy');

insert into accounts values
(101,1,'savings',1500.00),
(102,1,'current',500.00),
(103,2,'savings',2000.00),
(104,3,'zero_balance',0.00),
(105,4,'savings',1200.00),
(106,5,'current',3000.00),
(107,6,'savings',800.00),
(108,7,'zero_balance',0.00),
(109,8,'current',2500.00),
(110,9,'savings',1800.00);

insert into transactions values
(1001,101,'deposit',500.00,'2025-06-01'),
(1002,101,'withdrawal',200.00,'2025-06-05'),
(1003,102,'deposit',300.00,'2025-06-03'),
(1004,103,'deposit',1000.00,'2025-06-02'),
(1005,104,'deposit',100.00,'2025-06-04'),
(1006,105,'withdrawal',400.00,'2025-06-06'),
(1007,106,'deposit',1500.00,'2025-06-01'),
(1008,107,'deposit',800.00,'2025-06-07'),
(1009,108,'withdrawal',50.00,'2025-06-05'),
(1010,109,'deposit',2000.00,'2025-06-08'),
(1011,110,'deposit',1800.00,'2025-06-09'),
(1012,103,'withdrawal',500.00,'2025-06-10'),
(1013,105,'deposit',400.00,'2025-06-11'),
(1014,106,'withdrawal',600.00,'2025-06-12');

--Queries

--Task 2

--1.Write a SQL query to retrieve the name, account type and email of all customers. 
select first_name, account_type, email 
from customers c 
join accounts a on c.customer_id=a.customer_id;

--2.Write a SQL query to list all transaction corresponding customer.
select c.customer_id, c.first_name, t.*
from transactions t 
join accounts a on t.account_id=a.account_id 
join customers c on a.customer_id=c.customer_id;

--3.Write a SQL query to increase the balance of a specific account by a certain amount.
update accounts 
set balance = balance + 500 
where account_id = 101;

--4.Write a SQL query to Combine first and last names of customers as a full_name.
select first_name+' '+last_name as full_name
from customers;

--5.Write a SQL query to remove accounts with a balance of zero where the account type is savings.
delete from accounts 
where account_type='savings' and balance=0;

--6.Write a SQL query to Find customers living in a specific city.
select * from customers 
where address like '%madurai%';

--7.Write a SQL query to Get the account balance for a specific account.
select balance from accounts
where account_id=103;

--8.Write a SQL query to List all current accounts with a balance greater than $1,000.
select * from accounts 
where account_type='current' and balance>1000;

--9.Write a SQL query to Retrieve all transactions for a specific account.
select * from transactions 
where account_id=105;

--10.Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
select account_id, balance*0.05 as interest 
from accounts where account_type='savings';

--11.Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit
select * from accounts 
where balance < -500;

--12.Write a SQL query to Find customers not living in a specific city.
select * from customers 
where address not like '%salem%';

--Task 3

--1.Write a SQL query to Find the average account balance for all customers. 

select avg(balance) as avg_balance 
from accounts;

--2.Write a SQL query to Retrieve the top 10 highest account balances.

select top 10 * 
from accounts 
order by balance desc;

--3.Write a SQL query to Calculate Total Deposits for All Customers in specific date.

select sum(amount) as total_deposits 
from transactions 
where transaction_type='deposit' and transaction_date='2025-06-01';

--4.Write a SQL query to Find the Oldest and Newest Customers.

select min(dob) as oldest, max(dob) as newest 
from customers;

--5.Write a SQL query to Retrieve transaction details along with the account type.


select t.*, a.account_type 
from transactions t 
join accounts a on t.account_id=a.account_id;

--6.Write a SQL query to Get a list of customers along with their account details.


select c.*, a.* 
from customers c 
join accounts a on c.customer_id=a.customer_id;

--7.Write a SQL query to Retrieve transaction details along with customer information for a specific account.


select t.*, c.first_name, c.last_name 
from transactions t 
join accounts a on t.account_id=a.account_id 
join customers c on a.customer_id=c.customer_id where a.account_id=101;

--8.Write a SQL query to Identify customers who have more than one account.

select customer_id 
from accounts 
group by customer_id 
having count(*)>1;

--9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.

select t.account_id, sum(case when transaction_type='deposit'
						then amount else -amount end) as net 
from transactions t group by t.account_id;

--10.Write a SQL query to Calculate the average daily balance for each account over a specified period.

select account_type, avg(balance) as avg_balance 
from accounts 
group by account_type;

--11.Calculate the total balance for each account type

select account_type, sum(balance) as total_balance
from accounts 
group by account_type;

--12. Identify accounts with the highest number of transactions order by descending order.

select account_id, count(*) as txn_count 
from transactions 
group by account_id 
order by txn_count desc;

--13. List customers with high aggregate account balances, along with their account types.

select c.first_name, a.account_type, sum(a.balance) as total_bal 
from customers c 
join accounts a on c.customer_id=a.customer_id 
group by c.first_name, a.account_type;

--14. Identify and list duplicate transactions based on transaction amount, date, and account.

select t.transaction_type, t.amount, t.transaction_date 
from transactions t 
group by t.transaction_type, t.amount, t.transaction_date 
having count(*)>1;

--Task 4

--1.Retrieve the customer(s) with the highest account balance.


select * from accounts 
where balance = (select max(balance) from accounts);

--2. Calculate the average account balance for customers who have more than one account.


select avg(balance) 
from accounts 
where customer_id in (select customer_id 
					  from accounts 
					  group by customer_id 
					  having count(*)>1);

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.

select * from transactions 
where amount > (select avg(amount) from transactions);

--4. Identify customers who have no recorded transactions.

select * from customers 
where customer_id not in (select distinct customer_id 
						  from accounts a 
						  join transactions t on a.account_id=t.account_id);

--5.Calculate the total balance of accounts with no recorded transactions.

select sum(balance) from accounts 
where account_id not in (select distinct account_id from transactions);

--6.Retrieve transactions for accounts with the lowest balance.

select * from transactions 
where account_id in (select account_id from accounts 
					 where balance = (select min(balance) from accounts));

--7.Identify customers who have accounts of multiple types.

select customer_id from accounts 
group by customer_id 
having count(distinct account_type)>1;

--8. Calculate the percentage of each account type out of the total number of accounts.

select account_type, cast(count(*)*100.0/
					(select count(*) from accounts) as decimal(5,2)) as pct 
from accounts group by account_type;

--9.Retrieve all transactions for a customer with a given customer_id.

select * from transactions 
where account_id=101;

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.

select account_type, sum(balance) as total_bal
from accounts
group by account_type;



