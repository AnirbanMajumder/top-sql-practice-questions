## SQL 



```sql
Create table Employee (Id int, Salary int);

insert into Employee (Id, Salary) values ('1', '100');
insert into Employee (Id, Salary) values ('2', '200');
insert into Employee (Id, Salary) values ('3', '300');
```



```sql
select max(salary) from Employee
where salary not in (select max(salary) from Employee);
```

```sql
select max(salary) from Employee
where salary < (select max(salary) from Employee);
```

```sql
select salary from (select salary, rank() over(order by salary desc) rnk from Employee)
where rnk = 2;
```



