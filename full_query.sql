-- Drop table if exists
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE title;
DROP TABLE departments;
DROP TABLE dept_manager;
DROP TABLE dept_emp;


-- Create new tables

CREATE TABLE employees (
	emp_no  INT PRIMARY KEY,
	birth_date  DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE);

CREATE TABLE salaries (
	emp_no  INT,
	salary  INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no));

CREATE TABLE title (
	emp_no  INT,
	title  VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no));
	
CREATE TABLE departments (
	dept_no  VARCHAR PRIMARY KEY,
	dept_name  VARCHAR);
	
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no  INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no));
	

CREATE TABLE dept_emp (
	emp_no  INT,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no));
	
	
--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no,e.last_name,e.first_name,e.gender,s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--2.List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';


--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no,d.dept_name,dm.emp_no,e.last_name,e.first_name,
dm.from_date,dm.to_date 
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON e.emp_no = dm.emp_no;


--4.List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT de.emp_no,e.last_name,e.first_name,d.dept_name
FROM dept_emp de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no;

--5.List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name,last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees e 
JOIN dept_emp de  ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';

--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees e 
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';


--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Frequency of last_name"
FROM employees
GROUP BY last_name
ORDER BY "Frequency of last_name" DESC;