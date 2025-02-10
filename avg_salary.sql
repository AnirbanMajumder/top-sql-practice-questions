-- Drop existing tables if they exist to avoid conflicts
DROP TABLE salary;
DROP TABLE employee;

-- Create the salary table to store employee salaries with payment date
CREATE TABLE salary (
    id NUMBER, 
    employee_id NUMBER, 
    amount NUMBER, 
    pay_date DATE
);

-- Create the employee table to store employee details including department
CREATE TABLE employee (
    employee_id NUMBER, 
    department_id NUMBER
);

-- Insert salary records for different employees across different months
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES (1, 1, 9000, TO_DATE('2017/03/31','YYYY/MM/DD'));
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES (2, 2, 6000, TO_DATE('2017/03/31','YYYY/MM/DD'));
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES (3, 3, 10000, TO_DATE('2017/03/31','YYYY/MM/DD'));
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES (4, 1, 7000, TO_DATE('2017/02/28','YYYY/MM/DD'));
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES (5, 2, 6000, TO_DATE('2017/02/28','YYYY/MM/DD'));
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES (6, 3, 8000, TO_DATE('2017/02/28','YYYY/MM/DD'));

-- Insert employee records with their respective department IDs
INSERT INTO employee (employee_id, department_id) VALUES (1, 1);
INSERT INTO employee (employee_id, department_id) VALUES (2, 2);
INSERT INTO employee (employee_id, department_id) VALUES (3, 2);

-- Query to compare department salary averages with company-wide averages
SELECT 
    department_salary.pay_month, 
    department_salary.department_id,
    CASE
        WHEN avg_dep > avg_cmp THEN 'higher'
        WHEN avg_dep < avg_cmp THEN 'lower'
        ELSE 'same'
    END AS comparison 
FROM 
    -- Subquery to calculate the average salary for the company per month
    (SELECT 
        TO_CHAR(pay_date, 'YYYY-MM') AS pay_month, 
        ROUND(AVG(amount), 0) AS avg_cmp 
     FROM salary
     GROUP BY TO_CHAR(pay_date, 'YYYY-MM')
    ) company_salary
JOIN 
    -- Subquery to calculate the average salary for each department per month
    (SELECT 
        e1.department_id, 
        TO_CHAR(s1.pay_date, 'YYYY-MM') AS pay_month, 
        ROUND(AVG(s1.amount), 0) AS avg_dep 
     FROM salary s1
     JOIN employee e1 ON s1.employee_id = e1.employee_id
     GROUP BY e1.department_id, TO_CHAR(s1.pay_date, 'YYYY-MM')
    ) department_salary
ON company_salary.pay_month = department_salary.pay_month;
