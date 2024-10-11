-- Create tables

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     ),
    CONSTRAINT "uc_titles_title" UNIQUE (
        "title"
    )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     ),
    CONSTRAINT "uc_departments_dept_name" UNIQUE (
        "dept_name"
    )
);

CREATE TABLE "employees" (
    "emp_no" INT  NOT NULL, 
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "firstname" VARCHAR(30)   NOT NULL,
    "lastname" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" money   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

create table dept_manager (
	dept_no VARCHAR(8) NOT NULL,
	emp_no INT NOT NULL,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);


--List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.lastname, e.firstname, e.sex, s.salary
from employees as e
inner join salaries as s
on s.emp_no = e.emp_no
order by s.emp_no;
--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT firstname, lastname, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dept_manager.emp_no, e.lastname, e.firstname
FROM departments AS d
JOIN dept_manager ON d.dept_no = dept_manager.dept_no
JOIN employees AS e ON dept_manager.emp_no = e.emp_no;
--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
employees.emp_no, employees.lastname, employees.firstname, dept_emp.dept_no,departments.dept_name
FROM dept_emp
JOIN employees
	ON dept_emp.emp_no = employees.emp_no
JOIN departments 
	ON dept_emp.dept_no = departments.dept_no;
--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT firstname, lastname
FROM employees
WHERE firstname = 'Hercules' AND lastname LIKE 'B%';
--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT dept_emp.emp_no, employees.lastname, employees.firstname, departments.dept_name
FROM dept_emp
JOIN employees
	ON dept_emp.emp_no = employees.emp_no
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.lastname, employees.firstname, departments.dept_name
FROM dept_emp
JOIN employees
	ON dept_emp.emp_no = employees.emp_no
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
	OR departments.dept_name = 'Development';
--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT lastname,
	COUNT(*) AS frequency
FROM employees
GROUP BY lastname
ORDER BY frequency DESC;
